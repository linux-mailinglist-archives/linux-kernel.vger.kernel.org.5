Return-Path: <linux-kernel+bounces-16416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC39823E28
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2A741C2123D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3B01EA95;
	Thu,  4 Jan 2024 09:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v2kO3i9o"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CF01F5E7;
	Thu,  4 Jan 2024 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHROEj2ZEDJfS2hLF03My3BsiLMookI4LkB6UFa72CRKnSo+tLzD4G0r3NOfLwIN9dL7tRD63RURYs0jNWpd3wbWd26xQ9EIG2wzivvgjWm6nSaJMDZrf2hZFE+PqpYuixR0SxgPQj3Dx9wEBgpvXEA86wmYiCf6hRoehP3AdupV7J7frWlLKpuAxbPtX9O8QWIYOyQjRJI7OHOBSusdOhe+YCLRc1bKI7WMHzh8LJpZzPqvZDPBfGAAoEuU58cOZOgBWCtcXhd4b3iJhZgU5icKXNYm05B+IQNhajwcCW/UDc0yrwIteMq4GkQn4vbv1nUYDocDPtojLG+d8S4FOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8AOox6v1bPVQNhALIcN0F7nV/VQVRSvHt9Qx6yyRSQ=;
 b=GcqpSHfkk3eyxuOvdM4j6CoCEzVSf03Wqau2uhsy3U5tJqD1iba4rGI/Rqz6eUwqBIgMQSIy4Y5JPqtgYEisCyqYBkk5u1nq7Mf4VsUb9roqQ35NHVz16xd6IxGLpivFD+pRgEZDtrsTsfmmT7RjyVPY7A7p/dEITrA3yM5W/5OT5LQyawNMUIg1sfuZGpvl7WnAI81BWeDJrtLcj4u9bbV7H8qaqgR8Q8gV4GPUQY4wrs+FqgqcWpeBNaGen3OIWuSbf23G1VgYHhNam4suJ6pA0xmcicy0GtR45ro/bHSGdziD0TWEL3AS/MOXP+GRmMv9VqAEGgKPryx7ElMXFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8AOox6v1bPVQNhALIcN0F7nV/VQVRSvHt9Qx6yyRSQ=;
 b=v2kO3i9oJCuG0eKyqiR/aDPka9NyDBtkuALCf14I10byWWiXorCAdok12n7zHArnSw7D6C4TBsQd4kzOUoM7LOtnnR4WEnTsS3zxdeIG4CTtE5BHyUvk2OhRVxonxms4ByyhAfiKmn0cB7Sm0obE7Q1MTCJ5Z8GXzO8qgRO/nxA=
Received: from DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) by
 CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.14; Thu, 4 Jan 2024 09:06:35 +0000
Received: from DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::a8c9:b59c:30d6:b411]) by DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::a8c9:b59c:30d6:b411%4]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 09:06:34 +0000
From: "Gangurde, Abhijit" <abhijit.gangurde@amd.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "Gupta, Nipun" <Nipun.Gupta@amd.com>, "Agarwal, Nikhil"
	<nikhil.agarwal@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] cdx: call of_node_put() on error path
Thread-Topic: [PATCH v2 1/2] cdx: call of_node_put() on error path
Thread-Index: AQHaPX0ODnYFq2UpVU+x50nruOIjCLDJXo1Q
Date: Thu, 4 Jan 2024 09:06:34 +0000
Message-ID:
 <DM4PR12MB7765E1280F2070228FE9D8BA8F67A@DM4PR12MB7765.namprd12.prod.outlook.com>
References: <2e66efc4-a13a-4774-8c9d-763455fe4834@moroto.mountain>
In-Reply-To: <2e66efc4-a13a-4774-8c9d-763455fe4834@moroto.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3c007e91-6531-45bb-85d7-59f512589895;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-04T09:02:37Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB7765:EE_|CH3PR12MB9079:EE_
x-ms-office365-filtering-correlation-id: e44e1ef2-0052-4c9b-bde9-08dc0d04735e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 x7lxNwDgTqoJYyIA4gaklTd9FCVJHTfNChTNd+Wwz5+uvcQKZRVKiDNiHPQFMKupwRt7aBsq8eWthApy8z2ERGTtXFvqBOEZoyaPYozigdP/CF/05ioO6h/lCP3QTxumznVNPKZMm4l260APbHZB6ZewaSwqlHMnOqR7ZT18wg9bqWyXCMu3EYkzlyKKhrlt+t9tos1Qbbf7Ua+YIWiHB67gDXt3gOiD6lvIzMhKSxrVwULIobUjG+ynk4uKbNmpcsE3XTUzJAX+t2uu1wpuEqA1IyPODUVj2mbexpSyulqMydGRzB9hEizehp/ZvUgTyWskcTLwrSNuOAJLC88rt5uYPmUF0a4q1GbfGARzdNLAb5yrH3qv8DogFmoUYtLO2BgYmUc2dzlutdv65R0AyCkj+yuzwp1zeQclogYEe94qSMnvbao+3+/mKv+2AzWoi1WNUGELmvlEx2x8DYmsp+WuTbbWFDmw7xqQ7u0OQvRsFtiM/HdWUi08UBjmHlthARNtQv9iLt9w4wVsi5trfi11jB1bpLoJ1DPUbNKAZ02LVh95NrywZPGQplBJ64pQddgUvrOK1uV9HNBLO7NEg4s96aTdssBWZgE/SEDDcQmrocM8QrhtzyDTt3d0B9rA
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7765.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39860400002)(376002)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(5660300002)(4744005)(2906002)(4326008)(316002)(8676002)(8936002)(52536014)(9686003)(64756008)(66556008)(66476007)(55016003)(6916009)(76116006)(54906003)(66946007)(83380400001)(41300700001)(38100700002)(66446008)(122000001)(86362001)(33656002)(6506007)(7696005)(478600001)(71200400001)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?268HS4VV9pMNAiTfw6FGMArOMbNEP3ZcBl5vQA4UgPuZDFKkwjQlr1r+uODw?=
 =?us-ascii?Q?O3t3x8ZNOoctPzUuLy6U2O/HDJTuoLsDxgpjSlyuXp0bHA/wNTXar80XZyaJ?=
 =?us-ascii?Q?2u/KNUUJFAcfD6jmCjn9E5z/gnQafvhw4+6swIqh/TTmUCo0PDC0awNrKGFH?=
 =?us-ascii?Q?fzhQjCRC2flQZ7cn0PopHJEHa+kg0fbt5IVpkqZtY/RKazr/NtpsQ+K+GmwP?=
 =?us-ascii?Q?NcWAljWPdHIxac9Q2BPV8JBdYisDGveY3uzMaD7Uj+Ip5Hh3yzhJOHipzVJX?=
 =?us-ascii?Q?0wCAJXVnDfK5EwiAFgov6TqnHV++xFaFqFng3p6gaAz00toDEbDTOHIvsa0j?=
 =?us-ascii?Q?4FkLJKa9WWvnnUEHtcDjM3ZruyMlF3mMa2iKuC2PsGiAyYFcXsM/pKVBaDjc?=
 =?us-ascii?Q?BucOveuj4PKEIM2QqBCtHKUcWnlcUeqAqMBurugXLMhAwHT3eECce/PeGHVB?=
 =?us-ascii?Q?kQf5fZ4gs032aRTa6r8Ha2qLF43cPEJCrir8pl1A5HGEHTb8w4ZkETkOwN2Y?=
 =?us-ascii?Q?daJY+uBUDooJxAF17iCW/Mo8FssFv5NwGCbSjpyyGhebemGFhb6/kqUAUC1X?=
 =?us-ascii?Q?i9s9M8RZWix+d6/497wTwhUm11xi4m5omewkVN9npJ8Ms0KhZ6A5UHqY/voe?=
 =?us-ascii?Q?eKNAhAAaMuozPmftHY53M/HXHVTkhxtTc5fRQW5eghusMmONsCqR5R3sqwpM?=
 =?us-ascii?Q?ipD6L7w1IdrvGV6UnjNtA0hwINE17qYpfSOAaA/X9pupT7f4Qq/CA02DVEUK?=
 =?us-ascii?Q?284o8uh6YjUjFV+ive9MgmihkwgVDzb+xfYr9/Wpo8ErVqUHSaSU6XGA5xbe?=
 =?us-ascii?Q?PwjbBOFiI8hVMcnDVo56OAOuXVJcZDifnRDK9+6zgf/2kbah81S9vqaebiSU?=
 =?us-ascii?Q?nqByzqz9ypJNVNVN+0rNIs8ctgU0LhDDZoRLKgh2NrWOREcYuS82KvjKDSDm?=
 =?us-ascii?Q?fs1hc10jjxvq1BK4Or0yRE54MRu4+wAzuJ1y6hjCNmiZQ7/pC+c1FQIApCtm?=
 =?us-ascii?Q?QvpxVQyTVtyU7GKNH648FpPOmmvvdnCfYpqZAnKWhxqWMDG/qVZE1MK134zc?=
 =?us-ascii?Q?eIiY572fXQX4qXDK4Zl5898Uhze9lSUllAj1JE26EjhyNA6hwVnVHCoddMq3?=
 =?us-ascii?Q?3UTxj1bieMI2grObfUYrU+s/BFIXGJm2yDsngw9sW+H0oNCWYEmTgnUgcqxr?=
 =?us-ascii?Q?uIHQmRQlJKmRiRSudzA4dNGMbN+ySwKDM/57e4EX8dJEoE5f1lC6Zb9F2arx?=
 =?us-ascii?Q?OV5WwxDBtPSbgHWtdhirmYUFNEqEuSJxZe+jYmTtiVqp1veUBJCi2lr5FoNi?=
 =?us-ascii?Q?Cc3Z7WSM+m9VzN3xp2ZtzhmCNaDbeEFNWytn3JdG8jK5ivlsbE+H6ZVfxV3o?=
 =?us-ascii?Q?o6YtqJZS76VL98cY5LLs9LG0L9i/UqRNd7bp3NObeF2OQHXHuC/YrW6oJO/D?=
 =?us-ascii?Q?AjdxgmUj5Nrnsm9MoC2lZrObpFlVhdpNOvqQhXxaLtDSjt91lRRayYF1dTuP?=
 =?us-ascii?Q?oxyEIIqWEHRtllX7B+E3TGBh99Qdq8DSDP0ha1C8r7MZumi9VAWmzgVUqI9H?=
 =?us-ascii?Q?e8z+EVJIVlTzJOjwIRsTPceHe0MFfR13ZEYTxwTfUEJxKs5J6WulRrhoSBMV?=
 =?us-ascii?Q?j0JcycTybOZqweuyd4JmDm4=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7765.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e44e1ef2-0052-4c9b-bde9-08dc0d04735e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 09:06:34.6146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P8qhNU74FFwJq+Pu7nWjgGMoDKarxwuSGCJ4dDvfA8bFkyU++IF/cTj+Q5Vsndq/XUdIofNZYjTS+6dxG3fj1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9079

[AMD Official Use Only - General]

> Add a missing call to of_node_put(np) on error.
>
> There was a second error path where "np" was NULL, but that situation is
> impossible.  The for_each_compatible_node() loop iterator is always
> non-NULL.  Just deleted that error path.
>
> Fixes: 54b406e10f03 ("cdx: Remove cdx controller list from cdx bus system=
")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
Acked-by: Abhijit Gangurde <abhijit.gangurde@amd.com>

Thanks,
Abhijit

