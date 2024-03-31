Return-Path: <linux-kernel+bounces-125992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48564892F07
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 10:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4932282118
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 08:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA086DD1D;
	Sun, 31 Mar 2024 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="So+lHeaJ"
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2150.outbound.protection.outlook.com [40.92.62.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962262AC29;
	Sun, 31 Mar 2024 08:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.150
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711874248; cv=fail; b=c9jOhdinFfvq3r449DrRpPw3hPNDz+1Vpa9Ir9bvUsWWbJRngiKb0tuoxOhGSylWOTjlGKT30PncxfR8M0IDDLT3POPEyZcboWP47IQ0iBuj1IRfnapVBdMDSDK+46R1KNJ+idJlsUvgXWECj1nS7sN1SHDK0Fn8DqcykrKytTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711874248; c=relaxed/simple;
	bh=0MyAjGVqEYy+K1dXkwn2r9r0ya8CW14LKbsK1pDwtok=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tOzCRlSb4pKzMbnkSltQlRm1Gu1FG6Oxt83EssILj6G6864BJ3jfKJxXABe3nft3hhRzDVvlk2ezQFm72coPLrWAT0iEK5GeQZHAjvAkGR82rf+Q0y/FKLlz4w434T2d1fB4EuJ5xGccitmqH329l3mNgNri/+Zf6i4V77qNzKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=So+lHeaJ; arc=fail smtp.client-ip=40.92.62.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVVbSj09mfy3Pj9txqmkh9IILejYx3v9/E9sryVMc6tZzxYmhg51dhMqFLO7I5sPIPY++LPn2RqbL/4TjLaEnAKrwcvfQLJnrzrCtNYD4Q+p1ZgB/qrzv9nNwEaRVik4N8BB0tvvXyo0/t1Co34PqJsGNJcXML4dHrXtB2OoGnTpiVeAbFjucIolednbi5jn/75ey01pOcsb/oA7M8rJ/yxeu953QyyTZTJTe05SCSsyFe69Q/BbeTRvpHTnRPqJSi7Umsid+NbTwi62XLxRq0jAHfFWqpepfuE7pG4lpkZ3I/fAHkVpAabeOg9WCnUMTg2fZYJAdg1ult9n01CEMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZrwxN3CbJI4EDmxBONXwLWu+1hTOg9jQ2yEmrIP8fs=;
 b=jXKgFeODhhY57NjlduY0RL57pI76sC1JoRFiHv8uQ2tEU0AYckZ2IGZzKqQgWGCq0mVX58k60XD/wTkNv955exerXJOowvMnwCOAXEARgr/PGeo4CAZJwZJMCbkxedgwqMI9i8qCZweWa3f8j9tZ2LV+xI8+C8/wtn2EcbzffsAI+G7EwWYvkRXcjpTjfEHEoiBTVMcGlYB+CIOYocgcQ4RyKudJ9uQ4X79QCS6EBaaLFJ+45ymPnMyF+/E2sPu3mrt9uqQs6/1KWllFlzv+NS9kE9alMdcZ3kA9AjlX/JYeIAO1az8oxrww7fQLgTsBAAVBB59weaUTdx372djmSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZrwxN3CbJI4EDmxBONXwLWu+1hTOg9jQ2yEmrIP8fs=;
 b=So+lHeaJ+JH6tSQEsz5nVzxTk/TPpI83PIvtWwGidu1M4T7JJILU+hn1Yi/BMAMcsHn09SOdJLpNHIOWiIOzBu2kzt0IYAyYM/fTcrdV5C0+0+wtwwnCj1PFJM6fNTkp/CPGfaLNQ8QXY18U/o/CWwGJgHny+u8wOpHn629CYAt/EhXD57OO0CR4OKeoXrD6NYQ09y+5Tl58xkZbQSOMieGF0uhMbpoJcF3jrGyDyHLdKYf5C/mLl7BXhngsZkUZOoDUlJNFDzN2tMinXK0GI570n2l1Pj9caBedeaQTRKB/q0+zl4B0P+hX10soJaHa3gMEL7MWycGueL/agRgamQ==
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:159::9) by
 ME3P282MB0817.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:81::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.45; Sun, 31 Mar 2024 08:37:22 +0000
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::22c8:76c8:58ad:f00d]) by SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::22c8:76c8:58ad:f00d%3]) with mapi id 15.20.7409.042; Sun, 31 Mar 2024
 08:37:22 +0000
From: Stephen Horvath <s.horvath@outlook.com.au>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Stephen Horvath <s.horvath@outlook.com.au>
Subject: [PATCH v2] ACPI: thermal: Continue registering thermal zones even if trip points fail validation
Date: Sun, 31 Mar 2024 18:37:06 +1000
Message-ID:
 <SY4P282MB3063A002007A252337A416DEC5382@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:
 [6xuK7COvvvAbR46gIA5uXwkfoeDUjLsvWcnZVgCoSRDTeELuU970N7P8hYsg5HuBnTUYtWdCwNo=]
X-ClientProxiedBy: SY2PR01CA0027.ausprd01.prod.outlook.com
 (2603:10c6:1:15::15) To SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:159::9)
X-Microsoft-Original-Message-ID:
 <20240331083707.81468-1-s.horvath@outlook.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB3063:EE_|ME3P282MB0817:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cd8dcb0-77e8-4a4b-9626-08dc515dc80e
X-MS-Exchange-SLBlob-MailProps:
	xgbIMsDSu2aSx6qwb8CTBxBMMjMsogXZT/5Ec7LiPG93Hf0Pxkda8eFQtHTNcMVKIVRcoU76bkpF/xHMnP7AjN6eL6TjIcrBWLdiYHohou58GaWIpQpAzpvzTlSnKJY/hupuFZz7gSvIu1vdY03+kIvOHBGlemiQbFF5F+g7U54ZHVhvavzRdI5u8VdPFiQqco1XQrapzavNDupWm7GG3PuTE07jlawngVmNuL5wE12hgNJ1l++E4RJ5ctsT3x0sl3utPiPcrsCr9RVS/tgf9uXcyDHnLUwHaAvTppREDlVfzBMC4z/L2TSOfVB3falZSUO4yTLdJWOyz/jr65KfR/s2g5f7GIdUeFcnTHUaukEMx4qio/U/DgFL/K1pu8DBG2O0zVHrF3VgO/Gx3knQZH4ahqL1U9EUmtcvibFTZXBXRP6ZuXDTDKUdsxf2aEOa17zWHHW+l3pSK/zxjQhQlPo0pYAdeHGPChNwbJnRnmkqTL8yBkxEFqPNKo6BC+PWTX381rfWJaHvhKeN+9ePK97FwbOhk5X61xvrvNILf8xjFrh4rMHZPkDQPbavXv8ac5spzFtrmzX/sNiSroh887DPDYyasdHGfOe6Qj3Ul/2u3UMiBAmjxlaX0bKSl6CRTeKxcWGIn6dfsVurPexcTeKHUU7V2qRG6YzpEP72DZxJb9G0PX73ArGIT9A48xmIDM2bBLK1mu+F2Mrcq0HpjUO0hP7sD7rwoCiT3Iout5DgbwR8SVfvY2cffdE2PNN2tdw3gI1p7ndAbkNXVCyErCE/bjovAN97
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A8R5e4RogUi/pCf2ua6rJAL3HJBxmgq6TnOgvrDm8U7Yk3hyqsBxQ3zAZ3pm5nu65Yfx4r6eoxW+MjrNZw6CG5NckfMOSqCqOpb85CCcTHYTHyF4r53+osLAKzJZmQqVs2sbVrxS00cbDP+ORdBIa9jv1ZkjXwZdAKS9Ehk2TZ9qjaJ6apTvO3gs32EoY1Tw/qPtdqX2zxr1NshcP6VRJqLe4Y5Lp7aLRzbsBVMVZmTPGDe94jPL4ivD3xm+/a4h7Jy/Pi2j9uDUej5uGc4+rMw8Rw52wNVY36fcu78C8k3YTXjiL4M2J3R+sLybvKWrGePJ+SNGwjTRdpPVLZeBPvqvguMezRwnEQDnHzvhId18lVvgpnBLJAtHQXRBDlNeSo+xtwFU5hOHD20Nme7G/xzB0ra+cOng2QdWNBvIDhPYA1Nxi1RJwSDYusaJ2UVD6K+QsmAtG2WIbgoh1gH7ZD0Dodxdd0iYgmzdj+dhVIc061aGk8BNQsJ9L7+FXljni/1UYd4mJVNKWpjEHueQd5AKZBJp5KjSdNa2jg4eoLUFY3edROgkDTT3UyOWeA7f2qwSaPcLvNFt/0raDvssMAWgSF9BW/5sX+oWtAOindUAfBrIq18Lwc8hU9LOlwzxRHnVU7KMmdjNAaAt6zDf/4H237DjiPoqTtpVAGsjOI/LG+9Yw8osC3BfZly4hH64
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bpJt/J/eHWP6i/siSD0IcpFcgOQomXhLK5NeGSldwX8mKLej7Wnjy9miU/eV?=
 =?us-ascii?Q?SJLBrzJ/VLPkKtN6wj4zqSKh+SBqIsLebMQBYnB9xYPiI6K1f9E3SOtuRmZ9?=
 =?us-ascii?Q?z1dx7wfvUrrIaud1mhgJqnCTei5aZ0g6bjpLp802loD5A/rtD/XuHwbY74+2?=
 =?us-ascii?Q?mK3s/RXCxikZJo98RvmQ/7a8CgTFVWqcqdAp6y1TXN2S/OlGTiuIu8jaup1G?=
 =?us-ascii?Q?3E4gfFAl8eoIS2iNhNqddBcYNlssHi0lsBo5KNgcnFpgOyE1LwgQeoWnEaNu?=
 =?us-ascii?Q?0eBQdJsvljc+jkOirjen+pIGjSJ59djLoQXwrlTgW1V3NF7hVF7BQG9N76hZ?=
 =?us-ascii?Q?9X4vXN8r4XdkOncHa1ReBP8qKyDYmQr22//JkxWiTnMJnsr5XrTXTVXGGy1/?=
 =?us-ascii?Q?RJhh3Wvj12ivsuVdln6itB1yPVQkJatxpBOexb2lp6kQBnGMFtePTKFXP8cV?=
 =?us-ascii?Q?JkdXqnros8ICnbeO8vJcoE44AvSfHzgtSnlt3zZafRol2ppUPdtv7B/F8JCB?=
 =?us-ascii?Q?Qy37+9G8nZnT5tGceNK6v4nK6c7ylXluz+Prw1Wa8YkXIHjYu2JXhZcOUh9X?=
 =?us-ascii?Q?osC8b0SCu/+KvlVROWeuzWPMvC4lQgkJEG0VMq1VHBNqnPhbi4ZnOwWFjEiP?=
 =?us-ascii?Q?5wHOKXolwj7On+mPALYwsl9H4iqpG366RasMdT3L6wR2tSPDboX5llhm/P/3?=
 =?us-ascii?Q?1XsgE9OvREPEgT51ACUUoTNiBJ6jTWy0p9qJaV14L+IY8XtcQfvNDmcVrCFV?=
 =?us-ascii?Q?olACnhKU1BgIcnNAzjzRMgwCbEZPIG3kq5ZFkvlxPGosTJ5m8ny0wRzSxt1V?=
 =?us-ascii?Q?VcHq0A7xxyr5OXObF+3rJ4ijTqWXEAtbj9g+waj5uMERK91TIk7hcReQB0oU?=
 =?us-ascii?Q?7eVahL74gZAFL5sNcDFTfrtlv65s9hiw6hJGEBBGk3rR+zIhvPjIVrvRGRni?=
 =?us-ascii?Q?sG6LzA9+yppOpGpjlcZASB60eyb4G0sD9ihoj1WxxzB6/7OBkac4M63ANdcI?=
 =?us-ascii?Q?j+biXAt5OcDxwDOfRWOBqSzs0aJPSHRQUHj/V4WFo6vfU2xMhcQzixDQYGoy?=
 =?us-ascii?Q?O1J8k69w/F/AbSxckJtiXHbHPC2H1eUUbtqXbu+5WMTxzzDJlOmJ1TFqsXFb?=
 =?us-ascii?Q?UW7egh1C58yPybBaXsxpdcuNGqhtOO1gYFI88jgGV6JBid9R9WBpA0q+zoNW?=
 =?us-ascii?Q?ljEdQDqtR37/Elik78Hx2ql5TSb0mXSgxzL0TTeedReQW2M5x/h3FfVxTdPZ?=
 =?us-ascii?Q?x1dEWROexUREdpSE2rrFjz0ADUM42K5XrdbKuSWN3cbwj+H1XRSfgpMnzKwz?=
 =?us-ascii?Q?X1kknOakaVHnrbJPWTuC7Zv2?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd8dcb0-77e8-4a4b-9626-08dc515dc80e
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2024 08:37:21.3076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB0817

Some laptops where the thermal control is handled by the EC may
provide trip points that fail the kernels new validation, but still have
working temperature sensors. An example of this is the Framework 13 AMD.

This patch allows the thermal zone to still be registered without trip
points if the trip points fail validation, allowing the temperature
sensor to be viewed and used by the user.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218586
Fixes: 9c8647224e9f ("ACPI: thermal: Use library functions to obtain trip point temperature values")
Signed-off-by: Stephen Horvath <s.horvath@outlook.com.au>
---
 V1 -> V2: Referenced bug tracker in commit, and switched to using
                `thermal_tripless_zone_device_register` as per the
                suggestion of Rafael J. Wysocki.

 drivers/acpi/thermal.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 302dce0b2b50..10044c56b85e 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -662,14 +662,16 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz,
 {
 	int result;
 
-	tz->thermal_zone = thermal_zone_device_register_with_trips("acpitz",
-								   trip_table,
-								   trip_count,
-								   tz,
-								   &acpi_thermal_zone_ops,
-								   NULL,
-								   passive_delay,
-								   tz->polling_frequency * 100);
+	if (trip_count) {
+		tz->thermal_zone = thermal_zone_device_register_with_trips(
+			"acpitz", trip_table, trip_count, tz,
+			&acpi_thermal_zone_ops, NULL, passive_delay,
+			tz->polling_frequency * 100);
+	} else {
+		tz->thermal_zone = thermal_tripless_zone_device_register(
+			"acpitz", tz, &acpi_thermal_zone_ops, NULL);
+	}
+
 	if (IS_ERR(tz->thermal_zone))
 		return PTR_ERR(tz->thermal_zone);
 
@@ -903,8 +905,6 @@ static int acpi_thermal_add(struct acpi_device *device)
 
 	if (trip == trip_table) {
 		pr_warn(FW_BUG "No valid trip points!\n");
-		result = -ENODEV;
-		goto free_memory;
 	}
 
 	result = acpi_thermal_register_thermal_zone(tz, trip_table,

base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.43.0


