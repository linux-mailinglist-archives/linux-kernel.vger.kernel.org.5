Return-Path: <linux-kernel+bounces-64677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB1385415C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 03:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926B71C26F3C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2599B667;
	Wed, 14 Feb 2024 02:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="serI8PGc"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A8FB645
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 02:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707876100; cv=none; b=d64qnlSFhrZIUljifUyTUgP2rm1VaQHS/2eZJoIxTC2qMjM5xct9Md1R5iD6nTj1V9I0/PSER6yPFg/x5JxNc3P5c+LB91836k9+unPT6eW1hzOeSsWFdj5RwwnSlitg5ff+nAuwqtz3go9OCPU5luG0UDfEWMOHw/+67T90WpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707876100; c=relaxed/simple;
	bh=2bpG9c8MBxeE62uObIAttLKhwzWnUpwInveuq5ebRLw=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=b6gF+yv+arIgenVsaQZmj4SOAzg9XC5c8oopGn0OoO/ofYrBxvegUIuE6TlGJOyGfJo+4mAprfYiFsyC/rKMpfrbqH11M5FeId/TLNENtweBcAUjnklbt9dd099EYewBWPPszXzWrNCbww16vVpNxHYgjOIJGBIvkOcR8EHaqC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=serI8PGc; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240214020135epoutp02801718d4b648090cd28e181f2d8212f6~zmEKab9g72285622856epoutp02d
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 02:01:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240214020135epoutp02801718d4b648090cd28e181f2d8212f6~zmEKab9g72285622856epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707876095;
	bh=2bpG9c8MBxeE62uObIAttLKhwzWnUpwInveuq5ebRLw=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=serI8PGc00lvu2TQ/0M3sCuc3yGb56nWX5Wucgn1zvtCQzy3YqeeVn+5m40sTOtcx
	 mg6PqEIdia4kGw0GIVuUTVeXPRTtmjHPMxgUO1x0j/nPacXxjrhrK0ZrPKBhUBvEbR
	 8G7TpqrhNc98oSC1OKU5PSXxeCfFdCIvFjVvpGcE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240214020134epcas1p19221aaada68b73f9c19246de9526e2ac~zmEJvQ5dF1093610936epcas1p1e;
	Wed, 14 Feb 2024 02:01:34 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.38.242]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4TZLz22kHBz4x9Q5; Wed, 14 Feb
	2024 02:01:34 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
	epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	11.FB.19104.EFE1CC56; Wed, 14 Feb 2024 11:01:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20240214020133epcas1p35fa2e22d9b180b4c52c44f0f647dd502~zmEI7754Y2166221662epcas1p3J;
	Wed, 14 Feb 2024 02:01:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240214020133epsmtrp1f16d394532ac5c602d7c3d2eee5aa470~zmEI671la2395723957epsmtrp1-;
	Wed, 14 Feb 2024 02:01:33 +0000 (GMT)
X-AuditID: b6c32a4c-559ff70000004aa0-30-65cc1efe6145
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A9.F9.08755.DFE1CC56; Wed, 14 Feb 2024 11:01:33 +0900 (KST)
Received: from sh043lee04 (unknown [10.253.101.72]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240214020133epsmtip2f2dc1555b97a0253d6c53346bd62f874~zmEIq1thC0318203182epsmtip2z;
	Wed, 14 Feb 2024 02:01:33 +0000 (GMT)
From: =?utf-8?B?7J207Iq57Z2s?= <sh043.lee@samsung.com>
To: "'Christian Loehle'" <christian.loehle@arm.com>, "'Avri Altman'"
	<Avri.Altman@wdc.com>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <ulf.hansson@linaro.org>,
	<gregkh@linuxfoundation.org>
Cc: <grant.jung@samsung.com>, <jt77.jang@samsung.com>,
	<dh0421.hwang@samsung.com>, <junwoo80.lee@samsung.com>,
	<jangsub.yi@samsung.com>, <cw9316.lee@samsung.com>,
	<sh8267.baek@samsung.com>, <wkon.kim@samsung.com>
In-Reply-To: <94199ff4-1511-4f67-9794-b93195f8bac9@arm.com>
Subject: RE: [PATCH] mmc: sd: Add a variable to check a faulty device
Date: Wed, 14 Feb 2024 11:01:33 +0900
Message-ID: <000001da5ee9$bc1dee40$3459cac0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI2QrZr/hQwBfLmGOt++EZEApv72gJjevE2AlTbwFkCX8p+qAE5reIRsA6megA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKJsWRmVeSWpSXmKPExsWy7bCmru4/uTOpBh/+Clm8/HmVzaL/xEQW
	ixmn2lgt9l07yW7x6+96dovmxevZLDq2Tmay2PH8DLvFrr/NTBaXd81hszjyv5/R4tqZE6wW
	x9eGW2y+9I3Fgc9jzbw1jB53ru1h89g/dw27R9+WVYwenzfJebQf6GYKYIvKtslITUxJLVJI
	zUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBulZJoSwxpxQoFJBYXKyk
	b2dTlF9akqqQkV9cYquUWpCSU2BWoFecmFtcmpeul5daYmVoYGBkClSYkJ3RulegoFupYs6O
	R4wNjB2KXYycHBICJhLLFvSxdTFycQgJ7GGUOHl+DjuE84lR4syB96wQzjdGiests9lgWmYd
	mcMMkdjLKDF9718mCOcFo8Tr/otADgcHm4CZxPM7QSBxEYGrjBLvWs+AzWUWuMUosan9HjvI
	KE4Ba4mWb3dYQGxhAVeJ02fWM4PYLAKqEl+/7AJbxytgKXFz8jNGCFtQ4uTMJ2D1zALaEssW
	vmaGOElB4ufTZawgtoiAn8TGrz/YIGpEJGZ3toGdKiFwgUPi08cP7BANLhJ39r2EsoUlXh3f
	AmVLSbzsb2OHaGhmlGhr+MoC4UxglHix4BUTRJW9RHNrMxvIn8wCmhLrd+lDbOOTePe1hxUk
	LCHAK9HRJgRRrSzx8tEyqE5JiSXtt6CO9pC4vL6XbQKj4iwkv81C8tssJD/MQli2gJFlFaNU
	akFxbnpqsmGBoW5eajk8zpPzczcxgtOzls8Oxu/r/+odYmTiYDzEKMHBrCTCe2nGiVQh3pTE
	yqrUovz4otKc1OJDjKbAEJ/ILCWanA/MEHkl8YYmlgYmZkYmFsaWxmZK4rxnrpSlCgmkJ5ak
	ZqemFqQWwfQxcXBKNTBN1LonMslEM2NNeHGz5dXJ8mJ6H9yjSyXijUPKljFmn3f4W1KzRnpD
	dcu+l8o/BPsq1+/lex10u+RiIffKG/eCwxS9/W9P730RvEnkVNSuv6YL4s5tspvyULT59s/Z
	yrsPM/JzL97R4SXwd8KBOed9GbawfXmqlph0I2c1w7az/muX2Z3mC3Fk7n7hsJy7+qac2+vM
	0OT56y9M5Tuh4s7+gHHr6qpzttNlF51Sla+T//0i6F2OysdDBus1LzIsEHrczeQh/fTA5Hfu
	waeuuRa5v1TaynJK9u5a58NaeSeWh+S85Wn4nNfblFi4fPV7qYsbXrZd271p4ayV/YZ3vniI
	n2485n/6ubJssuKcmSv1lViKMxINtZiLihMBZ23DyFgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCSvO5fuTOpBp//GFi8/HmVzaL/xEQW
	ixmn2lgt9l07yW7x6+96dovmxevZLDq2Tmay2PH8DLvFrr/NTBaXd81hszjyv5/R4tqZE6wW
	x9eGW2y+9I3Fgc9jzbw1jB53ru1h89g/dw27R9+WVYwenzfJebQf6GYKYIvisklJzcksSy3S
	t0vgyph77QB7QbNExfNJ3g2MZ4S7GDk5JARMJGYdmcPcxcjFISSwm1GiYe8OZoiEpMTiRw/Z
	uhg5gGxhicOHiyFqnjFKNC5/zAISZxMwk3h+JwgkLiJwk1Hi4MSnTCAOs8AjRonfi2awQHTs
	ZJJ4N2sx2FROAWuJlm93WEBsYQFXidNn1oPFWQRUJb5+2cUGYvMKWErcnPyMEcIWlDg58wlY
	PbOAtsTTm0/h7GULX0NdqiDx8+kyVhBbRMBPYuPXH2wQNSISszvbmCcwCs9CMmoWklGzkIya
	haRlASPLKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4OjU0tzBuH3VB71DjEwcjIcY
	JTiYlUR4L804kSrEm5JYWZValB9fVJqTWnyIUZqDRUmcV/xFb4qQQHpiSWp2ampBahFMlomD
	U6qByefyNPcV6wP0rp0We/qur/ZxeAw3o33SZJ2//DdqylRygzzvTTbkndJTdUrJ88rf6yef
	GO8yv/2QbcNly2nvZ3nlTvFxD2r0Lr/wNmEl9wnr7R+lJ33b8IPnzwy7fRXsrYejnPT4viak
	Fd+K+SnUu4wnXoTxwQKt299D15aomouW1mz4zb+sfLOMWKeM4cGd7DtqjZUtK0K+Oq/cHnWK
	WcTD8Gfbd5aDjFP6D/6e/y+Y+/auYveV29dO05A+0B39v+IQZ7tq7f1V+eev9QhtPaGxfuMN
	lvDpxVOrK6Nldl92jLP3vm3uaXOzL/qKY9tcvZN3jZ817WUS+71y6a0UF70bS5Zd6z/ld+t/
	32RZZiWW4oxEQy3mouJEAMF/7rI9AwAA
X-CMS-MailID: 20240214020133epcas1p35fa2e22d9b180b4c52c44f0f647dd502
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240213051332epcas1p1f45d02dc34d1b95ea5608ab779d6b6cc
References: <CGME20240213051332epcas1p1f45d02dc34d1b95ea5608ab779d6b6cc@epcas1p1.samsung.com>
	<20240213051716.6596-1-sh043.lee@samsung.com>
	<BL0PR04MB65642D0389544F022A1D2222FC4F2@BL0PR04MB6564.namprd04.prod.outlook.com>
	<000101da5e61$f97e8cf0$ec7ba6d0$@samsung.com>
	<94199ff4-1511-4f67-9794-b93195f8bac9@arm.com>

> -----Original Message-----
> From: Christian Loehle <christian.loehle=40arm.com>
> Sent: Tuesday, February 13, 2024 10:35 PM
> To: =EC=9D=B4=EC=8A=B9=ED=9D=AC=20<sh043.lee=40samsung.com>;=20'Avri=20Al=
tman'=20<Avri.Altman=40wdc.com>;=0D=0A>=20linux-mmc=40vger.kernel.org;=20li=
nux-kernel=40vger.kernel.org;=0D=0A>=20ulf.hansson=40linaro.org;=20gregkh=
=40linuxfoundation.org=0D=0A>=20Cc:=20grant.jung=40samsung.com;=20jt77.jang=
=40samsung.com;=0D=0A>=20dh0421.hwang=40samsung.com;=20junwoo80.lee=40samsu=
ng.com;=20jangsub.yi=40samsung.com;=0D=0A>=20cw9316.lee=40samsung.com;=20sh=
8267.baek=40samsung.com;=20wkon.kim=40samsung.com=0D=0A>=20Subject:=20Re:=
=20=5BPATCH=5D=20mmc:=20sd:=20Add=20a=20variable=20to=20check=20a=20faulty=
=20device=0D=0A>=20=0D=0A>=20On=2013/02/2024=2009:49,=20=EC=9D=B4=EC=8A=B9=
=ED=9D=AC=20wrote:=0D=0A>=20>=0D=0A>=20>=0D=0A>=20>>=20-----Original=20Mess=
age-----=0D=0A>=20>>=20From:=20Avri=20Altman=20<Avri.Altman=40wdc.com>=0D=
=0A>=20>>=20Sent:=20Tuesday,=20February=2013,=202024=205:42=20PM=0D=0A>=20>=
>=20To:=20Seunghui=20Lee=20<sh043.lee=40samsung.com>;=20linux-mmc=40vger.ke=
rnel.org;=0D=0A>=20>>=20linux-kernel=40vger.kernel.org;=20ulf.hansson=40lin=
aro.org;=0D=0A>=20>>=20gregkh=40linuxfoundation.org=0D=0A>=20>>=20Cc:=20gra=
nt.jung=40samsung.com;=20jt77.jang=40samsung.com;=0D=0A>=20>>=20dh0421.hwan=
g=40samsung.com;=20junwoo80.lee=40samsung.com;=0D=0A>=20>>=20jangsub.yi=40s=
amsung.com;=20cw9316.lee=40samsung.com;=0D=0A>=20>>=20sh8267.baek=40samsung=
com;=20wkon.kim=40samsung.com=0D=0A>=20>>=20Subject:=20RE:=20=5BPATCH=5D=
=20mmc:=20sd:=20Add=20a=20variable=20to=20check=20a=20faulty=20device=0D=0A=
>=20>>=0D=0A>=20>>>=20In=20mobile=20devices,=20suspend/resume=20situations=
=20are=20frequent.=0D=0A>=20>>>=20In=20the=20case=20of=20a=20defective=20SD=
=20card=20in=20which=20initialization=20fails,=0D=0A>=20>>>=20unnecessary=
=20initialization=20time=20is=20consumed=20for=20each=20resume.=0D=0A>=20>>=
>=20A=20field=20is=20needed=20to=20check=20that=20SD=20card=20initializatio=
n=20has=20failed=20on=0D=0A>=20>>>=20the=20host.=20It=20could=20be=20used=
=20to=20remove=20unnecessary=20initialization.=0D=0A>=20>>=20I=20don't=20se=
e=20where=20you=20are=20using=20this=20new=20init_failed=20field?=0D=0A>=20=
>>=20Maybe=20instead,=20elaborate=20the=20logic=20to=20free_card:=20to=20de=
tect=20a=20broken=20sd.=0D=0A>=20>>=20e.g.=20instead=20of=20just=20if=20(=
=21oldcard),=20if=20(=21oldcard=20=7C=7C=20=21=0D=0A>=20>>=20mmc_sd_alive(h=
ost))=20or=20something.=0D=0A>=20>>=0D=0A>=20>>=20Thanks,=0D=0A>=20>>=20Avr=
i=0D=0A>=20>>=0D=0A>=20>=20Thank=20you=20for=20your=20suggestion.=0D=0A>=20=
>=20I'm=20going=20to=20use=20it=20in=20mmc_rescan=20as=20below.=0D=0A>=20>=
=0D=0A>=20>=20e.g.=0D=0A>=20>=20diff=20--git=20a/drivers/mmc/core/core.c=20=
b/drivers/mmc/core/core.c=20index=0D=0A>=20>=20a8c17b4cd737..461cd75dc7ab=
=20100644=0D=0A>=20>=20---=20a/drivers/mmc/core/core.c=0D=0A>=20>=20+++=20b=
/drivers/mmc/core/core.c=0D=0A>=20>=20=40=40=20-2210,7=20+2210,7=20=40=40=
=20void=20mmc_rescan(struct=20work_struct=20*work)=0D=0A>=20>=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20container_of(work,=20struct=20mmc_ho=
st,=20detect.work);=0D=0A>=20>=20=20=20=20=20=20=20=20=20int=20i;=0D=0A>=20=
>=0D=0A>=20>=20-=20=20=20=20=20=20=20if=20(host->rescan_disable)=0D=0A>=20>=
=20+=20=20=20=20=20=20=20if=20(host->rescan_disable=20=7C=7C=20host->init_f=
ailed)=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20return;=
=0D=0A>=20=0D=0A>=20I've=20seen=20SD=20cards=20that=20fail=20the=20first=20=
initialization=20attempt=20for=20both=0D=0A>=20'valid'=20reasons=20(e.g.=20=
weird=20insertion=20timing)=20and=20things=20like=20out-of-spec=0D=0A>=20in=
itialization=20time=20from=20the=20card,=20outright=20disabling=20these=20o=
n=20the=20first=0D=0A>=20fail=20is=20a=20bit=20too=20much=20IMO.=0D=0A>=20=
=0D=0A>=20Kind=20Regards,=0D=0A>=20Christian=0D=0A=0D=0AI=20agree=20with=20=
you.=20It's=20a=20bit=20too=20much.=0D=0AIt's=20just=20simple=20example.=0D=
=0A=0D=0AAnyway,=20It's=20difficult=20to=20distinguish=20between=20NO=20car=
d=20and=20a=20faulty=20card.=0D=0AThat's=20why=20I'd=20like=20to=20merge=20=
this.=0D=0AIt=20helps=20that=20we=20check=20if=20it's=20a=20faulty=20card=
=20or=20not=20in=20a=20dump.=0D=0A=0D=0A=0D=0A

