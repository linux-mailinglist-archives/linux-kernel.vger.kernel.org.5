Return-Path: <linux-kernel+bounces-95523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80045874ED7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EADD2B23D03
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF3712AACD;
	Thu,  7 Mar 2024 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="WKXP8rBt"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2098.outbound.protection.outlook.com [40.92.98.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FBB127B7C;
	Thu,  7 Mar 2024 12:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.98.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709814100; cv=fail; b=S9UIN5c5R5hoQRC6cyjLZPRNdIWJR5ynZSBrVVmLUT5iDQZonYg9Yl+DSc1fCrbrBMzRDzwmeFkgqzMWspDm9NkHZkSy0e1/khbWRXl4kOc2s6TUV/LAmb+ySnROCji86Zzyeyvm60rjHzwxt2LdlapBYK0H7TbgbAhgtnbhUao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709814100; c=relaxed/simple;
	bh=X0LtUiKxus+TWW2wAOhi+2E+blnLCDWyrLjHiD8Fw9c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=R/rjbDsyHr4/1p1GhPouSjjwc4a+Nr0wITH4rNCxajpncx08eSvXn5ggKXGjd60go1JyfitFwMVkE+otEcXAzU7A7E57tg6oNnXHfjXPsD+0UXuUT6Cpr8FwzHM/VACkHKtHksiVNzK8NPD0GeK2XZVokTK1+n22VDIOKQwf/DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=WKXP8rBt; arc=fail smtp.client-ip=40.92.98.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsBWOMxAnIM/SsmiszGv6tY0yM/OCPFjFvhlaaSwNgo804st7RqYLTHhXYRs0BOhR5362kS/qY6CgSh5a4CQr5Ufg5gFZF/K61W6RcHBi0PsMv1/ScnvZHmxU8RLzCj4H83KwzwcPD/a8/vFSjbMHjgTRWYFK+EtfXBj9XNKCOalJFBNWbnydvi4SYQGRt/5pJda/8GKscw5Uuk8K7g9XWYCeLTbAiT4z9Va5guGM1SwS0pH9U3k8EIxkKFigDACzyRAo6pJauUCMYInqSG0o4NC6TWl56Ws/jKUOkJVc4rJiXL9gdY2Xm62cp8bUtZUfOpbeahrtuaszP/MFMRpFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsCG3cgOJZo2jiioi32KTYtquGqPkcSozAkI1HJ1YXQ=;
 b=GotQGlTVQey0OrqFse66zB/zyGA8GaKrfbLPuuhxdTHVg3MnZMEgkiOvEoNrojqyqD5o8qBBACOUxZ9/1vDdXFxwtsEk+8Q5dS0jwQPCA2rV6i3MJv/BpAAFNuUBZySUDbOqlFGMBpnLq1TQb0RYSzN0k+oyceFCOE86z/DVWPITZhumjRPWTfUS2VSjF0rn/pHiXkldwJ5BQi0gkQNe2Fby/U41seCsGqPv5wIiUEARF12hLByAfFXcLxYsKUlqSO3sX1zh2s1umXJyKdqwlE4lrMhAD2YbVV4OGfW/9k/W442uNnOvDH/malxvMGnWfyacBTZ1NZMeP7zd1JSxUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsCG3cgOJZo2jiioi32KTYtquGqPkcSozAkI1HJ1YXQ=;
 b=WKXP8rBtK1f0RxtO/kFFcOlf0G/RVk8BA6OlSgPWxr+Tlxir8yyMjM94jrLy57UJ1uh4eauE2r/w1JDF+mf3pwMeQRs0fn1yo2GYs1M7IDiTF/Aim5bDuCkrrTer+mQQESBou9rXO0LWKEkjzvOZNnbWGBjhn8c0/7DTWx8PTtNAg8kW1E6/xCZUUy+1LSSf8g4kNLHaG/nxz+hUNzgVT9LqzD03Aab0iNK2OrQ1turmPz+SVupo8G+tJuDdmJQ3WVZooxkdwVLMXEfXfv4QzWhoZm4W6z8opqjHlWdMQF4BOc3DZrEsAUQVKNlTIr/tWs19IOvi3URV0IM32LYAzg==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TY3P286MB3661.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:36f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 12:21:34 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::955c:c8b2:efd6:1308]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::955c:c8b2:efd6:1308%6]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 12:21:33 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: ganboing@gmail.com,
	kernel@esmil.dk,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v2] riscv: dts: starfive: Remove PMIC interrupt info for Visionfive 2 board
Date: Thu,  7 Mar 2024 20:21:12 +0800
Message-ID:
 <TY3P286MB26116B828A34D614C09F4E8898202@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [AIxjkWDhVW/eLW/WuNBGqIIhBzMcTF8v]
X-ClientProxiedBy: PU1PR01CA0032.apcprd01.prod.exchangelabs.com
 (2603:1096:803:16::20) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <20240307122112.4455-1-wiagn233@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TY3P286MB3661:EE_
X-MS-Office365-Filtering-Correlation-Id: cab24302-0a38-49ab-0fc9-08dc3ea12055
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CYmqwhdpQa7KDAhce1OlodwoDdAO+gHLvxYspU3Y/bW8QZ1aAYfzGtb8FhVSw4EVTa5miOCcUZQ8VtF1uOGL+zNZ2Gvp4hG5sig8huT5D5m+x1IwQN+3o+PrfUWcVuLoiaqoGXMPszvrpVDXsMVY8uuNUu/isectELe3bf/Qfi0O0vCPyO+BHF7T1UziobBCofr3tfOXDOHlZiu7Aj8HKchYyYt//Deae8vTN91k6UjnFiiVju7qbRn5xciDW3iojo+xmEePt/+MGBRrHYcAgBSsl6xUpPVOKOWAa8Zhw8HGGQzjUEm20WQJccWFxYJOgwozNyy4TMCVP+vc/pynLs30uJqNoBF6r7ipbIgWq52x5fNrbcvJ7NaoQyr3J691CdbBn8pLi/1+4aUwCfaBRm/FNhHBvEB7+Hbrf3vaB0SBBXFjscUcu3OZiZN1moZq0+nHcJf/Q2spVSga6EToUVqbH6/VV0P6Le5lI8IibeLkgS8dQkII5wLkrYvyi0J84Ebf9ZefCOujCtKm/Phn2+wSGXVm/agWC0GPIanQntksKadhj4UskzVjyQwO+0QU1ja/yq8To049Kn3UAUrjoPx7Ba6YMKErgMXgX9pqCYcTBPt29ZcSRVZTCreuVCc8m4vApFomYeasp7BSx0R3HWJM78pzhAtKZU96vFkn3qV+uhElSuzvDO4+HlvxI91B
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sbS6hbh6hhj8U1N08Ya9gUixQBbexijl/do8yxeeoii3JwoGlQ7xHTLltvvw?=
 =?us-ascii?Q?dm4tmwQdUHLqyDIhURhkE6SUrhtNCTmRMntEIMzNfaznPDaIq4CGzJdgs++E?=
 =?us-ascii?Q?M2TQgWwHMhYBkszd3zT0COBnl6TB4oP6qAtU/mRqk4FTtk79Be9CkQ7CT6VE?=
 =?us-ascii?Q?hNFQeWVKYa00WiSd7RQhsdAXVWECBUPUjyJhTp1t/TGR8VESI1udA3Od8CJX?=
 =?us-ascii?Q?R5D9yBBOljgOl4swUmFVuedvQ8C55IzzB0BnTpK6UKaYJabN/Av4qPtL3UmF?=
 =?us-ascii?Q?5lNNbz6PGUQz2GfyOmGMkJRR3iHglgFOSNQkVqPnXg+TMT2Bp8jBpS87iUiN?=
 =?us-ascii?Q?kB7uUxY67nckDxHnbs6Bn7f3sUTcX5/A2MHdaIEsw1vLfV4hn1kz7qvjuoId?=
 =?us-ascii?Q?hKUDU1RH5WtxwGS8rQ9looOON2g+5z13oMY8PzxEBktWA8IPlvKNGr9auFVq?=
 =?us-ascii?Q?C3UaP8FPK3OG5AaKLJc/GkXlbGN4BnyjZqkYEaVkKNU/C5FlZFMXJx30qrTc?=
 =?us-ascii?Q?qzlPic8LMtXTl1IAO8oPfqH6q4xp7csj9zTPaVHaJXK2EHxydJoZqqy7jNvY?=
 =?us-ascii?Q?vy3WP4WlzTr+2991IZroCzFHFncAK/jMgT/mkUpjpdbHYhi/E7QunhlUs+hH?=
 =?us-ascii?Q?pphh2eIkEr7PVs7fiq6egCdqRZ9P3T1VK7INKlhK9XnS/PbXwzt0ZGgadDjV?=
 =?us-ascii?Q?Gici4STo8L1OtXFjMsiNESsjsL9ENwJjqJcX7FvAcYC8ULHcUc5ESO/3WoAw?=
 =?us-ascii?Q?nUxusZyUj8xpFOo4B4Y3y18PH+kDQzj5+hXzxkaYfALUHWKk7TLT47KROmBX?=
 =?us-ascii?Q?KkhWxdKgAv6tY+ihdh07tt502JR0ksBgfuV0o3vvXiOEGi/4wWowH134Ji53?=
 =?us-ascii?Q?Q2hHfZbnxElhdRVClO+3zxP1VNRu/LwRVXdKZe7H2rdS7ckHloUPoMKe9tVk?=
 =?us-ascii?Q?Vk9RUlEPeHyHOYneuUJnX0Yh6eivYph7UxuXbtGybBZCthu2SyyegfR/fzVP?=
 =?us-ascii?Q?tyCbx+vAx3vbf2D8csEa9T5Q7w30qc0O2BxqvadetsduN7a8aLsbdDVJkh2o?=
 =?us-ascii?Q?COCMqJ6CmE+TTqm7hsmqQtkOOp5MQ25KzOargJyNvOjDoMRmKeJkT8Wb/WVn?=
 =?us-ascii?Q?xmBfR+bJDJs5j0EMOzmrmyl0LhwE2d12CXusaFhNuCev6VobR/1gk89jNd9j?=
 =?us-ascii?Q?00fMhXg5Dq5sJYAKzLODIQnt2cs6GycuDqNvJMbgC7i+11i9mblyjIJ2RfM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cab24302-0a38-49ab-0fc9-08dc3ea12055
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 12:21:33.9346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3661

Interrupt line number of the AXP15060 PMIC is not a necessary part of
its device tree. And this would cause kernel to try to enable interrupt
line 0, which is not expected. So delete this part from device tree.

Cc: stable@vger.kernel.org
Reported-by: Bo Gan <ganboing@gmail.com>
Link: https://lore.kernel.org/all/c8b6e960-2459-130f-e4e4-7c9c2ebaa6d3@gmail.com/
Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index 45b58b6f3df8..7783d464d529 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -238,7 +238,6 @@ &i2c5 {
 	axp15060: pmic@36 {
 		compatible = "x-powers,axp15060";
 		reg = <0x36>;
-		interrupts = <0>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 
-- 
2.39.2


