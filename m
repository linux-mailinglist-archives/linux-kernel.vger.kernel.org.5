Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAFA7D67B9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbjJYJ7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjJYJ7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:59:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1445FDD;
        Wed, 25 Oct 2023 02:59:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F09EC433C7;
        Wed, 25 Oct 2023 09:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698227979;
        bh=015JNksl5/RLSxX1un00vsL2YWb8KGSC/yS8zTmEXAs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=E/TIj8kTBcY31vwevcUSuJDF5aKI1Pl6gtHQ0d9a6bq8KbPTBzhvKcgAjawLAv7Ao
         IqUCfnD1Wa6JkV3gA9x1YqimDgIp76R9G2EEzaU6D9rdkKnkSQkaUjQewlY46MvXZS
         USEImOHpqpFP3jK2oGitUfkDGsyQEFXGxC685qI0+mnOq4VOtl1ioB6PgFPng10E6h
         oo7qmIoaSZD53X9TBdxGZgK8hzdJ6z+1zfb56isxwgh71Xbo2HFrbemTM9lKZDPUSN
         azrpllh63UEggIgh1PARC4tW7AAs3QNb5J3gaLMxnWUHj62g8XoCd+WXWUD6DxWHHw
         jVpTEe+DKT1ZA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/2] wifi: ath11k: fix temperature event locking
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231019153115.26401-2-johan+linaro@kernel.org>
References: <20231019153115.26401-2-johan+linaro@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169822797640.891844.4871182636116201125.kvalo@kernel.org>
Date:   Wed, 25 Oct 2023 09:59:37 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johan Hovold <johan+linaro@kernel.org> wrote:

> The ath11k active pdevs are protected by RCU but the temperature event
> handling code calling ath11k_mac_get_ar_by_pdev_id() was not marked as a
> read-side critical section as reported by RCU lockdep:
> 
>         =============================
>         WARNING: suspicious RCU usage
>         6.6.0-rc6 #7 Not tainted
>         -----------------------------
>         drivers/net/wireless/ath/ath11k/mac.c:638 suspicious rcu_dereference_check() usage!
> 
>         other info that might help us debug this:
> 
>         rcu_scheduler_active = 2, debug_locks = 1
>         no locks held by swapper/0/0.
>         ...
>         Call trace:
>         ...
>          lockdep_rcu_suspicious+0x16c/0x22c
>          ath11k_mac_get_ar_by_pdev_id+0x194/0x1b0 [ath11k]
>          ath11k_wmi_tlv_op_rx+0xa84/0x2c1c [ath11k]
>          ath11k_htc_rx_completion_handler+0x388/0x510 [ath11k]
> 
> Mark the code in question as an RCU read-side critical section to avoid
> any potential use-after-free issues.
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> 
> Fixes: a41d10348b01 ("ath11k: add thermal sensor device support")
> Cc: stable@vger.kernel.org      # 5.7
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

1a5352a81b47 wifi: ath11k: fix temperature event locking
3b6c14833165 wifi: ath11k: fix dfs radar event locking

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231019153115.26401-2-johan+linaro@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

