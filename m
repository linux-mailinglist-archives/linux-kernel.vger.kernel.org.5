Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0967578414F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbjHVM4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbjHVM4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:56:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A2ECD5;
        Tue, 22 Aug 2023 05:56:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51C25653A7;
        Tue, 22 Aug 2023 12:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF48C433C8;
        Tue, 22 Aug 2023 12:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692708988;
        bh=2WNX9QQVAoAuPFyHg3TYLIP+sACknmV5BgHbBDJLXhg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Kc9wbtP019ThJqTZl07TKJdIhRJV8MLPsBxb6Bpoaq511RbNdjQva/I5VkTXMePXq
         xvFhDnBgHVwsbleZbHEy0Zy817mp44jSaT9epmtiPtNAx15KgjRkhjvm4kxHxLqpoa
         tjuYkcSO08QKQcqSQm7TtkTaWtz/en9nCFU7MSChqqBrzdaMCABurvhXLLHDrBliPe
         WSqZim9GcJwi/FxUl7jhuNm4cSGN37j2ScUwtYMtDD4avD/4LAqJf+a1GDBrK9fG7V
         u/T8IHmkCUSd9709CN1Cn0XsigAmn4c2n76TC6tUWPGvPeaUe9QENW78p6z40y26Ue
         wTaS/FD140PcQ==
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
        <ZONpkVU1ORHj-zFH@hovoldconsulting.com>
Date:   Tue, 22 Aug 2023 15:56:24 +0300
In-Reply-To: <ZONpkVU1ORHj-zFH@hovoldconsulting.com> (Johan Hovold's message
        of "Mon, 21 Aug 2023 15:41:37 +0200")
Message-ID: <87o7izi6br.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johan Hovold <johan@kernel.org> writes:

> Hi Kalle,
>
> On Wed, Aug 09, 2023 at 09:34:32AM +0200, Johan Hovold wrote:
>
>> Disabling threaded NAPI caused a severe regression in 6.5-rc5 by making
>> the X13s completely unusable (e.g. no keyboard input, I've seen an RCU
>> splat once).
>> 
>> I'm supposed to be on holiday this week, but thanks to the rain I gave
>> rc5 a try and ran into this.
>> 
>> I've added Bjorn, Mani and Konrad on CC who may be able to help with
>> debugging this further if needed while I'm out-of-office.
>
> Back from my holiday now, and this regression is still there with
> 6.5-rc7.

I was also away but back now.

> Any chance we can get the offending commit reverted before 6.5 is
> released? 

The problem here is that would break QCN9074 again so there is no good
solution. I suspect we have a fundamental issue in ath11k which we just
haven't discovered yet. I would prefer to get to the bottom of this
before reverting anything.

> I'll take a closer look at this meanwhile.

Thanks, much appreciated. Did you try enabling all kernel debug
features, maybe they would give some hints?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
