Return-Path: <linux-kernel+bounces-67975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9CA8573CA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 03:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D632871A4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5479FBF7;
	Fri, 16 Feb 2024 02:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="odz6wxSQ"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485F7F9DB
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 02:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708050405; cv=none; b=iXDMcRBbcr5HTS0X69xMPuzhONnBM0rKG7ieqKItrCTBjt99qAXm5yubU606SOqY2tveDhjg+kO5NxWg/RiEtZ29p6AhqJ6S3soCbqLtrp8ATk/E1baCoJjVgHDcTLnDfo4z8FxxRzwtDQPZgpGx1T5ab+37j9CUcDwsAjfjv0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708050405; c=relaxed/simple;
	bh=KOw8V1SG9F9JmoGGLyuqP39Q4/fFFbhpxFGdw5ygUXw=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=sXXSQepaagpdbSfRCfGjvNIl7pRzOYCNRDX2BXRleTMZ18DZ8QBS9YusBCiOF6OSpzw4S1XIVRiMIllzFYpzUceKT541ScdUMjPDx0zBxI+qmF9aH9tGmCQE0MbgiB8iml9PSgf+QHQSyvyQh+Fl7OKLcena9jGeDnPdWJEz0o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=odz6wxSQ; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240216022641epoutp02e0edb3d7f0b748310b96950186db49d0~0NspKmCAS1252812528epoutp02P
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 02:26:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240216022641epoutp02e0edb3d7f0b748310b96950186db49d0~0NspKmCAS1252812528epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708050401;
	bh=KOw8V1SG9F9JmoGGLyuqP39Q4/fFFbhpxFGdw5ygUXw=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=odz6wxSQMvGJ9dZM1McmI3PCkarZ6+wxeu+z3ZjHPqxm4qLK4IKYEm4pfMKeXvsiP
	 TT6bsETJRamqmsAt80SKxPHtp+Rnf0zQccd0Nn687x4h1PJlA1/0ueYwcId2VfZWEa
	 XrU6vMeWfbydqVthzlWso9JrJztwbVg468AL0Rno=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20240216022640epcas1p3c7b0c87ac12d57d86b4dc5e519cf01fb~0NsojUgon2356123561epcas1p3V;
	Fri, 16 Feb 2024 02:26:40 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.240]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4TbbR40Y7cz4x9Py; Fri, 16 Feb
	2024 02:26:40 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
	63.9C.10025.FD7CEC56; Fri, 16 Feb 2024 11:26:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20240216022639epcas1p322277b4c24637e1d7e69e1bbd982472b~0NsnbHofq1353713537epcas1p3X;
	Fri, 16 Feb 2024 02:26:39 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240216022639epsmtrp2274bed43bcb36449fdf4300035bfc44b~0NsnaVWfb1803518035epsmtrp2B;
	Fri, 16 Feb 2024 02:26:39 +0000 (GMT)
X-AuditID: b6c32a39-9d9ff70000002729-f9-65cec7dfaeb8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	26.6E.18939.FD7CEC56; Fri, 16 Feb 2024 11:26:39 +0900 (KST)
Received: from sh043lee04 (unknown [10.253.101.72]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240216022639epsmtip250dda4693c01018645c168efa16e44c1~0NsnLlPNm1088910889epsmtip2K;
	Fri, 16 Feb 2024 02:26:39 +0000 (GMT)
From: =?utf-8?B?7J207Iq57Z2s?= <sh043.lee@samsung.com>
To: "'Greg KH'" <gregkh@linuxfoundation.org>
Cc: "'Ulf Hansson'" <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <avri.altman@wdc.com>,
	<grant.jung@samsung.com>, <jt77.jang@samsung.com>,
	<dh0421.hwang@samsung.com>, <junwoo80.lee@samsung.com>,
	<jangsub.yi@samsung.com>, <cw9316.lee@samsung.com>,
	<sh8267.baek@samsung.com>, <wkon.kim@samsung.com>, <sh043.lee@samsung.com>
In-Reply-To: <2024021531-speech-lifting-89f6@gregkh>
Subject: RE: [PATCH] mmc: sd: Add a variable to check a faulty device
Date: Fri, 16 Feb 2024 11:26:38 +0900
Message-ID: <015301da607f$92332770$b6997650$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI2QrZr/hQwBfLmGOt++EZEApv72gJjevE2AeL7/EgCVM+otwGWv7XmATRrRiUCPo8fJ6/3SnSw
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDJsWRmVeSWpSXmKPExsWy7bCmvu6D4+dSDb6tZLR4+fMqm8WMU22s
	FvuunWS3+PV3PbtF8+L1bBYdWyczWex4fobdYtffZiaLy7vmsFkc+d/PaNH0Zx+LxbUzJ1gt
	jq8Nt9h86RuLA5/HnWt72Dz2z13D7tG3ZRWjx+dNch7tB7qZAlijsm0yUhNTUosUUvOS81My
	89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgA5VUihLzCkFCgUkFhcr6dvZFOWX
	lqQqZOQXl9gqpRak5BSYFegVJ+YWl+al6+WlllgZGhgYmQIVJmRnzPh/lbFgt3LF/y/HmBoY
	dyh1MXJySAiYSKzZd5yxi5GLQ0hgB6PE60d7mSCcT4wS0/q3s8I5XXfmMMO03N+3mw0isZNR
	Ysep71BVLxglls75AlTFwcEmYCbx/E4QSIOIgI5Ex5kTLCA1zAJfmSSe713IBJLgBJo0b+Nj
	MFtYwFXi9Jn1YBtYBFQltv7fCxbnFbCU+PL9ECOELShxcuYTFhCbWUBbYtnC11AXKUj8fLqM
	FWJZlMSkO8cZIWpEJGZ3tjGDLJYQOMAh0XluCwtEg4tEW99OKFtY4tXxLewQtpTE53d72SAa
	mhkl2hq+skA4ExglXix4xQRRZS/R3NrMBvIms4CmxPpd+hDb+CTefe1hBQlLCPBKdLQJQVQr
	S7x8tAyqU1JiSfstqKM9JC6v72WbwKg4C8lvs5D8NgvJD7MQli1gZFnFKJZaUJybnlpsWGAK
	j+/k/NxNjOBkrGW5g3H62w96hxiZOBgPMUpwMCuJ8E7qPZMqxJuSWFmVWpQfX1Sak1p8iNEU
	GNoTmaVEk/OB+SCvJN7QxNLAxMzIxMLY0thMSZz3zJWyVCGB9MSS1OzU1ILUIpg+Jg5OqQam
	9srNP185l2Sa6maV9P8+dfHAFE4ey4VRf042WwWuOlK56KvdzZv7GWftbLMWj/4sxpbp7WdZ
	sDz2QGTTvPnBocfKd3e3TlbR/1/TctyjzlNYn/vxs/xTL2VXCLF/PXJgIu+iuk6jLdkSftKO
	QfXfbsddf3ja/YTI57AVR3eJxoauTFpbER4+fcuhZV+3rvT3e3TRoO35L92cqzs+dC81iq3W
	yAr8UfVD7NrL8JAzC76aSO3Naq1YFugYtjBSSd94+S35e0nF7h+WFSYY2S4IExRr+srr+Kp3
	7S9PoTj1FdoMAVP189YbJ/gXVfL0vr13+/K3B7oLX0l1/9h3nUlm0YtZS88xiTpVMMUKLqhU
	YinOSDTUYi4qTgQAQLyaBk8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsWy7bCSvO794+dSDWav4LR4+fMqm8WMU22s
	FvuunWS3+PV3PbtF8+L1bBYdWyczWex4fobdYtffZiaLy7vmsFkc+d/PaNH0Zx+LxbUzJ1gt
	jq8Nt9h86RuLA5/HnWt72Dz2z13D7tG3ZRWjx+dNch7tB7qZAlijuGxSUnMyy1KL9O0SuDLW
	Xz3LXPBFrOL06xOsDYw/BLoYOTkkBEwk7u/bzdbFyMUhJLCdUWLj2QssEAlJicWPHgIlOIBs
	YYnDh4shap4xSsz6ugksziZgJvH8ThBIuYiAjkTHmRMsIDXMAs3MEjcm9TJCNPxnklj37T7Y
	UE6gbfM2PmYCsYUFXCVOn1nPDGKzCKhKbP2/FyzOK2Ap8eX7IUYIW1Di5MwnYL3MAtoST28+
	hbOXLXzNDHGogsTPp8tYIa6Ikph05zgjRI2IxOzONuYJjMKzkIyahWTULCSjZiFpWcDIsopR
	NLWgODc9N7nAUK84Mbe4NC9dLzk/dxMjOBa1gnYwLlv/V+8QIxMH4yFGCQ5mJRHeSb1nUoV4
	UxIrq1KL8uOLSnNSiw8xSnOwKInzKud0pggJpCeWpGanphakFsFkmTg4pRqYpu6PVNngtCTj
	6vPYPwHcjxu9Nsi/K34zsXftJtanM7q9ZboPGa2dZKjc9/lr7hdJ5p9yUqVH33W3t36Sltd+
	VtCmeH3Z02niqdE5H76pe+z89VRR1X/zm8+V/383GV/n7Kp8/maFLidX0iyt61Hsb++Z2zxj
	dLqRvZOpQvTx+vuVd451Jd062qawOz72ywRz5w57nSN7wvbMq1qx6xnvDbUV1wuDUlKus1Zt
	/JFye/nroOT1YS8E6vdkLHzun/npRk/kB2Fr6eMWis5mhlJyLhKbug81zJricfOPo+jtUxP4
	dobEMOvnmOyVnWY8yVB0H0Pfses8Abmur+tkF05iM5575OE8xTvVQly2NYHTlViKMxINtZiL
	ihMBPAYoDzQDAAA=
X-CMS-MailID: 20240216022639epcas1p322277b4c24637e1d7e69e1bbd982472b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240213051332epcas1p1f45d02dc34d1b95ea5608ab779d6b6cc
References: <CGME20240213051332epcas1p1f45d02dc34d1b95ea5608ab779d6b6cc@epcas1p1.samsung.com>
	<20240213051716.6596-1-sh043.lee@samsung.com>
	<CAPDyKFrjZ4jRHAfXsvrEvezuHTxbA3SAniF8CuObyLuW=AUoeA@mail.gmail.com>
	<000001da5faa$d34e1600$79ea4200$@samsung.com>
	<2024021528-fretted-sustainer-2ebc@gregkh>
	<000001da6000$527c8650$f77592f0$@samsung.com>
	<2024021531-speech-lifting-89f6@gregkh>

> -----Original Message-----
> On Thu, Feb 15, 2024 at 08:15:45PM +0900, =EC=9D=B4=EC=8A=B9=ED=9D=AC=20w=
rote:=0D=0A>=20>=20>=20Subject:=20Re:=20=5BPATCH=5D=20mmc:=20sd:=20Add=20a=
=20variable=20to=20check=20a=20faulty=0D=0A>=20>=20>=20device=0D=0A>=20=0D=
=0A>=20Does=20this=20really=20belong=20in=20the=20body=20of=20the=20email?=
=20=20You=20might=20want=20a=20nicer=0D=0A>=20email=20client=20:)=0D=0A>=20=
=0D=0A=0D=0AIt=20was=20caused=20by=20unfamiliarity=20with=20upstream.=20Sor=
ry=20for=20the=20inconvenience.=0D=0A=0D=0A>=20>=20>=20>=20The=20variable's=
=20usage=20is=20expected=20to=20be=20used=20through=20the=20sysfs=20node=0D=
=0A>=20>=20>=20>=20in=0D=0A>=20>=20>=20the=20vendor=20module.=0D=0A>=20>=20=
>=0D=0A>=20>=20>=20What=20=22vendor=20module=22?=20=20You=20need=20to=20inc=
lude=20all=20of=20the=20needed=20code=0D=0A>=20>=20>=20here=20please.=0D=0A=
>=20>=20>=0D=0A>=20>=20>=20thanks,=0D=0A>=20>=20>=0D=0A>=20>=20>=20greg=20k=
-h=0D=0A>=20>=0D=0A>=20>=20This=20only=20purpose=20of=20this=20variable=20i=
s=20to=20identify=20a=20faulty=20card=20on=20host=0D=0A>=20side.=0D=0A>=20>=
=0D=0A>=20>=20In=20the=20past,=20we=20can=20identify=20that=20the=20card=20=
is=20inserted=20or=20not=20with=0D=0A>=20reading=20get_cd()=20function.=0D=
=0A>=20>=20But=20now,=20most=20mobile=20devices=20use=20hybrid=20type=20of=
=20SD=20card=20tray.=0D=0A>=20>=20If=20the=20tray=20is=20inserted,=20the=20=
return=20value=20of=20get_cd=20is=20the=20same=20whatever=0D=0A>=20the=20SD=
=20card=20is=20inserted=20or=20not.=0D=0A>=20>=20It=20can=20help=20us=20dia=
gonose=20the=20status=20of=20a=20SD=20card=20as=20well.=0D=0A>=20>=0D=0A>=
=20>=20Here=20is=20the=20example=20of=20usage.=0D=0A>=20>=0D=0A>=20>=20stat=
ic=20ssize_t=20status_show(struct=20device=20*dev,=0D=0A>=20>=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20struct=20device_attribute=20*attr,=
=20char=20*buf)=20=7B=0D=0A>=20>=20=20=20=20=20=20=20=20=20struct=20mmc_hos=
t=20*host=20=3D=20dev_get_drvdata(dev);=0D=0A>=20>=20=20=20=20=20=20=20=20=
=20struct=20mmc_card=20*card=20=3D=20host->card;=0D=0A>=20>=20=20=20=20=20=
=20=20=20=20char=20*status=20=3D=20NULL;=0D=0A>=20>=0D=0A>=20>=20=20=20=20=
=20=20=20=20=20if=20(card)=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20status=20=3D=20mmc_card_readonly(card)=20?=20=22PERMWP=22=20=
:=20=22NORMAL=22;=0D=0A>=20>=20=20=20=20=20=20=20=20=20else=0D=0A>=20>=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20status=20=3D=20host->init_f=
ailed=20?=20=22INITFAIL=22=20:=20=22NOCARD=22;=0D=0A>=20>=0D=0A>=20>=20=20=
=20=20=20=20=20=20=20return=20sysfs_emit(buf,=20=22%s=5Cn=22,=20status);=20=
=7D=0D=0A>=20=0D=0A>=20What=20will=20userspace=20do=20with=20this=20informa=
tion?=0D=0A>=20=0D=0A>=20And=20why=20isn't=20this=20part=20of=20the=20patch=
=20you=20submitted?=0D=0A>=20=0D=0A>=20>=20As=20for=20the=20sysfs=20node,=
=20it=20should=20keep=20the=20path=20of=20node=20with=20or=20without=0D=0A>=
=20the=20SD=20card.=0D=0A>=20>=20That's=20why=20I=20mention=20the=20vendor=
=20module.=0D=0A>=20=0D=0A>=20What=20vendor=20module?=20=20What=20do=20you=
=20mean=20by=20vendor=20module?=20=20You=20know=20we=20can't=0D=0A>=20add=
=20code=20to=20the=20kernel=20that=20is=20only=20used=20by=20code=20that=20=
is=20NOT=20in=20our=20kernel=0D=0A>=20tree.=20=20You=20don't=20want=20us=20=
to=20take=20stuff=20like=20that,=20so=20why=20is=20it=20being=0D=0A>=20prop=
osed=20here?=0D=0A>=20=0D=0A>=20confused,=0D=0A>=20=0D=0A>=20greg=20k-h=0D=
=0A=0D=0AWe=20need=20to=20inform=20users=20that=20there=20is=20a=20problem=
=20with=20the=20SD=20card.=0D=0AThere=20is=20a=20diagnostic=20tool=20in=20t=
he=20customer=20service=20app,=0D=0AAdding=20a=20sysfs=20node=20is=20under=
=20consideration=20so=20that=20the=20tool=20can=20diagnose=20the=20SD=20car=
d.=0D=0ATo=20do=20this,=20a=20node=20capable=20of=20diagnosing=20an=20SD=20=
card=20is=20needed=20regardless=20of=20whether=20an=20SD=20card=20is=20pres=
ent=20or=20not.=0D=0A=0D=0ASince=20I=20understand=20that=20the=20proposed=
=20sysfs=20node=20is=20difficult=20to=20apply=20to=20the=20kernel,=20no=20s=
eparate=20commit=20was=20posted.=0D=0ASo,=20I=20created=20this=20PR=20becau=
se=20I=20needed=20a=20variable=20to=20identify=20the=20faulty=20device.=0D=
=0A=0D=0AI=20will=20consider=20this=20part=20again.=0D=0AAnd=20if=20you=20h=
ave=20any=20other=20good=20ideas,=20please=20feel=20free=20to=20suggest=20t=
hem.=0D=0A=0D=0AThank=20you=20for=20your=20review.=0D=0ASeunghui=20Lee.=0D=
=0A=0D=0A=0D=0A

