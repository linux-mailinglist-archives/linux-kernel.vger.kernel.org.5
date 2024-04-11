Return-Path: <linux-kernel+bounces-139744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E558A072A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F93FB242FD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220E64F5FE;
	Thu, 11 Apr 2024 04:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="NJT1x/+d"
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460575CBD;
	Thu, 11 Apr 2024 04:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712810017; cv=none; b=NDy9jEYRDpax8xudJoQW7wBVJlbsk4nO3zaZ/v/0YLln0ttq3waiG5FWpMw/XaEletxTCvBVE9CFkP6X/PDFzfg/JeMyhSfemFyr2rI9RfCU8D3Wf0TcJcQZrtnLYQpzguyMddDrgt1Wp+IE+JZoFJ+GruNuw743DM8vWQc/RSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712810017; c=relaxed/simple;
	bh=9X+PjMjMteDeHZkxEoky+iWM5pNEjgeb4ckxulg6FnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEXRz9Sv2pE0xN/J1JPTVR+qRQ0oeCW7+ysmKuWX5davJt3d+k2nOXLuUMXqgrJLB+4ZiP/cgJvZsy+UznEpBXhZt/5wVhMNHeMtg1Qx/WoFR6etyevFF2ypSUe4Tc4D5pCogGbusrG+wbxWA73TZIGDWDebfR6xsdSKXQEvq3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=NJT1x/+d; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0xy0RSu0FBM75EE/MzdLyTdZbtB79ssgCE2mlIY1v5s=; b=NJT1x/+dzc3HpsTSEkzjqdrf0h
	4cRu0nFH6tl2xw/kg+v6DQO7JLtOQSZD2MO+YWOqL70Bl56AV+jLtDGORb8WxQYthz4pWVxgpGnEb
	AbFXL0MTZsjRF/gz3zcrZiPcuJeu0sqEK52x14LotS0FcBOOv39h2+ku0RsRuFP97+YLHuv0caw5G
	wMp7Eq19dQqc4G4Khdqa266GRALYnyhlEr53FEwr9JwOT0/kXpdOcmRTp7yFMmptQ++a9VWgHbs9I
	NynjYGiChAafBRbkONZNLjd3S5GT6UOeU6HGuxugFIGfJMRBAbHQZL+4sItp3W+W/+ceSEbKk76O7
	TlyWsaiA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <kibi@debian.org>)
	id 1rum7u-001Xyy-9X; Thu, 11 Apr 2024 04:33:30 +0000
Date: Thu, 11 Apr 2024 06:33:27 +0200
From: Cyril Brulebois <kibi@debian.org>
To: James Bottomley <jejb@linux.ibm.com>
Cc: regressions@lists.linux.dev, stable@vger.kernel.org,
	Mike Christie <michael.christie@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>, gregkh@linuxfoundation.org,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>,
	John Garry <john.g.garry@oracle.com>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Diederik de Haas <didi.debian@cknow.org>,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: [REGRESSION] Loss of some SMART information in v6.1.81
Message-ID: <20240411043327.m5unlpweoslnzzce@mraw.org>
Organization: Debian
References: <20240410193207.qnb75osxuk4ovvm6@mraw.org>
 <0655cea93e52928d3e4a12b4fe2d2a4375492ed3.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x225b5f4ap2p7arx"
Content-Disposition: inline
In-Reply-To: <0655cea93e52928d3e4a12b4fe2d2a4375492ed3.camel@linux.ibm.com>
X-Debian-User: kibi


--x225b5f4ap2p7arx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

James Bottomley <jejb@linux.ibm.com> (2024-04-10):
> This is a different manifestation of the same bug in stable that was
> introduced by a backport of scsi_execute_cmd.  The proposed fix for the
> domain validation problem here will also sort out this problem:
>=20
> https://lore.kernel.org/linux-scsi/yq1frvvpymp.fsf@ca-mkp.ca.oracle.com/

Thanks for the pointer! I've just confirmed this, and I'll follow up
there.


Cheers,
--=20
Cyril Brulebois (kibi@debian.org)            <https://debamax.com/>
D-I release manager -- Release team member -- Freelance Consultant

--x225b5f4ap2p7arx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEtg6/KYRFPHDXTPR4/5FK8MKzVSAFAmYXaBUACgkQ/5FK8MKz
VSD9xg/9GEc++o6wJulDZVizBrO3tZpCsV9wW7+fEFJd7Lb2Wp3KDhubYoYI1Nmt
tct6p0VsUU0RZ0rmd0tq4HfF+DpkL/1xN7AG024BJJxjn5ut6j253y/nfA4YIUZc
KwQQ3IEU+NlkKUh510RV8aJ8C4Zu8IX5S4G1ijp0tigFTJuD/Sj4RpS9Njcrmq71
bENUCYb/W4nfdjrQ5u5DwYLitDC7duABnJw7HlvK7G71r78+LHIVRJ8JfgLgGssj
DEo6eX1/h/YF/Ov+9It34/KIZOFZoXvRWyQ9SFvjWIYPtug4tETRoClvucIaJSjF
3i13+T6r7TSVGihQskcsxKypWN/d4yr5kizp8nLc1UdEqZxPCv0YIFsNZcFxYp/R
DqiFfpq3G/7I+Pl2tL320Ej2jPSe2pm+OYhqM34CenioiW2TxjVn0tWdzcBL4QU7
XyFYjM/h1gMB4mvtrw3bAQQajBT+zMyCZQCG3k17hL3FCA8sPpYpIWXbnnDMAlD/
Tf31Er4lnedTttVQ3PVo5xEhy9cPvNYRbBRkg7xPT+htfY0fcM1plMbz96kfMF1e
Caao801hRtZoP0N7j1mKahXdJga3Z/oBGlS+yhI2fmwR1wRzZJ8JUpSuhvYfqGhv
EAsC6Z67Urgk3hoOAcbLS4AwaEXvA11LXAlAooFxDGs3kubF9CY=
=RLmB
-----END PGP SIGNATURE-----

--x225b5f4ap2p7arx--

