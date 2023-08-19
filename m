Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8D0781663
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 03:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243544AbjHSBPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 21:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243466AbjHSBPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 21:15:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1855810F1;
        Fri, 18 Aug 2023 18:15:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9ACD76112C;
        Sat, 19 Aug 2023 01:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA806C433C7;
        Sat, 19 Aug 2023 01:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692407723;
        bh=823Uug2iH8j2/brkRGqqkN6G52DCGKWo7rJr40XQXZc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a6VlkYLmj1M6ZcIasuHEWA7p0R3nanJU3nmrTaWdx79mOmmkszytRSNLvu7dgf5gB
         FHvWMv9DMGr4cIBFhhg8zVRCi3jUstPcRwQdDTScGY/iPzN4GmcoJVAoZsW3K0t09p
         ljy5KEMk0tSoS/cpkBD2Q3TP289Y1ju1WN+P6DUml3Khca9Rimrsy9WEvqnOKOMeYZ
         x8ghM+N8m6GMPriCtswminNWM/4cNC5/D+hJPK+4WAR/PtAyjmKzmoD7PxhxSIYnTO
         4P6JA+J21xC2fmgwDRe93EhmDfbRzldgq9/saTEjY6zWvWj6U3oHwqs7A0VOd3BwDW
         UBfCBRjik9RUw==
Date:   Sat, 19 Aug 2023 10:15:19 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Francis Laniel <flaniel@linux.microsoft.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] tracing/kprobe: Add multi-probe support for
 'perf_kprobe' PMU
Message-Id: <20230819101519.568d658fbb6461cc60d348e5@kernel.org>
In-Reply-To: <20230818142033.1d7685e9@gandalf.local.home>
References: <20230816163517.112518-1-flaniel@linux.microsoft.com>
        <20230818213705.b4f5e18b392c4837068cba6f@kernel.org>
        <20230818114141.2a3a75ee@gandalf.local.home>
        <4853240.31r3eYUQgx@pwmachine>
        <20230818142033.1d7685e9@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2023 14:20:33 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 18 Aug 2023 20:13:43 +0200
> Francis Laniel <flaniel@linux.microsoft.com> wrote:
> 
> > Hi.
> > 
> > Le vendredi 18 août 2023, 17:41:41 CEST Steven Rostedt a écrit :
> > > On Fri, 18 Aug 2023 21:37:05 +0900
> > > 
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:  
> > > > That's why perf probe uses the offset from '_text'. Normal KASLR will just
> > > > moves all symbols. (Finer one will move all symbols randomely)
> > > > This should not need to access /proc/kallsyms but vmlinux or SystemMap.  
> > > 
> > > We could just pass in: "_text+offset" too.  
> > 
> > So, the idea would be to change the existing create_local_trace_kprobe() and 
> > above functions to indicate the user's offset is to be used against _text and 
> > not address?
> 
> No, not to modify that function, but if you know the offset from _text (via
> the vmlinux), you can easily calculate it for that function.

Note that the kprobe-event PMU interface itself allows you to specify
FUNC+OFFSET style;

https://lore.kernel.org/lkml/20171206224518.3598254-5-songliubraving@fb.com/

perf_event_attr::kprobe_func = "_text";
perf_event_attr::probe_offset = OFFSET;

Then, it should be able to specify the correct one. Of course you can use
other unique symbols around the target symbol.

Thank you,

> 
> I mentioned having a way to pass in the vmlinux debug info address and
> subtract the kaslr_offset from it. But that's actually unnecessary. If you
> have the address of the function you want, and the address of _text, both
> from the debug info of vmlinux, you can simply pass in "_text+offset", and
> then use kallsyms to give you _text, and add the offset to give you the
> address for create_local_trace_kprobe().
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
