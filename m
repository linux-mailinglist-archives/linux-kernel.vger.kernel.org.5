Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BE478424B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbjHVNox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbjHVNow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:44:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1163B19A;
        Tue, 22 Aug 2023 06:44:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9545B656FA;
        Tue, 22 Aug 2023 13:44:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5439C433C7;
        Tue, 22 Aug 2023 13:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692711889;
        bh=0cUpYuMSDrgHXWCsxLU6JaxRi+nUtLLQl0WkRsCUSD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h58jkPrUVrFT5bYstrdcltlWZbIgg2BEJHzRk5VjfuWh2Ng/s0nztCnEUaNamBMwf
         lkEXeAT4CB6TPXc2rAt0wtFb4WVAdF9b2A6t2/Wq2pfdflP1LOgAsNGGi0Bj4jf5Zr
         3NIgbbbwCX5muM0uQqVp7svns0oyfuFItWU1DAb7tdZHKUJbiP20KQ3Fp8AP41jPMw
         gY1vA9sGu4PcQafZIfNrm2Flvat/WdfcXTMeYu3w0FrknZAfsFIeiGcvHuUp+zTY1T
         NEh98VVz4bCKTIhkWK21qXziaCUmA5l4E8GU+mrLvdPR/yHr2g2NW4rmrRaQAw2PAd
         A+ikNfn/uGKIA==
Received: from johan by theta with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qYRgb-000127-1r;
        Tue, 22 Aug 2023 15:44:45 +0200
Date:   Tue, 22 Aug 2023 15:44:45 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "Revert "wifi: ath11k: Enable threaded NAPI""
Message-ID: <ZOS7zdWNaqmfCHet@hovoldconsulting.com>
References: <20230809073432.4193-1-johan+linaro@kernel.org>
 <ZONpkVU1ORHj-zFH@hovoldconsulting.com>
 <87o7izi6br.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7izi6br.fsf@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 03:56:24PM +0300, Kalle Valo wrote:
> Johan Hovold <johan@kernel.org> writes:
> > On Wed, Aug 09, 2023 at 09:34:32AM +0200, Johan Hovold wrote:
> >
> >> Disabling threaded NAPI caused a severe regression in 6.5-rc5 by making
> >> the X13s completely unusable (e.g. no keyboard input, I've seen an RCU
> >> splat once).

> > Any chance we can get the offending commit reverted before 6.5 is
> > released? 
> 
> The problem here is that would break QCN9074 again so there is no good
> solution. I suspect we have a fundamental issue in ath11k which we just
> haven't discovered yet. I would prefer to get to the bottom of this
> before reverting anything.

Sure, ideally we can find and fix the underlying issues these next few
days, but since this regression was introduced in rc5 in an attempt to
address the QCN9074 issue which has been there since 6.1 I think we
need to revert otherwise. 

> > I'll take a closer look at this meanwhile.
> 
> Thanks, much appreciated. Did you try enabling all kernel debug
> features, maybe they would give some hints?

Yes, I have a bunch of those enabled. Lockdep does not complain, but the
hard lockup detector triggers and it looks like CPU0 (which handles most
interrupts on this machine currently) has got stuck while processing an
interrupt.

RCU also detects the stall on CPU0 and provides a task dump for
ksoftirqd with the following call trace:

	__switch_to
	run_ksoftirqd
	smpboot_thread_fn
	kthread
	ret_from_fork

I just tried the out-of-tree pseudo NMI series [0] to get a stack trace,
but CPU0 does not respond to those either when I hit this.

Note that it takes a bit of RX to trigger this, but I hit it as soon as
I try to download something substantial (e.g. after a couple of MB).

Johan

[0] https://lore.kernel.org/lkml/20230419225604.21204-1-dianders@chromium.org/
