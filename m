Return-Path: <linux-kernel+bounces-134757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F0D89B673
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40623B21E6C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F9463AE;
	Mon,  8 Apr 2024 03:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="i92VHKfz"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2028.outbound.protection.outlook.com [40.92.53.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B959D187F;
	Mon,  8 Apr 2024 03:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712547406; cv=fail; b=BH9zzTpV3NkNv5Q1jg7XBVzAIZzTg/6/EcPh1XxEuKhQLN1bzC0JGxor/3SgoId8fdzRT30/nGVgo+eN9R7KBt+mRr+E8/wlhtqjcRiuCA0r+rbsDkpE6narnnAg4AnMsR60vqQuy+eIN/b3HvAyUko1LzVEGV0MpKhOuOEvwlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712547406; c=relaxed/simple;
	bh=+pzfuCzPRwb6PxOClH/EItwayzRJ06WjayFWikVZrbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TDDrWP3JErMe4gkIZ5JHy1V10oWKWYsZps0957YkVQxzpOuSu2uOB2mNmRDci5ugIXhuo0iP7wm0duxpzaObgIfITAKBUWeEh+c8zU0lLu+9cnyJ2/oAvYHfvABRFwp/y1giv7YhHiBPrA4wOMfvLNhotHohtwVAHQSOhchZVVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=i92VHKfz; arc=fail smtp.client-ip=40.92.53.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqsZ3faBwYRzg3UIhyKSC70k2NNM2Wp73QQmC+cIwuYvjgBxYFzRe8UvgC+D9Bdx2FArHcdFHDGZqn5eVtar9xAIW2Uh6Jxk/ODXarsnpeeNffHhY5n1HGISLcV/CzIXaDsVWp43a8cqmzNlqbYYnb2f/RrNOBNv7qBa/fVuHfiNqNMJOp2QmpdZbAqvvxLilYeirofNlsATryavb5vqco4MUBXzklGRsClwp+LpEEBg6jtEnZok9ktwdBt4+HVZuhhnKF3j/NM6mMidqNBlaOyhOGe62qlV8JCHsHir+taa+7wmpNNfqXIzipdHXHm3vuYRD93h4BzJTgUVtDvGNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csW8Ke7ZaM6IlQ3PEizPMkg1sdPp4F6OXfq38SG0QDo=;
 b=ETMR2Uqo9XVTj8SEYdUUt2AlrxjUkP997kffprBw5cs0R8MXTzRBApcSFw2O/rIzz4oURB/sKAA7dXzisK54mL6yFq5abrrxYwHShHdAQ4IwD8Fwkrcw+jN+jfIsD/SemG/nIdAi0yt8EgCRKioL2R36wIxOpRyh8z1zlR/u/+cwkRYUIrjonlWOAGlMRjkUzZ4e1XDadKjIWKX72gUbUNxpN4mz2dIL/rThOELTPIR3ud5ta5XzSG37/qjyTK48JNaQNWSOC0v7gNHkBZVmGnHItrN9zn4xIE0aHMX+KVP0+fUxjpBD6aIoBbSupjrftWKfM9XNo+Hoa6qlh0gT1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csW8Ke7ZaM6IlQ3PEizPMkg1sdPp4F6OXfq38SG0QDo=;
 b=i92VHKfzlh7jqpKRfeh5Y6nDIpCcOhTMhMDJjqAPXTHV/RIlWhIqYTMarzXesS7sADUfMupF94f7ZU/xcCW9tuoiOVkquk1jPk8Q8UD3ovvNuYgiRqXxso5Y2wFE5uChuiFu8mzBOGUqPDwuVbVDzP2vgJL0QiCbGbAJtchBi+sxPCFcGsIrPMh9VYxo20alJ6zsC+5ldxwsJUWAOIg04i1kFkUr3HOB1RkpuYjRZb3aWdbq4yUnkbFzVKCvtQDica+W9z4WV2PGarzAKsNQWiI0AWtSVEayLyjCILsqVbY5ygMK9uPPqJejvXrW9M/C4B3T3eX0SqgE3N5aHhwXcw==
Received: from PSAPR06MB4952.apcprd06.prod.outlook.com (2603:1096:301:a3::11)
 by KL1PR06MB6041.apcprd06.prod.outlook.com (2603:1096:820:cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 03:36:38 +0000
Received: from PSAPR06MB4952.apcprd06.prod.outlook.com
 ([fe80::45cb:f62c:d9bc:b12b]) by PSAPR06MB4952.apcprd06.prod.outlook.com
 ([fe80::45cb:f62c:d9bc:b12b%7]) with mapi id 15.20.7409.053; Mon, 8 Apr 2024
 03:36:38 +0000
From: Guanbing Huang <albanhuang@outlook.com>
To: gregkh@linuxfoundation.org,
	andriy.shevchenko@intel.com,
	rafael.j.wysocki@intel.com
Cc: linux-acpi@vger.kernel.org,
	tony@atomide.com,
	john.ogness@linutronix.de,
	yangyicong@hisilicon.com,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	lvjianmin@loongson.cn,
	albanhuang@tencent.com,
	tombinfan@tencent.com
Subject: [PATCH v5 1/3] PNP: Add dev_is_pnp() macro
Date: Mon,  8 Apr 2024 11:36:22 +0800
Message-ID:
 <PSAPR06MB4952B6F731E61760358CDCFBC9002@PSAPR06MB4952.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1712472167.git.albanhuang@tencent.com>
References: <cover.1712472167.git.albanhuang@tencent.com>
Content-Type: text/plain
X-TMN: [wp7oDCUwKJ7ulSI08kmeuxpQuKYWzBwa]
X-ClientProxiedBy: SGXP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::13)
 To PSAPR06MB4952.apcprd06.prod.outlook.com (2603:1096:301:a3::11)
X-Microsoft-Original-Message-ID:
 <f8f216c4a36d2266b4fbf48f95793c44f13fb506.1712472167.git.albanhuang@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4952:EE_|KL1PR06MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: bb864f30-2d85-475f-698b-08dc577d191c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sw2+EHLOMINebkXpPd1YzB2OE2G8WmyEBjWnw2F3xx6GppQFXS4ZL0JM8/Xbc/Ovoye0/U2TrvDY+RkkRPgOYyc10F/Prx4SLW2ZSR0DCuWtuaIGjBmma5G/hM/aIjKNUGULNS4T70rRAPqB4Eie2aECciMIhx6vwrAHYT6nGOHJIGRZiWP0B/Gb5dkCDKHQOuKqrWx8qwjdYeWs1qyNKLSKpFHUBKX6HXuVO2EKyTOEulKat6JUIvpvUSYTx8/XmGvA6rY0QhwzEohQ2TIoLTxGtXnEha2vj1+7g7LJ5yGc2YFAzEG+dVMFIjCzD7/ij8daOh8LAUoJpqh6IZStfwiaB5FLvwIuNpqkf6p8V66fp3KnRA6pLnC7JC1H1vkXrM4CwuWKEH4wbT9Vrd6KLREKmW1Icb3FcbDGdLN/2mDd5pPUvY1nyArxlcWL4QH1TxE/HTstcYKykUpE6f5GyH7YimdsQUAWEAD+P900EW8Uh/e8TSN6a/WhH2b/VLLjqx9BMo7x+SO7HHho/dUpp3f0s/3ftYmbukCs8TMkoMoUY2QJ+jL4+AL2uMR3ahji
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YpBLKKoqdBmQXP/hN6dL0xT8hWivflQmTy/yVrIce0oDr3mw6W58LJnqrndG?=
 =?us-ascii?Q?gGXISAG2V8BBrWREXQ6WZ7f3glONDKNPmHMq5+BQQ4dTDXgjNvEdjo2+ClwN?=
 =?us-ascii?Q?2SFELeaXRF8Ty2rGsNHmB5Ljfjvcfua6aMeILA43dNxrNfbDvJrFZnU+maA5?=
 =?us-ascii?Q?iS2lWn7LNCsKol18YZv0S8EGBDYZmfvMNM3mIiUTVEjXVTxlxBVDHbXBO12M?=
 =?us-ascii?Q?m+0aZzCtN63aijyStKXbFqgkfoO9hDDufiF11F4e0sog+Ve5i1/QWAqfq8dI?=
 =?us-ascii?Q?2BatWrcWqAEywobbuPTETHVII+cFku/wc5foUW0Kcs/xhZuhOAdD3vc5++5B?=
 =?us-ascii?Q?rJEfFu5wm1veA5tlEsjjv0c0l9dwTUaa/1tRW/A+NmqxK76WaDrqm5lVPCgZ?=
 =?us-ascii?Q?YTh+N+vt+k67mac8Zkou90bMoHezbJsuCWQ/GyN1Ams+LXrP+nWO2WdiBkeA?=
 =?us-ascii?Q?goQ8ekgoNxFyfjMo8Yu53aCD3BeGzDM5EnwBeFvVHD0b/83G3mjWpvAVM1Mz?=
 =?us-ascii?Q?9mQAMq2g4mNvsjDrzC+3xfgi9Cnn6Kg0jb5YBPXJaO7mkn1WPxa9bBTUj84K?=
 =?us-ascii?Q?EzUsCpb3U/uuiIk/xNRQvQttjFnFBTg9Vb/Tmfb0ISBI+s9A9PRSjRbOkXHc?=
 =?us-ascii?Q?EdwOdoIw8VosLM7JXFd/dB9wxhIHzIRM+lnLwlGdeQHlypTz9oyMPhlU3te/?=
 =?us-ascii?Q?fPdy7xAapUifwVxCNU33W5ftGqJzL2GIbwyTzAchhVLuMH5uzpIDU6Sg8X9j?=
 =?us-ascii?Q?T8M19BMD9qpGM9o9lVdV//eu9lRRNtlGceMu7CGsdXn6+rtmJuOCW+tjfRRC?=
 =?us-ascii?Q?IfIX9ShLLlC2bA0au3WO8aAekwRb8jdAWUvhPGPInfBS3+Eu1IFktLnmjU04?=
 =?us-ascii?Q?o0QPCZUFctQBfUIuewZ0GE9zUDxivLyzjctW0FwCtSTuq1yIkpwIe+VFsxlV?=
 =?us-ascii?Q?+1/YQ+oTLXeejVHHjonGqPjbCPYjLXFbvoVEqqZ1iUIbCnZLSZl70YAPWxIE?=
 =?us-ascii?Q?PoM2wcZjyPEiulrt8dn/q13tI+Gtk0L1iKGo/GbpSr2vRxMw0f32EPa8z7ff?=
 =?us-ascii?Q?nSvVBo7rB7VvLEkSjTi0vW2TTYMYOdcVSkFCpJvid17lT4ri4dpjcA+BZo7w?=
 =?us-ascii?Q?5a7u/LUHSdUW44bjyhhjLAsPrWCKQXknczDLoFvcOxL9vbOehGw9EwAZM/0G?=
 =?us-ascii?Q?lOV3tbqpmxKPmnuVFOxRvU5EJut+jSysQW4oj+dz338keqLBqd8iF/E9q2o?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb864f30-2d85-475f-698b-08dc577d191c
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4952.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 03:36:38.5633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6041

From: Guanbing Huang <albanhuang@tencent.com>

Add dev_is_pnp() macro to determine whether the device is a PNP device.

Signed-off-by: Guanbing Huang <albanhuang@tencent.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Bing Fan <tombinfan@tencent.com>
Tested-by: Linheng Du <dylanlhdu@tencent.com>
---
v4 -> v5: change "pnp" in the commit message to uppercase

 include/linux/pnp.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pnp.h b/include/linux/pnp.h
index ddbe7c3ca4ce..792921c06594 100644
--- a/include/linux/pnp.h
+++ b/include/linux/pnp.h
@@ -502,6 +502,8 @@ static inline void pnp_unregister_driver(struct pnp_driver *drv) { }
 
 #endif /* CONFIG_PNP */
 
+#define dev_is_pnp(d) ((d)->bus == &pnp_bus_type)
+
 /**
  * module_pnp_driver() - Helper macro for registering a PnP driver
  * @__pnp_driver: pnp_driver struct
-- 
2.17.1


