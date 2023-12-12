Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FF080EFBF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376486AbjLLPLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376490AbjLLPLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:11:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32F6DB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:11:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E2DC433C9;
        Tue, 12 Dec 2023 15:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702393873;
        bh=QPR/krVHmjoQ5/V+yZQzkxTpdJRIO/LwVtq9frP3VZk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=q2bntngsIpTggy2/06KzhMJGxAejpTAkBOzkHxt92ddFX9KqK+cjbpZjxvBdNQioF
         Bc5MQ8wLVo/B2sVu+8PtESSh17k0Q45m+tg2xLvEoIqu3h7hgrkZhEMvA4+aTTj7HM
         +yYHrcLa5BgyjuJz8ngjQx7ntFQi86YzOIAkTBoqvDZhb5gCilxc/VPobUMPFDHu9F
         ZwpgiFK/89oePtMXbrptqcssQO2IYiotE5C9awly8FmBZX75ZgjxudAiNXdoZuMVHq
         CLz6ps7n02aCCKmN9bE6r2MQJjv1DfqGVIETccp0Eh6A0sGcMriwSmQBg5BeZIN8Ue
         F4UCAmQUlsZ5A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: rtw89: avoid stringop-overflow warning
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231204073020.1105416-1-arnd@kernel.org>
References: <20231204073020.1105416-1-arnd@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Ping-Ke Shih <pkshih@realtek.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ching-Te Ku <ku920601@realtek.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170239387004.306086.15470071247075562655.kvalo@kernel.org>
Date:   Tue, 12 Dec 2023 15:11:11 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> After -Wstringop-overflow got enabled, the rtw89 driver produced
> two odd warnings with gcc-13:
> 
> drivers/net/wireless/realtek/rtw89/coex.c: In function 'rtw89_btc_ntfy_scan_start':
> drivers/net/wireless/realtek/rtw89/coex.c:5362:50: error: writing 1 byte into a region of size 0 [-Werror=stringop-overflow=]
>  5362 |                 wl->dbcc_info.scan_band[phy_idx] = band;
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
> In file included from drivers/net/wireless/realtek/rtw89/coex.h:8,
>                  from drivers/net/wireless/realtek/rtw89/coex.c:5:
> drivers/net/wireless/realtek/rtw89/core.h:1441:12: note: at offset [64, 255] into destination object 'scan_band' of size 2
>  1441 |         u8 scan_band[RTW89_PHY_MAX]; /* scan band in  each phy */
>       |            ^~~~~~~~~
> drivers/net/wireless/realtek/rtw89/coex.c: In function 'rtw89_btc_ntfy_switch_band':
> drivers/net/wireless/realtek/rtw89/coex.c:5406:50: error: writing 1 byte into a region of size 0 [-Werror=stringop-overflow=]
>  5406 |                 wl->dbcc_info.scan_band[phy_idx] = band;
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
> drivers/net/wireless/realtek/rtw89/core.h:1441:12: note: at offset [64, 255] into destination object 'scan_band' of size 2
>  1441 |         u8 scan_band[RTW89_PHY_MAX]; /* scan band in  each phy */
>       |            ^~~~~~~~~
> 
> I don't know what happened here, but adding an explicit range check
> shuts up the output.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied to wireless-next.git, thanks.

595b1280e2c9 wifi: rtw89: avoid stringop-overflow warning

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231204073020.1105416-1-arnd@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

