Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE4278C393
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 13:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjH2Lr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 07:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjH2Lrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 07:47:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBA2109;
        Tue, 29 Aug 2023 04:47:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48FB560B70;
        Tue, 29 Aug 2023 11:47:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42DAC433C7;
        Tue, 29 Aug 2023 11:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693309651;
        bh=2JIypwUK6FhIZ3QHAhrbsLajiBfjZ62lgJwSgVYXJYg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=WpoxyfT96RrgWmxmpt0PCKw3+0p9AMvKZBdy3TXUdL05NbfuKsxK77tiGyJnGNJpR
         gCGygjGrcu2CfbwyEtnC3unyQWxnfWRPgPW2rcGvRqZOPr5ZCLr66H480QkVADumGf
         InSYuRL8On+eG8q/1uYOyJTBCfDVCb2KlPilpds3+dHyBMuhNysqkxgc+wxr1GlmVL
         iXwL1UMc3X0KoIZljIw6IO1+ivfZ3oug14DW5RYpHh3LxbR9m0yUy7nLEpRxa8wCxJ
         7VAMZeaEio82tcD6cbFptCLSLvY0SNF0whvzjsjTrm62OguXDmgW43D8ZdJG9fxxZY
         xeuuLZ623t+QQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "Revert "wifi: ath11k: Enable threaded NAPI""
References: <20230809073432.4193-1-johan+linaro@kernel.org>
        <ZONpkVU1ORHj-zFH@hovoldconsulting.com> <87o7izi6br.fsf@kernel.org>
        <ZOS7zdWNaqmfCHet@hovoldconsulting.com>
        <ZOof7EE0tXAt0YN7@hovoldconsulting.com>
Date:   Tue, 29 Aug 2023 14:47:27 +0300
In-Reply-To: <ZOof7EE0tXAt0YN7@hovoldconsulting.com> (Johan Hovold's message
        of "Sat, 26 Aug 2023 17:53:16 +0200")
Message-ID: <87leduf4ts.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johan Hovold <johan@kernel.org> writes:

> On Tue, Aug 22, 2023 at 03:44:45PM +0200, Johan Hovold wrote:
>> On Tue, Aug 22, 2023 at 03:56:24PM +0300, Kalle Valo wrote:
>> > Johan Hovold <johan@kernel.org> writes:
>> > > On Wed, Aug 09, 2023 at 09:34:32AM +0200, Johan Hovold wrote:
>> > >
>> > >> Disabling threaded NAPI caused a severe regression in 6.5-rc5 by making
>> > >> the X13s completely unusable (e.g. no keyboard input, I've seen an RCU
>> > >> splat once).
>> 
>> > > Any chance we can get the offending commit reverted before 6.5 is
>> > > released? 
>> > 
>> > The problem here is that would break QCN9074 again so there is no good
>> > solution. I suspect we have a fundamental issue in ath11k which we just
>> > haven't discovered yet. I would prefer to get to the bottom of this
>> > before reverting anything.
>> 
>> Sure, ideally we can find and fix the underlying issues these next few
>> days, but since this regression was introduced in rc5 in an attempt to
>> address the QCN9074 issue which has been there since 6.1 I think we
>> need to revert otherwise. 
>
> I've managed to track down what causes the hang on the X13s after
> disabling threaded NAPI. Turns out to be a severe regression in the
> genirq code that causes the software resend tasklet to loop
> indefinitely.
>
> I've just sent a fix here:
>
> 	https://lore.kernel.org/lkml/20230826154004.1417-1-johan+linaro@kernel.org/

Oh wow, that's a tricky bug :o I'm sure it was not easy to find.

> I've also made some progress on the QCN9074 hang, but keeping the
> threaded NAPI revert for now is indeed the right thing to do.

Ok, thanks for the update and looking at also this problem. Very much
appreciated! I'm sure we have a major bug lurking somewhere in ath11k,
would be so good to fix that.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
