Return-Path: <linux-kernel+bounces-165687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA748B8F91
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1B11C216D1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FCB15B560;
	Wed,  1 May 2024 18:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dwp9upVU"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A7E15B0E7;
	Wed,  1 May 2024 18:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714588313; cv=none; b=kE/hRDHSJBh6+ozj1CuQng9D+wjnFrQxDc5w7r7qclToXCm6i2yPUrw54vXnef3f3FR8owtHPi7WwDDCyp/BGrbl4v+lLfFhBxQjBsDyWC2n7dyiUbwDSGNLD1Tvgs9vwyogQK20o1jSE+wWLemjdgJTbnQEZ1pKPImZxvrJIPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714588313; c=relaxed/simple;
	bh=uSZJZlVEjnv5VVZKI60BYw+Pc0dZMrsdmpS1r51v58E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tds3u7cwx68ZmdA3hbXhA6Gzj0iAidZNbtqbmFFac2lV100NI2mVykc56b491DWMAtQbkSgZp3fpnxOkO0LR7+8eHvCSDa9tOdR6UVzA4/Per570ybJr77wOAHcUEyPlx7VotFYsBFgfq1OFV2lhcDg/p00fMSWcUmJaMbqk1GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dwp9upVU; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714588309;
	bh=uSZJZlVEjnv5VVZKI60BYw+Pc0dZMrsdmpS1r51v58E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=dwp9upVUf8uqjfy0K5alr3USuis2rsxquerVShprotY1c3DyZ9pnNikSrA/dSHLDN
	 PIubU7wjjYsNDCxL2+OWUkngL8e+0qx0jsRqpw+UyhYV7V+9t9a10JmC0VY3l/fuo6
	 HQj9Kg1cLRanQHF1Jwwt7x5PivXepUFgmuDT3l8DdQU3GtT3387uWnhtl1B3dJ1bF3
	 PF3TmYh6ZH0fl9oN3eQtb1GJOTx+zR5WeXQ1kRCCMoqWESb14k57a3kyILv7OMXGD0
	 ie8/fD/WotD5gU77wZZgd044WGdQ3/NREbr7/7EAWvTCNTnFkoOTyT6iqM8lAXBsHm
	 0dlXiU26yUmIQ==
Received: from nicolas-tpx395.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D498B3781F9A;
	Wed,  1 May 2024 18:31:47 +0000 (UTC)
Message-ID: <d73d7ade60de2bf4c4e9048756dc59062af64bc4.camel@collabora.com>
Subject: Re: [PATCH] media: mediatek: vcodec: Alloc DMA memory with
 DMA_ATTR_ALLOC_SINGLE_PAGES
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Fei Shao <fshao@chromium.org>, Doug Anderson <dianders@chromium.org>
Cc: Tiffany Lin <tiffany.lin@mediatek.com>, Andrew-CT Chen
 <andrew-ct.chen@mediatek.com>, Yunfei Dong <yunfei.dong@mediatek.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Wei-Shun Chang
 <weishunc@google.com>,  Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 =?ISO-8859-1?Q?N=EDcolas?= "F. R. A. Prado" <nfraprado@collabora.com>, Rob
 Herring <robh@kernel.org>,  linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,  linux-media@vger.kernel.org,
 linux-mediatek@lists.infradead.org
Date: Wed, 01 May 2024 14:31:43 -0400
In-Reply-To: <CAJ66y9FrpyzEwa1J=5L1OwRkrSBm308g8OZKnasYQcJYJpRbRA@mail.gmail.com>
References: 
	<20240422100354.1.I58b4456c014a4d678455a4ec09b908b1c71c3017@changeid>
	 <022936a6704d08fbed22e7f241810d857eecaeda.camel@collabora.com>
	 <CAD=FV=XSyLJiTCHYF7UaLersix0zP-q-MybW+nOR3A2WfccQcg@mail.gmail.com>
	 <CAJ66y9FrpyzEwa1J=5L1OwRkrSBm308g8OZKnasYQcJYJpRbRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le vendredi 26 avril 2024 =C3=A0 18:20 +0800, Fei Shao a =C3=A9crit=C2=A0:
> Hi Nicolas,
>=20
> On Tue, Apr 23, 2024 at 2:52=E2=80=AFPM Doug Anderson <dianders@chromium.=
org> wrote:
> >=20
> > Hi,
> >=20
> > On Mon, Apr 22, 2024 at 11:27=E2=80=AFAM Nicolas Dufresne
> > <nicolas.dufresne@collabora.com> wrote:
> > >=20
> > > Hi,
> > >=20
> > > Le lundi 22 avril 2024 =C3=A0 10:03 -0700, Douglas Anderson a =C3=A9c=
rit :
> > > > As talked about in commit 14d3ae2efeed ("ARM: 8507/1: dma-mapping: =
Use
> > > > DMA_ATTR_ALLOC_SINGLE_PAGES hint to optimize alloc"), it doesn't
> > > > really make sense to try to allocate contiguous chunks of memory fo=
r
> > > > video encoding/decoding. Let's switch the Mediatek vcodec driver to
> > > > pass DMA_ATTR_ALLOC_SINGLE_PAGES and take some of the stress off th=
e
> > > > memory subsystem.
> > > >=20
> > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > ---
> > > > NOTE: I haven't personally done massive amounts of testing with thi=
s
> > > > change, but I originally added the DMA_ATTR_ALLOC_SINGLE_PAGES flag
> > > > specifically for the video encoding / decoding cases and I know it
> > > > helped avoid memory problems in the past on other systems. Colleagu=
es
> > > > of mine have told me that with this change memory problems are hard=
er
> > > > to reproduce, so it seems like we should consider doing it.
> > >=20
> > > One thing to improve in your patch submission is to avoid abstracting=
 the
> > > problems. Patch review and pulling is based on a technical rational a=
nd very
> > > rarely on the trust that it helps someone somewhere in some unknown c=
ontext.
> > > What kind of memory issues are you facing ? What is the technical adv=
antage of
> > > using DMA_ATTR_ALLOC_SINGLE_PAGES over the current approach that help=
s fixing
> > > the issue? I do expect this to be documented in the commit message it=
self=C3=A9.
> >=20
> > Right. The problem here is that I'm not _directly_ facing any problems
> > here and I also haven't done massive amounts of analysis of the
> > Mediatek video codec. I know that some of my colleagues have run into
> > issues on Mediatek devices where the system starts getting
> > unresponsive when lots of videos are decoded in parallel. That
> > reminded me of the old problem I debugged in 2015 on Rockchip
> > platforms and is talked about a bunch in the referenced commit
> > 14d3ae2efeed ("ARM: 8507/1: dma-mapping: Use
> > DMA_ATTR_ALLOC_SINGLE_PAGES hint to optimize alloc") so I wrote up
> > this patch. The referenced commit contains quite a bit of details
> > about the problems faced back in 2015.
> >=20
> > When I asked, my colleagues said that my patch seemed to help, though
> > it was more of a qualitative statement than a quantitative one.
>=20
> The story behind this is that I'm looking into an issue on the MediaTek
> MT8188 Chromebook, where in some scenarios the system may emit 30+
> video decoders concurrently (e.g. generating thumbnails for excess
> amount of video files etc.), and such behavior can easily hang the
> system if it has a smaller amount of memory (<4GB).
>=20
> In addition to seeking mitigation in the user space software side,
> we're also looking for ways to optimize how the video decoders use
> memory, so Doug suggested this improvement.
> My preliminary experiment showed that it has some positive impact -
> the system doesn't freeze up completely with it and is still
> responsive in the UART serial console. However, just like mentioned, I
> didn=E2=80=99t have any rigorous numbers to support it.
>=20
> To test the patch better, today I set up a local WebRTC demo to
> simulate a video conference with 49 people where the mocked input
> stream is captured from the device's own front camera.
> With that, the original system easily hung in less than one minute
> with less than 40MB available memory at the time; but with the change,
> the system ran for several minutes and had an average of over 100MB
> memory. It's not a huge improvement, but it's something.
>=20
> I know this isn't the most scientific experiment, but I hope it=E2=80=99s=
 a
> good enough representation of one of the multi video decoder use
> cases, and gives you some confidence that the patch is worth merging.
>=20
> With the test above I think I can give this:
> Tested-by: Fei Shao <fshao@chromium.org>
>=20
> And, since this patch LGTM and I support it, here's my humble
> Reviewed-by: Fei Shao <fshao@chromium.org>

The arguments hew and my own research has finish convincing me we want to d=
o
this (unless we had limited TLB space at the device level, or performance m=
etric
that show that bigger contiguous chunk helps).

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

>=20
> Regards,
> Fei
>=20
> >=20
> > I wasn't 100% sure if it was worth sending the patch up at this point,
> > but logically, I think it makes sense. There aren't great reasons to
> > hog all the large chunks of memory for video decoding.
> >=20
> > -Doug
>=20


