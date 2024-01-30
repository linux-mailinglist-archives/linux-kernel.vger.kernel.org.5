Return-Path: <linux-kernel+bounces-45213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD994842D20
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9440E286D17
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944DD67C51;
	Tue, 30 Jan 2024 19:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b="M1PAtR9n";
	dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b="F2ghRAEP"
Received: from esa.hc4959-67.iphmx.com (esa.hc4959-67.iphmx.com [216.71.153.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6475C7B3C3;
	Tue, 30 Jan 2024 19:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643752; cv=fail; b=UdimOPd9y5vH8Ha2SkcfwPfvj7F2An/EuioeM68UEmwCWvOM9WIjAAifrcuXS+AlWrBkWeZgmZRXTWorDS0n8+QqtsIx0Vh+K2MLwkcZf/Fi8nt2BxoJ67++ccnGxx9gvsMfQruNivR5ySt8iIjEYMxYIqGc2rbhsEI6buInrag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643752; c=relaxed/simple;
	bh=5mVaZWfSTElDdOKpzteEbgITXk/2ed9rLYo3BAy505U=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=S51kK56zp8pEHSfNFh9/dY2oHKQmnIeKeWczR1rBa3tHR2uO8D5m3uU5HimIwuOeqHaR1qe/Q1Pnw+i1v3Mtx3qQuhXNB+bLSWdyA5uFrLtwr1jOLZvTZ0M/JPeNBjR2bo5DK+oxRvfPSJPFiA/i+BFX7tWk70ssb6M8590Pya4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seagate.com; spf=pass smtp.mailfrom=seagate.com; dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b=M1PAtR9n; dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b=F2ghRAEP; arc=fail smtp.client-ip=216.71.153.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seagate.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seagate.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
  t=1706643750; x=1738179750;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=5mVaZWfSTElDdOKpzteEbgITXk/2ed9rLYo3BAy505U=;
  b=M1PAtR9nZqmuq/5lx7tncfORUMdesDAWwy+n8nQQPMzXeT5Nd0QRYLbJ
   eyTIj3Tsgp/jLLJjcBBLh2KGYM7N58MRT7ShOrsBDy8wz4c2XRVz74uZX
   hwVmssGYHLSOgOx1Bi6Ax64TRig1imwq0z0so3m2ViLn6P9d+1DMhsbjc
   M=;
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 11:42:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hx1V/mPeM3nkqcv1Aq5cttmge8oicQdAMJZHA0Xozp6Bru4V5aHHAF9vkcvyMnG5e3EpuwTS05BL8H7/7hQi5ab852Cyqwyx+7XEhaU1PlP/TN7Ww6/sZ8y3uV6wMqTFpM49AtF7PiJpW9XlLIax507CyJKRDzN7hj+QoTACOxp3mYIOu4BvL1Bo1It9NfcrzF2nzC8/fQVM1QMVS0xC5Bt7Kswdz1RtSuMY8gtU/dmjdcDyr0C3FTyV+RiUcQjzkzdOhlzcOz1q4artChSNOO2ITshxDQ0yz6Kp5Q5tdGSd/vXHDjozr6EYYK4WZbn5GripxJjIz/QFx9jiMRIqxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35J1objnJeiVsjOHgWg/nuKLOdLeNODCyexDiqAbmJw=;
 b=WnFkcxuhkXBdjG9oyEtjk6pwEonyo/qeoSL8/qdIDILO88WV864ssSbhRL1zXhuVvo1HTCSrX3BEIAk7/DvGiAA4pS/25luSzokHKu5RCPFnxxCp2BLEVZEzOpZJXiK83c99su0JPMieWdG5IJS3ixPcxf3DsgKPIJrDRFq6hp1UGP2Vv6SbMeQDGZdJYk1oaxG80OH67/OtwjFAHya/mI+HSj+aWFWiDT6zGgs1bi9DJd+ynqaKgiXwUHtM4mC5wEWS7MKXURJqBfpUl9wCHcOl6ETHHtV6Dae1v6aCiZ3/Nn1zAvc57LqVUobWRiPKWVm+rCptYAcEk6MBNX0hrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seagate.com; dmarc=pass action=none header.from=seagate.com;
 dkim=pass header.d=seagate.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35J1objnJeiVsjOHgWg/nuKLOdLeNODCyexDiqAbmJw=;
 b=F2ghRAEPvFhjZD/irNEDmfGy3stz3t6ZK73ghRM8RkWH53F8L2jtjP+9U7XT2ovhmpQZteStJD/d5dgNqZEEGufl235OdUlwgb5BD+gFUc7EpAQ/QHGjPQBUqtGSelrkvhPZIGVyAIEM/FDYxdKRmLtT3QHgCdt8XDPczEf0Dps=
Received: from CH0PR20MB3818.namprd20.prod.outlook.com (2603:10b6:610:d9::9)
 by CH3PR20MB7114.namprd20.prod.outlook.com (2603:10b6:610:1ab::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 19:42:18 +0000
Received: from CH0PR20MB3818.namprd20.prod.outlook.com
 ([fe80::f72f:8a31:57b9:b6f7]) by CH0PR20MB3818.namprd20.prod.outlook.com
 ([fe80::f72f:8a31:57b9:b6f7%7]) with mapi id 15.20.7249.017; Tue, 30 Jan 2024
 19:42:18 +0000
From: Nick Spooner <nicholas.spooner@seagate.com>
To: "rafal@milecki.pl" <rafal@milecki.pl>, "srinivas.kandagatla@linaro.org"
	<srinivas.kandagatla@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>
CC: Evan Burgess <evan.burgess@seagate.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: [PATCH v2] nvmem: u-boot-env: improve error checking
Thread-Topic: [PATCH v2] nvmem: u-boot-env: improve error checking
Thread-Index: AdpTmMVIZ6aACCM1RuCdZRDh2RTdLg==
Date: Tue, 30 Jan 2024 19:42:17 +0000
Message-ID:
 <CH0PR20MB38183679A4F4229A419A9EB29C7D2@CH0PR20MB3818.namprd20.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_ActionId=0ea55728-07e3-4514-a34e-709864adb6f5;MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_ContentBits=0;MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_Enabled=true;MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_Method=Privileged;MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_Name=Public;MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_SetDate=2024-01-30T16:23:01Z;MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_SiteId=d466216a-c643-434a-9c2e-057448c17cbe;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seagate.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR20MB3818:EE_|CH3PR20MB7114:EE_
x-ms-office365-filtering-correlation-id: 6a8652a7-5f9c-4280-47a9-08dc21cb9155
stx-hosted-ironport-oubound: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tK/f/JRdINO7ZeZpzoq4X7G0MxI/RpiaVGwaPGES33Ffo5Bc++sbpV0RK1fi3jy1eNnS91jZ58k48L0DGuPR9+pJZia/d1FRWY4jRnQ84ELVzPgO1iRTjmNcNDvlq95m2eCTOuCdRNZsozwrZMGjyFzvmeQHTKphQTFXZCziVbyweSRKB/B8wPFySK3g5BrcD1YjmlxN2+zmayr0x6u34+LSdqAntFcTE2q7B+MIGVbHea+xrhw6Ttd7f4VVlWS9RWm2MVpk1jQCJMzrzueOxjqGLkJiuhXOE9a9ucqZKYMYrH8rwQ+KTZX1Fd03yu3jvs04Iap7ZhoWWnHMhEHXLHjNZ25Kz6C13zK0HSCPtOIfnIJuVgJf7v+oFxf6dKa/UPG567ajmn++vzO3iEjcluvxBvv1SsEMff0UqqzEv/sG8kfOE8rbH/vUwD3SNUYkyXfTYZgRqAvtHXW4oSqZ1k+mB8p03PRnTvY4fcBreWbGdBOToryh0gLzgGud74FSreXgtbUPrcPsXZg0RpDVXr09gtr5RtpH2w2laZ4ZJXVl40nOzvBAtX+bWIE2x0icVL7F2JSdfpwHkFJHx5VwsevghPY6t8JBZkUBBmNIZQxJVXtanOorGUIcuxDsH/oi
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR20MB3818.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(54906003)(41300700001)(33656002)(9686003)(71200400001)(7696005)(478600001)(6506007)(26005)(8936002)(4326008)(4744005)(76116006)(2906002)(83380400001)(55016003)(64756008)(5660300002)(66446008)(66476007)(66946007)(66556008)(316002)(52536014)(8676002)(122000001)(38100700002)(110136005)(86362001)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7Td6SW5CwZQ0Hy3hkuo/1TcrZvMoS4A5OAtXqLMWAwQxmRKlmrTKwZ6Cu+HW?=
 =?us-ascii?Q?wUgMdhSm3Mbp9Ag6cDqo9kpqbarT979RYNwF3IW8vTbX/RgA+1JctTwWVYmL?=
 =?us-ascii?Q?nKDoEuoOIkdQOm6+vin5FoKuVj803D8jwAoaRvY5YwFQ+Y1dfMo+fLh/ovtz?=
 =?us-ascii?Q?whFI/ShEVi9V8BPc6LuTcAAtUWE/5fmNKgKT++6bRdssPqhRomE+dLn9NVge?=
 =?us-ascii?Q?mMA1qedpVc0/4ViHVzDdUSvbF7wJRMsdT9/HgTfrPScyCYAVP1d45c6Pix7b?=
 =?us-ascii?Q?n1JWigkFGUDRtw4UtRuMWPgUjhZ5z1RfZhtjUQ3hIltnniXMD0cqjhZaS7bd?=
 =?us-ascii?Q?Z8gs4Xw6MHiQxPX4IyA1y/3w0AyCR5+22lXN2KNoMrD8Q7zMbeqj2gWKrdm+?=
 =?us-ascii?Q?Zkzkcm8fs1OmanPR1gpGVV/C/C4i5Hm59I6lDAcN9tacxy+/EQo3T5VYKPMm?=
 =?us-ascii?Q?yCgdELNVK0pfOUS4XC2QGplBtaLkgDkOCJqJ1MvN4kMGemLRENwHegI0wyhV?=
 =?us-ascii?Q?m6FUj0RLJFV6beZxZ7u7qbzdh1tF8+0JhC4E1HPN4RIC74Xw+3oiFlbMp8gQ?=
 =?us-ascii?Q?mgnIXQnY9ohQzoUwuEBFn9b0lzpjwUFibK4v7SKrmhaBhh0jO8iO3NmJu6R0?=
 =?us-ascii?Q?hAhgXxLt75kXBk5z2mDzyLwKuQ7b/tUIph0yzo7d2XVAy80oFdjU8xjzUxmN?=
 =?us-ascii?Q?92LFaW5KFoCeohPu7j5/Lk8OGdtnpwOj1m8t1XPA7YBdaylVh33TYYdzavo7?=
 =?us-ascii?Q?Q8GwFNPRnAqjEgSym3Sa5sUTQcvhpWcPwrQUnq7W3SMu8NTUg1hXJDPdMmmR?=
 =?us-ascii?Q?5kNI8VqiXNXgafIVWb5tdoP8SPwCWdw+r4G/hHoIAXeWd3FcOTbpD1KdzS9g?=
 =?us-ascii?Q?lEKrMzfi1f1s8Wv/rwFK3Oy88G3LP7esawTTTOhreCQ3rz+2TaOI9WZdLs0s?=
 =?us-ascii?Q?IQz4hQ0JI9QcIUB8+qedlD8ij9vpT//99HlZFnXob1DnvKR8ULigd7ndOeN3?=
 =?us-ascii?Q?1aOtor1lwHxYcNYasvlqlfjzRKh0k96OAgcoSyIk0i/HHomMysymJzIRVp9B?=
 =?us-ascii?Q?6y3MCJDdfGZT/81kGFBe59AdGiGIiWfr8gO8TWz0TXqDhvNPmp5ty8pyIElV?=
 =?us-ascii?Q?NfOBpK+JQdTkAI5/ESOrSDMOhz3iIYn58fPXpKlUo0Zu43Pxq9GmHvX4VBEE?=
 =?us-ascii?Q?R4moBycw7r7ue5CwlM7tZqIVSbz0Oj7oQp1a734ANxC+GsEyQ/5trdsXvZ/O?=
 =?us-ascii?Q?T3GnzH3e6RBmnWnLyNX8ygeah4A0PTIa1AJEy0USPM9dq8dkICKW07029WIS?=
 =?us-ascii?Q?ujrC8d8jSjXPeNlly1TOzUwkHPGllWJaTihPW0iwC2NIjuho0R3ZL65Iv+va?=
 =?us-ascii?Q?GrYkayiB4enJ3VI+kfe8uwN18IYThB/aDhX1usPa2KQ4VeBOei+opKsj6pUP?=
 =?us-ascii?Q?44xN1DzHVIh8AF/qnCGQ4AtxxStGBWWR2ATKzlZUE4ldJg++NH68Jtp0dqOq?=
 =?us-ascii?Q?2doO5kL1JgxwqZ8JipY6GdG18QmPx/qNBWTe6gwi+GEb6fKfcwLZK5w7YXPD?=
 =?us-ascii?Q?1h1vSYkgRfdkF/QVCeRVPSwnZ4tH/YvcbrGmU3sMtQVbiJo/5QA3wxv99VZ7?=
 =?us-ascii?Q?Vg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SM4eHCAVNvBKxmOtrkDPsz/mNdhj6COKAMYtfh9m0yxvz1sbhlD4t+1T08lnq08Zop60i6zsDSvVQlDYNXh7C61UNvf1kuUFJUV/YqybTtHNK4qjuT6VKwU7N9xtsigQsryeP71BydPLKeKyog4QXz+LCZj2RQ8ZP7Waw2c0AWCi1WlZ281XQGt6EeylaXPNlycUsET2wjtimW9OKxaLCZJAby8oLOSg0smGwD/5ZWoIEhvF/kVn7v6fLpRFNbuVAqUCk/LglAM8PXDwB2TonYvCX6a1zFsGrUebpv7kNRFLEfS7/1gZgyh2qUUj02v4MaaYknyJGxDIdrlggpEHg5R0X1Hc+7a4SIIs6MjrpL3tGb/nkA9UvULh26w1Z3YU4TCOXTm2/hvceWmXy7iVsNeXQHwfELIYYUVMCNB5neCDIS4Zk9ABBAhUgpjRQj6e7Epv12wEYOunJTqNBeee7IigqgirfikH/fVvP795nhot6YrqOEOE9rGc42Z4DTd7Spo8UeHTaMpbQ7eeelVwwWNlz/lfW2IxmHAIY7XSzpbLsdKYGZAdH7qm58xuEXw5DQ20qadrMLuCFLKKK30hUN9iLXhk17jwWNGBO8qnzSi75ttN0LEYI7g60ULaUAIb
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR20MB3818.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8652a7-5f9c-4280-47a9-08dc21cb9155
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 19:42:17.9892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k5qPVzHfu4CQOjw27H8s6a0qW2libJx2w9HUi18h2cTE++2JVtf5cctsEgipEKDQShs9EP6dCxqJcVy9jA6fQoF2RrMDCTuFwuWzmDsAX1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB7114

Coverity scan reported CID 1575482: error handling issues; this patch
addresses this by adding error handling to u_boot_env_add_cells.

Signed-off-by: Nick Spooner <nicholas.spooner@seagate.com>
---
v2:
    Fix whitespace issues in previous version

 drivers/nvmem/u-boot-env.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index befbab156cda..c15de5f7fd99 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -95,6 +95,7 @@ static int u_boot_env_add_cells(struct u_boot_env *priv, =
uint8_t *buf,
 	struct device *dev =3D priv->dev;
 	char *data =3D buf + data_offset;
 	char *var, *value, *eq;
+	int rval;

 	for (var =3D data;
 	     var < data + data_len && *var;
@@ -119,7 +120,9 @@ static int u_boot_env_add_cells(struct u_boot_env *priv=
, uint8_t *buf,
 			info.read_post_process =3D u_boot_env_read_post_process_ethaddr;
 		}

-		nvmem_add_one_cell(nvmem, &info);
+		rval =3D nvmem_add_one_cell(nvmem, &info);
+		if (rval)
+			return rval;
 	}

 	return 0;
--
2.34.1

