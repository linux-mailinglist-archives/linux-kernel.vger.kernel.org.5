Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD32480EFB2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376483AbjLLPJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376469AbjLLPJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:09:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D41D3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:09:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0F8C433C7;
        Tue, 12 Dec 2023 15:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702393770;
        bh=Dd+Z9g8Wy9pE/XbicCpt6HzoSR2qPgHCFARthzdpVJ0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=EknqhJ48zdty/TvXxhQhjINVvNz70LWWe1nCJ0hC3o5SwQu1v3g9NkkLvmYnpntZq
         kuTTu54aL6cCpME7W5w/OZ4ynNorUF6jL6GACwmTP7vGG3lxzUuSODN88EKpcuMyG6
         ckCtYRAfESJXYsK/bFIqBYNYxbNTw7jTKFrYNcldjNFSUgvs60t6cvLzWuJpxNKFcF
         TmOZimDPKkM32RGWMHrGXNg4kxDAIqdrfezpQ+EB3ydFBBOSqKxlnW2C2W+iqWXozO
         ggAKjG6e/TFBzY/QppVqhjy99DQweo9FJbK8t44OMPq0gdvgBB57AecJ3WyUNR208b
         OPwuiWsNz1M3w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH][next] wifi: mt76: mt7996: Use DECLARE_FLEX_ARRAY() and
 fix
 -Warray-bounds warnings
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <ZVaCNAohuieMmdq9@work>
References: <ZVaCNAohuieMmdq9@work>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170239376588.306086.11901816078975577906.kvalo@kernel.org>
Date:   Tue, 12 Dec 2023 15:09:27 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> Transform zero-length arrays `adm_stat` and `msdu_cnt` into proper
> flexible-array members in anonymous union in `struct
> mt7996_mcu_all_sta_info_event` via the DECLARE_FLEX_ARRAY()
> helper; and fix multiple -Warray-bounds warnings:
> 
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:483:61: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:490:58: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:492:58: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:469:61: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:477:66: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:479:66: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> 
> This results in no differences in binary output, helps with the ongoing
> efforts to globally enable -Warray-bounds.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Fails to apply, please rebase on top of wireless-next.

Recorded preimage for 'drivers/net/wireless/mediatek/mt76/mt7996/mcu.h'
error: Failed to merge in the changes.
hint: Use 'git am --show-current-patch=diff' to see the failed patch
Applying: wifi: mt76: mt7996: Use DECLARE_FLEX_ARRAY() and fix -Warray-bounds warnings
Using index info to reconstruct a base tree...
M	drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
CONFLICT (content): Merge conflict in drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
Patch failed at 0001 wifi: mt76: mt7996: Use DECLARE_FLEX_ARRAY() and fix -Warray-bounds warnings

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/ZVaCNAohuieMmdq9@work/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

