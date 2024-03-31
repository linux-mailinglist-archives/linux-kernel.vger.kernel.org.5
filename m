Return-Path: <linux-kernel+bounces-126385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9BF893662
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 01:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C9581F21BB2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 23:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D1A148843;
	Sun, 31 Mar 2024 23:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BDIbWROS"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2056.outbound.protection.outlook.com [40.92.23.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F347148314;
	Sun, 31 Mar 2024 23:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711927309; cv=fail; b=fbc8VTt3jL6dvzrcCq97Owwb+aQvaihySiNJ48dWUr/L93BjaIDil7rVnibIeAyU6M/j5i3jLhYmWG7v7vd3GomJ0NtvWYO+Xm+7ejNITU2Ar8DZjf3Cw5EaJ6RWhBXdUQJ1Tdu69+3YuzG82qa8TMALskoog8sryG/nAgIQmSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711927309; c=relaxed/simple;
	bh=SQZhQobUF5Br+58Q1ShYWW3LfRzSU+Z8El6nNU9fxmg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qoMzs9tlYQZ19/IGiF7gRgQijthb+rZpe/UlD+bMqs0rUB5S22tNTddLvTcOkxDVdmc4nV+vOWtFAF3UOEQBaViQ9ChM3OMo/V+2yVvtj7ISMcqkLWxeFF1DFOp+NzcEtkWuLvdhAVYBebxmraRAxf28n2YMvWLFQLcfG2wws9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BDIbWROS; arc=fail smtp.client-ip=40.92.23.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VltenAnId+th5o8C5NFPku6NlC3rZt9RuLEwWoEPYGMnnu19o6sCmTMDy8QL1IElUixxRHeu5OK1KRKjqQTINWCrCzBF+SuBCB9MsJp5vv2c3jPZ4cf7G5avH/xdGoJBbjLC1CostxQXgpPba1CjIUOERHD8b/1Ov5doYA2VSmMB/kp+YBkhVyjPHWvWG+0M/N5HmLv3d/ZqaZIVYLw4zQ5KEI8+tOPf9w7e97tnRZVA21VOAx2jwV76/SFbuNLpm8jreiyO5BW1iBufb0Y18M6pWNDfsbsr8mxOp3VbNAvPTV4C/f5npndHAhpOuEo25VeukwjiQlpywegAC6SFOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGOpWUQpBigOMWcqrVwtT+q8YV5IfeMPz3/4lp4Q13M=;
 b=DOD7bKMm3hACEuINKGpSThBgQAyeEv//VlHKty+rKlPqbKIpMO634quMw2Smi/hsk4L121XWQTB1pDR3kIX0oI5Oj20BIVFZOM74eGbzE83YSL40i2KJpB3bUU3ihUjp5yRJJj1vNL+XtYyg7Tm1VI8YLs/UyyH55LPN3wML1gtJdoDKk7Hyo0dsuNxyqxmKDwQrDSqiuSC0dublxVLXiS3mO0LH+sQ8/UVhviRGJjsqmUz1QiZUcJgUhcTbhLTQIxDUYlMnWhIeyWdRG37mJm+jsB+DI3GrM3H4mAcAKZ1IH39Xd/ndgts5HP5bcApGXyTMYhW061N1ZYojfC+/Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGOpWUQpBigOMWcqrVwtT+q8YV5IfeMPz3/4lp4Q13M=;
 b=BDIbWROSX49ZqzrT/fBrnOuUsNbdjnj97Q9/1Wl2mVVLCzGXYylZYX9tax7TDknZvAU+41yYbb/K+lGkDohZKCNsyxki4mTb4ILiDUX7oKJkPxsmcy5LGGdTd0ONQoigZEYZjZ/cFEKlxZy8pxDreO8buK2h95L9XIzjgSfkX5eCPHynAGLOgvBGAPdKanCUV1tjfGmvh8DuPYxduqtwXs+yglwLWjnRE3e6TPkDgF3LyDChTpD34LXC2tTJ/2N6sDlRKnkwdkJsM2udlzyTtjNliTUd8p/vznrbQW6WgQhmk/+oLEPMsj/ewrvYQvjzoSq27BLql/xrcxgPEjr0rQ==
Received: from MN0PR20MB4717.namprd20.prod.outlook.com (2603:10b6:208:3cf::20)
 by MW4PR20MB4504.namprd20.prod.outlook.com (2603:10b6:303:18e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 31 Mar
 2024 23:21:44 +0000
Received: from MN0PR20MB4717.namprd20.prod.outlook.com
 ([fe80::e0a3:f058:e169:988b]) by MN0PR20MB4717.namprd20.prod.outlook.com
 ([fe80::e0a3:f058:e169:988b%4]) with mapi id 15.20.7409.042; Sun, 31 Mar 2024
 23:21:44 +0000
From: Mac Xu <mac.xxn@outlook.com>
To: Joe Perches <joe@perches.com>, Barry Song <21cnbao@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC: "apw@canonical.com" <apw@canonical.com>, "broonie@kernel.org"
	<broonie@kernel.org>, "chenhuacai@loongson.cn" <chenhuacai@loongson.cn>,
	"chris@zankel.net" <chris@zankel.net>, "corbet@lwn.net" <corbet@lwn.net>,
	"dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux@roeck-us.net" <linux@roeck-us.net>, "lukas.bulwahn@gmail.com"
	<lukas.bulwahn@gmail.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
	"v-songbaohua@oppo.com" <v-songbaohua@oppo.com>, "workflows@vger.kernel.org"
	<workflows@vger.kernel.org>, Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v4 2/2] scripts: checkpatch: check unused parameters for
 function-like macro
Thread-Topic: [PATCH v4 2/2] scripts: checkpatch: check unused parameters for
 function-like macro
Thread-Index: AQHagLa6dUAj6irLP0SxfpZRpU9V17FM60mAgAT23VWAACO3AIAAfOPE
Date: Sun, 31 Mar 2024 23:21:44 +0000
Message-ID:
 <MN0PR20MB471701E2FEB9DBCDCDCD9D44F3382@MN0PR20MB4717.namprd20.prod.outlook.com>
References: <20240328022136.5789-1-21cnbao@gmail.com>
	 <20240328022136.5789-3-21cnbao@gmail.com>
	 <ef2c96e40bcf777535c9ff2405e4dc5b3138b27e.camel@perches.com>
	 <MN0PR20MB4717810B82175CC594A9F285F3382@MN0PR20MB4717.namprd20.prod.outlook.com>
 <dbe8ea1a6a3b599a00eeb8ba0254fde785a500b9.camel@perches.com>
In-Reply-To: <dbe8ea1a6a3b599a00eeb8ba0254fde785a500b9.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-tmn: [JoQvYRRq1gC3nL8hEzEhe432+ZkdA/nT]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR20MB4717:EE_|MW4PR20MB4504:EE_
x-ms-office365-filtering-correlation-id: 327be0c5-1776-4ab2-8f28-08dc51d95487
x-ms-exchange-slblob-mailprops:
 02NmSoc12DedRvKN5/4QiK8NHQIQU0k8kQ7VOs77cDKlBCz3//c2Zm/ofZtqNkbk30DD3WAFDUYBSmoVfr5Si9TqQ6y9bm2xsL8qaeSjp0HZcRi8+6eT1yc7+urqMw0/kKTbe+4Zf6Fn/+4lMzoOxBRWrCUMj1eMDHuvgITPAR9/nefBJ7C21/PxEpUjJpza05GNLlTqIjKbmwZPM/w0AKplPa6lfk3lGdHcCB6tbL89gmjhEYevNGYXhl8pqPbAPaPaTENHe4DQjlGCcuqlATUFf9bm1muAHum3SJ7IcOy2rXd71dPEy7Eg8DCjj3ciLVB69BjPpTAqCY5IAb483ssnXFyxLZwrOH1cdQ5BnQwSxAQrJfDoz6m9g1QF2gyRD3+lfdJlvw5dMPMhMlq87pbm1Kd8xJ7aSaYCjQL+t2Qe1jxffBRr7NQSPu/psfpg8ZlN7JgibMdfbYYpkIyUkKYcyV7gYKNA9WTyIjC4c6JBWuEc7GFJyyeXH18XCLP7RkuiESo4lRg75a01c5vNTnzNV8qW0bpTp14/ABA6Lvb6uQuIF47W2YcnK5D5TAQlJ7QVvI5NtofXcVPpprsPdM/MuLPL2bGuIbz8pBUN6ecQ4Jh7Y/3jdZQIPs74E7saZVTDQet6cL4CHnI4U5tBfhFT6D8hcVJN6JrbfYndlI/4PqDnyitCNUyjC4ju9mHN+NlXaeXKqKDL0y2fxqbFIW7hAV+hgfVks+B5hF0xGI8AzYK4AfVBo98iUpstp+Hz
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 JWK/AGNFXoKHJBOAnMGpTw6uvAeON4V832zGTbNkzAfQOmNuweMHFZK/T19LQN2RtNsk+kg4C2rLO7Te1SnFJD7r7zPY5OuAfkv8WqzKxMM/itZ6S41K43+aPj6VUJ041vCOqhdsCV7Uq32diZDeHWyaQSAx9U/z8vEKwLpnyjg79aKd45LCDKO9dxR04wITdku11B4O1VHpfFBROJpECECZ2fndQGQ4TTeQXiLDbHbnvobYqTDfaAgF1SV9N4+4MrQHEAH/QyXSMQM/du7IAga9ZmbojkZK4jUFjgBPzoeYlV+WstluqNRg4u67UDgEViR0SFkU+4ztJOd+RM55whMUZgdM04DJHeoAO2J6thsttdTa/0QYL+T/fqvWCHcAJrDwh5Oqf0IDgvByWf8fiOtjXrO684RhdxfgcgjGnehfaCIBVC03o9qSl4LxUARj33qRhrOKccb+0lBJFo5XYOxntXgBx2UT9Bft8H4Z6RcawRqSOP1FAtEOT8fSdZy08ZQix81NqCLKOvo3yGT7a/wkxDCfZvtJ0g1pji+gAy1wrwrDXHC5/R0lWzhMV/OZ
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?sbEZvsXBQ/Ri+RKwv6SkrgAq5HvmpbQIqb+B2ODMXdIW34guOLRhhNZw5x?=
 =?iso-8859-1?Q?ZpmO7/qYctaN3cz9A36TLjrVjA1kNavuyhchucv6Z0GY8OFN8qB2SONYf+?=
 =?iso-8859-1?Q?DAgo6jrEji1swcXdqxmeROXZOpNgWAfqXDF0Y7OSFiD0hKsGN8WYpzYyHv?=
 =?iso-8859-1?Q?pX/5V0gQ6WU8swacDjo019qnpz8F4vwBi4bsDE5oQgSvm+1RMg/2izV/6R?=
 =?iso-8859-1?Q?CbqVM9osKFoQmDI2Wqkebaac/w98XgFr85K2vjo/C46Fkvj/D/TaiC2ucf?=
 =?iso-8859-1?Q?W3DsWq8SDfOCtW1Hl3j1hUV267DFTT8f/zqcVJyhg3XXmKyGT+BnpZ0DHJ?=
 =?iso-8859-1?Q?zFd+gs66MaCP+/GLCimaETmNg+u1fd6TSba45csJIqzsCWiwspdzFAVxFj?=
 =?iso-8859-1?Q?Xe3GJdm9LPnx7s10HvsRftGs8K6QSXFr5CvGVmIyibh64N+O5DpB/mr8QS?=
 =?iso-8859-1?Q?fFZcUYKDg/HeT5co6+z0GogZhVFzzVXhYweRiEluNAY3BUy6MXvmNe9cJL?=
 =?iso-8859-1?Q?iC51wS3esyY2b2HAgqML7ahWi3pkdd7ORJdgnUhLe0hggtJPxXbZp2rD4C?=
 =?iso-8859-1?Q?2yv14vC+w5/H/9vwsZm2DV3joaXOHL84TLRg8btLszWxUdqN7nfmIQI89g?=
 =?iso-8859-1?Q?jccH66meSMwMjsOTSoDMOEzxtEsVMQfHpEMYVGr4AGtTmFSLJ4SFrZaj5f?=
 =?iso-8859-1?Q?SWKl9+XgKsEyEEMQyfGNcOKPOJAOuaT1uDP2tHh/GIHhkiEpDxAkGS873i?=
 =?iso-8859-1?Q?3MWkJLLIeDA1+O/O3MWS2AasEAAjsqKGpaCqHp51aNOEVxegwyE2t3Cq+U?=
 =?iso-8859-1?Q?zPiHrDHgVwoBZetyg8q2xH/2FrRCrwAQJrTcgDRHmmS8MFAfYNBl3Z8VXU?=
 =?iso-8859-1?Q?sVvxgaAjfA/BBGGI8B3iETWUERoc7WbroOwAjRHtwQwS8aQtsH2i2Ss/l5?=
 =?iso-8859-1?Q?s8xV1uHZsLjHg6i99Q80TDoKOiMgqXqTOTL21Qbg/HgJZZ/Zhuqy2tOvTO?=
 =?iso-8859-1?Q?JdYU8sThwQHpkGSzMmoTtbKyJryyogujxr2wrG5Ygtnc4wXoFrT+xhFrRZ?=
 =?iso-8859-1?Q?G1oguvSGO35nyrc0nDJNeIu8lCpLku1Q2hnwA9nXBkO1tGcReFhCAwZcxk?=
 =?iso-8859-1?Q?wWEYm79wgVeNktB+dYbLcgGnL/9H4VFn1V8Tdwu5uW/NOLjesKWyCXSnZJ?=
 =?iso-8859-1?Q?sTvr0BXVmxC/Em/MH38WWvcIpnFW7H565FaLBAEUGh8evt8NNoiJUitxkO?=
 =?iso-8859-1?Q?auObj1D24KpSiRWCfsHg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR20MB4717.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 327be0c5-1776-4ab2-8f28-08dc51d95487
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2024 23:21:44.7280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR20MB4504

=0A=
> On Sun, 2024-03-31 at 13:46 +0000, Mac Xu wrote:=0A=
> > > On Thu, 2024-03-28 at 15:21 +1300, Barry Song wrote:=0A=
> > > > From: Xining Xu <mac.xxn@outlook.com>=0A=
> > > >=0A=
> > > > If function-like macros do not utilize a parameter, it might result=
 in a=0A=
> > > > build warning.  In our coding style guidelines, we advocate for uti=
lizing=0A=
> > > > static inline functions to replace such macros.  This patch verifie=
s=0A=
> > > > compliance with the new rule.=0A=
> > > []=0A=
> > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl=0A=
> >=0A=
> []=0A=
> > > It seems this logic is a bit redundant to existing=0A=
> > > code and might be better added in the block that starts=0A=
> > >=0A=
> > > (line 6026)=0A=
> > > # check if any macro arguments are reused (ignore '...' and 'type')=
=0A=
> > >=0A=
> > > as that already does each param in a #define and=0A=
> > > ignores ... and type=0A=
> >=0A=
> > Hi Joe,=0A=
> >=0A=
> > Thank you for your comments with insights, as you said, code block of l=
ine 6026 is a better place to=0A=
> > place this new logic, as it already handles the logic I'd wanted like e=
xtracting, splitting and trimming=0A=
> > the arguments, excluding the trailing comments etc.=0A=
> >=0A=
> > By placing the logic in the new place, code duplicates are reduced.=0A=
> >=0A=
> > Here's my new code (inserted from line 6044):=0A=
> > +# check if this is an unused argument=0A=
> > +        if ($define_stmt !~ /\b$arg\b/) {=0A=
> > +                WARN("UNUSED_ARG_IN_MACRO",=0A=
> Perhaps=0A=
>                                         WARN("MACRO_ARG_UNUSED",=0A=
>                         ...=0A=
> =0A=
> to better match the others above it in the block:=0A=
> =0A=
>                                         CHK("MACRO_ARG_REUSE",=0A=
> and=0A=
>                                         CHK("MACRO_ARG_PRECEDENCE",=0A=
> =0A=
> Other than that trivial bit, seems ok.=0A=
=0A=
Sure, updated, thank you!=0A=
=0A=
+# check if this is an unused argument=0A=
+if ($define_stmt !~ /\b$arg\b/) {=0A=
+	WARN("MACRO_ARG_UNUSED",=0A=
+		"Argument '$arg' is not used in function-like macro\n" . "$herectx");=0A=
+}=0A=
=0A=
Regards,=0A=
Xining=0A=

