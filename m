Return-Path: <linux-kernel+bounces-159626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0800D8B313F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2908282CDB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E1F13BC36;
	Fri, 26 Apr 2024 07:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MsOPUG/6"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1B8210FF;
	Fri, 26 Apr 2024 07:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714116060; cv=fail; b=OK0JcYBaaarMGIyIUqlYv/DNe8WI5cmvwgjBu/zZ626evgf8LKyqo39xQ8VNZFu7b2kgFk7I/QDEIcTtsywuxaG7s92Zt1Ap3JxhTJwBD5fzM3HCOCFd0Xfkee2aBagXnu5NcplhjtVQblLe5IxDVXDhblZdHPe2Xg297iyXyFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714116060; c=relaxed/simple;
	bh=sKFIitWipMbAgEmuCXsHlutk7xmzouIskxpLwdA7gw0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a4o257qvP1f8gnhCuMWN//XReozvcsIUxzTLzvbUsDeQ1yqqZWVpsn2B8r/+S/F2ru4saWyN1Sn7Gw6byrCGm9XjaCXVOEJExAst6mCbUUpohOZuXDYDD+EDzQmTsdMeDZ3nkPbJoPAITCBOy9RUr2NzUIoACqryTsQUDokE5RQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MsOPUG/6; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzQULdQMSscouCZklzO+rs0G03KP0o6qmTKBzKCSI4quB1qYQu7LaUZXVdSIjDoaoFQvSAx/YyxtsmeLWdyRVBHz2lkh1hC+Fh2HP/VIcRA1ImAs2jn9EKdoaHvEmISym0MiprVjFeOhuX95uaTqDFwC/LmLPHwwhAmLu6UP93HA4C8xWkaR/WjXT3YiCZC47c3c1aI/8IIXYvcpcrxMwk+mh6p8P4H3o5LeZbHb1j9bh/8YWUFmi7/QA7GzbWMxGM+sZr4wQL+rUwus1klihXPPFwDuRF5BT/xKYJd+v3wuBj+znv2wo9749zoYHIjq01WflkVTIDBCXUgcEEFEEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mku0Xn+pOjYchBQWHxRkd5EQfpDzzGttVm4vJAKSVOk=;
 b=fDktH02mmYRDwxBKyaD1DzwOoERiO6AOTEpPPnINAu/SPsCeeomFZlZkdfpAaxuJ/B6fXGbXYTU1NUiMmFssAoZl1s1Y7ftfq9URIBnW4WzTT/WUGsCPRMAym640JaNuzRKBD58qwZdNevD97Y/Y5uP3Q7yARDxh5DBnsjDVWyLZ27uUg/gyQkGWv0Sn0KCNWXDnUytNc7hF+MiBZdndGGbVRyXf90WWYVvOVru9iOkTx+GNm7dXIxSrcMVFGVS34SAaY+TiXU4ZZTBzz1OEcOK7SLhKJOwGiG7Y31bVIFb1zd30uAFRRSkHvFk/ZHw9hUNw/0kUfgqU6j+aODEDLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mku0Xn+pOjYchBQWHxRkd5EQfpDzzGttVm4vJAKSVOk=;
 b=MsOPUG/6f9mGaC0g1cdc9Kw+H9jmJy0PAXU/xenfzN2qJIQ2L5zsgQm357GMLei0ipvbDJbtWyA2GiTr10oqY6f6hBs+zN1xNHKaBjZ6+FkvyMLOUib+4Cj5DvV7YA21Wrapq8ItowfHiCB2oGzzzcUvGQWNvy2RJAaTGpAsF3U=
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by IA1PR12MB7734.namprd12.prod.outlook.com (2603:10b6:208:422::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 07:20:56 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033%3]) with mapi id 15.20.7472.044; Fri, 26 Apr 2024
 07:20:55 +0000
From: "Khatri, Sunil" <Sunil.Khatri@amd.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Alex Deucher
	<alexdeucher@gmail.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
	<linux-next@vger.kernel.org>
Subject: RE: linux-next: build warnings after merge of the amdgpu tree
Thread-Topic: linux-next: build warnings after merge of the amdgpu tree
Thread-Index: AQHal6arerHDoxMTDUy8CI2jv4q8MrF6JSKA
Date: Fri, 26 Apr 2024 07:20:55 +0000
Message-ID:
 <PH7PR12MB5596845E0211FBA34E5DFD8493162@PH7PR12MB5596.namprd12.prod.outlook.com>
References: <20240426165500.56c28076@canb.auug.org.au>
In-Reply-To: <20240426165500.56c28076@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=30f708cf-773e-471f-9faf-14e9668950f0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-26T07:20:29Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5596:EE_|IA1PR12MB7734:EE_
x-ms-office365-filtering-correlation-id: 7b17550a-158d-47f1-b223-08dc65c169e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0GYGjP0a08HfIWYEuWZXG1EyUSxbBqaDXief+/te32WKDvwTt27eHU2yaR9f?=
 =?us-ascii?Q?9XlyzK6moTANB2Kuz8gag6r4T1SFN/e63jOukg6x6beTlLR0XFX9WhLSTjud?=
 =?us-ascii?Q?yDwbIkogDt5DQ7OC8hH2dCNRGV6bM2X/6hBjjSWic69saWHTNQIk/sL4tGx2?=
 =?us-ascii?Q?cT6K9rk+bhmv9PUHiw+ggBq1/fJeo9h9JvHke6NHBEi1Z3Jwo/H8X5hbRsAH?=
 =?us-ascii?Q?T8gWJLAFZRxJOcdU/9fk4M+1uO0WmmYEEPAMRjh0f/Q1Oy6iNvRGs/XsGuj8?=
 =?us-ascii?Q?x1z/7v2M+dIqpC7sjej0h3Vifh0O3s04FHLzjVsqqvVRFA3MgsWjiNz1gIaV?=
 =?us-ascii?Q?cwSEmwK0ldaK0DXKzldozUCA9d5WI1SaNLFdIEJ1cainHbhSOBp44u6qE8Fv?=
 =?us-ascii?Q?Af5yd/YS/CyPmRzPRHg2j5rWFjUHSRgd2owq8D5VkdStkigZ9VXWj694Z7MB?=
 =?us-ascii?Q?yMnwZKmYWXJbh2yPXFR7r9wrPw5FzsqwArZ9YFS9mcF3/nh2f9xPM+u+70Oz?=
 =?us-ascii?Q?MJcr2IIm+kTk8qN1MTVVxFlmZLREQwNWJHvTE2VEcjWIYiC62Nu/PNQ1W8Av?=
 =?us-ascii?Q?KgkBf8IHnHgEPrlLyUaYEAxl9MWGf0YMsyRyQwQj9Pdon379WkAaA+UMClsK?=
 =?us-ascii?Q?u1DCod0Xk63FwhGSCWWP1oSwriq1J5bBp1bPGQFo8iv2S5abJZKifneirCkj?=
 =?us-ascii?Q?6+n2/GrGZH+Nhw//0fRwIF+L2glTTITVW2JFPI8AF5TPZbqcsWTZ7FBlaBJj?=
 =?us-ascii?Q?YNwEePJ5M1Aw309kOAjW+WmWJBLA4kL8zgoepWzjjHHbeNxPJZ3oR4G3eDtM?=
 =?us-ascii?Q?DfhLeoKMKkmyE6Zg/V10fljTpUrkNNng7G2hGo39wpZhFJ0uxLYbFCO6fW5L?=
 =?us-ascii?Q?5i26IaEbB0jYwc/ZgX79oEtU6QJ8Thugtm/rmTAYepJHCbkYKqdh6iDFyO1h?=
 =?us-ascii?Q?T42aOImOoBSQZYe7uCdsPFjffTspyN5HyxcLeezX2eap5idfCcyvC/90C8rO?=
 =?us-ascii?Q?XNQfx7hOCWWNEyI0ibXihPHWUehcS2xx0gB0RmbMSFNfhBRGwOKyVmq8Xh7Z?=
 =?us-ascii?Q?NH0koN4eM+59ivgexQ/F20kOa2kuJdaID5V5Nz2QcaF4GT9rgBvh7yk6gBKk?=
 =?us-ascii?Q?lAfUZex1s1J4OsKoX4clmW5o8SJcmjwIblBKXnagITcWFZezelhrA02/frIL?=
 =?us-ascii?Q?7AjQBIMwqgaNrY9/A3z9KlA7i/X72KjAxzXBTBtHq0LLTIbQREayi7f10ei+?=
 =?us-ascii?Q?lr6Y1w34/ZOBpn6Jxb8PDW41iXVd4ein2Js2eL6ue2ZRL0LAQpjNWvy2YnVZ?=
 =?us-ascii?Q?nXTDQERCQKRqQ59rjAfQBWDPtS6+sKiJ+0cVwlHck3s0NA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5596.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gczTtBFJNNEpVPr90LP6xDLB/WzLXvmhfsZMYq+DsQBj8UyiGKDp6n5XxkqW?=
 =?us-ascii?Q?IRl+5tvHmGw9r1sLquZ7Xd3FaoSvXXr2JoCKbr6JYXLB2IF3c/2Vk8DuYvJI?=
 =?us-ascii?Q?aUGZvAIlE90xtITLIvj0Be+fcW0ARjjA96nNSE+ev/TeU92/CjW1ySGCtscn?=
 =?us-ascii?Q?ry05IFlpsd6S4qX2Ut402iwBHfOe6mPEBPYWDaU62fyoJUYfUd5oUiGhBRCQ?=
 =?us-ascii?Q?FoUOz8QBy5hbP/GYVFcJJc3xsoiNdOx9gEs16SXq2jAOKZUbT2rZrus4ygTO?=
 =?us-ascii?Q?FyCXijZNPQNENm9I/vFz2jsupIDIHzlKKvBYVrYlldGK1iLdQ/r2FHV1RL9v?=
 =?us-ascii?Q?IBmgmdxFv2DfMKipac7HICjEdTcNm8JDRTwJwHOQtAdYh0l1egyKoNepD188?=
 =?us-ascii?Q?P6DTNm1QwjM4ZJsaJh++CTwigX2ly9WcDMgdLPqKa9upns+pJslkrg/nV57X?=
 =?us-ascii?Q?zrwg21sh6xyJ08Rgiv8QcnCLaDxxWK9549QFHNB2QgemHJJTFLKzqY36V8+E?=
 =?us-ascii?Q?LxP5gABJTZ7XaJdXLy0ywdVF289K1eIekp/0WwzVPHFhxkoTsTfEdeXYOWID?=
 =?us-ascii?Q?Evl8KH1NJdApyxZIo24FrDoF6zFqE9JWYj7xV9E3Whsg27KvBG49JUooauJw?=
 =?us-ascii?Q?1xDSh3gWxpM/C3NWFZvdhyhlIk3rXAZNhcm3vjWiPpRyPPcyjnHkYJGQPqlv?=
 =?us-ascii?Q?gY4xVGaUfhonz0rp8K0r7lZ4BT9FWA+PSshsifADIh50nZxSL/cYct/MZ10B?=
 =?us-ascii?Q?glHPhXeqYNPBLioVTkKiPy7WTYup4chRhyBMGaXT7/2/9bFWO8LJO4tTsk8W?=
 =?us-ascii?Q?w2LHWOKWnuSxjYnPoP9rhaZHnzTYCFUNdfeR5aBkIWOIEi7i8qVc1n3SFhpP?=
 =?us-ascii?Q?xPBUScy5oOQtzJFa5k9awgpXgxx6yPZBEDR4B2nwASmw6BV2QadxfLJPweSa?=
 =?us-ascii?Q?10lyO0fX9c8Fwfzr/XqK2nLq2SZe7oW2hsThrd1lI1JyH22n2XsmzMVGTxzq?=
 =?us-ascii?Q?N6FvfgKvXt316tnTs3QCecze6XXygd8pYcPjJ5CJbdgLRCIsCkPrccIoPHkj?=
 =?us-ascii?Q?UsXxI940A/RRhl39Tf2PR0RWCNvDZHiT8AgE4UseWrs/E3kPzN/wrDiHH+Yx?=
 =?us-ascii?Q?/iK4prUtBmbypMiVmpmGEcpOJSvFIh5PETpvRR371HlSCyNAGN5uWUeOhQ5C?=
 =?us-ascii?Q?ONg4rdEv6tZfbtPZsJaLxdz9682Y8OoBRcaDg1rO8aG4xjB/Fo8P8+/MvD2G?=
 =?us-ascii?Q?mHFfZeiBZUb1S0d6a4AUAnURGCFTOBO/YyxkNfDJKyUv6cexw2VSgWUKhT4D?=
 =?us-ascii?Q?XSjYEK6oAw2r66js5ysaOuFb1ya5Q/mCCWb4Dnyo65GEr+yErRvi6X56LiIx?=
 =?us-ascii?Q?QtWr09D/hiSuNZXWA8+Qe/hbZ97RQRsrOpsJ8wGlhjV5thp7Jn5ldni0ROrB?=
 =?us-ascii?Q?tKcT2LHMPKu6gMCFDO43tBufT70RNjhH6jrTVXifeteXSvj8Sj28JtoJNYWk?=
 =?us-ascii?Q?HWWHImh5CS3piOFUW+WTZnHJSDOmttB3Fnb9VQg/0JuNF/Qy3VVB6H0ncRNj?=
 =?us-ascii?Q?Kb3rjsoz2Q1AauazFOA=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b17550a-158d-47f1-b223-08dc65c169e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 07:20:55.8802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: asEUulQfi+k/ekDn/2dsab9i+Uv8QlIZnyiHXJ6pHLycYWmqaRuXXgu5RE29r451h0bdin3Rwb3WoBql6buTkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7734

[AMD Official Use Only - General]

Will push the missing comments in new commit.

Regards
Sunil K

-----Original Message-----
From: Stephen Rothwell <sfr@canb.auug.org.au>
Sent: Friday, April 26, 2024 12:25 PM
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Khatri, Sunil <Sunil.Kh=
atri@amd.com>; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Li=
nux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the amdgpu tree

Hi all,

After merging the amdgpu tree, today's linux-next build (htmldocs) produced=
 these warnings:

drivers/gpu/drm/amd/include/amd_shared.h:327: warning: Function parameter o=
r struct member 'dump_ip_state' not described in 'amd_ip_funcs'
drivers/gpu/drm/amd/include/amd_shared.h:327: warning: Function parameter o=
r struct member 'print_ip_state' not described in 'amd_ip_funcs'

Introduced by commits

  9c5c98ebec02 ("drm/amdgpu: add prototype for ip dump")
  70977336d483 ("drm/amdgpu: add protype for print ip state")

--
Cheers,
Stephen Rothwell

