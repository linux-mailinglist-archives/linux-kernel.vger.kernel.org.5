Return-Path: <linux-kernel+bounces-50267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAD7847695
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3E6B1F2889B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602AD14C593;
	Fri,  2 Feb 2024 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="JSdtw7GO"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46474168B9;
	Fri,  2 Feb 2024 17:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706896121; cv=none; b=nqWiYXpmHw3AxSmhVvBbJK6vhc4uAxZ5m3vDMZSY3sB0rzau1uHS21gEddhilgkwIHieRGs3O+U9pYudCpklM5yTB9BqJhGgUclBp8fs66/WW6TGAF0wfZniGPPkM6h7bBA5XKSP6tcCwaHd/RoE6BnLVqbqYzrTXUSqFMELA3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706896121; c=relaxed/simple;
	bh=fRArofEFyV+mEzuCwxl1rFk1RSKjZ9nhZus4D76DbVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A90irFKYX4PbUTBqW5zPEBHSnLQdqCsNhNXiItp+t1wMaXBDgqpMzcfGN/6ejbXQB2DXq+L3zx2zJ9ox4HjN8Q/uX0VobfQPcCs50T7nBeimC46Yyd0a0Ok9h/FqUk9VZhtAoQ/BF7NNzsx9PRjCOJ35WqloCv7oCXnj7A+6II8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=JSdtw7GO; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1706896108; x=1707500908; i=erick.archer@gmx.com;
	bh=fRArofEFyV+mEzuCwxl1rFk1RSKjZ9nhZus4D76DbVU=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:
	 In-Reply-To;
	b=JSdtw7GO816RZ2gkiccH1dMv+q9KOxYDOnVTZAAkZ8wzTWgEJTJsATWrdSRwHyOe
	 bE3bUxc/JFIaGxH9s3bRar99ojTntA8WGfaQOOF2pJBeO1bxXIU0UV+pZTGvA+nMI
	 sf2qfSOlpkPkmihGU6kdKjlUjsqdmDsaEG4FkiLCu5NzB/2BJyq/6IA9XHba2Mkly
	 /RIA2RMTrOmfQd/DqGDSid3zFXvpCexhoMd9gGSYGFDbQocath2r8HxNKgjPxeRD4
	 uA0m337egDT4n6z6kQ8pBqvT7igHsXE/D6NpDm81mx69IxltA26pFwturas46O8By
	 MncHri29v2NTFvDDHQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from titan ([79.157.194.183]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MO9zH-1rglPB2gqf-00OXq7; Fri, 02
 Feb 2024 18:48:28 +0100
Date: Fri, 2 Feb 2024 18:48:17 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: ep: Use kcalloc() instead of kzalloc()
Message-ID: <20240202174817.GA4528@titan>
References: <20240120152518.13006-1-erick.archer@gmx.com>
 <43614a09-d520-4111-873a-b352bd93ea07@moroto.mountain>
 <20240128102933.GA2800@titan>
 <3b175cb6-fcbe-4521-b6ac-442c8a11c297@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b175cb6-fcbe-4521-b6ac-442c8a11c297@moroto.mountain>
X-Provags-ID: V03:K1:rtIgJn7pmL5lL6vGpRvFEKAofZVjZhyCaB9E/9VDne1F3q25qZ8
 7G/Jh4Acg9rS4kW0Md/PW4nR2rJapbUfT6DV3UoEGDPd0lwe+ROTKVYEfiA2Q0h5r92hDA3
 Iw7WmbsTIA6YJKBLuluiTHjTAGkak36yvgoPaanEeUMGF1C33OO8VGYeNhotWBGOZ69ptKq
 TmgcMjFokJe3bsDo8Lx5A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:29H8hio1c6g=;TkzoBl8a9dsfCi8c6fPJThbbKJ4
 UVjlCR6g1UL7r/risxhYylpG3698ZTtztzwMTHuN5F1GHp4VKq9PIVZzeOjWq1Fe5hoOam/jQ
 CnqOhCcggSfaTbXYSspkYKjWYc/vmP0icaJh7e96kJ6f4sss0HS+sqr7UXNisvzGQ8mLWNnhj
 W1jRAY9xHmFieakEpVMryKE/rAoj9TkUNfxCYDizoTIkVxL9BSIpcB5yJtWzRHUhKJAb98ck4
 6lvkza/97frSU482Zlw6vOAkG10RYMPUepO2o5m4D0mqgtV/TogiP92Gz4yvsLR3xmC779mpP
 /nn4nqIaK3m0mlCy2AAeZ2twv/WCRwsCcWBlhHc/J8royGPd/O3kFsQY2kvHTgGTj394JWbIc
 EbWqV0nhCJiNSempCGmhQBick/PGN/4Gx77BtzP/qbpLRkeHbbKugRPp7IY/5SP0JEnZydopW
 ukREJq3gf2y9AmZqp4z9U4qR9hEiuqHroXC3fC0ogylpMk7nfi91Zf+nNdyOuDnYMRMLGHzeu
 j4U9L10frSQj9pxULAWpBLP2dII/jCF4rW4kMWDalqLVRDRcNX5xy/ATQ3zzv/fZTIgT7mDkv
 8M+dj7HJ/+c/YgZ0a/p52tdFEK5UrTqxpSnbmLDZI27EFPucXv72fM7v3CMc1mLjEcbf/PcAq
 bYbQ5Lsu7e+hNy7KGsDBcfAmQsVQsu0HfGONlbuK7nKVuskpPMAhGixWE9jTjEwXylT82UQOM
 NcqsPHPkPzIfXNI7L/TSqEqeqwSSpaHWWCqlMHr8qP6sDd/QKOlZJ36yKQRuUuhyo/aF/KuU0
 AMC3XUFR6mDrcUD5/tzNS5m7WV05sWniUjHx7t6femOac=
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Mon, Jan 29, 2024 at 08:20:26AM +0300, Dan Carpenter wrote:
> On Sun, Jan 28, 2024 at 11:29:33AM +0100, Erick Archer wrote:
> > > It's a bit concerning that ->event_rings is set multiple times, but =
only
> > > allocated one time.  It's either unnecessary or there is a potential
> > > memory corruption bug.  If it's really necessary then there should b=
e a
> > > check that the new size is <=3D the size of the original buffer that=
 we
> > > allocated.
> >
> > The ->event_rings is set twice. In the mhi_ep_mmio_init function and i=
n
> > the mhi_ep_mmio_update_ner function.
> >
>
> It's not about the type.
>
> The event_rings struct member is the number of elements in the
> mhi_cntrl->mhi_event array.  However, we ->event_rings without
> re-allocating mhi_cntrl->mhi_event so those are not in sync any more.
> So since we don't know the number of elements in the mhi_cntrl->mhi_even=
t
> array leading to memory corruption.

Thanks for this clarification. Now I understand what you are explaining
to me.

Regards,
Erick


