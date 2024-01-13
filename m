Return-Path: <linux-kernel+bounces-25292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CDC82CCC9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 14:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B742284B1C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 13:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB70219FC;
	Sat, 13 Jan 2024 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DwwyCPkU"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23148210FE;
	Sat, 13 Jan 2024 13:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705151847; x=1736687847;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f/zLXvwgj4jxgYwgj1jMUxPl7GNVSbhmhNkWrqRyWW8=;
  b=DwwyCPkU3MWbXMH98kTwH1n99DMfxTQSz0/yxaMwJ+ZpWYtYMlG3Vc/l
   Bq7RmIGznPmGwdmL3Li2MJMrHeQuljYFcRv6vYCVGJ+Ie+1x+NGvgTmsG
   8I4yTMvUEOSkKzDEGye5CpCi7uTi+3c7eknGWDnftUMQEKu+kfifkac1c
   Hu+THrrIKc4I6kRvOsgMj3TzvdNO9fiDDg/AzBR+uwU37YLYIscY4vwV3
   xoiPZAB+3GBQUXsLigqE2WB7XyNPUAmyNDtH6XJGg1aHmz8SIq7uib4NJ
   Qz/JCCdkY+uV5ycSreksvwwNUDsvyOeaJpw8QFu6dBER4ISyqBKv9NEqN
   Q==;
X-CSE-ConnectionGUID: IbxK4g7OS92kjFhowD7KHA==
X-CSE-MsgGUID: z9b/JqlIRiWwUEdaoUa8TA==
X-IronPort-AV: E=Sophos;i="6.04,192,1695711600"; 
   d="scan'208";a="245432937"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jan 2024 06:17:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 13 Jan 2024 06:17:10 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sat, 13 Jan 2024 06:17:07 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>,
	<Divya.Koppera@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net 2/2] net: micrel: Fix set/get PHC time for lan8814
Date: Sat, 13 Jan 2024 14:15:21 +0100
Message-ID: <20240113131521.1051921-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240113131521.1051921-1-horatiu.vultur@microchip.com>
References: <20240113131521.1051921-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

When setting or getting PHC time, the higher bits of the second time (>32
bits) they were ignored. Meaning that setting some time in the future like
year 2150, it was failing to set this.

The issue can be reproduced like this:

 # phc_ctl /dev/ptp1 set 10000000000
 phc_ctl[118.619]: set clock time to 4294967295.000000000 or Sun Feb  7 06:28:15 2106

 # phc_ctl /dev/ptp1 get
 phc_ctl[120.858]: clock time is 1.238620924 or Thu Jan  1 00:00:01 1970

Fixes: ece19502834d ("net: phy: micrel: 1588 support for LAN8814 phy")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/micrel.c | 61 +++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 32 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 1752eaeadc42e..d9eabbb5af37f 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -152,11 +152,13 @@
 #define PTP_CMD_CTL_PTP_LTC_STEP_SEC_		BIT(5)
 #define PTP_CMD_CTL_PTP_LTC_STEP_NSEC_		BIT(6)
 
+#define PTP_CLOCK_SET_SEC_HI			0x0205
 #define PTP_CLOCK_SET_SEC_MID			0x0206
 #define PTP_CLOCK_SET_SEC_LO			0x0207
 #define PTP_CLOCK_SET_NS_HI			0x0208
 #define PTP_CLOCK_SET_NS_LO			0x0209
 
+#define PTP_CLOCK_READ_SEC_HI			0x0229
 #define PTP_CLOCK_READ_SEC_MID			0x022A
 #define PTP_CLOCK_READ_SEC_LO			0x022B
 #define PTP_CLOCK_READ_NS_HI			0x022C
@@ -2590,35 +2592,31 @@ static bool lan8814_rxtstamp(struct mii_timestamper *mii_ts, struct sk_buff *skb
 }
 
 static void lan8814_ptp_clock_set(struct phy_device *phydev,
-				  u32 seconds, u32 nano_seconds)
+				  time64_t sec, u32 nsec)
 {
-	u32 sec_low, sec_high, nsec_low, nsec_high;
-
-	sec_low = seconds & 0xffff;
-	sec_high = (seconds >> 16) & 0xffff;
-	nsec_low = nano_seconds & 0xffff;
-	nsec_high = (nano_seconds >> 16) & 0x3fff;
-
-	lanphy_write_page_reg(phydev, 4, PTP_CLOCK_SET_SEC_LO, sec_low);
-	lanphy_write_page_reg(phydev, 4, PTP_CLOCK_SET_SEC_MID, sec_high);
-	lanphy_write_page_reg(phydev, 4, PTP_CLOCK_SET_NS_LO, nsec_low);
-	lanphy_write_page_reg(phydev, 4, PTP_CLOCK_SET_NS_HI, nsec_high);
+	lanphy_write_page_reg(phydev, 4, PTP_CLOCK_SET_SEC_LO, lower_16_bits(sec));
+	lanphy_write_page_reg(phydev, 4, PTP_CLOCK_SET_SEC_MID, upper_16_bits(sec));
+	lanphy_write_page_reg(phydev, 4, PTP_CLOCK_SET_SEC_HI, upper_32_bits(sec));
+	lanphy_write_page_reg(phydev, 4, PTP_CLOCK_SET_NS_LO, lower_16_bits(nsec));
+	lanphy_write_page_reg(phydev, 4, PTP_CLOCK_SET_NS_HI, upper_16_bits(nsec));
 
 	lanphy_write_page_reg(phydev, 4, PTP_CMD_CTL, PTP_CMD_CTL_PTP_CLOCK_LOAD_);
 }
 
 static void lan8814_ptp_clock_get(struct phy_device *phydev,
-				  u32 *seconds, u32 *nano_seconds)
+				  time64_t *sec, u32 *nsec)
 {
 	lanphy_write_page_reg(phydev, 4, PTP_CMD_CTL, PTP_CMD_CTL_PTP_CLOCK_READ_);
 
-	*seconds = lanphy_read_page_reg(phydev, 4, PTP_CLOCK_READ_SEC_MID);
-	*seconds = (*seconds << 16) |
-		   lanphy_read_page_reg(phydev, 4, PTP_CLOCK_READ_SEC_LO);
+	*sec = lanphy_read_page_reg(phydev, 4, PTP_CLOCK_READ_SEC_HI);
+	*sec <<= 16;
+	*sec |= lanphy_read_page_reg(phydev, 4, PTP_CLOCK_READ_SEC_MID);
+	*sec <<= 16;
+	*sec |= lanphy_read_page_reg(phydev, 4, PTP_CLOCK_READ_SEC_LO);
 
-	*nano_seconds = lanphy_read_page_reg(phydev, 4, PTP_CLOCK_READ_NS_HI);
-	*nano_seconds = ((*nano_seconds & 0x3fff) << 16) |
-			lanphy_read_page_reg(phydev, 4, PTP_CLOCK_READ_NS_LO);
+	*nsec = lanphy_read_page_reg(phydev, 4, PTP_CLOCK_READ_NS_HI);
+	*nsec <<= 16;
+	*nsec |= lanphy_read_page_reg(phydev, 4, PTP_CLOCK_READ_NS_LO);
 }
 
 static int lan8814_ptpci_gettime64(struct ptp_clock_info *ptpci,
@@ -2628,7 +2626,7 @@ static int lan8814_ptpci_gettime64(struct ptp_clock_info *ptpci,
 							  ptp_clock_info);
 	struct phy_device *phydev = shared->phydev;
 	u32 nano_seconds;
-	u32 seconds;
+	time64_t seconds;
 
 	mutex_lock(&shared->shared_lock);
 	lan8814_ptp_clock_get(phydev, &seconds, &nano_seconds);
@@ -2658,38 +2656,37 @@ static void lan8814_ptp_clock_step(struct phy_device *phydev,
 {
 	u32 nano_seconds_step;
 	u64 abs_time_step_ns;
-	u32 unsigned_seconds;
+	time64_t set_seconds;
 	u32 nano_seconds;
 	u32 remainder;
 	s32 seconds;
 
 	if (time_step_ns >  15000000000LL) {
 		/* convert to clock set */
-		lan8814_ptp_clock_get(phydev, &unsigned_seconds, &nano_seconds);
-		unsigned_seconds += div_u64_rem(time_step_ns, 1000000000LL,
-						&remainder);
+		lan8814_ptp_clock_get(phydev, &set_seconds, &nano_seconds);
+		set_seconds += div_u64_rem(time_step_ns, 1000000000LL,
+					   &remainder);
 		nano_seconds += remainder;
 		if (nano_seconds >= 1000000000) {
-			unsigned_seconds++;
+			set_seconds++;
 			nano_seconds -= 1000000000;
 		}
-		lan8814_ptp_clock_set(phydev, unsigned_seconds, nano_seconds);
+		lan8814_ptp_clock_set(phydev, set_seconds, nano_seconds);
 		return;
 	} else if (time_step_ns < -15000000000LL) {
 		/* convert to clock set */
 		time_step_ns = -time_step_ns;
 
-		lan8814_ptp_clock_get(phydev, &unsigned_seconds, &nano_seconds);
-		unsigned_seconds -= div_u64_rem(time_step_ns, 1000000000LL,
-						&remainder);
+		lan8814_ptp_clock_get(phydev, &set_seconds, &nano_seconds);
+		set_seconds -= div_u64_rem(time_step_ns, 1000000000LL,
+					   &remainder);
 		nano_seconds_step = remainder;
 		if (nano_seconds < nano_seconds_step) {
-			unsigned_seconds--;
+			set_seconds--;
 			nano_seconds += 1000000000;
 		}
 		nano_seconds -= nano_seconds_step;
-		lan8814_ptp_clock_set(phydev, unsigned_seconds,
-				      nano_seconds);
+		lan8814_ptp_clock_set(phydev, set_seconds, nano_seconds);
 		return;
 	}
 
-- 
2.34.1


