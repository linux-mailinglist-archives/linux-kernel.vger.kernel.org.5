Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400EA76F44F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 22:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbjHCUxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 16:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjHCUxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 16:53:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DABF421A;
        Thu,  3 Aug 2023 13:53:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA61C61EA8;
        Thu,  3 Aug 2023 20:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DDBC433C8;
        Thu,  3 Aug 2023 20:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691096013;
        bh=gnY0icLGx3OFl0vDnCwwzG6CyKZI5b2IVmGBpNdxe6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fCat80oZbGRxutrrlcy6605LCCFL9dLpHI6nEbLIMs03mnvudOhQhlRJpca1SD8rt
         1SnZRGVEeAme+AX+M0Cl4ppHY6YMWlq0b9MRK7Er8f2GdxNphGPQZctnXqGChYvcAv
         SL74YtEoQWIoj8zFz+5rTyr2R8/hqVpLr3YNtbtrcXQdFXyi1BAsh5MN1Eog2+5PPD
         0+BLBCf52PtOFRUgVZhhc752f9ezDczJdhbbQzMavKCU4QbaI1o3OV9aepr1cj19NA
         kWSvpa4aUh1kMsPNKPMdH+Ioe7QlRlb01WhZsNJM4H8y00rvwTNoNe60roQZUgcnEE
         Q9+pLKiyFhRNQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8D2D8404DF; Thu,  3 Aug 2023 17:53:29 -0300 (-03)
Date:   Thu, 3 Aug 2023 17:53:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf doc: Document ring buffer mechanism
Message-ID: <ZMwTyVKPn0cRewEc@kernel.org>
References: <20230803035037.1750340-1-leo.yan@linaro.org>
 <87v8dw6vp1.fsf@meer.lwn.net>
 <20230803165636.GB1783639@leoy-huanghe.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803165636.GB1783639@leoy-huanghe.lan>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 04, 2023 at 12:56:36AM +0800, Leo Yan escreveu:
> Hi Jon,
> 
> On Thu, Aug 03, 2023 at 08:34:50AM -0600, Jonathan Corbet wrote:
> > Leo Yan <leo.yan@linaro.org> writes:
> > 
> > > In the Linux perf tool, the ring buffer serves not only as a medium for
> > > transferring PMU event data but also as a vital mechanism for hardware
> > > tracing using technologies like Intel PT and Arm CoreSight, etc.
> > >
> > > Consequently, the ring buffer mechanism plays a crucial role by ensuring
> > > high throughput for data transfer between the kernel and user space
> > > while avoiding excessive overhead caused by the ring buffer itself.
> > >
> > > This commit documents the ring buffer mechanism in detail.  It provides
> > > an in-depth explanation of the implementation of both the generic ring
> > > buffer and the AUX ring buffer.  Additionally, it covers how these ring
> > > buffers support various tracing modes and explains the synchronization
> > > with memory barriers.
> > >
> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > ---
> > 
> > So this seems like good material from a very brief scan.  I do have to
> > ask, though: why is it not in RST, and why not put it into the
> > user-space API book?
> 
> This documentation is Perf related topic, so my instinct is to place
> it into the folder tools/perf/Documentation/.
> 
> Strictly to say, the doc doesn't give formal introduction for the
> user-space APIs.  Given perf ring buffer is a mechanism for exchanging
> data between the kernel and user space, I am open for placing it in the
> folder Documentation/userspace-api/.
> 
> I would like get opinions from the perf maintainers if possible, if we
> have agreenment I am glad to convert it to RST format.

Yeah, I agree with Jon.

- Arnaldo
