Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2ACA767F5C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 14:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjG2M6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 08:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjG2M6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 08:58:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5453ABA;
        Sat, 29 Jul 2023 05:57:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5800B60689;
        Sat, 29 Jul 2023 12:57:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17C7C433C7;
        Sat, 29 Jul 2023 12:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690635478;
        bh=Unz7rll9qKWO6Vd4XLB0oAGzZlovfi+8nNbfFKWB/yA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BmZVsA2FLwi/lW0IyNHNcVh1LFU+CtNGxr+uCEJ2slA3q2ZMybArTEUF4Pjvbui5b
         J+5GR438HIM8J7Ij22GJEbjEs3P9HSCPfCr/TpixFAlrXMXuUFScnzwfNHekO+xjzN
         FfdpITkwmXn9KmIMr+od78cIpgxFol/DuDSVRKLhXq2gKPD8eAijvdBhmAwI13eto7
         9QJMxZH/iZNFeRs2w+7Qx2F/41HqLe5unMokDCSjM8xgBMQJhEsMFwmJ/dxfc263NI
         PpjP0X9knU3BFIyZdqG8bVfeeGFADVhiN/8G7SaGyba33WLS/Ja3UosVvcq5CvwKkY
         EGF+dkrUcUsaQ==
Date:   Sat, 29 Jul 2023 21:57:53 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Petr Pavlu <petr.pavlu@suse.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] kprobes: Prohibit probing on CFI preamble symbol
Message-Id: <20230729215753.eb0057f6559fa1d8749c80a2@kernel.org>
In-Reply-To: <20230728184913.27bb666f@rorschach.local.home>
References: <168904023542.116016.10540228903086100726.stgit@devnote2>
        <168904024679.116016.18089228029322008512.stgit@devnote2>
        <20230728184913.27bb666f@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023 18:49:13 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 11 Jul 2023 10:50:47 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Do not allow to probe on "__cfi_" or "__pfx_" started symbol, because those
> > are used for CFI and not executed. Probing it will break the CFI.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks! I will pick this for probes/fixes.


> 
> -- Steve
> 
> > ---
> >  Changes in v2:
> >   - Check "__pfx_" prefix functions too.
> >   - Make the check unconditional.
> > ---
> >  kernel/kprobes.c |   14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
