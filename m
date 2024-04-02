Return-Path: <linux-kernel+bounces-128217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEFF8957C7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A27E9285CE7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590E412FB01;
	Tue,  2 Apr 2024 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jjub1QkV"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2104.outbound.protection.outlook.com [40.92.44.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A68112BF22;
	Tue,  2 Apr 2024 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.44.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712070359; cv=fail; b=pzoRxqPuKx1RM+1fd8rpg1HMQpd3SZDuxELWN5nv7GVNKVSSxzMPLHGCIHhY2M5xfocBLCVlk/7NLaEy6GROI/XUHnfqRd6meNU/tz/+4KXUbnFsfXqjKGlA+w/20tcvyVF02vOfeXEgR2ulGH6iDnW7+Af8APhvvGKJSkgLVzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712070359; c=relaxed/simple;
	bh=nqPdktzCB7I8uk8mJnZx/Fi1rCAFXIJfxl0JzMmen3k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AuptDIsQnQYz7WHGjsee+OWvvi/+jbKu6IgLHsKITD6tk/hUdqDWZxqE386x25WYQYKpHpvctd2Vf8IUGVQQr7Jo8VdQDoJTAdxB19D9Bc7YTzglOyDm0RjPBJYWeSGiP9r2WWm4KvwhP9EIk+isHg1uj3gYFayX0+TFXkYDDYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jjub1QkV; arc=fail smtp.client-ip=40.92.44.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPMOzuCpt3N/Rq3KoAs2EBB/vHw0vH/6p5EIIikNSlMaT/7kmyjshgFUKGLkU7E+rRfv4d/sKcpgKTmnaEx9yBYczSfe8Bl2YIrwZwmrtwVKVMAPcqQB+MlK3GZJdb9ewKxeuIAsvh8zA42Pp2Vm2KTy+9iiEkLSroK9DpHxUE5HbIVSxMNkmgDR/V68//px2OzIrlj1RMdONJubS6q41gM7w5H4ot8iRsArutjF9eTz4iCCaP0SwXmJMYJQNWHitUnT2sm3W1GG2HPCqmuEqRVequHLJxcV5hUxfMvUV+QdTZ6EmX4GwMuEqx7ZHMcmr7t8zz5HeoLKuBfkC3jC0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngGHFfGwhXmpY83BmsTe59Vw/npZm98tyGuiiKBn7gY=;
 b=T66PkyrwsDXIrgw5vh0j9ThJ+rp6lmEUjlTm7KifmLl1/K2No5Rgz4vhHvbGp0WdqMELZHyYXCzH1/l3VpRi5+3idLkI48ocGdu6fWzEkoJQcJYbCFHaCpl9vC+Cj+hD7LZRuip6C4UxmQNtzG0lB6CgYASiX+FAckrnQ0tibFiAbC4scm8NkXRjHqiohdD2rU6YMBqHh8aeTWG/JIqL3nv7Jjo89pzdrcVcFG+TCcpDXOzbyaTrkaDw8ZOM70TqvcPXMBvJxPeB2RLp/W1Rmhj61wzTahtRjtgsZSxmB1P/Y6/Z4QMITCTYiI8SQE5oABfo8Rtjsgsj5UqloBI1vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngGHFfGwhXmpY83BmsTe59Vw/npZm98tyGuiiKBn7gY=;
 b=jjub1QkV1c2+/4dJc+EcAUJegWPLJBWI4jzTL0SIBkM7kDoe7om1z0n1ZkCQ7YRkOyagGvo1MFt6KQbio951u/XKnkDNF6pIr4O1vWl8WeNsONQdtOd6Rz7PN+2azgHlGm7gdVn6Y81ev8b5nSccP9vzcLhFbPrPeK31gbfXCb/L5lePtbsz4PzvkQr6jGQ+nF4f4WUcC5cJuYTWlLNHPJAgxI2IqU+FrUVMxlJ3v1xRzi7lmM2kI6cdNZhgOeXoMhYMGOUIVGMmJONU1btS/4iMN0mq7zJlVd2vWqw3ZFz8BsqLIU9x2FWzAhebGCaqqnFA4Etk70muG2cktLuC8w==
Received: from MN0PR20MB4717.namprd20.prod.outlook.com (2603:10b6:208:3cf::20)
 by SJ1PR20MB4788.namprd20.prod.outlook.com (2603:10b6:a03:459::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 15:05:51 +0000
Received: from MN0PR20MB4717.namprd20.prod.outlook.com
 ([fe80::e0a3:f058:e169:988b]) by MN0PR20MB4717.namprd20.prod.outlook.com
 ([fe80::e0a3:f058:e169:988b%4]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 15:05:51 +0000
From: Mac Xu <mac.xxn@outlook.com>
To: Joe Perches <joe@perches.com>, Barry Song <21cnbao@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"workflows@vger.kernel.org" <workflows@vger.kernel.org>
CC: "apw@canonical.com" <apw@canonical.com>, "broonie@kernel.org"
	<broonie@kernel.org>, "chenhuacai@loongson.cn" <chenhuacai@loongson.cn>,
	"chris@zankel.net" <chris@zankel.net>, "corbet@lwn.net" <corbet@lwn.net>,
	"dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux@roeck-us.net" <linux@roeck-us.net>, "lukas.bulwahn@gmail.com"
	<lukas.bulwahn@gmail.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
	"v-songbaohua@oppo.com" <v-songbaohua@oppo.com>, Max Filippov
	<jcmvbkbc@gmail.com>, Jeff Johnson <quic_jjohnson@quicinc.com>, Charlemagne
 Lasse <charlemagnelasse@gmail.com>
Subject: Re: [PATCH v5 2/2] scripts: checkpatch: check unused parameters for
 function-like macro
Thread-Topic: [PATCH v5 2/2] scripts: checkpatch: check unused parameters for
 function-like macro
Thread-Index: AQHag9MBE6nuZEX6x0OitxYUtdLwcLFSs1aAgAFq0i6AABdXAIAA3lZU
Date: Tue, 2 Apr 2024 15:05:51 +0000
Message-ID:
 <MN0PR20MB47170F8BDF17A5B9914AC610F33E2@MN0PR20MB4717.namprd20.prod.outlook.com>
References: <20240401012120.6052-1-21cnbao@gmail.com>
	 <20240401012120.6052-3-21cnbao@gmail.com>
	 <f5bb12d8602a03d28b2a8aeaffd8f74f001d692d.camel@perches.com>
	 <MN0PR20MB471708D419907FFAF1DB0FC2F33E2@MN0PR20MB4717.namprd20.prod.outlook.com>
 <3ea68e8fc46332d45e2af0d8de938628445b6691.camel@perches.com>
In-Reply-To: <3ea68e8fc46332d45e2af0d8de938628445b6691.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-tmn: [U2M8j3arNbz5NBPmPg9APEnnaeB46ORM]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR20MB4717:EE_|SJ1PR20MB4788:EE_
x-ms-office365-filtering-correlation-id: e158c523-79e6-4b0e-2cd7-08dc532662ca
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 FSzcqxX1xDL+R8hoZYt9SrpvJpO0M9Jxgk5PNhMKqszBYAZWbV7SOZhpy/+VKJZe8Mut0tM88dL9kaZP1fIP+hrM0Dar59PrPV7FDq/F80UiLkYm9M7VezrbsUAwL/knpbEClHur55urmMcTkBY0Hv2Agyh+x5zPTkHIbAR35l/RnzLBsaPJtoeURX2jhDt+h3oHLr1wN2ngLkv5QINRSKkK4hYC/5q/upwRwQqtsDWiqUj6rDnvb6orLdiVK9lskBc1+Tfv+sFJ6fux+uL7/w7ABv+YwQavAIXbBJWrtSBPyNzkoMknMh/jb1J1Dg4/neRznmnydy07sZ6A9qitHOnAKlf091/2v4TkbOLaSZZF1Nqnr1rk1tu9ReeFeeRi3BsfnZI+nefbCWQ+CO2HoVXREMMtKm+c8bOOwoZQ6bDnZPdR0DyW2hd3BzWv41mDG2kh7550jBZGGBHhQNj0KkbCthJlwRWmbsDyzb0k39sY8cThPt7Heb1UgXfaUAjxJMpU2m80aB+LLSLK06covtQCsTDkK8Drq+0OXXxtYIsHdZrY3nMhK4mUADgDAFeiRsHyEc4D8f4r16mGLWV/Z4SOfv4ZP6sRe4D1Utic+vijm4AFxnJ3HBPDb7CB4xNL0TX1Z/zQhTQUCEsFZwqx68wzQJsjnXuK9V/P9JCIi9Q=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+5ekHNDnVBZPoIcJloAJ+5u4+YA3ZXJA27LpKSdtLJKv4KJ807TSeI7All?=
 =?iso-8859-1?Q?Am9WmWtQCkjvAFX3xQRyRXUZ/d8ZKU/a3IKSB+Gp6sRvVLTZGttkvQsTe0?=
 =?iso-8859-1?Q?hOp3Au9kmEmDPS9IvWn6lhau+UOOmoTfceZr4X1RyAavZOWjcq9HcaWSwG?=
 =?iso-8859-1?Q?RCbLqJEE4vlFsT+d7CFlJNCDbxKWWo4le99252/VIwcK4uSsA1uY/YZdht?=
 =?iso-8859-1?Q?pVCVWYBto8oAZYqLeX4RX1TRlOEgq+OAQqOtM/eS3T1e2c17JZisBkQcto?=
 =?iso-8859-1?Q?FJSJh0FevPCbv2qicPn0V4NuFEWjA4hOUrlI9DN+8YPDhJpD82h5GA2Vie?=
 =?iso-8859-1?Q?WS1s9lxMrr1EqBZkSedXJ6a42U5yOFiwlCtwIYGVm99I68f+mZkQHsMqlL?=
 =?iso-8859-1?Q?r4oIWE82P2NpFgPpnKkZtMVWnJ2JxFVRPJGBr0EdxI1ADRvEsdLOLyFIPn?=
 =?iso-8859-1?Q?Xawh8n9MLKQM+b1Iq9ji205bdFuZR5/pXtIcUwVXbdA4bwxF1Ct3XJTyfW?=
 =?iso-8859-1?Q?s/wmks2V+c6Vstf662K8SZCEHJcx3o2reYdM3uzA5krHWtaivolRr2Hmo6?=
 =?iso-8859-1?Q?DTtg8P5wGl5AYCCjwnt4zEpYql9egXrD44880zhqHwQHxacn5iS3Xxw0Kb?=
 =?iso-8859-1?Q?DGfbcAsbvntdDYwFKG4Xbhu5OW2i0DeSzOiNRKRZ+/m3K1nOIccglcUz3M?=
 =?iso-8859-1?Q?tdPTf1pCDjQ6pB3v6vM1SuiSXYF3UylQ0Nn+IOPVomEZMrjN19z7/CzY26?=
 =?iso-8859-1?Q?+/Y2CM7TdlLJVmvbEDz49F73CrsxalpGsRRenIuq0itOC9LwRK9j/CQ+fU?=
 =?iso-8859-1?Q?2phpVkZOBfjjNwwR0XfvIQ7oEEvUv3nLyRc36DRYB5GIXTt7tR9FVN9kNC?=
 =?iso-8859-1?Q?RT3XX/MiVp6qMNlg0MEWtTv14YZJsQ7cm+kAdutl6y8/ExiJKeoi5BPiCA?=
 =?iso-8859-1?Q?12d6VusH+/mR11a2DE9hZrVxjrDwSHvo+Sa7vpnsKihJ4Xu49KcgSl7P7p?=
 =?iso-8859-1?Q?X0J0ygbyMST0aNa5G8WEmPlze0thZCFkTqd1Sc2mZlzWUvQIznlHqZEMTv?=
 =?iso-8859-1?Q?Bq7BEqCYFD9W/QUG0jAD3aw7ICPIUnJim9tAto2NbstUN0L1fFijhbf0/p?=
 =?iso-8859-1?Q?vhQDGsIrGo/e20ix3UpB2wuOs9PI3XbzW4HQhc2g8HTaJ4YdrgUs/3Lv3e?=
 =?iso-8859-1?Q?WhkV/P/Zba2wBkXGpO1ifR9vBHWrI8rdD07cqtE6kkcTjTI4Xlb786fJia?=
 =?iso-8859-1?Q?W9Kh+G9XWlZmAAcg4qVQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e158c523-79e6-4b0e-2cd7-08dc532662ca
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 15:05:51.0977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR20MB4788

=0A=
=0A=
> On Tue, 2024-04-02 at 00:16 +0000, Mac Xu wrote:=0A=
> > > On Mon, 2024-04-01 at 14:21 +1300, Barry Song wrote:=0A=
> > > > From: Xining Xu <mac.xxn@outlook.com>=0A=
> > > >=0A=
> > > > If function-like macros do not utilize a parameter, it might result=
 in a=0A=
> > > > build warning.  In our coding style guidelines, we advocate for uti=
lizing=0A=
> > > > static inline functions to replace such macros.  This patch verifie=
s=0A=
> > > > compliance with the new rule.=0A=
> > > >=0A=
> > > > For a macro such as the one below,=0A=
> > > >=0A=
> > > >  #define test(a) do { } while (0)=0A=
> > > >=0A=
> > > > The test result is as follows.=0A=
> > > >=0A=
> > > >  ERROR: Parameter 'a' is not used in function-like macro, please us=
e static=0A=
> > > >  inline instead=0A=
> > > >  #21: FILE: mm/init-mm.c:20:=0A=
> > > >  +#define test(a) do { } while (0)=0A=
> > >=0A=
> > > This is no longer true.=0A=
> > > Please update the ERROR->WARN and message as below=0A=
> > >=0A=
> > > Ideally, this would have an update to=0A=
> > > Documentation/dev-tools/checkpatch.rst=0A=
> > >=0A=
> > > to describe the new --verbose message type=0A=
> >=0A=
> > Hi Joe,=0A=
> >=0A=
> > Thank you for the comments, here's the code:=0A=
> >=0A=
> > +# check if this is an unused argument=0A=
> > +if ($define_stmt !~ /\b$arg\b/) {=0A=
> > +     WARN("MACRO_ARG_UNUSED",=0A=
> > +             "Argument '$arg' is not used in function-like macro\n" . =
"$herectx");=0A=
> > +}=0A=
> >=0A=
> > and here's the document for it which is inserted into the "Macros, Attr=
ibutes and=0A=
> > Symbols" section of checkpatch.rst starting from line 909:=0A=
> > +=0A=
> > +  **MACRO_ARG_UNUSED**=0A=
> > +    If function-like macros do not utilize a parameter, it might resul=
t=0A=
> > +    in a build warning. We advocate for utilizing static inline functi=
ons=0A=
> > +    to replace such macros.=0A=
> > +    For example, for a macro as below::=0A=
> > +=0A=
> > +      #define test(a) do { } while (0)=0A=
> > +=0A=
> > +    there would be a warning as below::=0A=
> > +=0A=
> > +      WARNING: Parameter 'a' is not used in function-like macro, pleas=
e use=0A=
> > +      static inline instead.=0A=
> >=0A=
> > Please let me know if the document needs further re-wording to make it =
helpful enough=0A=
> > to the readers.=0A=
> =0A=
> Hi again Xining.=0A=
> =0A=
> Thanks.=0A=
> =0A=
> That looks good but it doesn't match the script output=0A=
> which doesn't use ", please use static inline instead."=0A=
> (and I believe the script should not output that too)=0A=
> =0A=
> Another good thing would be to add a line like:=0A=
> =0A=
>         See: https://www.kernel.org/doc/html/latest/process/coding-style.=
html#macros-enums-and-rtl=0A=
> =0A=
> For example, from: checkpatch.rst=0A=
> =0A=
>   **ALLOC_SIZEOF_STRUCT**=0A=
>     The allocation style is bad.  In general for family of=0A=
>     allocation functions using sizeof() to get memory size,=0A=
>     constructs like::=0A=
> =0A=
>       p =3D alloc(sizeof(struct foo), ...)=0A=
> =0A=
>     should be::=0A=
> =0A=
>       p =3D alloc(sizeof(*p), ...)=0A=
> =0A=
>     See: https://www.kernel.org/doc/html/latest/process/coding-style.html=
#allocating-memory=0A=
> =0A=
> =0A=
=0A=
Hi again Joe,=0A=
=0A=
Thanks again for the detailed comments.=0A=
=0A=
Here's the code (which keeps unchanged):=0A=
+# check if this is an unused argument=0A=
+if ($define_stmt !~ /\b$arg\b/) {=0A=
+  WARN("MACRO_ARG_UNUSED",=0A=
+    "Argument '$arg' is not used in function-like macro\n" . "$herectx");=
=0A=
+}=0A=
=0A=
And here's the updated document, which drops the ", please use static inlin=
e instead" from the=0A=
warning message, and adds a link at the end of this document block:=0A=
+=0A=
+  **MACRO_ARG_UNUSED**=0A=
+    If function-like macros do not utilize a parameter, it might result=0A=
+    in a build warning. We advocate for utilizing static inline functions=
=0A=
+    to replace such macros.=0A=
+    For example, for a macro such as the one below::=0A=
+=0A=
+      #define test(a) do { } while (0)=0A=
+=0A=
+    there would be a warning like below::=0A=
+=0A=
+      WARNING: Parameter 'a' is not used in function-like macro.=0A=
+=0A=
+    See: https://www.kernel.org/doc/html/latest/process/coding-style.html#=
macros-enums-and-rtl=0A=
=0A=
=0A=
Regards,=0A=
Xining.=0A=
=0A=
=0A=

