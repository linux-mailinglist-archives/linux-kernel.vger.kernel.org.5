Return-Path: <linux-kernel+bounces-101711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DE887AADE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 383A01F22A56
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9827C481C6;
	Wed, 13 Mar 2024 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4BzoVUlZ"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753E0481CD;
	Wed, 13 Mar 2024 16:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710345839; cv=fail; b=AayBZN6ee21nmqfte/Qlo2LxDUChHNAQmflLCmWSCPeicaPO7tIkxz5sdcMgkGUc5vlISABTfL3vHZdVgBHtWryFkAQ5RvT8PKF1sdIR2g370SPl15/Du1/hGxDh4AYIZ+dqvH89z7TsI+USH0/XyOTlgy3rrPbTrh+cw4+T+DU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710345839; c=relaxed/simple;
	bh=g7h4Sf03F9pxrHfAHXEFOnywEsqvTJUUIRCF9FU3s5c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gd2866RvvFYH6m26gggZtefQZ1tJtNTeeOOe6dLOxHlvG40ncY7asEb7XgirAn2rl1fbQFN9mxbCOzWXySI7v4SqXG7kZzi/MULDU+hwd/CgQOW4pPRgdVnSWvU4JLTnk19v9qd1+9j+9vmP/ciEKpybSNrh7Gd+YJo9c6oo5VU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4BzoVUlZ; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+Nzi/jX/O8mhl9GBZ2WY+kHWEiauUxJsqrwjO6A0/Pt5cR6WPUvCnhEAxWEB6FXub7EEHxhgcGKYl6zawF1HtqYi4qTqB34V30hUutiEy2BTT68uA0Q6uIs0DPLiq3j2+jMf3QYgh9rOM8ElCBxb19Y2P9nm7DYKYr4ASl4rIo1fWz3PNfP5p+APqJJHtjxatqFV4EsBXvks1ByOHrvu2zUJoBBLrblwacEepLrSzpGYTr1951raw3B1IdaxjLIhNvpsGAWQvaCRhAnH/gG+XmPtSWug/3Jyd4j2WoOwTKGprBFdp3HFXErNwou+JVp//+PjzeLMbTsqMzPFDIwsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7h4Sf03F9pxrHfAHXEFOnywEsqvTJUUIRCF9FU3s5c=;
 b=NOWBKUx/QMiP+PeCNQSDlnluMh5Kmmmq+kYnHrHRunGCum99W1atubcJQW11l1ycQkRecCNYyA1e3QHo3LZFWeGqokx9GNPPTX66Jfy41rYCsJIV8/kLj8T2ueNAtZDTHvaf4MdJeqaP4xLap0GLrS/QX5hniCtefJlMVpihVhGewIzdmgMIwRkCrOuKxcAxfxFn8Ag+XUF01vGsiwEZGvSmLgpUFAFGBf34kgkXQnJ7I2kEBNT8clTdD7Hza7xaA/240IfAba2M18uWLJa0iDNcMyxsdekc0KW4yqurHKYwt1lQ1ZsKNAFxlVqjbznUSrzROw2Ss/1zwse6frp12Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7h4Sf03F9pxrHfAHXEFOnywEsqvTJUUIRCF9FU3s5c=;
 b=4BzoVUlZ0ZAYw2tKzQJQ7PLZqh64B3GzC+qxUYf79DkYDMozgCLlUEI9s3D7SWjxGeWsN3vGlrIMcdHMJUzch3raSXi0OYlxs4AYSUcqf2Xa0aWZfa/6LuLXA1/9jANdC0/9Zy1siS1qlTsvpxNDkzvunvz8JfTfefWcqmSY9rc=
Received: from BN7PR12MB2802.namprd12.prod.outlook.com (2603:10b6:408:25::33)
 by IA0PR12MB7578.namprd12.prod.outlook.com (2603:10b6:208:43d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 13 Mar
 2024 16:03:45 +0000
Received: from BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::2318:9906:4dae:a041]) by BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::2318:9906:4dae:a041%5]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 16:03:45 +0000
From: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, "broonie@kernel.org"
	<broonie@kernel.org>, "pratyush@kernel.org" <pratyush@kernel.org>,
	"miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>, "richard@nod.at"
	<richard@nod.at>, "vigneshr@ti.com" <vigneshr@ti.com>,
	"sbinding@opensource.cirrus.com" <sbinding@opensource.cirrus.com>,
	"lee@kernel.org" <lee@kernel.org>, "james.schulman@cirrus.com"
	<james.schulman@cirrus.com>, "david.rhodes@cirrus.com"
	<david.rhodes@cirrus.com>, "rf@opensource.cirrus.com"
	<rf@opensource.cirrus.com>, "perex@perex.cz" <perex@perex.cz>,
	"tiwai@suse.com" <tiwai@suse.com>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"michael@walle.cc" <michael@walle.cc>, "linux-mtd@lists.infradead.org"
	<linux-mtd@lists.infradead.org>, "nicolas.ferre@microchip.com"
	<nicolas.ferre@microchip.com>, "alexandre.belloni@bootlin.com"
	<alexandre.belloni@bootlin.com>, "claudiu.beznea@tuxon.dev"
	<claudiu.beznea@tuxon.dev>, "Simek, Michal" <michal.simek@amd.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>, "patches@opensource.cirrus.com"
	<patches@opensource.cirrus.com>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>,
	"amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>, Conor Dooley
	<conor.dooley@microchip.com>, "beanhuo@micron.com" <beanhuo@micron.com>
Subject: RE: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
Thread-Topic: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
Thread-Index:
 AQHaH4D9pFM5xtDoeEuMNIpXuxvtzbCcYmwAgAEJ+aCABhoaAIAAMcLwgAAzdICAADdZAIABtmWAgAQ4ECCAAAuVAIAAD5dQgAAYdQCAAAF/8IAGJHEAgAFe7KCAUIcDAIAAVewAgDPXogA=
Date: Wed, 13 Mar 2024 16:03:45 +0000
Message-ID:
 <BN7PR12MB28028B63E69134094D50F3E4DC2A2@BN7PR12MB2802.namprd12.prod.outlook.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <BN7PR12MB2802BEDFB821A1748185794CDC8AA@BN7PR12MB2802.namprd12.prod.outlook.com>
 <f5a47024-514a-4846-bc16-08cf0f9af912@linaro.org>
 <BN7PR12MB2802BB3DA682D9C13EF7DE08DC8FA@BN7PR12MB2802.namprd12.prod.outlook.com>
 <5a6f6764-6779-42b0-b6c6-3f638b85ef78@linaro.org>
 <BN7PR12MB28029EB1A7D09882878499A2DC8FA@BN7PR12MB2802.namprd12.prod.outlook.com>
 <c3fa1e04-92ed-48ab-a509-98e43abd5cd6@linaro.org>
 <BN7PR12MB2802E87F1A6CD22D904CAEACDC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
 <b3d3c457-a43b-478a-85b3-52558227d139@linaro.org>
 <BN7PR12MB28027E62D66460A374E3CFEADC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
 <e212f9fa-83c5-4b9e-8636-c8c6183096ab@linaro.org>
 <BN7PR12MB280237CDD7BB148479932874DC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
 <576d56ed-d24b-40f9-9ae4-a02c50eea2ab@linaro.org>
 <BN7PR12MB2802F288C6A6B1580CF07959DC95A@BN7PR12MB2802.namprd12.prod.outlook.com>
 <c6f209c8-47da-4881-921d-683464b9ddd5@linaro.org>
 <9cdb7f8b-e64f-46f6-94cb-194a25a42ccd@linaro.org>
In-Reply-To: <9cdb7f8b-e64f-46f6-94cb-194a25a42ccd@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR12MB2802:EE_|IA0PR12MB7578:EE_
x-ms-office365-filtering-correlation-id: 324089d3-1849-489b-6914-08dc4377295b
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7kgfpfpPGX8+teMBan5OZWU4rZNA6NbUjTHkofexVZdSFgf7ird3JKGt2Gsf5XnmJr16Z/Q1wiHjv48G/PTlUJ1Q+ELVQ6z4AjfANMkwEo04bQV9rPclDOmecu05uIa5dp6XkDwuUGzDd8XT5yCL5QD+zPYXjSMaxpjm1+Ra1+6+Eceewy3tetVCW9TRNiJbKVxuLouMNu6Gf1sP3lb7SlxaMcLGtF1C+4WoeRjHk02Dhhe74YflUlav1OvVEZDnwaP+47OQonMhMmunikGVAYUlK56dsVXyaMt4A0oNTEHT5w8AXUwQYLIZ/lN+Q2Od4EkUXhyimxhH78UPwcvqS9SWiNR8eOG8J7B/YoDvabdX6Js/1G6AALx3hVkmUw1lvqPqBeDLGP7LQ8Feiq4qVWnjFNFgLSWVzYS9bvqIVXqMgeN26Pi7wlv0Rm1V/IE23TYfWYf+RFxp6y5egq1J0nmnopJpYf264ydGH5chHm1feJn8kaWqoYoDacNxfpnTznX0zW47sVF0r/6PkpmDzrIKct5Z0FFOr0JdPMCtsJXVzoyJ1AMKOfn+Mn7o7L1Ne9sCYixyVd8FBcKyDBICQTCHepRdkvqmtqn5jE8pECcPRojcheTPk64QQqeboBa2bZi9SuCTR+VmaNj08l82NMTwI7ZWNL/Hp8uOwvncv3QCLzbAnlKlqkXnynDNWhWO
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR12MB2802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WHd2ZEFvMDdXcmFWSVJKbGpRWFZySFZNM1d1T1pBVENOYVFoUGl3d1dFd2xw?=
 =?utf-8?B?dDJEZG4zQUZVZk9STGFsWm5VamlSV0ZJU1hGZE5XTm83TEw5M2FHaUdFbkw4?=
 =?utf-8?B?emlyRytIUCtENnlZdzBESGxtbG12ZE1nd0Y2S2N3NXdNemdRRDFtNXBDZ2xI?=
 =?utf-8?B?cHh3aHVmamd3R2twdEpGQXRyMk5iMURUekNEMFJLSUMxek0xMGY3OENDMHhn?=
 =?utf-8?B?b0hScG5XQ09oMXVvZXpmd1JwdUt0Qnc5eE1nSXZuSmdLMkZZc3pJT1NxQ3Jv?=
 =?utf-8?B?Y2J6b2dLQkhxVFc5ckwvUTU5K2JzVkVteXMrVTczMmtMY0JxdWVUZ3YrMkhE?=
 =?utf-8?B?UTIwOE53N0J1enZXdFZBS0p6YnJINWRCMXdBQWwyZmJ4dVJzWWZLVjBUZnNw?=
 =?utf-8?B?TlVYendsdG83eHRXTUFvWHFBN29SOGxZQllqS1N3WjR6R3BqTkZVYzZlcVFk?=
 =?utf-8?B?bXFoT3ZSNzJXcVoyNno3czc3VXFlamJta2syYXppV0pFQnFpZXZSWFZpWHA4?=
 =?utf-8?B?RG50cTFWb2dwbGFyanJPRk8xRTk5MzdkWkNETjNjaS9iTzlKOUFiaXdWZW5S?=
 =?utf-8?B?dVF2bU55bFRQNFJjWGJNdEJUTzRuYitzMGkwaDhzMFFqRXo0Y05LZmJEUW5p?=
 =?utf-8?B?NTRvWTA1Q1FIYlYraEdCendqZjAxYS94cldwTmMvY1BBTTQ4UDY3SEloM1I3?=
 =?utf-8?B?NjJZbk9qb01UTnk5ZUZ1REJuZGR0dXdQLzR0Ti84VTJURmVFZHBjZ0lXOUZl?=
 =?utf-8?B?QVJzVDduUWZOQW9yY3NyU1hUVUw3THJjUWhZa29JYkdHYnlxc1g2TGVUc3R2?=
 =?utf-8?B?cmRvNlM0Sm9OTUtKUEo5MUdqbkJIa1FHM0dhbXd5UThrOGpBd3ovQStwMHRp?=
 =?utf-8?B?N1dLc05NdUovamoxQTFBcDl1ZzRiblJUbkl5dElwMitoVy93OWd4VThTQklF?=
 =?utf-8?B?V0VjcWFITzRiZm9NZERlbk5Hb1lTNWg5YVVQejV0VU1OQUo2aEc1cTYyT0Rp?=
 =?utf-8?B?ZGRjVkhwK3d3bnJweWt6bCt5OFJqY2JBWW5PQmZkN25YTG5CODdOdXljVndq?=
 =?utf-8?B?eVpGRlRkYStOS0JKaXlkM3NuS0N5TWVNSHFxYXBLbWpqZHdaTmRXY2dhZERQ?=
 =?utf-8?B?NjFlcEZBVHZ2ekdNMEFra1JoTmtZOU9UUEU3ejFKYUJTa2NxNTEvSkJrbDlG?=
 =?utf-8?B?OWtscXJEbkNaUTZWb2dudHRMenEvTER6QzV3Z2FiQWlIL1kvajlrUXp3V1l2?=
 =?utf-8?B?Njd5aFZzZjRqQmY3cW54eVZkMWk5VzJ3d045bVltRWh2TGFkOE5GZzhwOXVw?=
 =?utf-8?B?N2dod0RSTlhvNUVLbU1YcW1jbERxcUhqdlFxdXFJdjY4L0Q0Y3lkb0Y1Rm9y?=
 =?utf-8?B?SGtNVU1kRFRUUU5JbHdRRVdWTWJPeWpWbTZDNHlWaTVNVkZKdXlUajNkWTlM?=
 =?utf-8?B?ZWpXK2hhTzR3bmI2alRSeDZKZ2szRnYrcjNKMTdkMUw5Uzg4TnhVUnc2WFZZ?=
 =?utf-8?B?QmVsNG9iNlNmb2JLa2FLUFNkOFlOMnYvaW9lWXJMWWx6NkdpVmdJdzZ3R1Q1?=
 =?utf-8?B?cGg1REllNGdNcUVLYkRNcDJ5U1NqcXhIOEdnbUhvVEVMQzFkOVEzT1U4U2NB?=
 =?utf-8?B?dmxVWFMrWjFBMko5em1qM0NNc0E4M01YSlYwYjdKaDlNdVpLRE1FL0VWbHRB?=
 =?utf-8?B?cDA4MzRDUm1QaU51WG9RVnFFeXYvTU9uUE5PZmtmSEhSQm9ZdTg5S3Z5c1o5?=
 =?utf-8?B?eCtKWjV0SnUrK3J1bC9xZGtnS3VZY3YvaXdiNUoyT0tJZHZzSjlESGhpYnhN?=
 =?utf-8?B?a0ZkRzZLYklmdDdjZUt0MnlYNWVpVjFSTFB4QnV0WTB3bHBwRkpTeVpQb01C?=
 =?utf-8?B?V3B2aXBZejczSW04ZkJSSXpDa05uY05hcUU2QlQ1N3V1d3Bhb05FYnk2Y3hI?=
 =?utf-8?B?aW5KYndSYStnVDV6dEhWbk5ldW5vbW0rVG5YNlVGdjg4UXpXZmFDcGViaDJ0?=
 =?utf-8?B?aFZqN3RLQjNYZHF1TUI3MkdLMEZ3RnM4ZTZ6SmFqVEE1UzN1OCtHNkY2NDlx?=
 =?utf-8?B?ZWsrRCthanJlWVRyMHlMb3BqZzUybEROS0ZBaitsVFZNWEc5WUlNb2orNXFk?=
 =?utf-8?Q?6Xk4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 324089d3-1849-489b-6914-08dc4377295b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 16:03:45.3275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zppKlKiangAWEAH7rXb61+8zfeXCfsI/r1Tx94uItUXBiyEioRtYMZQA3jvn8OHKMjw34jdUUXqOzt/pXVhtGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7578

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVHVkb3IgQW1iYXJ1cyA8
dHVkb3IuYW1iYXJ1c0BsaW5hcm8ub3JnPg0KPiBTZW50OiBGcmlkYXksIEZlYnJ1YXJ5IDksIDIw
MjQgOTo0NCBQTQ0KPiBUbzogTWFoYXBhdHJhLCBBbWl0IEt1bWFyIDxhbWl0Lmt1bWFyLW1haGFw
YXRyYUBhbWQuY29tPjsNCj4gYnJvb25pZUBrZXJuZWwub3JnOyBwcmF0eXVzaEBrZXJuZWwub3Jn
OyBtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tOw0KPiByaWNoYXJkQG5vZC5hdDsgdmlnbmVzaHJA
dGkuY29tOyBzYmluZGluZ0BvcGVuc291cmNlLmNpcnJ1cy5jb207DQo+IGxlZUBrZXJuZWwub3Jn
OyBqYW1lcy5zY2h1bG1hbkBjaXJydXMuY29tOyBkYXZpZC5yaG9kZXNAY2lycnVzLmNvbTsNCj4g
cmZAb3BlbnNvdXJjZS5jaXJydXMuY29tOyBwZXJleEBwZXJleC5jejsgdGl3YWlAc3VzZS5jb20N
Cj4gQ2M6IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7DQo+IG1pY2hhZWxAd2FsbGUuY2M7IGxpbnV4LW10ZEBsaXN0cy5pbmZyYWRlYWQub3Jn
Ow0KPiBuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb207IGFsZXhhbmRyZS5iZWxsb25pQGJvb3Rs
aW4uY29tOw0KPiBjbGF1ZGl1LmJlem5lYUB0dXhvbi5kZXY7IFNpbWVrLCBNaWNoYWwgPG1pY2hh
bC5zaW1la0BhbWQuY29tPjsgbGludXgtDQo+IGFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsgYWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnOw0KPiBwYXRjaGVzQG9wZW5zb3VyY2UuY2ly
cnVzLmNvbTsgbGludXgtc291bmRAdmdlci5rZXJuZWwub3JnOyBnaXQgKEFNRC0NCj4gWGlsaW54
KSA8Z2l0QGFtZC5jb20+OyBhbWl0cmtjaWFuMjAwMkBnbWFpbC5jb207IENvbm9yIERvb2xleQ0K
PiA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+OyBiZWFuaHVvQG1pY3Jvbi5jb20NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MTEgMDcvMTBdIG10ZDogc3BpLW5vcjogQWRkIHN0YWNrZWQgbWVt
b3JpZXMgc3VwcG9ydA0KPiBpbiBzcGktbm9yDQo+IA0KPiANCj4gDQo+IE9uIDIvOS8yNCAxMTow
NiwgVHVkb3IgQW1iYXJ1cyB3cm90ZToNCj4gPg0KPiA+DQo+ID4gT24gMTIvMjEvMjMgMDY6NTQs
IE1haGFwYXRyYSwgQW1pdCBLdW1hciB3cm90ZToNCj4gPj4+IFNvbWV0aGluZyBlbHNlIHRvIGNv
bnNpZGVyOiBJIHNlZSB0aGF0IE1pY3JvbiBoYXMgYSB0d2luIHF1YWQgbW9kZToNCj4gPj4+IGh0
dHBzOi8vbWVkaWEtd3d3Lm1pY3Jvbi5jb20vLQ0KPiA+Pj4gL21lZGlhL2NsaWVudC9nbG9iYWwv
ZG9jdW1lbnRzL3Byb2R1Y3RzL2RhdGEtc2hlZXQvbm9yLWZsYXNoL3NlcmlhbC0NCj4gPj4+IG5v
ci9tdDI1dC9nZW5lcmF0aW9uLQ0KPiA+Pj4NCj4gYi9tdDI1dF9xbGpzX2xfNTEyX3hiYV8wLnBk
Zj9yZXY9ZGU3MGI3NzBjNWRjNGRhOGI4ZWFkMDZiNTdjMDM1MDANCj4gPj4+DQo+ID4+PiBUaGUg
bWljcm9uJ3MgIlNlcGFyYXRlIENoaXAtU2VsZWN0IGFuZCBDbG9jayBTaWduYWxzIiByZXNlbWJs
ZXMgdGhlDQo+ID4+PiBBTUQncyBkdWFsIHBhcmFsbGVsIDgtYml0Lg0KPiA+PiBZZXMsIEkgYWdy
ZWUuDQo+ID4+DQo+ID4+PiBNaWNyb24ncyAiU2hhcmVkIENoaXAtU2VsZWN0IGFuZCBDbG9jayBT
aWduYWxzIiBkaWZmZXJzIGZyb20gdGhlDQo+ID4+PiBBTUQncyBzdGFja2VkIG1vZGUsIGFzIE1p
Y3JvbiB1c2VzIERRWzM6MF0gYW5kIERRWzc6NF0sIHdoZXJlYXMgQU1EDQo+ID4+PiBjb25zaWRl
cnMgYm90aCBhcyBEUVszOjBdLg0KPiA+PiBZZXMsIGNvcnJlY3QuDQo+ID4NCj4gPiBBbWl0LCBw
bGVhc2UgaGVscCBtZSB0byBhc3Nlc3MgdGhpcy4gSSBhc3N1bWUgTWljcm9uIGFuZCBNaWNyb2No
aXAgaXMNCj4gPiB1c2luZyB0aGUgc2FtZSBjb25jZXB0cyBhcyBBTUQgdXNlcyBmb3IgdGhlICJE
dWFsIFBhcmFsbGVsIDgtYml0IElPDQo+ID4gbW9kZSIsIGJ1dCB0aGV5IGNhbGwgaXQgIlR3aW4g
UXVhZCBNb2RlIi4NCj4gPg0KPiA+IEkgd2FzIHdyb25nLCB0aGUgQU1EIGRhdGFzaGVldCBbMV0g
d2FzIG1pc2xlYWRpbmcgWzJdLCBpdCBkZXNjcmliZWQNCj4gPiB0aGUgSU9zIGZvciBib3RoIGZs
YXNoZXMgYXMgSU9bMzowXSwgYnV0IGxhdGVyIG9uIGluIHRoZSAiVGFibGUgUVNQSQ0KPiA+IElu
dGVyZmFjZSBTaWduYWxzIiB0aGUgc2Vjb25kIGZsYXNoIGlzIGRlc2NyaWJlZCB3aXRoIElPWzc6
NF0uDQo+ID4NCj4gPiBUaGUgQU1EJ3MgOC1iaXQgRHVhbCBGbGFzaCBQYXJhbGxlbCBJbnRlcmZh
Y2UgaXMgdXNpbmcgZGVkaWNhdGVkIENTIw0KPiA+IGFuZCBDTEsjIGxpbmVzIGZvciBlYWNoIGZs
YXNoLiBBcyBNaWNyb24gZG9lcywgaXNuJ3QgaXQ/DQo+ID4NCj4gPiBNaWNyb24gc2F5cyBbM10g
dGhhdDoNCj4gPiAiVGhlIGRldmljZSBjb250YWlucyB0d28gcXVhZCBJL08gZGllLCBlYWNoIGFi
bGUgdG8gb3BlcmF0ZQ0KPiA+IGluZGVwZW5kZW50bHkgZm9yIGEgdG90YWwgb2YgZWlnaHQgSS9P
cy4gVGhlIG1lbW9yeSBtYXAgYXBwbGllcyB0bw0KPiA+IGVhY2ggZGllLiBFYWNoIGRpZSBoYXMg
aW50ZXJuYWwgcmVnaXN0ZXJzIGZvciBzdGF0dXMsIGNvbmZpZ3VyYXRpb24sDQo+ID4gYW5kIGRl
dmljZSBwcm90ZWN0aW9uIHRoYXQgY2FuIGJlIHNldCBhbmQgcmVhZCBpbmRlcGVuZGVudGx5IGZy
b20gb25lDQo+IG90aGVyLg0KPiA+IE1pY3JvbiByZWNvbW1lbmRzIHRoYXQgaW50ZXJuYWwgY29u
ZmlndXJhdGlvbiBzZXR0aW5ncyBmb3IgdGhlIHR3byBkaWUNCj4gPiBiZSBzZXQgaWRlbnRpY2Fs
bHkuIg0KPiANCg0KSGVsbG8gVHVkb3IsDQoNCj4gQW1pdCwNCj4gDQo+IEkgZm9yZ290IHRvIHNh
eSBteSBmaXJzdCBjb25jbHVzaW9uIGFib3V0IHRoZSBxdW90ZSBmcm9tIGFib3ZlLiBFdmVuIGlm
IHRoZQ0KPiBkaWVzIGFyZSBpbiB0aGUgc2FtZSBwaHlzaWNhbCBwYWNrYWdlLCBtaWNyb24gYXNr
cyB1c2VycyB0byBjb25maWd1cmUgZWFjaCBkaWUNCj4gYXMgaXQgaXMgYSBzZWxmLXN0YW5kaW5n
IGVudGl0eSwgSU9XIHRvIGNvbmZpZ3VyZSBlYWNoIGRpZSBhcyBpdCBpcyBhIGZsYXNoIG9uIGl0
cw0KPiBvd24uIFRvIG1lIGl0IGxvb2tzIGxpa2UgMiBjb25jYXRlbmF0ZWQgZmxhc2hlcyBhdCBm
aXJzdCBsb29rLiBUaHVzIGlkZW50aWNhbCB0bw0KPiBob3cgQU1EIGNvbnRyb2xsZXIgd29ya3Mu
DQo+IFBsZWFzZSBjbGFyaWZ5IHRoaXMuDQoNClRoYXTigJlzIGNvcnJlY3QsIHRoZSBNaWNyb24g
Zmxhc2ggdGhhdCB5b3UgcmVmZXJyZWQgY2FuIGNvbW11bmljYXRlIHdpdGggDQp0aGUgQU1EIFFT
UEkgY29udHJvbGxlciBpbiBib3RoIHBhcmFsbGVsIGFuZCBzdGFja2VkIG1vZGUuDQo+IA0KPiA+
DQo+ID4gaXQgYWxzbyBzYXlzIHRoYXQ6DQo+ID4gIldoZW4gdXNpbmcgcXVhZCBjb21tYW5kcyBp
biBYSU8tU1BJIG9yIHdoZW4gdXNpbmcgUUlPLVNQSSwNCj4gPiBEUVszOjBdL0RRWzc6NF0gYXJl
IEkvTy4iDQo+IA0KPiBhbmQgdGhpcyB3b3VsZCBiZSBhIHBhcmFsbGVsIGNvbmNhdGVuYXRpb24g
b2YgdHdvIGZsYXNoZXMuDQoNClRoYXQncyBjb3JyZWN0Lg0KDQpSZWdhcmRzLA0KQW1pdA0KPiAN
Cj4gVGhlbiBpdCB3b3VsZCBiZSBnb29kIGlmIHlvdSBsZXQgdXMgbm93IHRoZSBzaW1pbGFyaXRp
ZXMgYW5kIGRpZmZlcmVuY2VzDQo+IGJldHdlZW4gaG93IGFtZCBhbmQgbWNocCBjb250cm9sbGVy
IHdvcmssIEkgc2NyYXdsZWQgZmV3IGlkZWFzIGJlbG93Lg0KPiANCj4gdGhhbmtzLA0KPiB0YQ0K
PiA+DQo+ID4gU28gSSBndWVzcyB0aGUgdXBwZXIgbGF5ZXJzIGp1c3QgYXNrIGZvciBhIGNodW5r
IG9mIG1lbW9yeSB0byBiZQ0KPiA+IHdyaXR0ZW4gYW5kIHRoZSBjb250cm9sbGVyIGhhbmRsZXMg
dGhlIGNzIyBsaW5lcyBhdXRvbWF0aWNhbGx5LiBIb3cgaXMNCj4gPiB0aGUgQU1EIGNvbnRyb2xs
ZXIgd29ya2luZywgZG8geW91IGhhdmUgdG8gZHJpdmUgdGhlIGNzIyBsaW5lcw0KPiA+IG1hbnVh
bGx5LCBvciB5b3UganVzdCBzZXQgdGhlIHBhcmFsbGVsIG1vZGUgYW5kIHRoZSBjb250cm9sbGVy
IHRha2VzIGNhcmUgb2YNCj4gZXZlcnl0aGluZz8NCj4gPg0KPiA+IEkgYXNzdW1lIHRoaXMgaXMg
aG93IG1jaHAgaXMgaGFuZGxpbmcgdGhpbmdzLCB0aGV5IHNlZW0gdG8ganVzdCBzZXQgYQ0KPiA+
IGJpdCB0aGUgcHJvdG9jb2wgaW50byB0aGUgUVNQSV9JRlIuUFJPVFRZUCByZWdpc3RlciBmaWVs
ZCBhbmQgdGhhdCdzDQo+ID4gYWxsIFs0XS4gVGhleSBldmVuIHNlZW0gdG8gd3JpdGUgdGhlIHJl
Z2lzdGVycyBvZiBib3RoIGZsYXNoZXMgYXQgdGhlIHNhbWUNCj4gdGltZS4NCj4gPg0KPiA+IElu
IHdoYXQgcmVnYXJkcyB0aGUgQU1EJ3MgImR1YWwgc3RhY2sgaW50ZXJmYWNlIiwgQU1EIGlzIHNo
YXJpbmcgdGhlDQo+ID4gY2xvY2sgYW5kIElPIGxpbmVzIGFuZCB1c2VzIGRlZGljYXRlZCBDUyMg
bGluZXMgZm9yIHRoZSBmbGFzaGVzLA0KPiA+IHdoZXJlYXMgTWljcm9uIHNoYXJlcyB0aGUgQ1Mj
IGFuZCBDTEsjIGxpbmVzIHdpdGggZGlmZmVyZW50IElPIGxpbmVzLg0KPiA+DQo+ID4gQW1pdCwg
cGxlYXNlIHN0dWR5IHRoZSBhcmNoaXRlY3R1cmVzIHVzZWQgYnkgbWNocCwgbWljcm9uIGFuZCBh
bWQgYW5kDQo+ID4gbGV0IHVzIGtub3cgaWYgdGhleSBhcmUgdGhlIHNhbWUgb3IgdGhleSBkaWZm
ZXIsIGFuZCBpZiB0aGV5IGRpZmZlcg0KPiA+IHdoYXQgYXJlIHRoZSBkaWZmZXJlbmNlcy4NCj4g
Pg0KPiA+IEkgYWRkZWQgQ29ub3IgZnJvbSBtY2hwIGluIGNjLCBJIHNlZSBOaWNvbGFzIGlzIGFs
cmVhZHkgdGhlcmUsIGFuZA0KPiA+IEJlYW4gZnJvbSBtaWNyb24uDQo+ID4NCj4gPiBUaGFua3Ms
DQo+ID4gdGENCj4gPg0KPiA+IFsxXQ0KPiA+IGh0dHBzOi8vZG9jcy54aWxpbnguY29tL3IvZW4t
VVMvYW0wMTEtdmVyc2FsLWFjYXAtdHJtL1FTUEktRmxhc2gtSW50ZXINCj4gPiBmYWNlLVNpZ25h
bHMNCj4gPiBbMl0NCj4gPg0KPiBodHRwczovL2RvY3MueGlsaW54LmNvbS92aWV3ZXIvYXR0YWNo
bWVudC9kd21qaERKR0lDZEpxRDRzd3lWemNRL2ZEOG52DQo+ID4gNHJ5Nzh4TTBfRUY1a3Y0bUEN
Cj4gPiBbM10NCj4gPiBodHRwczovL21lZGlhLXd3dy5taWNyb24uY29tLy0NCj4gL21lZGlhL2Ns
aWVudC9nbG9iYWwvZG9jdW1lbnRzL3Byb2R1Y3RzLw0KPiA+IGRhdGEtc2hlZXQvbm9yLWZsYXNo
L3NlcmlhbC1ub3IvbXQyNXQvZ2VuZXJhdGlvbi1iL210MjV0X3FsanNfbF81MTJfeGINCj4gPiBh
XzAucGRmP3Jldj1kZTcwYjc3MGM1ZGM0ZGE4YjhlYWQwNmI1N2MwMzUwMA0KPiA+IFs0XQ0KPiA+
DQo+IGh0dHBzOi8vd3cxLm1pY3JvY2hpcC5jb20vZG93bmxvYWRzL2FlbURvY3VtZW50cy9kb2N1
bWVudHMvTVBVMzIvDQo+IFByb2R1DQo+ID4gY3REb2N1bWVudHMvRGF0YVNoZWV0cy9TQU1BN0c1
LVNlcmllcy1EYXRhLVNoZWV0LURTNjAwMDE3NjUucGRmDQo=

