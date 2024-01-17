Return-Path: <linux-kernel+bounces-28516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2AB82FF96
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 05:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A402288C42
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 04:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2809E611A;
	Wed, 17 Jan 2024 04:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Vl/MAyTY"
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364788BE3;
	Wed, 17 Jan 2024 04:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705466047; cv=fail; b=ggDb/ANNVztcj0+I3zQ4Aq+QQZGVszxyaOBHm6e7cFViOvFBPpXttArP/F6VEsrNtEG+78Vw/XRO8J9swkd/fdQTCNJS0rJFcJGwVKqo2/Gh9ynzDDQpqG6eK592DaQbKs6J/pv4Z5umk97b+N2wWjKak5eWr043qapGdn0pzbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705466047; c=relaxed/simple;
	bh=+aHDwuvjW68unOCk16YV/Qi4QoI0DWr73uCD7IZdCwo=;
	h=Received:DKIM-Signature:Received:ARC-Message-Signature:
	 ARC-Authentication-Results:Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=IY4xQCj/gNNyy10lBqPJPqZ0cjditGmWdzi4Dcf+cCr1AXsvFa8qW/q/xu4dwemAb8nZeAxQn3UrS2rjHILr6XehN7L8vQM8gC9G7KSRjn5WV1hC8OdpmEra9/O+OBzO1FkV8xrQ7VZ9MRjaOKKDCTztvKbg1mxGlJ0gxD5AL98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Vl/MAyTY; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H4U2Ka018661;
	Tue, 16 Jan 2024 20:33:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=omaP+5Bo4VJwmdFoFV
	cewnAVkHJVTmW2uYFnZauLZ6c=; b=Vl/MAyTYGGmv01Lv9pKmHZYaJ1is5Z8s5e
	XLVO4fbomR3DF2w1oDq6Y9uAKBOctYtZkfERxhYkBxA37e4Mvt+WJlwPm3ZSDHrc
	mKiaCIFLG7AuGGBZoIwCrlA2S92QwJ7BtvAHGLzc70u62qMPmEWBOEzmbu5rIoGE
	FcmvyaQy3pHrN4fKvCEASUbmtOXSqsz8Xem7pTRmer47MaumR4ga4DvuVkxII73v
	ClM0OtFQ2FPDdMJ8pfVSYyar2nLo8geo7n1nR5BK1ccN3KJCwKhKHoTmUa0DebNp
	cQpFTIguDz3+3tlvDaTKT5gIFPAE0t2qSkcgudIBYFbD6BtAKr4A==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vktwkks28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 20:33:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUGHUus+LyTnfCPlPgy7ah8eLaI6L81oHlTeSG7vpe2pV0CMMxbBaDgeFPktpxSEiqbOWfXMhEmVRyRHblKN7SR/oqh4ceaa4MG14EyQK+X4fQWryJUU0w/upRtlyfw0xg9akOoK+0YIN1Jjh07ZjJTBgs8G1AHzE6ofunZAOYrTk99nsX5CajM904MyzbXaf8y+Tt/jYGJYR9tkaMZPgnM02BvfSOM//RRyOz0roQPtsqJhCvKFqDNsl+JFhMpYzGRJKJGnn+KZ3R+gVU/JBq4jkVCzeRTDzOWufC4p7PLcsmFtEckKIjfH0Pf6gx3XgzSB98VLhlvFfsmHB/UYmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omaP+5Bo4VJwmdFoFVcewnAVkHJVTmW2uYFnZauLZ6c=;
 b=MZIAj+ytq4/Hx8mTSr8iKifH03GlN5OG+5xDP8N++TfBKgvchTiKAzVwzpbWJFMP7BDdLj7Qdd3B6xCnvix3R2kE/e7jAzlyJBUCbTWONd8i/N7x0hAANdzxFo9BzAZqGGGolPwQPufi6naCsJzIq9pZTYaTLcSHav6EMKYz5oD30kLiaAnQDw/kaxKmZehJW34DNFQAxdG5GNSYdorByXtvaqtGGodBQDqcEdCIZCdYR1eLZ0WYaYxG4BEe1ZtoJyJVH/1NBIQAfFTLCexPqQkRtmXwG0eUr+FZWFTzd6GKW1m0/BoKHrstC4tnR4QhxcWPehnT5mSULgUCtRDoiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA2PR11MB5193.namprd11.prod.outlook.com (2603:10b6:806:fa::5)
 by CH0PR11MB5268.namprd11.prod.outlook.com (2603:10b6:610:e3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Wed, 17 Jan
 2024 04:33:43 +0000
Received: from SA2PR11MB5193.namprd11.prod.outlook.com
 ([fe80::1f50:d5e1:869c:1709]) by SA2PR11MB5193.namprd11.prod.outlook.com
 ([fe80::1f50:d5e1:869c:1709%7]) with mapi id 15.20.7181.029; Wed, 17 Jan 2024
 04:33:43 +0000
From: Xulin Sun <xulin.sun@windriver.com>
To: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        xulin.sun@windriver.com
Subject: [PATCH] ARM: dts: tps65217: add power regulator & backlight drivers support
Date: Wed, 17 Jan 2024 12:33:23 +0800
Message-Id: <20240117043323.2008454-1-xulin.sun@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:404:e2::16) To SA2PR11MB5193.namprd11.prod.outlook.com
 (2603:10b6:806:fa::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR11MB5193:EE_|CH0PR11MB5268:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e5a0b0-9041-47eb-13cc-08dc17157c84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	muhg3a0LBA/DKIcwma3k67jhayilDoH5EjY9HVeRrudp5dYYesyJdTRrFS0SCvDQtzy0a7HsS2Gnh6IDiPkDy+I5CPWXeal3ypyomRJgtFVCefLkyTDRoMT5ZknwK2L0UICTXQCdJP1Ld0T6wBekSpA2eeUTrBR4jewqCq/l7WjM/cQVTSsV27WPuCPekdBmSaY93kvIatEVlyh+dZI6NDtwlXD75ATpxa52Yi+3zYhxXKicOmO+0aZmZ1rkJ6r3hv6/WtGWfeYMjkBmyb2Lo/s4AZ6ZwXNTzuuVguh5grTpg4HQoWPUwGk3vZiv4GFsaLUwSoDGwOdSCmqrS8MloZSpPh9GsPq+4Eab07YmIvgoadv4Clc5ptq2hpjDcqJlGiXPLz2kiDtyApkF8N3UNVGpf8p/Jl4n8RIN5hnoCB1r9dAs6oaZ3pU7tZjUkEUofhDanfbk2f+J93d3qJ2XTPoTsMVbWTq8pF8FXQCNbHd4A0g9o5bUUXFLZ8ccRnlBRBGyfPY2pc581BTkPrGr5Xsf4xCzWlBNAjEPhvq6uMA7Rc251h6J57dkKIl5/lujMqOU/ENR1fqwfJ1rvYaQcJa2797DRKsAOn+Agd9wufsuuClPwestnnY34CIpufTu
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5193.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(136003)(39850400004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(86362001)(6506007)(6512007)(52116002)(6486002)(38350700005)(36756003)(2616005)(38100700002)(107886003)(66556008)(1076003)(26005)(5660300002)(66476007)(44832011)(4744005)(2906002)(6666004)(66946007)(478600001)(4326008)(316002)(41300700001)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?m4B7MOasJRs4+/jvIT0eRB1i7U1fUAKNc3jGEYogCkA02TpwpCxs47RmL+px?=
 =?us-ascii?Q?/KhR10dQXuZE+BmobhpSo7B0Z0R+1BY3Jarn7cpGaHAT6YlkwqTfKlUo+Ubw?=
 =?us-ascii?Q?jYFPZwPkSPuaFcwxKpBHOQJU687q2Ejg00II6ZMMAnhKYWJhumvZ6vrWgC6G?=
 =?us-ascii?Q?fnRcCutXZ+oUp+oNQax4b76wsxwhlQT2JCp4Ss62rm1AMDk6nA8Ry2IU1NE3?=
 =?us-ascii?Q?L1sdgJSxg9G2S8WVg4fNV3eHsOu/ChXw5RXW+LfpbUK32BqVMGATRDnaDEo0?=
 =?us-ascii?Q?y5JqfRisi+mQmzqw9GCrGLZYLrh1zsIzLOxk6qTIGWN1bZ67VdRLwI7ZSkgu?=
 =?us-ascii?Q?4PscQwRqzOr4j9LHXltmEEkxJTJ897Jr0Tc56iB0NQFhP62q+na6ob2IcBjY?=
 =?us-ascii?Q?ufsGAE+An/Onw9DP8eiiQAEtywsCvPIisUGVew1dX13itZic4cGdqUdwHcIM?=
 =?us-ascii?Q?yHke30gR2o8n25QCGmChAc8r7pYiz4zqUn+k9zvYalG+FtI8bSw8eBEdVlA9?=
 =?us-ascii?Q?iCIQgCcybu1vDDV4gAGYuHFwLSjE2L9ibB+gDhQveRhUN0CnCVXyHL2eSNLU?=
 =?us-ascii?Q?0s1A1bL572humBVo4ZF248b2wKCynhjx6aqsk7z0q/qR1PXWC4WmLXxzF9mC?=
 =?us-ascii?Q?BcxC1GYyYr7elqkDLG9wQuz5D8OmF5XUKW276RoNIhE+lEqQaWW6ChNPZiuA?=
 =?us-ascii?Q?nN8DkKcbVwRI31x0l9xIniqWsuIRIuaZBRRe/K5swGEVq0zjFYkdNbRjvwn3?=
 =?us-ascii?Q?zF34nmVgtV5PQ1N4U2v7g1YjYwmOakCbEXC3xlKQrDig/U/lUaizRgxVyj3O?=
 =?us-ascii?Q?Zzof+lQUVnYIZAdN98KIJZKgeo8KGwZsTCsQmf6a4R9d+imGPVKLrLKVCXbh?=
 =?us-ascii?Q?K5/3tdHvh7aALVfY3BKnh+HQGjovTG6VYofD9xac7NF0Xo2APfFWsNUOtnZ/?=
 =?us-ascii?Q?fxajJkI0jr7x7wpTO/dvZESOV/3zvR7DUJxpRHO4vce2+GrHmhhfKlsD2BVD?=
 =?us-ascii?Q?Czc3sYa5L6A3x8lMPSeLbXkJ3nLcDcIw9GSVtbA/XHGl99TDuSHeQDsJTaka?=
 =?us-ascii?Q?qgbzq0YVupqNGh+AHMEkR5YW3n9xpDrNuAaOPO6TQq3v22W/loGtMQ+qC8+Y?=
 =?us-ascii?Q?kwNKDonUYztjcYRtbjDL6Q4Zl6FnilzvmcBI1kIHJwTqswjyrNhwlcHY4PBn?=
 =?us-ascii?Q?wSbgDe9A5wB2PJubnaE9mRk0cEJXVhpP9emwPHoQwXIH721yoBqDs2/YW0Pl?=
 =?us-ascii?Q?ecnsriSSbr1wEXxqW5Wqy9AadET7XwVVXyBKdfgcW1h2Tarm0Lcodpzy5hW9?=
 =?us-ascii?Q?O3FH0BuZkJ/6GKJTddfFE5ACqOV1Q7X3dtNuPe3fLZDtSGVhqpyG04o0EWsT?=
 =?us-ascii?Q?lEdKJtJyKqEqvCM4FSB8IZDQJhIG3dME3Bi/F9SHYmLgTaduqu3vYExumE6w?=
 =?us-ascii?Q?LiDZMeHJl4rckjNv/A01kkSW6LrMEOt45Y6Wc6Ohb3R+ovQzxsbxljCdJ9hV?=
 =?us-ascii?Q?7yjlnaSHcY6HWUPvwFkR20iCwBT6TDWhbo9DW9X3UFKJFDPGD2n+vb8UhoCe?=
 =?us-ascii?Q?pf38wlkRYwbpdfPOwb/F4YPw8csIUUzFwr3FVt7wOVMKd71uIh6+veY1lK+b?=
 =?us-ascii?Q?LQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e5a0b0-9041-47eb-13cc-08dc17157c84
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5193.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 04:33:43.2768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xNpC2PKGgmu90wH+LSqFmOeCEYjNSX3VUkcs6GKsrXgdODkgXil9pcxDR/rkDM6ifs5ykj/8h3K2+83yc4zycg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5268
X-Proofpoint-ORIG-GUID: -uSZ62SsHOQpR1uKuCqacQ3XOxtEecr5
X-Proofpoint-GUID: -uSZ62SsHOQpR1uKuCqacQ3XOxtEecr5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_01,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=374 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1011 malwarescore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401170028

Support TPS65217 voltage regulator driver and TPS65217 Backlight driver.
And enable them by default. This will avoid below booting failed
information:
tps65217-pmic: Failed to locate of_node [id: -1]
tps65217-bl: Failed to locate of_node [id: -1]

Signed-off-by: Xulin Sun <xulin.sun@windriver.com>
---
 arch/arm/boot/dts/tps65217.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/tps65217.dtsi b/arch/arm/boot/dts/tps65217.dtsi
index 0d463de5650f..f412e7476660 100644
--- a/arch/arm/boot/dts/tps65217.dtsi
+++ b/arch/arm/boot/dts/tps65217.dtsi
@@ -13,6 +13,16 @@ &tps {
 	interrupt-controller;
 	#interrupt-cells = <1>;
 
+	pmic {
+		compatible = "ti,tps65217-pmic";
+		status = "okay";
+	};
+
+	bl {
+		compatible = "ti,tps65217-bl";
+		status = "okay";
+	};
+
 	charger {
 		compatible = "ti,tps65217-charger";
 		interrupts = <0>, <1>;
-- 
2.34.1


