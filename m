Return-Path: <linux-kernel+bounces-129200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEAA8966DA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BAE81F2564E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5FA6BFCA;
	Wed,  3 Apr 2024 07:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cpl3+Sso"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2106.outbound.protection.outlook.com [40.92.52.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FDF5D91E;
	Wed,  3 Apr 2024 07:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130109; cv=fail; b=R+yXaxkJlxMiiB/uxpHHl16T5DV5RG8fowILoyI+5R2GIkNVt/Ato187VJqGj5CE65IVASanayvnYs8fNOWIihxPb4XhoQf4a+kuU4Q4BQr4EwPTJCB5sxufwrGwjSdnsmpBoVXn+jDmRa55s8Ih8xglK3uIcjk8ENn1ysuLmic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130109; c=relaxed/simple;
	bh=y5MBC1wZqRNlAlC7Q8MbbTEywrxX8OETnD14mktOMCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oArkN0O/vvrUjzyK7mhXzRLopUVEXQ3EsPigdqF20uq9GSW05o2fle7bLbtrDiXOpaAA+UYmkUc90ye+0iLLGLCxzYM9SpE8Ld11uOD7eim7A5ujPexAgOG5nhm0OGSe9F3WL28ecjgMcADggLyNUMCrl6EKXv/OITwiKCi51co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cpl3+Sso; arc=fail smtp.client-ip=40.92.52.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i61DxgcdnsIz4W1nY7k2zR5RV0Dri7Rbi0m3XQDYEJUEdFBVoNqpJfQpvesY40DMLZESnaI9Zl3JHcGHS/jEXuvk0RE13x8+PKlOA15Amv42k812iwsxc8reFvuWSGXt9TrcN9l3FnDBG/dORjR7i66C44vUm1SjUqlewoqlUSCr4DKVddFfSkwLiT3WmJsZy7FoXdGJbaaUnNBq/qkipeXmfg+jaDTadTOzhsDh5BAIAgbJWFVoQR8GFEONBk6DeJRbYoDhBCeswFiY77zvkdFAbWFdg+9Mm+dji8zZTJ6t/6n1SZF4mgt74yVctxR3KqAN/A/OnlDVSVQyPayWzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83md5WSWcVzebHf/A+5fljk4rOv4GvAK1ZrAb7I3TWI=;
 b=F8QzEDbS06IxTEsyoJZQQNVHfPSxdDUouJnKK3229DWsiHaCl3M/fhV2atvpEbFEBPfCweFWjsb9y5KFgJUhfbyO2H0uktVb2RuKmtmrevhTG6tEGtHKiBLkszVLsLg4iyOc6tq4xGBSzyX5/TMqqx4T/FIbDOPa67LHMPeAZH/Q6s+f33t7TcrwToLeNWigPDC6pdAdsIblRrMg6C5B/Frc4UIv4pJpAQxug9lr4XdOd9zqvw90GP1Ylgq1nJ7rAtpwrmH2e5O6RFrsHkb/oGwxop+11tgLmBYseWyIyaFSwfgB7xK1dWu33J7AqFCX+cDeKtpFhSlVGW8OOwMwZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83md5WSWcVzebHf/A+5fljk4rOv4GvAK1ZrAb7I3TWI=;
 b=cpl3+SsoFKwsPYp0eAKaHnpE8IWmB/u3xt9SZIc6zM5/KR0GM5kxKSxidyXsBYcCQp5PIzo8/FktVfvpn648RKxyHciVQbb8pWoSK0v3ems2wRBm/2xK+m21NkL3owXPQDUgnRGmKlnTfZ2RLOPyNyC7fSUDA+zPx6AUhswtyDG73HI42xkZ7mPUG/BA3cmKVgLGNY4a87ZYAOkm9S0hL45orJ7dj8zTOqai+2TQScsPrmho7cwkoYj4Od6h/89GgyLWW8dxnleLphLEjDo1DrCjH4+ssAFmwF7nIJsc0paWnRmYmITzq9IxbqyU3J6/j8DlfKgiv3qZUH7pqeDEXQ==
Received: from PSAPR06MB4952.apcprd06.prod.outlook.com (2603:1096:301:a3::11)
 by TYZPR06MB7169.apcprd06.prod.outlook.com (2603:1096:405:b7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.45; Wed, 3 Apr
 2024 07:41:42 +0000
Received: from PSAPR06MB4952.apcprd06.prod.outlook.com
 ([fe80::45cb:f62c:d9bc:b12b]) by PSAPR06MB4952.apcprd06.prod.outlook.com
 ([fe80::45cb:f62c:d9bc:b12b%7]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 07:41:42 +0000
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
Subject: [PATCH v4 1/3] pnp: Add dev_is_pnp() macro
Date: Wed,  3 Apr 2024 15:41:28 +0800
Message-ID:
 <PSAPR06MB4952DCB31578A5CB547612E3C93D2@PSAPR06MB4952.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240403074130.93811-1-albanhuang@outlook.com>
References: <20240403074130.93811-1-albanhuang@outlook.com>
Content-Type: text/plain
X-TMN: [tW5Jjevm/8o494xJH/n9cdndo2d6Dlhc]
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To PSAPR06MB4952.apcprd06.prod.outlook.com
 (2603:1096:301:a3::11)
X-Microsoft-Original-Message-ID:
 <20240403074130.93811-2-albanhuang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4952:EE_|TYZPR06MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dbcaebf-b261-49bd-f274-08dc53b180e5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QMyamEH4gMp9zby7wSxr6HiZhxRhHjyHsqnUv0n1uuvYDn2W9wi+TQ7YCzdO4qWFlk3crX8SZidd7KK7TOjKOHiE1QN5IUW+efHkca8a7jXGO2V4KG5ODSVwDR3rk4BTOOGSFXvqp8kbXPp45LiOJTw2+m0kvedPae9eNCVdjGcnY7wPJtXLqlGKrdrYXqyDraQAhrJAPzxfQIBmWQBLFiaBKEJhQ+VLQpUDs06SSCglGZLiF/u68fvi0vJQ0/xgu7Az2eN9Tejrk418vHJ5Ryw6PdvcAi9q9Xkq+n1NoJFORmBIrF5zaRTnyCFrFwQthrYmvLCs+GjyltoKYxyfKYmV/e6Bo0cwReMFr4b7yVxjucB5icsZpCq2QBIlBjd+d9t8m+yNB018fL5dVgATxHTvc5lopamutOXx8egm8RSxz3vtuOFjZYHVEd7xOFgPHDRS9f0LZ6nxKw6M6l/5dZDq6mGQzZHczhECjD3T9hoH3pfn3O9vOq64Wx8XY29UILwq/S+u0t+JMQr1k4aJPsBlNmWxqiWez11cPDvD6KzuUQLWOSghrK6OI/Nl7j9M
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HHCEA00IH8jEkefn7U/pLvHd+Lr1bE27m/PMb1biBvPrhwGSuJgKM3sTTwfa?=
 =?us-ascii?Q?PQt63ud3TOaOyJ8/eTznGOP6wwdYhKHU9rbOtsMO9/owzYNJ8ckZInw1TSE0?=
 =?us-ascii?Q?zKmORLOhtKpcQ4VLfXZdbp3KjslgmLnQTX7MZ+6Ag/CN75A6ARGBfx683nRN?=
 =?us-ascii?Q?eP3Rba1AR6qkMSPBNt8pepqwfD9776unOGyh7bnHm6jHWI+1eJqXsmt+URZ5?=
 =?us-ascii?Q?+W7CZOX5WnOUHuihcyiGx1UcZI3RuuwsifyMnsSwtgtcSeQSyffE+eaC1fQO?=
 =?us-ascii?Q?6bvej5lOa31fEuwFMNh1HDz3h8UO/K0QDyVFEBSmv1PrZI5Swyg+bnI/Ptee?=
 =?us-ascii?Q?1EfEsNPbuLc0mL8+y1nJyVVgIJl/lRZ4ltKuBcF8C/YhhNeUvEKu+//FJLu9?=
 =?us-ascii?Q?Qb1UOOiTIimvfWc4TVE66+E55Gy5821mxCDVX96ljeXMR5uHO7Uo+uCeZIxs?=
 =?us-ascii?Q?rZLcqlk4RU0QLZQPuABSNtL4RYp6DRP2VDBMOeHfj1ZGBkYAT7+nwEvLIQEi?=
 =?us-ascii?Q?Cy+W5NknleU16QY1so1ekBHV014ChIq61vt75M08jVMeJbVyFD2I00+JSBEg?=
 =?us-ascii?Q?//o8lSKkoR+ZMeFV94hLakz76ddOOcjGT0y1cFbFygHNeDZLwi+p7RLjfcKf?=
 =?us-ascii?Q?giSfR9tdnm7cWidO/bLwsw8CgGjUvfsjZaChO0KTbiEhfnjQ62EU53HHPakN?=
 =?us-ascii?Q?DsRYPh97Swcjprt+LD0gPEpsEEMt5a5yWi19j8jPH+p7TCgSO8aUla4/hELw?=
 =?us-ascii?Q?95LU0XXiMjEP+oKH0Wiyt7RsWEn7qsMX64NvJWjtp95yx3zNx9lByVk3N3E5?=
 =?us-ascii?Q?S2glV4dBHdoBgM71DGMzoOpwj+ANlNZYy3J5no6CaahXfisdYXnSfapqClAc?=
 =?us-ascii?Q?qFqM0mGVYmYLjgx38rfB4calNTLVbsT/uZPdsIh/lsEkuGXatXaFQjggDo2H?=
 =?us-ascii?Q?cphRguWMYb0qWIBAQB+N533gC/Ho+wl9JZp39HI/xA7SoHE91ziuMbBLZNEQ?=
 =?us-ascii?Q?fl0AsHy6N7mrW7fpGqIxziF9aNIC2BFrxbqnf9vxuNMAiZeRb9wndgd2ZrmF?=
 =?us-ascii?Q?xR4iHjURrDCC+Sbd+nt7e+kAoYWeUmbZcKZqME9wsSofZ7MlBlCuYwk4irEg?=
 =?us-ascii?Q?hhWB14aM8OvXB7/XwOieS/h3rbV2/tfKQwxBjorwh5BhR8QCzZzJK4kAV1kQ?=
 =?us-ascii?Q?VXGT7tqfg7UoT4UL5HmTiDissvDqFsCcrKElgNYFacmjxu3XDVX97Trfevo?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dbcaebf-b261-49bd-f274-08dc53b180e5
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4952.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 07:41:41.8837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7169

From: Guanbing Huang <albanhuang@tencent.com>

Add dev_is_pnp() macro to determine whether the device is a pnp device.

Signed-off-by: Guanbing Huang <albanhuang@tencent.com>
Reviewed-by: Bing Fan <tombinfan@tencent.com>
Tested-by: Linheng Du <dylanlhdu@tencent.com>
---
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


