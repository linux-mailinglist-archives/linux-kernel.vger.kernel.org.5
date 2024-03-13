Return-Path: <linux-kernel+bounces-102459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2FD87B268
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F7B71F26943
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896324CB41;
	Wed, 13 Mar 2024 19:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KpF8+dz9"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23190225AF;
	Wed, 13 Mar 2024 19:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710359939; cv=fail; b=ZTafFQeXz2fdUDiFht25gBLojd1GRqlOZnDZO9TGeECydFJKV1ZhCs8amtgwPWIV6pAH7pRIw/+/VJlbcOMCavv2UwGuTfAKE9XP8XEOUcWngS9wCXqR1rf+JpnahdxHvhuoI7rppNQ0avIMgb68I2nViDotgWmRmllketnbBQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710359939; c=relaxed/simple;
	bh=/M0ApumTfsxEGZqkcVTek5hnDMYUxCrPjzlarY3z0t0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YrEeXzGS+KQ2lqWFlokQuaBtn97+ywkVS3/uPzi1mqU/R9BQnJ6fWvsPp8HRbLWBYm8tG8NarqrQIsDFhaENdBACyf+KP58NJnRs0TeBjqfL0+Sp64I80xNB4H4ADXO0u8M63YCeyS9TdlOHHn1yuFJPaXGn25qD0UYXjnox88k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KpF8+dz9; arc=fail smtp.client-ip=40.107.95.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCiLI4M4u9/aN0yqgnHzSqyu7Y/rxTWg6xtIWEIbQKCKmyqG6vjL9QlyC3xojeXVHoG5q7nsWb302kt5xX3qwRb0gQsiaUC5nXZupMH/DvPjjila2gp+2hCumYrzqtOeX1mf2CEkKvWtr4IWxel/9rzMnp7UW+ta/mIn3iHwfSTnVPGAhYqaP4P8fdDB2PgQGvOQV8NvbQYCIIsiSMO30tQx/tJkaYWA1OFomLb9ltN/jC2bRzhk/UW2V11CvC83Zts2HUlDCV67pdXLaqKjoj9ojf8ReK/8XdXW4rB2u2ZMI+X3SgM+OAZHornNhXmpAVQ5K/Fb3gxrLFkGWdiMjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/M0ApumTfsxEGZqkcVTek5hnDMYUxCrPjzlarY3z0t0=;
 b=dYBGr+QixDjh78ZaWcycSyEdMcRWCnu9SfPfNRtmXW3CoBiBeQc4kmF+Bwzsx9nHA8Z/gd6DLDvn9GCqPj/CJQct9TpRYegek4oJiXTsIQ1zsnSRxt9QcyNdnQhMLdv2fwkvSA4U8ACm7q6Pd8EIPUzGFHhebKxb+2Uf3kYak+v2o6agDo0YpyQnYfh80OWCL8uAxbfGcq83yi/E2CvVBA+U8OWUTIiZYtEkC8+rrQjZud5VJAkriET0bcGMTztfHL9J6ZklmAENn2AvzaP1auN8fyUT1SSLTq9cf2dTgt4F/IBQebt0nLt2Dn/34b9pGBdeG+5FDdNy+s805TfhiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/M0ApumTfsxEGZqkcVTek5hnDMYUxCrPjzlarY3z0t0=;
 b=KpF8+dz9aaUn6GSQ44B3pdau9fbQXsGy/ko4NAc/f+RpmHNEPd2qywPIL6Mm5sdsUh3i9bJOZ5VcJUb13CiSrrLAf7ImdVFl0yAmCqPj58VTbeA12nJxDERVTA8jddWKiH55FXthNv3RZpWE73efSqQUOVqJD2ylj9z823BRB5o=
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Wed, 13 Mar
 2024 19:58:55 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a%4]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 19:58:55 +0000
From: "Bilbao, Carlos" <Carlos.Bilbao@amd.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC: Carlos Bilbao <bilbao@vt.edu>
Subject: [RFC] Notify of second email
Thread-Topic: [RFC] Notify of second email
Thread-Index: Adp1gKVl3EfWYu39R7+WCrP+rwQxjw==
Date: Wed, 13 Mar 2024 19:58:55 +0000
Message-ID:
 <BL1PR12MB58749FF2BFEDB817DE1FE6CBF82A2@BL1PR12MB5874.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c36d28d5-9232-4d82-9297-54da1b93e558;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-13T19:57:02Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5874:EE_|DM6PR12MB4481:EE_
x-ms-office365-filtering-correlation-id: 92b57fa2-60e7-45f3-8c18-08dc439803bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 D1gXUQFOXR4R7DSxuqhsCTTUENCeOg5lTJLgXZ04O6Fj0UKUAq1sm5Ty4aajMDqdPISTVqqc3tlM4gUOr8PpuiKQCFMkbNo+p3ebMRKlgu3xyqjQ3FUDOXEv8HFDcqO/LdGHE0QkbFIRxjX4S0TRR9uIL+Ot5t9lW3+hONPRV7S7bcNpAGNcASemvHVf/TUhkuE36ykNXyV0PlHsAirwnSzgyzvdi+V8agae96VM3fZPmmTdY5XuWdkrasYKJVAxBsOpsGwy+J8aZ+wDB+DFEaMxDtkqUblEMtmHuN23Kzn4KLtgeI/MFRmgRaGMTjww+1NbbHhHgw5AQag1dful9NDKRHOxiLZyvqoC3HmMYkFl03uLn0svOkb1VIe4RGGzV0ckVsuYChWCidbWZ9T2jNnNcXWOZv74nzG5N03EOOg4cSZqWpkIHcfFt81ennFtIsZ3oLkbZZHXaP2Du1DTnWQAVG5KxWG/mcT/4WdtKFGwwqut7EdB7Ian54YI9f2J4LimcSMagU9icE8KWr4//B3hUcuEFXztVUtXVBeOcNxX3pc3YKn8m6LTXx7snzJTejm9W7BVrdwmY5pMY16SXVQQl1ka3pLiG91WLcJ/PKOOKVrFOw7rO09MYJiGCabxTpBKAt4z10eZBvJ4T2K7mHVIQ09m/miCFtfkPlK/Rb4sEOzngwWkrie2TQ6+p1sUnLeQZzY2KHYE0fYGVbKdP4BbE1SidUdJC1qJlR526/8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XdJgI+d3CQBWInioZobSpWd0+WyQJkPZMzKWkrURMyFyYU4FG45vps7e61wU?=
 =?us-ascii?Q?SCsKrCa9UYuIfGgoTnviZJPsTkLmvKB0aoDxfSDCyEN6X3Q0XPT1eHvWZAyH?=
 =?us-ascii?Q?VysEk35Tj9uP74CjI7YkXDU36sTQch3gPZG2DaLW3CYLsl0zoPpstiDSXEaj?=
 =?us-ascii?Q?z43T/MkfgN5v2gu+QnzPr7xRt0+vHhEvYSiuusff3il/mZcxu8dQcWGvVWYd?=
 =?us-ascii?Q?vAF79ZZGA4RWvOZWtm0AY9C05fnPviIGnvai/Ex8Ny6gCa6lx3NXMITpAtdS?=
 =?us-ascii?Q?/0B3HvugahaE8ggcS5VYocxdp72A3DWPZcQzCjye8qYWIwtbk7H6/WJZg+2F?=
 =?us-ascii?Q?pEkNMIayiG5P3FXlxvyoBRrFOmT+IYnNXLiFdqMrhyf6Jfy+tmt6N4YJLk/S?=
 =?us-ascii?Q?+Cr+OqH8yTKqh7GqVk30FEQK5FFGRXrW234QMeF6XDshjjb9+G31ANf8UBf3?=
 =?us-ascii?Q?DoYpfsS+IxhYa9ecJ64VGaK9GblALK6/LOp2cQBQmn9bUCSSiWwKuQo+GshJ?=
 =?us-ascii?Q?FpmfdLFlIe4ZoL7cA0y0RN0s3yKZNyK4oOVgYmdr9PrP4w1AR7CfadH7NeGV?=
 =?us-ascii?Q?IPIPOxR2V2nt4tmqpTT/AjM8PVE4rDKFK7p9YY9+1WlmUO3qWlUsU7cSwEV4?=
 =?us-ascii?Q?7xQGSDmTjE371P5Vu6q1p32hIYsjG4lmrYmWcAldzdRdW5rKf7DPPo2017sR?=
 =?us-ascii?Q?5mSvfPj7HFjcgY4kAwNY05Cnth/XJXdwGLVOy3y9GOZq5EFL/XzPYIZKiiuj?=
 =?us-ascii?Q?9Nin2/2P0TdvM5YRS/nt+TtrqoLYZ9YF5j9OkGE+bblhWe+t4Gv+ltQhwEST?=
 =?us-ascii?Q?v8tXGW4rbmSJEoSD5JpZT+yCzvei2EqtM00nP2krOTggzzPA1GjSQ2jiA3lM?=
 =?us-ascii?Q?73V2LijKWKk5Qg5EcFGqtYmTzJIOlc5JgJzPQ+4OZznHWTiDdhG2ajws6Y9U?=
 =?us-ascii?Q?2DrMbVKEJN0TTSPXUqqHI8t35eBMkxwgNhDuaTYp9igkQ4/Hxhm9gbXOVUzs?=
 =?us-ascii?Q?azJ9Jp8UU79DuULzNyB2UlzobNO31Sy3onp0LsQhuisIbhjPdReA9abo07VJ?=
 =?us-ascii?Q?qNfyCIZmXb2E8tzFmisxEq5po6iaiLHLqL896cxOPPGss9ZCVn9mS1uvC9PZ?=
 =?us-ascii?Q?utID7JFGx5z3vUaxbj1SnhrybFhalROeTUUGmphL2x0BxtL6qxMRk9NTHnc8?=
 =?us-ascii?Q?d0JN7H93Ro/+hn7hIjN7SiYhoc8Z3JYT483mwOtOd/dNvzY7H2KGWx0epc7I?=
 =?us-ascii?Q?tH5GmgGKVExkoAoF7meNtGOSgyJtvxvjI8rdSRGqxMn+gHbpM504/sEjHjsG?=
 =?us-ascii?Q?WnJHDe2zN1tMqU+xu9WyRJAC25kfGBaZt1yW0aCPHZRFnvjd0voHT9wlBxEd?=
 =?us-ascii?Q?LathEaXrF637F9rpYbYcJX3vrz9cnbh29y6HXFkp7tefxcLx7c9o3QtDvYxq?=
 =?us-ascii?Q?t9gk5Zk/P43lGm3HiAGYJBHsLFGtJOBPg5p7g0WJFpK+vZKRoCKk1QsD97/7?=
 =?us-ascii?Q?iRTXX+SiJrL2Ya9NfUr8lhjgBJd/ihY/mJNj1q7vsyq25lUh6awHixbBARxj?=
 =?us-ascii?Q?bsQFkLVZw3elSiQJNI8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b57fa2-60e7-45f3-8c18-08dc439803bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 19:58:55.6435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ooS3ZpLFw/Nu1guCHRTXJk97aoFjSE69H49xB0DRgKnmOLqo1alPGRNFPHzDSdrcb4Kwt+bCHoWcwbT0SlbyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481

[AMD Official Use Only - General]

Hello,

I want to inform you that I now have a second email address:
carlos.bilbao.osdev@gmail.com
This is still me.

Thanks,
Carlos

