Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4D07B5829
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238610AbjJBQ4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238563AbjJBQ4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:56:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9935BCC3;
        Mon,  2 Oct 2023 09:55:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D83C433C9;
        Mon,  2 Oct 2023 16:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696265756;
        bh=sPlHNmzUSdBxnJ8yitiqY23idbEgXus5Y1nrmAkWweQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=sARPa3QNqo2ddqMiMCByHiNP+YQvPz19V1/oiSd/ZW2tmwUsrFzKXIwm1/cu9mqZL
         NUiibzUjfgDoNeu7m5NOb/Fjk2Dt6Pb5tbdbR5KEpoLeW1s+Hnk0yU7jOz1OIb/6oS
         AwNccwIzlqbjaB/ET75fjRwmnFmbZjQTB9L+k0KunjRNCGy+nRK3BBCNObY7dqjQtP
         NTa9sPQkcoJRfBi/Tr2uK9k2qADCz4DBf3P+ttoUGUt/KK9ymYILx4w5p+MqdELYlw
         eFEdIXCSvegwaflyLsYSrS3/I+U17/QEGDtiEV5zL6DKmha6zPE2EfPmudjLng+1FK
         A6VOaEoUq/L1Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: Don't touch the CE interrupt registers after
 power up
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230630151842.1.If764ede23c4e09a43a842771c2ddf99608f25f8e@changeid>
References: <20230630151842.1.If764ede23c4e09a43a842771c2ddf99608f25f8e@changeid>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     ath10k@lists.infradead.org, Abhishek Kumar <kuabhs@chromium.org>,
        Youghandhar Chintala <quic_youghand@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169626575295.3936351.833023194847155734.kvalo@kernel.org>
Date:   Mon,  2 Oct 2023 16:55:54 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas Anderson <dianders@chromium.org> wrote:

> As talked about in commit d66d24ac300c ("ath10k: Keep track of which
> interrupts fired, don't poll them"), if we access the copy engine
> register at a bad time then ath10k can go boom. However, it's not
> necessarily easy to know when it's safe to access them.
> 
> The ChromeOS test labs saw a crash that looked like this at
> shutdown/reboot time (on a chromeos-5.15 kernel, but likely the
> problem could also reproduce upstream):
> 
> Internal error: synchronous external abort: 96000010 [#1] PREEMPT SMP
> ...
> CPU: 4 PID: 6168 Comm: reboot Not tainted 5.15.111-lockdep-19350-g1d624fe6758f #1 010b9b233ab055c27c6dc88efb0be2f4e9e86f51
> Hardware name: Google Kingoftown (DT)
> ...
> pc : ath10k_snoc_read32+0x50/0x74 [ath10k_snoc]
> lr : ath10k_snoc_read32+0x24/0x74 [ath10k_snoc]
> ...
> Call trace:
> ath10k_snoc_read32+0x50/0x74 [ath10k_snoc ...]
> ath10k_ce_disable_interrupt+0x190/0x65c [ath10k_core ...]
> ath10k_ce_disable_interrupts+0x8c/0x120 [ath10k_core ...]
> ath10k_snoc_hif_stop+0x78/0x660 [ath10k_snoc ...]
> ath10k_core_stop+0x13c/0x1ec [ath10k_core ...]
> ath10k_halt+0x398/0x5b0 [ath10k_core ...]
> ath10k_stop+0xfc/0x1a8 [ath10k_core ...]
> drv_stop+0x148/0x6b4 [mac80211 ...]
> ieee80211_stop_device+0x70/0x80 [mac80211 ...]
> ieee80211_do_stop+0x10d8/0x15b0 [mac80211 ...]
> ieee80211_stop+0x144/0x1a0 [mac80211 ...]
> __dev_close_many+0x1e8/0x2c0
> dev_close_many+0x198/0x33c
> dev_close+0x140/0x210
> cfg80211_shutdown_all_interfaces+0xc8/0x1e0 [cfg80211 ...]
> ieee80211_remove_interfaces+0x118/0x5c4 [mac80211 ...]
> ieee80211_unregister_hw+0x64/0x1f4 [mac80211 ...]
> ath10k_mac_unregister+0x4c/0xf0 [ath10k_core ...]
> ath10k_core_unregister+0x80/0xb0 [ath10k_core ...]
> ath10k_snoc_free_resources+0xb8/0x1ec [ath10k_snoc ...]
> ath10k_snoc_shutdown+0x98/0xd0 [ath10k_snoc ...]
> platform_shutdown+0x7c/0xa0
> device_shutdown+0x3e0/0x58c
> kernel_restart_prepare+0x68/0xa0
> kernel_restart+0x28/0x7c
> 
> Though there's no known way to reproduce the problem, it makes sense
> that it would be the same issue where we're trying to access copy
> engine registers when it's not allowed.
> 
> Let's fix this by changing how we "disable" the interrupts. Instead of
> tweaking the copy engine registers we'll just use disable_irq() and
> enable_irq(). Then we'll configure the interrupts once at power up
> time.
> 
> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

170c75d43a77 wifi: ath10k: Don't touch the CE interrupt registers after power up

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230630151842.1.If764ede23c4e09a43a842771c2ddf99608f25f8e@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

