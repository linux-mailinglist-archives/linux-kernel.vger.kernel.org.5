Return-Path: <linux-kernel+bounces-165793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 393F58B91B3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 00:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AD6F1C2154B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2A41635C7;
	Wed,  1 May 2024 22:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSGN62oS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7481E481;
	Wed,  1 May 2024 22:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714603301; cv=none; b=OMuCJbAcYCA88ygDKxehbbwgcC4Wwx8hzQNnT/9vbbzQ1k5d3a6VzszxmHP1NlJANbcD3x2XJ0Fuoi5ubMbcFtreSBkuE11qXwTS55eVzlrV1rD9opOVA46KFCE6MwPSAU2Fno+OFJQiRdZ2mq5orq1/l7remaOBvxozkRGJVrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714603301; c=relaxed/simple;
	bh=21eJgw3bVlrvg9JhkL7vGWg5gy5SSNA9yb+RC4qJH0U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RwZIJH0vdvg1H+nlxH0dNqyvD869iUErtIiz5mjEZG86ruThBwAK3VfDJNF6+DqP3fkMYWVho7TzBiLmvOedTOAdpz7nuQoYlI+t4tchTkKA9mGQSa8QcNl6Ac+DR/9soLYqvtcumleeIvLqhwCvO1VqpPq0R1Hsa8BYwpmTMdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSGN62oS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B1DC072AA;
	Wed,  1 May 2024 22:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714603301;
	bh=21eJgw3bVlrvg9JhkL7vGWg5gy5SSNA9yb+RC4qJH0U=;
	h=Date:From:To:Cc:Subject:From;
	b=aSGN62oSHnV5bTA6Cvn6RwYasu8gLbikz9Uena1xj0g3FEdeZ6cnNnzh4kCddR+tR
	 v37PBkCHIx8DwAGrZIkOEeNj3mpeC6kEHyC5SkTqDid6Nzh7vAnHHb3el4FaV8cUMy
	 O4FH4dVBPBA7HNWE+NOBvGiNOXOCLUGRQKRw7YnB+JlkXGMyE4R+g8hYD21mYB1PTL
	 VQ1dl+ALcIckEWwFwuDX+vVzvowFAfJnS2h4kNHUf6YYL1OeZ12tY9J6nM8XFDA4Fg
	 ikb+91aQjR/NRbbvCPAn0UPgtIrVROV2eHcTN3nmQmKaMtYNKxmyO7RraUoHpUtI+t
	 axN/fW8F34JWw==
Date: Wed, 1 May 2024 16:41:37 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: rtlwifi: Remove unused structs and avoid
 multiple -Wfamnae warnings
Message-ID: <ZjLFIa31BGPVCGh1@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
ready to enable it globally.

So, remove unused structs and fix the following
-Wflex-array-member-not-at-end warnings:

drivers/net/wireless/realtek/rtlwifi/btcoexist/../wifi.h:1063:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/realtek/rtlwifi/rtl8188ee/../wifi.h:1063:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/realtek/rtlwifi/rtl8192c/../wifi.h:1063:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/realtek/rtlwifi/rtl8192ce/../wifi.h:1063:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/realtek/rtlwifi/rtl8192cu/../wifi.h:1063:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/realtek/rtlwifi/rtl8192de/../wifi.h:1063:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/realtek/rtlwifi/rtl8192ee/../wifi.h:1063:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/realtek/rtlwifi/rtl8192se/../wifi.h:1063:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/realtek/rtlwifi/rtl8723ae/../wifi.h:1063:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/realtek/rtlwifi/rtl8723be/../wifi.h:1063:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/realtek/rtlwifi/rtl8723com/../wifi.h:1063:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/realtek/rtlwifi/rtl8821ae/../wifi.h:1063:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/realtek/rtlwifi/wifi.h:1063:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/realtek/rtlwifi/wifi.h | 27 ---------------------
 1 file changed, 27 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index 9fabf597cfd6..f4c71890b989 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -1043,33 +1043,6 @@ struct octet_string {
 	u16 length;
 };
 
-struct rtl_hdr_3addr {
-	__le16 frame_ctl;
-	__le16 duration_id;
-	u8 addr1[ETH_ALEN];
-	u8 addr2[ETH_ALEN];
-	u8 addr3[ETH_ALEN];
-	__le16 seq_ctl;
-	u8 payload[];
-} __packed;
-
-struct rtl_info_element {
-	u8 id;
-	u8 len;
-	u8 data[];
-} __packed;
-
-struct rtl_probe_rsp {
-	struct rtl_hdr_3addr header;
-	u32 time_stamp[2];
-	__le16 beacon_interval;
-	__le16 capability;
-	/*SSID, supported rates, FH params, DS params,
-	 * CF params, IBSS params, TIM (if beacon), RSN
-	 */
-	struct rtl_info_element info_element[];
-} __packed;
-
 struct rtl_led_ctl {
 	bool led_opendrain;
 	enum rtl_led_pin sw_led0;
-- 
2.34.1


