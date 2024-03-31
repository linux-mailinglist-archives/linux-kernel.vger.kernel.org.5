Return-Path: <linux-kernel+bounces-126076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD6C8931C3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 15:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8240B214EE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 13:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2445144D28;
	Sun, 31 Mar 2024 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AQDwW/LC"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2075.outbound.protection.outlook.com [40.92.23.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E922E286AC;
	Sun, 31 Mar 2024 13:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711892805; cv=fail; b=gZHb2AiT9laLh14uX4AcUnqff89uVI6CboN84RcV9RIzu0o1ZyEdP5FJa6iEMW16WnWBBqDhzIlJ71sq7d12IyVgBzoHBgV8p+3vb+peEKLcZIjiDeNPA/VatDC0yr4YvVpVcqeVEV9JCg4yQLquHKEICJEEByqQ7u9uEZSimeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711892805; c=relaxed/simple;
	bh=GjYd+T5dL5V+LtpwpIBs+sIkgYQ8GLjgIOjoeJtPKwI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KqPTqusL6269zpFL8OC7IfvFQulU6Qv0xzItS6YTd9COHq45l+HQg+8Zh1Lzly2Vc4tPRZJ+xc0a6BkE5xzRZP1pSJ1ZisLJryC9EGklrEC76+XqGQ8R8XYO3SXfGmRKmGECSxnWbEGRDBh9mOYrBUBH6AITRcr3YLU+61KUBOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AQDwW/LC; arc=fail smtp.client-ip=40.92.23.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqtwElJDYhkweK17bI/Ub7/hWsoH9E9FCLvVgCEOL49jmNhk0pwXMl2wVaqYU7siGatXqpOdOQEazkrOyFF7U1wIcP0+mfnyjfkgCn2FezqQRNte1kvJy+epPb8ui7ndcJ8ia6ii+Mf5Aui8liOBDz7sU9dkJ7KIot3VIbs25NU7qUxJSesZHTz0y4eEuXkMJ6qoNzoI3O9M220VtTRvf2V4A6NWaSW1w+AEYqZOIYgThMDLcc26wjATdcmVgo9YItRVGP7Iznb3e89aslzkaBKFZIlKDm5Ahzd5+uo5FBAEAv2zxk41DOOdcUlFvHf04eeMZIyTSfCSsyN8ML25aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmNKTn1rqkqYekd21Wz0HxWQFKjl8z3Hqus1wLV8WDE=;
 b=DKoW9v9DKADCluz2/izUVnIbgM1IEzsr3mUVvNorfJ1g1qjATXa4VQMHKfF/1KjY/2TOijiseDGTT9GV4tqBiEcfg7Ea8qYOG9MldLwwBqHGRdPlcFHOtF0Zp0BO73r6D/2JL7g6vJqGra38Yul/EU13Cb1ALrzH52WroOSNKbo+FZI1iWy/2xzym4zlb8BfoZk1TtoKqct+fWRpBhJRXCGBHRxz3uG6xdvcqO9k/t7K7DZgJQKwn/MCqj27jeDVf4S1DadcXDqPkil0gkoMpvnQbb+6U6WsAze/emOQjUxiUbx/OT0O0EpVFn5jlULlXd4uPlQDJoFhs+Bjh7ENZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmNKTn1rqkqYekd21Wz0HxWQFKjl8z3Hqus1wLV8WDE=;
 b=AQDwW/LCX1choAYdEq3rDilTsL3UIkqVDscvpQQU2jvduXvrjTMoAvJmEQFgdmzmMwB+9BXA3nVszSkywEBID7xzSTYOIY0qD9/LIXNthtO0wWufzcQlorQl7ugE58HLpYz8R8kkoJ4Oe9oWgKqtNwf0RDyInG7XfHM65Cn3YJ8TmVQG+eIIYDNkyO8CEL8o3ft9p+SgHF0PrggL4aI/GSioit7wQw6PeHexaLtwiriCP804Vn699XUo6hn6I1oqt+f+N8158WF7EtymMdj9OQwG/vNgPfdnTvhlog3os88M+fqVhzCPMBFG49EPFQNpgzWWuMBNemQCa85YXn9bVA==
Received: from MN0PR20MB4717.namprd20.prod.outlook.com (2603:10b6:208:3cf::20)
 by BY1PR20MB7433.namprd20.prod.outlook.com (2603:10b6:a03:4b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.43; Sun, 31 Mar
 2024 13:46:41 +0000
Received: from MN0PR20MB4717.namprd20.prod.outlook.com
 ([fe80::e0a3:f058:e169:988b]) by MN0PR20MB4717.namprd20.prod.outlook.com
 ([fe80::e0a3:f058:e169:988b%4]) with mapi id 15.20.7409.042; Sun, 31 Mar 2024
 13:46:41 +0000
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
Thread-Index: AQHagLa6dUAj6irLP0SxfpZRpU9V17FM60mAgAT23VU=
Date: Sun, 31 Mar 2024 13:46:41 +0000
Message-ID:
 <MN0PR20MB4717810B82175CC594A9F285F3382@MN0PR20MB4717.namprd20.prod.outlook.com>
References: <20240328022136.5789-1-21cnbao@gmail.com>
	 <20240328022136.5789-3-21cnbao@gmail.com>
 <ef2c96e40bcf777535c9ff2405e4dc5b3138b27e.camel@perches.com>
In-Reply-To: <ef2c96e40bcf777535c9ff2405e4dc5b3138b27e.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-tmn: [n82rk41Zo/hu9sYBDkpmvJ9h7F4SDJ/q]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR20MB4717:EE_|BY1PR20MB7433:EE_
x-ms-office365-filtering-correlation-id: a879ec86-8d8a-4926-150b-08dc5188fecf
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 vqHEEqmXOWPrf2d54XD7m+2i5uLHiNp1Y0BnJszZQ4gcOSuXgnmKnfZMvUZO82xPIF1kZLMCJP0L8H5kEQUnySvD+54qHb97ncTGcUWAM5a36QUbwYsi3q4txNb7e3NW651pQs1XiVlAl6MYODgAsEsvXmHaKrpVgcPvmrmRki+S4lq9LsXbjpUWlPfTs1i9TZBXw9CoZHIFmoLL9Svd4lWjmBtddsnDO+1Q6JIOL0U4C9J6rW7AkjCvGdBH6qIGJhy86gRg9doY779y7KTDbaroOrHD/zVxMhLn/c9G59os66SGEllUiVjrI/UiooLnyJkHuGDmbol4FBESLowBJUo4oboEUk3uCkAA0itaFVMwt7Cxdj5NifjWjeqSsBa1P9Ch1VlRSbW9L5XKmTo234IFlpYCmBlWm2AdNgfix9IyEt+j1SieddqnePg/h8eg4GowmE+AH9nZ3IaFSr8BFIfdz/uSEAGM5r5D9sG/hUCON0mhILdCQwWQ1Y4EuFu8dZdWI1APYdsq+QcoXm07WBFTcaJPWi0AYoigy9YjFkprR0T1gaWshTN1wEch0Evk
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?QCIc/IWPFXz/FJztQbQkytyzLEdVgne5uEZTR2OxYiRWDRX87V+88EsLSN?=
 =?iso-8859-1?Q?XPo7/68gq7oSi6wWNMwFDosL3h1xVRdgB22HgkgtyH8LQkpoIj7Cd2NJxd?=
 =?iso-8859-1?Q?bcCAJWTFaThArnB9e9zS/09+EcUReYw/e0VkXelcYwk8scFDwUfq7cnwHX?=
 =?iso-8859-1?Q?67eSkHF9ubtNZWTs0xUZOx2s4kwBWxzY2SzYIZjqTG/XQYRWRx1JtXbZ0c?=
 =?iso-8859-1?Q?gUquKarY0NumJEvYPWhIhNoLUqa/LV4mGwK0wuDDBxne3JiCWDOWNj3rTo?=
 =?iso-8859-1?Q?IJlBzsmUJ0ozXBELHAI4E//LlI44gGqKJxBThkGFmyLbJhVYI/qEuPsbM5?=
 =?iso-8859-1?Q?A5Arnvm1yk0Eqq0YyAUv6f0CJRWRBQkFqK90uogBRf7dqtLalVUtqTnjHA?=
 =?iso-8859-1?Q?p+4Qk9UFdDw9gnv1oM5Y1FMUs641bv7uF9N/yyld4c4RKr4lX4/CKXIhBO?=
 =?iso-8859-1?Q?yDGH96NCM9sGBy4ORnlium2tw8MRQptfmK7zDhnOvoqOWoNv/tiyq9ogku?=
 =?iso-8859-1?Q?NebUXXts9cv4QxFojadXM5b8zYdSE74X8Jk6ltT9llaaDcJPerCysa67zo?=
 =?iso-8859-1?Q?QgGg948FXK8Ae70A/2P5YWcnvEdtHUh9Wx65VIat+dtP0CVtR735qUCW+n?=
 =?iso-8859-1?Q?L1iXvnjKhz9/NdqvYEhLOCkOjT68HU40c73sRmOaGnt4YJDViIdbWDvZCG?=
 =?iso-8859-1?Q?RY2Jo64kkfrNROFjwqBt59Sp0url80Wx5WowHOLoxkWCEIz22tf10uCXQ3?=
 =?iso-8859-1?Q?tefLvuy5FurydJ5wwlwS8/eZA7BOI8taN6KfTEQIz7Q3aIVC3eXsUX9fhd?=
 =?iso-8859-1?Q?MKMlUrIW75vj8GOmkt2xEms9H5q7lft9+t3D8PS/XHuQiqRxWpKWVwWZH8?=
 =?iso-8859-1?Q?TRfvTSVDMCV/6p0mHkz8hkjLWCQPTpBBaEz08P3R9hvGaiB4V7h64GdBal?=
 =?iso-8859-1?Q?zLCRkKm7PdREoeAF4wN97svh0U0vDLpeK0J3vUpYM52igUj47pM7erAg7m?=
 =?iso-8859-1?Q?jHupohS90A/jMBDwC3eq142biOcRRoaFlNs0M+AglNxZg0WMifpKY9vEZZ?=
 =?iso-8859-1?Q?W+oi13R19F8EE27rYo/bikoD7i58jgXgLMYowDvowrgyHu82YaKPdysVZT?=
 =?iso-8859-1?Q?kZQPSMRBEjqHYeUPI0j6fToV1Nk3xeeOvKC/vopKSZdvdytRkBXSvFB6Ee?=
 =?iso-8859-1?Q?xORAmeIjETJJpMrrZpC/y/llUmfrm3sry3D05hR4JVEpzVxTjx52jyl59m?=
 =?iso-8859-1?Q?ciLn72l7ezLBCHOZFB8A=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a879ec86-8d8a-4926-150b-08dc5188fecf
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2024 13:46:41.2138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR20MB7433

> On Thu, 2024-03-28 at 15:21 +1300, Barry Song wrote:=0A=
> > From: Xining Xu <mac.xxn@outlook.com>=0A=
> >=0A=
> > If function-like macros do not utilize a parameter, it might result in =
a=0A=
> > build warning.  In our coding style guidelines, we advocate for utilizi=
ng=0A=
> > static inline functions to replace such macros.  This patch verifies=0A=
> > compliance with the new rule.=0A=
> []=0A=
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl=0A=
> []=0A=
> > @@ -6109,6 +6109,36 @@ sub process {=0A=
> >                                WARN("TRAILING_SEMICOLON",=0A=
> >                                     "macros should not use a trailing s=
emicolon\n" . "$herectx");=0A=
> >                        }=0A=
> > +=0A=
> > +                     # match "\s*" rather than "\s+" after the balance=
d parens, as macro definition with arguments=0A=
> > +                     # is not required to have whitespace after argume=
nts=0A=
> > +                     if ($dstat =3D~ /^\+\s*#\s*define\s+$Ident$balanc=
ed_parens\s*(\S+.*)(\/[\/*].*)?/) {=0A=
> =0A=
> I think '(\/[\/*].*)?' doesn't do what you expect=0A=
> perhaps '(\/[\/\*].*)?'=0A=
> though I don't know why this should be capture group=0A=
=0A=
I'd wanted to capture the comment to handle a case where a unused param hap=
pens to appears in a comment=0A=
=0A=
> =0A=
> > +                             my $params =3D $1 || "";=0A=
> =0A=
> =0A=
> > +                             my $body =3D $2 || "";=0A=
> =0A=
> Should never get the || "" as the 2nd capture group is not optional=0A=
> =0A=
> > +=0A=
> > +                         # get the individual params=0A=
> > +                             $params =3D~ tr/()//d;=0A=
> > +                             # remove leading and trailing whitespace=
=0A=
> > +                             $params =3D~ s/^\s+|\s+$//g;=0A=
> > +=0A=
> > +                             $ctx =3D~ s/\n*$//;=0A=
> > +                             my $cnt =3D statement_rawlines($ctx);=0A=
> > +                             my $herectx =3D get_stat_here($linenr, $c=
nt, $here);=0A=
> > +=0A=
> > +                             if ($params ne "") {=0A=
> =0A=
> probably unnecessary=0A=
> =0A=
> > +                                     my @paramList =3D split /,\s*/, $=
params;=0A=
> =0A=
> please use split() with parentheses=0A=
> =0A=
> > +                                     foreach my $param(@paramList) {=
=0A=
> =0A=
> maybe=0A=
>                                 foreach my $param (split(/,/, $params) {=
=0A=
>                                         $param =3D trim($param);=0A=
>                                         next if ($param =3D~ /\.\.\.$/);=
=0A=
> > +                                             if ($param =3D~ /\.\.\.$/=
) {=0A=
> > +                                                     # if the param na=
me ends with "...", skip the check=0A=
> > +                                                     next;=0A=
> > +                                             }=0A=
> > +                                             if ($body !~ /\b$param\b/=
) {=0A=
> > +                                                     WARN("UNUSED_PARA=
M_IN_MACRO",=0A=
> > +                                                             "Paramete=
r '$param' is not used in function-like macro\n" . "$herectx");=0A=
> > +                                             }=0A=
> > +                                     }=0A=
> It seems this logic is a bit redundant to existing=0A=
> code and might be better added in the block that starts=0A=
> =0A=
> (line 6026)=0A=
> # check if any macro arguments are reused (ignore '...' and 'type')=0A=
> =0A=
> as that already does each param in a #define and=0A=
> ignores ... and type=0A=
=0A=
Hi Joe,=0A=
=0A=
Thank you for your comments with insights, as you said, code block of line =
6026 is a better place to =0A=
place this new logic, as it already handles the logic I'd wanted like extra=
cting, splitting and trimming =0A=
the arguments, excluding the trailing comments etc.=0A=
=0A=
By placing the logic in the new place, code duplicates are reduced.=0A=
=0A=
Here's my new code (inserted from line 6044):=0A=
+# check if this is an unused argument=0A=
+        if ($define_stmt !~ /\b$arg\b/) {=0A=
+                WARN("UNUSED_ARG_IN_MACRO",=0A=
+                        "Argument '$arg' is not used in function-like macr=
o\n" . "$herectx");=0A=
+        }=0A=
+}=0A=
=0A=
Please note that I use the wording of "arg/argument" instead of "param/para=
meter" for consistency, please let me know if if this is the =0A=
correct wording to use here.=0A=
=0A=
=0A=
Thanks,=0A=
Mac.=0A=
=0A=

