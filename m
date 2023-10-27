Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF057D9160
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345420AbjJ0IZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbjJ0IZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:25:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57511B1;
        Fri, 27 Oct 2023 01:25:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3D5C433C7;
        Fri, 27 Oct 2023 08:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698395132;
        bh=QfeOWdwE/IqoYB+mqr3chG0yS+T71+Nm/ssIY25qlkk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=iHzGHUBYp8J5jK0eJJXhQwe2tROaFdXhyaE9WXpL2QJaeNYhqGWrVX/Wuov+RF7Yz
         jtasbTiM94yhN0ZwLm9vSB0XMYB01AiFWbi77ecTU98zIsIPsH3tuw1XQCczwHec74
         VLg8Hq/oow8+z7plFR88BHej0Btb9VGwUaS4FxaVzKvSkWtluXiAql/7sjQzlzLhTD
         EkMgPWxkjqPLWlipA+KLtEUxV/m2D+NlZ0bBCOvLG14G0z0tCxkbFKFxMNLRuHIndZ
         30tlzT8KETaxluOYytLD0Xe9gn0y/7f/cmyOumwVOLNX4UDKJgp+jPZYiH/7EK42Ec
         E/ovnyIHnxUdw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] wifi: ath11k: Defer on rproc_get failure
References: <20231027-ath11k-rproc-defer-v1-1-f6b6a812cd18@fairphone.com>
Date:   Fri, 27 Oct 2023 11:25:28 +0300
In-Reply-To: <20231027-ath11k-rproc-defer-v1-1-f6b6a812cd18@fairphone.com>
        (Luca Weiss's message of "Fri, 27 Oct 2023 08:57:18 +0200")
Message-ID: <87lebowjyf.fsf@kernel.org>
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

Luca Weiss <luca.weiss@fairphone.com> writes:

> If we already have gotten the rproc_handle (meaning the "qcom,rproc"
> property is defined in the devicetree), it's a valid state that the
> remoteproc module hasn't probed yet so we should defer probing instead
> of just failing to probe.
>
> This resolves a race condition when the ath11k driver probes and fails
> before the wpss remoteproc driver has probed, like the following:
>
>   [    6.232360] ath11k 17a10040.wifi: failed to get rproc
>   [    6.232366] ath11k 17a10040.wifi: failed to get rproc: -22
>   [    6.232478] ath11k: probe of 17a10040.wifi failed with error -22
>        ...
>   [    6.252415] remoteproc remoteproc2: 8a00000.remoteproc is available
>   [    6.252776] remoteproc remoteproc2: powering up 8a00000.remoteproc
>   [    6.252781] remoteproc remoteproc2: Booting fw image qcom/qcm6490/fairphone5/wpss.mdt, size 7188
>
> So, defer the probe if we hit that so we can retry later once the wpss
> remoteproc is available.
>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Did you test this on a real device? If yes, what ath11k hardware and firmware
did you use? We use Tested-on tag to document that:

https://wireless.wiki.kernel.org/en/users/drivers/ath11k/submittingpatches#tested-on_tag

I can add that in the pending branch if you provide the info.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
