Return-Path: <linux-kernel+bounces-142969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF738A32B3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA3991C21F70
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58742148842;
	Fri, 12 Apr 2024 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="A8sxtXm3"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E641487D8;
	Fri, 12 Apr 2024 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712936405; cv=none; b=QSizSlUasKLeDBx1sZpR7ThkEVKm6KKw4/tyGd0/fF9Kps1mtcQv9ah9O8+2CKb3TCk2rhDy7ZVXaANYgBqT8e+jd+rGTUOiwDt5t2j0VAQWRBZ37ruFnQlZkKVDWBigRyBPOBqzVTMSRi7woHDS/xrpfebH+vFGsDpeQOpQ9PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712936405; c=relaxed/simple;
	bh=cb2yJJcD0Hbk+45aCbkWuSgX79odNGqq3CZK0GHO9GI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dhl9r4IWeGikkwy1p6GJlN4uuBFZQQAiekqYp2BKBxD2atGG4zUjoLakzfx3T+HD1EmFnZ5pEQtaJ25ueaSCeHR2TUzExywu6XzZQDDVUbvzQN7AwJjE4O3Em7JQa6mwKRjEGu1bTD1ZJ+hO0ouQhPmQPOxX2MmQRL1Mpsp/4rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=A8sxtXm3; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1712936385; x=1713541185; i=parker@finest.io;
	bh=b/AzrjodG8Ty/4WJZG+tzIEn6cxEm6dU7JqcH8NWHTI=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:
	 References;
	b=A8sxtXm3eSnkJ1AA+fY53kcs9TcsvsvBykyIkKqsvBeCrV6zyOhtGV/mpK2Bc59Z
	 yBXheMLFj8TjPMaauoBtBzfWEdwZBSPWeENO9x0KasxpFZFMYaqBpdcyS02ziancB
	 rZ6pBu49TroLH3CxM77Pfl5mMBcv4jeMrEI3bPb85F+qeT/YkWoN0YslFmgnuTd3z
	 Y5XSh5xvK6r5V0GllLf+TlmjWUL6m9kHLznFxUnPJoi8/AmP9gypESvl+1kHLihzK
	 apZ04LVq7feFPGz8pUEGjMEBYfWteJGIyRJtJFu80iHzRXRjbAZ/1eRpNqo5nCXXS
	 4FYgJXMz1bqBcaXMFA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id
 1MBmM4-1s32mT1M7g-00CDAH; Fri, 12 Apr 2024 17:39:45 +0200
Date: Fri, 12 Apr 2024 11:39:43 -0400
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Jiri
 Slaby <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-serial <linux-serial@vger.kernel.org>, Parker Newman
 <pnewman@connecttech.com>
Subject: Re: [PATCH v2 6/7] serial: exar: add CTI board and port setup
 functions
Message-ID: <20240412113943.7a2bf0c6@SWDEV2.connecttech.local>
In-Reply-To: <2024041248-enjoyable-barterer-4f01@gregkh>
References: <cover.1712863999.git.pnewman@connecttech.com>
	<ca94454e54504c1621f17f5e3933cad299f61344.1712863999.git.pnewman@connecttech.com>
	<c73b4fc3-be87-6a6d-408e-634ba915f28e@linux.intel.com>
	<20240412111926.5b4c9953@SWDEV2.connecttech.local>
	<2024041248-enjoyable-barterer-4f01@gregkh>
Organization: Connect Tech Inc.
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1SP0sy12AmEwE41YKrF1nYVxSvj0IpmMWOmGZWMpMhwGVyiEp19
 J49OIKQf7o2gWmc3980+j4o4iJCXGqDn7o2OAs7qpkhWOiULaGYRkQyPgXzhK3EGhcdak6v
 XspwIfelmdjlrVmptfZlT8ssHdU917/84ya/BG/UjyR4YQ7AKDA6VteJ3gmOlaJeCoBmT0x
 fKCqmbTaHHXEneoUJZRYw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+5fXMDEAca8=;0mzk6sFLx1VxltU3hfs50br1UTq
 bQzPeW2Lwsk+HGSQPDlrDmkVaZD0eB6cm9Io1OsNOUdcnuwvAbN2fvs1vh1gwtjRMr09wDhRb
 WbyuBzxXK5IgrUm/iHEBZLU3/x8j4muv1cHIa00Fks7gnN0d8tv2D5bGR3woyO+135u3hYYkA
 H+p6/poG/HpdKEBUZAD/cwAIgcMuFNGQ5XalEJL7lijZQErdWxOcSHSPofhVg0FS6a+Bm+Kop
 gJnCm5OQVFgoxjDQkj5f4jHX2t8DyqV5EIM/AOLoovMLecQcltvovMS/wfMgAr9W/AMIeI/sT
 H7Q91dAejh5fsE+CRNL6llQyxsbxVmYkj74ro5GQfi3jNGFn3dyeF5uwVESR3s45hHpVgMTOS
 +aBQIVIwFxeJI0INkFgDf1FDHlp4Wz7OCK+yuL6yyNmokWAfVSDvt7DpRkVvR5/PJrUtlGcRc
 AhtTUc6/rQXivucQpRFsZzAdl0VCDPk/Kh3QzGVCNc4w3CgWFgqomsHSBQc7AA1bOf1/4lQDA
 yX5xYbSNvotuhKAgIzkqrV+N1A8Yg42UM0TCJZF621fBBtngCm2ErkydITdlaVqZZJ7CEB8AB
 /Z99ctrZ4uN4eAmGaCHr/Nug0R3ELhR7mRnM26dvcNbLTzkGCrQShBMcwcB42joVixd+QIFQd
 qmT1nMIkd3yiqYyaHwqVXlxOIszX8nGgq5GCFGUI1+4fzclEXixwFFYaEcO6EJnh6J1jRsLME
 c3OiKnG4NQv1pwGKLWsgCaypHO1BjXKbTt42KOfuXuNcRWfW/k/kWo=

On Fri, 12 Apr 2024 17:28:20 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Fri, Apr 12, 2024 at 11:19:26AM -0400, Parker Newman wrote:
> > On Fri, 12 Apr 2024 13:57:01 +0300 (EEST)
> > Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
> >  =20
> > > On Thu, 11 Apr 2024, parker@finest.io wrote:
> > >  =20
> > > > From: Parker Newman <pnewman@connecttech.com>
> > > >=20
> > > > - Removed old port setup function and replaced with UART specific o=
nes
> > > > - Added board setup functions for CTI boards
> > > > - Replaced CONNECT_DEVICE macro with CTI_EXAR_DEVICE and CTI_PCI_DE=
VICE   =20
> > >=20
> > > In general, you should try to do refactoring in a preparatory patch (=
one=20
> > > refactoring thing at a time) and add new stuff in another patch in=20
> > > the series. I didn't go to figure out how much it applies to those th=
ree=20
> > > items because you likely know the answer immediately.
> > >  =20
> > > > - Moved "generic rs485" support up in the file   =20
> > >=20
> > > Please do this in a separate patch.
> > >  =20
> >=20
> > Will do.
> >  =20
> > >=20
> > > Another general level problem with your series is that it adds functi=
ons=20
> > > x, y, etc. without users, whereas the expected way of doing things wo=
uld=20
> > > be to add the functions in the change they are getting used so it's e=
asier=20
> > > to follow what's going on.
> > >=20
> > > I believe if you separate the refactoring & moving code around into o=
wn=20
> > > changes (no functional change type patches), the new stuff is much=20
> > > smaller so there is no need to split that illogically into incomplete=
=20
> > > fragments in some patches.
> > >=20
> > > --
> > >  i.
> > >  =20
> >=20
> > Thanks for the feedback, I am new to the mailing lists and am trying to=
 balance
> > what you mention above with not having giant patches.  =20
>=20
> It's a fine line, and takes a while to learn, but as a first cut, this
> was pretty good, I didn't have any major problems with the structure of
> it, so nice work.
>=20
> thanks,
>=20
> greg k-h

Thanks, I appreciate both your feedback I think I have a better handle on i=
t.
-Parker

