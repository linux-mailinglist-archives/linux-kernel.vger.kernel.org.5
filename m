Return-Path: <linux-kernel+bounces-126074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EAE8931BE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 15:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEF21B215E0
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 13:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D81144D30;
	Sun, 31 Mar 2024 13:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="eYEDm/6w"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2103.outbound.protection.outlook.com [40.92.23.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C6875813;
	Sun, 31 Mar 2024 13:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711892618; cv=fail; b=jXTGs6tRgsQUuOcCfyc1Ws46yPAL+8ik/vnAvzFZYn6uKonNZC3cG7LYIdKbpZDrnq87OOhQhDdgkyh8YL+6II8ThGB2SMDYc6GXh5W1nRmJfm2mMwUV8GGoSmKfTaVJ+pvOi/ikc/ynMrdpYVwSl48cIYTAkRcHNVZA9Y0mCCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711892618; c=relaxed/simple;
	bh=4lmyGAdIk5B0DP6g9C8WvLoajGqhoGc9PaEQdsZuGBs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=saZpzXNOi1+43qF80LUtMiC8+OQjuB4oMddt1nr62x+WHMIzgTe6MNBsgoUQfvlsCVwiDFavoaISt/pfLZwO754VpFKtL5oLLC+nz38wgRrbk/JRQps8G4zn14TdOvBFmkREIvx73AZuFSgUZQGAuSdmInG8fzdW6iQshoXJYi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=eYEDm/6w; arc=fail smtp.client-ip=40.92.23.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ojdvn99c3eZocRTMU+YJzPvznzNAE6RdgX+zZdMlOTzBuPpBEm48UDDga5wBv2FHx/03xlxBU1WXP2KuJgatOSyzKXxFxmR7zgO7GXDifwLfvMJhlHmnLP+miVoPjphVqQO75WnrC1v/E4Jh9OgVkULne2notNhkyiyWmyewRjuvzOZBKpOT3YQfolIm+6b07SFC4AaxFyDtOy4yxrJKOoQFuYMFpUrh4e+o1Lvz+7ZKvVwromfbi+Jk6t39a/3qSWjCq1QYsfQB6zIDh5fKSjkJ99Oa8p8Yj3fufarwqeF4ENI0ZPh9wk1Lqc/1fVyDq473RuGek/spopYLeCd26Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWoAE0dUeLMqDl4GmB3m5z2f21t7U0VAGxemvbR2Jj8=;
 b=YNUuwS3skBU9Up9+5J3pJKQqHbkoOvTD++lSHCP3yNwxsxvQAMlcxqcnag2+8pdYfeLRbzSvhKge7uULwLbrWcwzeqxk43uxqDBB5fXDhBV/GpBk8YnPQuF0dBTvXgJSlNNMtdZ0slO+uSKSF4eKOZ4OXLBZMslm1TZawTShJ5ggETFzUmC5tksiIpkVnOL3zcAkYwwfUmWnVvtmtnOwovVSCZ/yx2EQ3mQzmX7ERhO/WdByAsouzxqRSigbqq7UPDLKwYfSKgCYVrWwJHtwxwgBPpfq+vTfk2pMH0WyTNnZugVJ/LG9nLBD+LeV9RdVwgmZt5kde5sXrLeNQx5sRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWoAE0dUeLMqDl4GmB3m5z2f21t7U0VAGxemvbR2Jj8=;
 b=eYEDm/6wfN/zKOZ9AjARAL+9SLYOCBfL9a5P7aLrljRDQJsjDrQ5BoUMC7aAxTuPOb/nO2XJwIPZaeHLSybRVXgo4+S5LbQ9G6CDC8lrH+/YN16x/udCKzK+jddR1g9uK4+Pt2ZH36FXjaG711Pnwq3yhLssiHd+YGf4OEUriDRXVgi7aGzdkfE186bXAtu8tt05kw3Sx2y2GTXtuadwn8l0BTKwsbnUDdljDrPwM8bHxHVUFG1H/3GwcqvtjCcy/jREK1q43Pxa/eQ8ePO1fNjcxUEEIZfJDn4c2uZHrrNPo0UYRW/xM87kbwHOgReiBKXovBFZmOG/i1fhdoBdRw==
Received: from MN0PR20MB4717.namprd20.prod.outlook.com (2603:10b6:208:3cf::20)
 by BY1PR20MB7433.namprd20.prod.outlook.com (2603:10b6:a03:4b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.43; Sun, 31 Mar
 2024 13:43:33 +0000
Received: from MN0PR20MB4717.namprd20.prod.outlook.com
 ([fe80::e0a3:f058:e169:988b]) by MN0PR20MB4717.namprd20.prod.outlook.com
 ([fe80::e0a3:f058:e169:988b%4]) with mapi id 15.20.7409.042; Sun, 31 Mar 2024
 13:43:33 +0000
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
Thread-Index: AQHagLa6dUAj6irLP0SxfpZRpU9V17FM60mAgAT1lsw=
Date: Sun, 31 Mar 2024 13:43:33 +0000
Message-ID:
 <MN0PR20MB47171D2D78C8E71286E133BCF3382@MN0PR20MB4717.namprd20.prod.outlook.com>
References: <20240328022136.5789-1-21cnbao@gmail.com>
	 <20240328022136.5789-3-21cnbao@gmail.com>
 <ef2c96e40bcf777535c9ff2405e4dc5b3138b27e.camel@perches.com>
In-Reply-To: <ef2c96e40bcf777535c9ff2405e4dc5b3138b27e.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-tmn: [HQNAlrncRfkrRgud9wP9UzlVA/4FqJlc]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR20MB4717:EE_|BY1PR20MB7433:EE_
x-ms-office365-filtering-correlation-id: 953deff3-b627-4c79-6cca-08dc51888f13
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 OKZ2fJQZ2fqgrNyXQAuIHRyf2AKW2DIEn8rENlUArLEJkifF/X1A/GxvUvX5QF+MQKF+DIsptLOn24AjSpKYHKr48yh5IolLYPKBYZRleZ07G3nwhguVr+Os/6aFmsJPhdeJtoOtuZxCEn/C1Xl9ey4laqYJKmIy9XpncAlmp5qVk/1KfUsCvD4EUniosIgVL2VE01bM0WFy9KpvWH/oM8Dygi6JAP/q2KWVfmKtDxiBgQech8NEi8wqrSgXkgwsGzV5K8mSQpJi9IRraVkngld4lqurHl++fuknBS1o0+2Kk01xkI7lGgJElOsf7TLN0qBbYhiBofcMOAmUEmdn1x55dXpa3/uqftovEyBHxG2nBGEOG82AP1LuEbQy2TI8BkkJzPasYr1ehS88yxPJ3l9hETSbEhZAmaaRYzzNbNZCbxXy1rnmg+HjukCHhAnx52zw2nScQyjuaFqsNkIod9iVlED6Tu3M6LYn22y3hbBgrHijy6whJajJShQVOGkEfXAFeElWz1DpqszN7BHIgN8tlVd6uqBFytLD2ckSoFEFf3/50coIK9VW4Cr+FCpW
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?1b6HgsvSXwIS8D1rpVLE/0/uckDuw5qrPwEPrmc7oShh0DBSNv3k81duxJ?=
 =?iso-8859-1?Q?Pq1Y/TSZO/0UD0be+fnpvP5JHY6BMrriuPh3qqxtTTLmvDSIP0aIKUdhxk?=
 =?iso-8859-1?Q?Gdne3DoGw/f9pEaPUgE5T60SppE0HXmKAVAvfbHmUO0orRXtlpREZIz643?=
 =?iso-8859-1?Q?9Xkf43+uiXVZO7ekew5aw2zNTcaxI527uiRkrPMVJZ1fIcNm1pEvxa/WbV?=
 =?iso-8859-1?Q?SMtTvaXnvLNvc5Ne99G5GBkBGDEa9UBe7b6WQtgaHkT9pVYptBZ4LswI49?=
 =?iso-8859-1?Q?4lvhuDsLRi+4RbShD7GkZGaOM4B2Uo/LT2yTvjzNTtW0Gi3VAZhYdA76VU?=
 =?iso-8859-1?Q?cDJeA/g8/tfZtsK03XuTR7jyBuidZttMjW+Z416Q0jCIDVmXlnpHwhm7et?=
 =?iso-8859-1?Q?NLpsYko7G9xjV+EfCmKuajbKbnqQWZFIS+eIIn97j9eXbyf2PFQYqQ/Oqt?=
 =?iso-8859-1?Q?UO/LLWi8Q7SkpvutsNdn9e3hnB7rBClU0MXOKN719m1uY0eM+yfsoNOira?=
 =?iso-8859-1?Q?RB01BpV7sQDH8iwEusCI8JkwFgKj+lV5YjC2vEDS/KMIAa23Dq7BMOcRm2?=
 =?iso-8859-1?Q?co4JbXi1adXDkMoaDXuK1i/lKtPC2s/lg7CVHQwcwbaMplX0u22ZLEnPbE?=
 =?iso-8859-1?Q?DSK3+MaP7L1h3dcCW0uEZonQjvHK+mVop/yO2lCVmuAQ9N0jZ0HW+sfNwP?=
 =?iso-8859-1?Q?rFzvmKGuZro6a/hteZy/DSPIwsV1z+BKSQgCclbkqvcxhtifInKh+9Ypem?=
 =?iso-8859-1?Q?IrhcfETn7XCIn2W8uyMluj9vid0l0cZKnIxl/TdJtqwZy3hJip8MW+rJ9J?=
 =?iso-8859-1?Q?dDlz+YIec44k1iV0OCIgNIqkzXkdxah6pP+XeoDdu++ajmxjSqfjAig/dW?=
 =?iso-8859-1?Q?o44FJJDkWlVMrLmiLG5EJgxNzzrFdkYxjHlFeCycXLrMuxHg/nCRUMKFt3?=
 =?iso-8859-1?Q?hqyD9Akx2VNXheAyC4OrE+XGxRjWjF19Q/Q4hx3iVTtwnmJ2MFsonLxV0u?=
 =?iso-8859-1?Q?7ia1IGXdHTJgNZ8HDb6ZdQ0t5ovtrjxjQSnPgWqwmygAneA2cEel52aHa2?=
 =?iso-8859-1?Q?QwiS6/aqlQVPkL6IsGGcyi8b6sxVe062sCvJqjwbSc8ykWNgRu06vCSfvW?=
 =?iso-8859-1?Q?jOfjhZZxl/xQ9tAxVXfO9bXUCgQ6Tkol4hjdOCo7kUUDjg3rbFMWbqqjwi?=
 =?iso-8859-1?Q?0ObaPW/rUb4YIpC6rfixk6ezYEEsjqsok2noYrTdxpRzbfEfzy6fujlJ9I?=
 =?iso-8859-1?Q?Y6bYF84RUcovqwDFz7Pw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 953deff3-b627-4c79-6cca-08dc51888f13
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2024 13:43:33.7186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR20MB7433

=0A=
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
By placing the logic in the new place, code duplicates are drastically redu=
ced.=0A=
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
meter" for consistency, =0A=
please let me know if if this is the correct wording to use here.=0A=
=0A=
Thanks,=0A=
Mac.=0A=
=0A=

