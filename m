Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0E87EA3CD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjKMTf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjKMTf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:35:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A279D6E;
        Mon, 13 Nov 2023 11:35:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA8EC433C7;
        Mon, 13 Nov 2023 19:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699904153;
        bh=JPhKLghvGw7StGSXf9vQqvISbNEZ2A3Ksd7jEA2P43c=;
        h=Date:From:To:Cc:Subject:From;
        b=EJ1+KQXzxNB13oEzr4f1dnR5SV6Q3UTECdIxoz9WkICpSJpIgrKPkhzr2IlCYHnrl
         ls21xmpHW6HgBsgZ6vsn/hIuWP8E2abKEU7PXKZTWPONhiUMIxTHVmU0fHTsdIIdz4
         ZG4kN5xOngj/ORNWaxeM7KqfBDDB4XusRxMNntI6JxAyxLnQXen8W4uz5o20SEgKhu
         IzHB3IJaezfn8C+b1EeNgEcs2Lrs1a2i+P9zkC0ZaPDyjv6lGQobg9idKCMYHr+mJZ
         11COhrXciddhSaH69A5JSSfpNzUvtTCma09sbn+669i7+aelA/kMEmcbuhF71Cfk5I
         M0nqlCewMnUzw==
Date:   Mon, 13 Nov 2023 13:35:49 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: rtw89: coex: Fix -Wstringop-overflow warnings in
 _append_tdma()
Message-ID: <ZVJ6lRCRaywGktxJ@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Copy a couple of structures directly, instead of using `memcpy()`.

This addesses the following -Wstringop-overflow warnings:
drivers/net/wireless/realtek/rtw89/coex.c: In function ‘_append_tdma’:
./include/linux/fortify-string.h:57:33: warning: writing 8 bytes into a region of size 0 [-Wstringop-overflow=]
   57 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^
./include/linux/fortify-string.h:644:9: note: in expansion of macro ‘__underlying_memcpy’
  644 |         __underlying_##op(p, q, __fortify_size);                        \
      |         ^~~~~~~~~~~~~
./include/linux/fortify-string.h:689:26: note: in expansion of macro ‘__fortify_memcpy_chk’
  689 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
      |                          ^~~~~~~~~~~~~~~~~~~~
drivers/net/wireless/realtek/rtw89/coex.c:1585:17: note: in expansion of macro ‘memcpy’
 1585 |                 memcpy(&v3->tdma, &dm->tdma, sizeof(v3->tdma));
      |                 ^~~~~~
drivers/net/wireless/realtek/rtw89/core.h:2703:37: note: at offset [5714, 71249] into destination object ‘ver’ of size 8
 2703 |         const struct rtw89_btc_ver *ver;
      |                                     ^~~
./include/linux/fortify-string.h:57:33: warning: writing 8 bytes into a region of size 0 [-Wstringop-overflow=]
   57 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^
./include/linux/fortify-string.h:644:9: note: in expansion of macro ‘__underlying_memcpy’
  644 |         __underlying_##op(p, q, __fortify_size);                        \
      |         ^~~~~~~~~~~~~
./include/linux/fortify-string.h:689:26: note: in expansion of macro ‘__fortify_memcpy_chk’
  689 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
      |                          ^~~~~~~~~~~~~~~~~~~~
drivers/net/wireless/realtek/rtw89/coex.c:1579:17: note: in expansion of macro ‘memcpy’
 1579 |                 memcpy(v, &dm->tdma, sizeof(*v));
      |                 ^~~~~~
drivers/net/wireless/realtek/rtw89/core.h:2703:37: note: at offset [5710, 71245] into destination object ‘ver’ of size 8
 2703 |         const struct rtw89_btc_ver *ver;
      |                                     ^~~

This helps with the ongoing efforts to globally enable
-Wstringop-overflow.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index bdcc172639e4..b842cd9a86f8 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -1576,13 +1576,13 @@ static void _append_tdma(struct rtw89_dev *rtwdev)
 	if (ver->fcxtdma == 1) {
 		v = (struct rtw89_btc_fbtc_tdma *)&tlv->val[0];
 		tlv->len = sizeof(*v);
-		memcpy(v, &dm->tdma, sizeof(*v));
+		*v = dm->tdma;
 		btc->policy_len += BTC_TLV_HDR_LEN + sizeof(*v);
 	} else {
 		tlv->len = sizeof(*v3);
 		v3 = (struct rtw89_btc_fbtc_tdma_v3 *)&tlv->val[0];
 		v3->fver = ver->fcxtdma;
-		memcpy(&v3->tdma, &dm->tdma, sizeof(v3->tdma));
+		v3->tdma = dm->tdma;
 		btc->policy_len += BTC_TLV_HDR_LEN + sizeof(*v3);
 	}
 
-- 
2.34.1

