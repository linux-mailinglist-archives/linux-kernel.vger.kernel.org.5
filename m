Return-Path: <linux-kernel+bounces-52049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E06D849359
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 826231C21FD3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 05:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176ECBA22;
	Mon,  5 Feb 2024 05:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gL09LoDd"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E28B653;
	Mon,  5 Feb 2024 05:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707111039; cv=fail; b=TOrtG7HWDKyCUC7Lm1ujhrXEWPuFTfJG//WhLaKBQBdWH4dcg2kpZDD67fYWgypZg6nxQomh361jQdi4/dme07r6BxbQIzcSfek3RFHeub5rps3ZxbYNTJ0uh60yDd+No8Rn4W3j5tXKW/yNP53tBbNp5PrtRoG8Td3XbYbAQfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707111039; c=relaxed/simple;
	bh=6zSfL1FykDaalRci1fi4Y/sfW9f9uisz1iicXYn4UeA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JOqPWG70tsLxEgriLyu6RU/C57OBsib915PE3QtMqiFmf1O5cSth4YkXsilTXqa8GIVGWy/w9GweKz0Tou2Ey12Ps+0SRpYcTatKrBUuhUzZz3gUihLy8afQRY/pCcac/qRiKIM+Ah+2mOacejN9AuMJT7iJIMGNxoOwlpClAIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gL09LoDd; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLB8XLWikbXl9Wda7WEdwct49ksAStnTrmIaY/jJiGOPI8bfj/nfA3TOZYz/OiPqh3TheTULuNnhicc3lLaWGekQiGgSP1+W+89qpg7nwXfE/DzG5CkBgj+9dEtmLRc6Iyqu47lkKGqZ5R6deK6xgZO290UOMljWrF/1U6JA4X9ryO0CsuNYShUaErs5g+VjSa1Xk7RWua4wIXHxhTMlSnzZlxUAcQ6P3qZQjTT2NJB8gTwMjubhku+bM6NvgUeUvHJvKKrJHLYZa3Fa6TnePCOw0jj1MYD3VRgJJYrCQinNH5Fgkdz0lvhjK79dXXlzBN7rp8paZN37wFZnzlc9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhySrlN2XHjzD7VPJdOyMrNWb7rDdoHYXtCDKwGRbEE=;
 b=VTuMnL62OPCYON3E5Zehonre6h5wuZUjIa+zH8ojWMohttLCcuHYQg9EYdEBhC3lTOORrTe4AhQqFYyPU+E5C1BJRUtKFYTelUK0ps/YZcWy6w78SjDTIYrQlJqA3v+rSrQSn8sjn1EN2AUlUQ3Ivs3onYqsg9u7mH+3wBYeKxvcEobdQYNFV6l+wX9NVfrb0yP/bpaV0+qb/ZjvJcxPPRzW2qnxYBHtTs2CQgtyZp4R1zvW48as2haN4bCydxTDteoVR74+BrNIyXngWSw6dUEx1rtuCWnpOTAqsGRu6CGUWlr8voktQRKA3gsg5VB5Gs7a+clLpX/BrGA0byAnGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhySrlN2XHjzD7VPJdOyMrNWb7rDdoHYXtCDKwGRbEE=;
 b=gL09LoDdgK5fQCVSigJ9hX+qw3NpsWZEUonqUTfxlNrQQnwj1dj+gu1k3Q8wRrq0DMptEr3tXv+WZrjmZWqTQpXX2M89cyQCvm/5Zgrp8T1PyLhliQ7IH5g7xcXIF+vi9gD/N9fvjvx58Zh+iUPiVsNie+iIrgqmTXmYyeNskcA=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 BN9PR12MB5194.namprd12.prod.outlook.com (2603:10b6:408:11b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Mon, 5 Feb
 2024 05:30:34 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::831c:60ba:97df:9720]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::831c:60ba:97df:9720%4]) with mapi id 15.20.7270.012; Mon, 5 Feb 2024
 05:30:34 +0000
From: "Meng, Li (Jassmine)" <Li.Meng@amd.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, "Rafael J. Wysocki"
	<rjw@rjwysocki.net>
CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
	<linux-next@vger.kernel.org>
Subject: RE: linux-next: build warning after merge of the pm tree
Thread-Topic: linux-next: build warning after merge of the pm tree
Thread-Index: AQHaV/BL9brK23sCWkqmXDoXQ0ZdcrD7OHQg
Date: Mon, 5 Feb 2024 05:30:34 +0000
Message-ID:
 <DM4PR12MB63510C9924DFF397DC3CC95CF7472@DM4PR12MB6351.namprd12.prod.outlook.com>
References: <20240205160042.2e1cffb5@canb.auug.org.au>
In-Reply-To: <20240205160042.2e1cffb5@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3060d2e8-f9de-454c-a3f3-1cbc78a1c30a;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-05T05:28:35Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6351:EE_|BN9PR12MB5194:EE_
x-ms-office365-filtering-correlation-id: 095bad80-37c0-45cf-17f7-08dc260b93cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jdQ3+HW0tOWzM2/zjZkNREc3vwP8/G8WBda172u6XLxkVpQZ2wcgEMkr4pY13pMRUTYV6rRG3rxVpyTeS7aOkrdfmHKPBdSZlN97zp7i4+TiZ5A6lzjSsKBkXWHDDyRDXrZwDxzPhwcmjIqsGVE1F+eO2iudfhn9zhHvgBIenQ2SCxzZD4mekytGacSnLBTT4dPg19/tQzw5Y/BDIZw9g7sr37i/ABzv5eKrPMzBzFfcLMuObg9I6BBHWqGdgRKe2nhE0JzcroyFvpSVncc1llFJ5da+dk1J5BdtdoSydZC9j41AhOCeF3arRgsSpPF1DbVO2EiaBftPBTxNXR3Tws8ZYdpD/ny2uY7vvTCyQCVtcOUH53eNz0jclFXSWKdck8TY3guijTtEJX+JO8bWPd6uKwYr9DMIu2bup/tA6/DEzLP/AYLAPwD61R7yDkzD+pwgq64t1ev3JPjbsMBG++8IlUmdLIjs2qznKr1CccIBi8S0dn9kWhDU78qMOk46PL2Ix17W/x45aIgTHJep1kCzTkI04dcwPP/vgxb/FgFoQnvM9La7EjAhLgYz4GlhG0wjvZJP3eJlC89WBhXwHGEzQak25V8w7rqaoVbHJeaI6vbcGBQSbDqTz9VG++GX
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(136003)(376002)(230273577357003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(55016003)(41300700001)(26005)(83380400001)(53546011)(38070700009)(122000001)(71200400001)(9686003)(6506007)(38100700002)(7696005)(66446008)(478600001)(2906002)(4326008)(316002)(86362001)(66946007)(76116006)(64756008)(54906003)(66476007)(33656002)(5660300002)(66556008)(8676002)(4744005)(8936002)(52536014)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KNmoi8PdR1QLZi/VCNTVyj8w8qSNp6YV8xRAFLjpdhGXspUbq7IyrMXKYdmj?=
 =?us-ascii?Q?L44lnPOYaXVOFYOKPO+NANBy+kbiPynZ+zHJZC3eJlNhXjDwd3E4NVHcXVnC?=
 =?us-ascii?Q?MUIHisF7W+/CVCgjgQh+5K41lBByG8uyQEINEJ/2SmkkG4LHwBVTdT9plCOR?=
 =?us-ascii?Q?NmtuO3pmcoLjMNmTmiq9yrffYDXt/2fmI4lBgMTePkEhZjVDumrxvxdlUsck?=
 =?us-ascii?Q?Jmu3sLBZMOxU/WyVA536Timxo5usAVEhnJnHGXlKK5THOvPRkRQ6+2kb8isn?=
 =?us-ascii?Q?VIwhp/yso8bvHDzQlCfO6PDneOslZtAVF4MPOjosZDL74bFXSKEIkH3bN3G3?=
 =?us-ascii?Q?yhJgIOzU0hpKJhZfg8fHMHE/5Zs6muC+duS+Bst4eP6bxWG1iV6D7CPmlcSj?=
 =?us-ascii?Q?V0ahyNSN59d/GXXCc4pBmIOWsqbMvoqybbiyzLs1jChHCLE7rJL8Ba2O8NiJ?=
 =?us-ascii?Q?q4NjosFF37Nd1Z4ytgSyFQ8t7YhH5DCL586fYdo2c/+QLzU9SiKIMWGXAfHc?=
 =?us-ascii?Q?y9fAIZXnx+locvUOsleeeYj9kYNAcSNd2jFkBOkQsFJ3cfU01V/otRqFlx86?=
 =?us-ascii?Q?mNjQkogFSGVjxH0Ki21BouXCw8NHYhbT0knx043ZlrlkGaD994TjtOwAuWJe?=
 =?us-ascii?Q?BiqvZImkCQRnDCostd74fD5O9CNoydqKjd2hPI0BbM5mnjWachGTxVjiugJO?=
 =?us-ascii?Q?P9gDXkRRzIHjvHxpMWEWGqBiWcOhGHjFOcRXatkrwql/io76AB2kS96i40wc?=
 =?us-ascii?Q?OR6Y8+vX+XRFPFQXF1dOx0pZs59ltYGDTM4M77bozlj/2JQGdTqoh2u0q9PA?=
 =?us-ascii?Q?GCJ9f4cIUng0lQLG+yuGE9H49nrie3sG2P974aCe0DdM75Byi8X+i+VyYP5e?=
 =?us-ascii?Q?95C9ATKe+lY4S/9nuFy4Ceuz85qV7oU/3QCO8kVF3/wc1K7y5U5Zu//FPNX+?=
 =?us-ascii?Q?lA5lz0Pof99W/jJjlKwJSZNLycILaLseyI3kpe0zvkjFr6LfyiZUfWLa2G6R?=
 =?us-ascii?Q?puMCErYxUYmPzsKmGkRvjP81fjIFRbPYgeMt+CSRwS6bykCg654jXhjxDmP+?=
 =?us-ascii?Q?C/SLIgNu1X/ofwGRb3LtDeSoLrteZUe3LAl+etjGjl5cujSSq5y5dK32AXMv?=
 =?us-ascii?Q?fTanq9mobYNJZw/1sFe5+D6wBL6AjLfW3BZeTC52rsSGR7cpk0gYeHfr02GS?=
 =?us-ascii?Q?z8oHoDkidsPoL8H1y5o56axd8UntsyhLbex5gZK/FZooLRqWV+VDRWpe1Arq?=
 =?us-ascii?Q?NyRLCUmc2mx5AiLazZHc6folXGBbP9f3eOzlHmWFDKSG8QKi5lJY6Ap7n7x0?=
 =?us-ascii?Q?2kV5ISOcXAT5xy4eShJhlYOcz7LPwUnaVKlKSowRogf8fRTijajl9MF2ODOS?=
 =?us-ascii?Q?ivL4FHmXMtlFDD2evCPX58wzLYVcLpDiilWxHP+bxNxuu6J/e7Aqh7dt73uN?=
 =?us-ascii?Q?+6ca6DJKu0Ju24Wy9PMiK3zkHCO+tSJ3epX+V1VByQIQZbKvoWDLJRHpcD6M?=
 =?us-ascii?Q?8G4OnpVxvvalEnQp8DmNS5E3YWF0qiJzuoan6YYsPzH4Izv5m/onLhofFzJF?=
 =?us-ascii?Q?kgoIb9i4RSrJSOQd1wU=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 095bad80-37c0-45cf-17f7-08dc260b93cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2024 05:30:34.5724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aVusiV1XCIT1JrkQ8RosjpfPjVNlN3cwPDNTIhqa/PQbA1eoIr291PWQxRDqdf+uj/Z5jNGtaI+zeIMiUw7GrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5194

[AMD Official Use Only - General]

Hi Stephen:
Thanks a lot.
I will fixed this issue as soon as possible.

> -----Original Message-----
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Sent: Monday, February 5, 2024 1:01 PM
> To: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Meng, Li (Jassmine) <Li.Meng@amd.com>; Rafael J. Wysocki
> <rafael.j.wysocki@intel.com>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; Linux Next Mailing List <linux-
> next@vger.kernel.org>
> Subject: linux-next: build warning after merge of the pm tree
>
> Hi all,
>
> After merging the pm tree, today's linux-next build (htmldocs) produced t=
his
> warning:
>
> Documentation/admin-guide/pm/amd-pstate.rst:384: WARNING: Title
> underline too short.
>
> ``amd-pstate`` Preferred Core Switch
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Introduced by commit
>
>   3a004e1fee4b ("Documentation: amd-pstate: introduce amd-pstate
> preferred core")
>
> --
> Cheers,
> Stephen Rothwell

