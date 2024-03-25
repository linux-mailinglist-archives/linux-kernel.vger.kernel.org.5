Return-Path: <linux-kernel+bounces-116525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB7788A04F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD40D2A65A1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80631172BC1;
	Mon, 25 Mar 2024 07:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="p6SfuO7z"
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2169.outbound.protection.outlook.com [40.92.62.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DE91C3219;
	Mon, 25 Mar 2024 04:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711341887; cv=fail; b=JGnAoDxqIBMrdEELSlupIQzfcARmcbU/L3RIUY2rs5YwXKwplKnltg8So5nv2/Z9wPgySR8w4G2mnpJbQoS76WyowCLVVVJke/aRMm5h7ZFw0yCa+zRoORiHPO4nsXsN566p9m4fuVnpR9m6oNsp5LxcGaFvlCJ16rwyU3hZoGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711341887; c=relaxed/simple;
	bh=VgEjxTMW9cWo5wPpgCmMXWHoVFh5X+HSfVIjnSlrP+4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UFP9z27lva2Pyd8mrj7kZOsSR6Be/ZBTGKCEJKY1O+rYZvQEnD/rO29l4tlUY7r548iHETPN8Y6819l7MMC7OfqSFGh4cM4zShYwt6iXvCj86XVV+O8NPXanWIIW6BoLlWZ9ZYUDZ2q0jPftdx56333KkaCENLRpyLzt+vHwzj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=p6SfuO7z; arc=fail smtp.client-ip=40.92.62.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I87Jjqzpl/wRBzA5meYpRe+9gph1go5L4xc5fHtoSJ4YerrBu0H4hU02ESmDkRsDWtkM88SRIdHcplOWcsEGYjomZG/8EdkjIo4nz16Ry6XOEIzT9MYcQKYGFFGbCx1nsq889HI9GlwS6A8gpvCqvVV+m7xyrDC0gjGeRgfBq/cNMY0Xaw6hnVv4uN5NR4t1tfvhP9qNCjnPBRstagJ4luhMQliM44qVdS1CZ9MoydjqdQyQrJLkjcykNWMLg2YAi64O3lnVMwhvJIUlAqAxkgiaZklCSZXfbG9OnyDiCT0ZP2WcrLN7a9tgoPShOJJkG6ooX0UnwiB67iCjHCTUng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBqX63IXtj86cPMv6yuZTIw44j6pLX8pqEIZaeFlwfE=;
 b=KpgRDKjnIo189NkvFN1M5eWGtZ+D4MgX9doeXzecAQk5ZIy12mjmCXgqlJISoeaLmfnnp9SeJPRrCtvftMeRK1x4jtQzaImOKEbIZUiVUKH0owi4VjxBljT3JXBW2y1L8lzc+yx9txmZ56zH/0HVkWvI37YQ5P5zof/rUrciWvkJdXiauxn2jIurKtXIADsy9Hcmcps83c66kvrPcb2QqlNrx0HnYipY3Qnnq0dahITWq+oLoXamBf+B0+Y6BD1YGAKKQLSplf91pxUljmll6BH7SNzUJsT3Do6dPqhCQULhGH/fk8a2eM3aAD3aTtIAP6fFqKN+KcZA7MYE49Lhpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBqX63IXtj86cPMv6yuZTIw44j6pLX8pqEIZaeFlwfE=;
 b=p6SfuO7zS9vBMWNrj0YgkM9oV4K3QnGUFvLLuqo97ohf2v+Vthek9HSw2tt4Srs/L2Ke6U65jSRODsHPQO+5UVEOhkrawCU3ImLvxkEaPkVGfv5pyt4avxX2Sp5kGTfXXEvmwg3/GUkIhhowBFRMxWo4qqd1fEn7hFzQM0ABNFlXd1hCX9XwRGP67Ipz/a47+XfkZDF+u4r6lM4j6Wz2Qul5Da3k8lkrp7YwHe/hQBij3UsPuQkvbNjSt8hgfJ0yD3k4RKkg8kv5M9jubn+EzBa0OYMKjd/4ITAXm/itUo8a0jTcO9vAr5ppZ+ND5BfzgGqjeoOp6uKlh7OSpMOdnw==
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:159::9) by
 SY4P282MB1227.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:a8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.31; Mon, 25 Mar 2024 04:44:38 +0000
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::22c8:76c8:58ad:f00d]) by SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::22c8:76c8:58ad:f00d%3]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 04:44:38 +0000
From: Stephen Horvath <s.horvath@outlook.com.au>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Stephen Horvath <s.horvath@outlook.com.au>
Subject: [PATCH] ACPI: thermal_lib: Continue registering thermal zones even if trip points fail validation
Date: Mon, 25 Mar 2024 14:42:22 +1000
Message-ID:
 <SY4P282MB3063EE2CC37BD0EF2318B746C5362@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:
 [Lzw+SD+eF/ssDIN42/CaN9fTvh/o1GsjxIFS02/5MjRU72nrJK1q1ksSFW5DbmrtRAVTA9A/9XM=]
X-ClientProxiedBy: SY6PR01CA0035.ausprd01.prod.outlook.com
 (2603:10c6:10:eb::22) To SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:159::9)
X-Microsoft-Original-Message-ID:
 <20240325044222.420984-1-s.horvath@outlook.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB3063:EE_|SY4P282MB1227:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee5d88b-ec97-4e2b-4191-08dc4c86475f
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwVFQjMFFRw11WWc0dpssb1e9g4rgxwiUGElXAGPacrR0lken0jD4fuwfeDmEChnK618VNwSH1GjKge7nyWqDLEEYcJ4XkS0Hh4ND13kFhpjjvvL7/CvrXU3Go6gybY2Ou1QD7zXmhqWlAILV3fHoUzGbGXoh5wRPdjbIlFd9gt7hDy4XRP95Id9R9KvsGBK5rd96bgd+vQ66WJOjmLf8z7KqFPuRYQssd5Oy5OZwPzXgPj1uM/KF0X0DaqDX2L8xSxt/tG+pjgzQTEngP9AyL5KxGoTk4Dn+n3aF4q+FKywKFzgK2CchHzT77OrvnZxgrJ3Og2cP+lj/nVgTF8bJv/FnZKWQeRY7omnG6yNtoYyEA5IKQ4QP2qTrJcjrmFZA+HuJxXNryPoaaADkiDZU1Ax6noabwopX5orMJb++JPi8owGs2GJ2XNa8hz4so1wsn86LQSSW12Kpj5VZoQE62XQmuS0v2jvSCMAjuj44bHd0G474z/no7ttn75nLJ4usHgJq+v++jMDWd5L8Koji4tSm7/a2EbFjvv7QQrdBew4P9AQqKpnyE6NznwH8WwNU4CqQh+bq5ESbeK8gI944/v79oewVZV/1U9tnT+QoS3Q82Lzd4Fe5eAVk9QvKWaSDd53XsOcucYcRMc2fuiUuafcVl7JDsoe49P5jvQG8xpTdGjCpAKl6cfieJsJ/FelTVWryZT/yzkZjd9ByO8GTZu2Y7squsLgvLQd5h1kEiOCnkssOrNatvmWYdxf12yCf8w=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oc3rhg/Rl3hN0hgv57zftt44pMR259QsUivJBGqLawOWqJE7jEncP3k6mY8n9UgnKk38fElDtwVK2DEetj9EZF6k5lCpvwR4cJhCCc53BP9sh5e0mIvva9n7e6s+zR+7/wyIVIiF6VliOvDXtRjrDL7tJ1LYnhOGTuPllmhZNuHmHBJ3f1yAgbfNty/pHdhTlM23iJvUFeo8He8d5RGG4FyYHqHoCFrQ8gYnmj4m5muTdg36NORDgKnYJbE0nQls5KRBLdvLdeavK70GIXIiCCeof7MlnZuhvatbl483xDbe1aLTAKmiWduU0F3Whd0UnkeqgTlZaVtrlXcj9pHYRA5vMkt+38WRyYtQknWV7m52GKHkjdHcAka005SD3jwOrzQ9E/pgwuiUlCQRf9rNex3vUbRul+hEfXZxGqKpQiM3wbn/CJxBSZTnR1NdqE/jfUvEDx8aIgjLQDL3XvOT4+THy+9W1oZ/TiC9fMu64PXEym5+oWcFg9zQnw5wi5mcA3830SeIcmuf7jifqHdyuHRPqyy9DLAcNOIzkFuNBn6juQoDsr8NhAaZdemrciHvNCzefegWqygTowMj9Qm9Vn/LBaaNGMwD1W55S6AnxmVuA5fouW2jWgLbkjoMDYa0
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BQZWgJh2JlCJ3fXExzuLbyuOT45tY/s5QeHv7lU2TJJSVYYZgL/RkYr3BZck?=
 =?us-ascii?Q?OkyMPckuTy/zO00Y+rKOYVmg0TDnSzYHsAWjJQt5IuNBP2aclEI4hVX06TED?=
 =?us-ascii?Q?zPf8pc12ClVF89HdGEqCjASmqdu+tE3wZt6FO6jKl8oHhzaHcDs8dkYmtrqC?=
 =?us-ascii?Q?oCgSu9I4o4n6Z8nlEOVCnKw1jkAEcLrAUUpDdO6v4Em6UBp90nPX1i+brLsL?=
 =?us-ascii?Q?oTvpgOPv0JVHtirbrUfyVtkL5UholHMYFdJE/yCm0UDBWzUBMAqqVEdJsVIf?=
 =?us-ascii?Q?fGsQYJg/ZvJ1a9DqK1jENaHRO/ARe+f2wjHMjHJL0sD4HALyAWfJmCiWc+rZ?=
 =?us-ascii?Q?/pCra0hzMFZ4/Pm2GCoPg4viPyTMdOLVCp8E125mJw9W6p40+pnEMPBCUYws?=
 =?us-ascii?Q?07iJ5KzBYyze/XT1N3VHtpFW38+nkde/XBgr0A8b4HRpNGmTnW9eSaI8GQbZ?=
 =?us-ascii?Q?CAQxFZFF4mqJ498mDYbLVjvWBVs7pfoFVz8G6aUk4T8zKiRayp+di8j/DRVf?=
 =?us-ascii?Q?Yyonj2wVVHmxB/UB0tVwdqcAWm+5zyYYyGEEj3Gfkk7m9Kz3CDJeE8Soiirk?=
 =?us-ascii?Q?e3UlT5X5xX5RXODHyKF7ii4RUpwQldDfR6oGsrr8ZFtOXd7xg3DeQnFBo5Ht?=
 =?us-ascii?Q?w2ZHvY5ikswW/UVR0nvS9jEJ+D1/3uANloTTi7UY0zazqolME4PPrdVhfLu2?=
 =?us-ascii?Q?/F7jhd2iLJ+w6423bbwMJawTpXLYIC3ZSzub3RwShCGKojpjwcu8C+LSFWE4?=
 =?us-ascii?Q?aOWRghthvR50EXofg7YjHz0z00wyWckDnm4dTk+7dVAFPLKa4zZw2PLJmb6B?=
 =?us-ascii?Q?91xCxvR1roB5BSjR3VBvBSRMuDTgf2geO76OYT1UVVcvrDZIrfiy2koXyU08?=
 =?us-ascii?Q?Y/0SRDwrR4eH422BhceyjmDfxROplCf5PuSxO/6Jdtj0TVI5+ORAmepMqrbc?=
 =?us-ascii?Q?G0RWOH65H6GikfFStMry0Meyst3w2rXXiUdT/wzRhTA1/VoqLICD7ZO+Ke5p?=
 =?us-ascii?Q?wXF5dOZnJps2aUJKN6ZqA0jLKTk0O1KL51QbQ6eKiXFBc4eF2iceABCUQSVI?=
 =?us-ascii?Q?cGcibHyHoRFILDpK93vqQcRVlqeobbOfZsi3N48wux4W/QOSxOm2YNC7uZIy?=
 =?us-ascii?Q?TU/ube0VrKujVdAijcoI7VlZRa6O1/D2lt5srQ8Sfrx+U42hTY5qO+LDff1p?=
 =?us-ascii?Q?bsk8AducRPIzFHGEhvN5pNfusYEPOWcAwnBdbXOTi3w41qfekBndtlmiAlOR?=
 =?us-ascii?Q?fTjvsLxOLypamCoXmpcIivrOC3Sc58utmd1jtJKikdVKF70iHez2wQlgoqvZ?=
 =?us-ascii?Q?SyYIm5wnkrjLMQWvb6zctOMV?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee5d88b-ec97-4e2b-4191-08dc4c86475f
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 04:44:38.8468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB1227

Some laptops where the thermal control is handled by the EC may
provide trip points that fail the kernels new validation, but still have
working temperature sensors. An example of this is the Framework 13 AMD.

This patch allows the thermal zone to still be registered without trip
points if the trip points fail validation, allowing the temperature
sensor to be viewed and used by the user.

Signed-off-by: Stephen Horvath <s.horvath@outlook.com.au>
---
 drivers/acpi/thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 302dce0b2b50..fd59e41037ec 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -903,8 +903,8 @@ static int acpi_thermal_add(struct acpi_device *device)
 
 	if (trip == trip_table) {
 		pr_warn(FW_BUG "No valid trip points!\n");
-		result = -ENODEV;
-		goto free_memory;
+		/* Effectively disable polling since it is not needed */
+		tz->polling_frequency = 0;
 	}
 
 	result = acpi_thermal_register_thermal_zone(tz, trip_table,
-- 
2.43.0


