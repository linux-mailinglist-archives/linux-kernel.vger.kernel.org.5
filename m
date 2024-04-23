Return-Path: <linux-kernel+bounces-155306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A018AE894
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D11428A57D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AB6137C5D;
	Tue, 23 Apr 2024 13:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bGN/LraB"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4011D136E2D;
	Tue, 23 Apr 2024 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880068; cv=none; b=n4nGNfCN6+IMo6BP1gRzzeDkWcAEIeN5J7n1PgvHRt/ah+CpO3qjz8ZdVykmjcRtDJpb3SMGN0JJML68cvKQZVFwWlhPHLBJKyls1l0G0xjF6lOCf4VOvA1fwrVe31eVJEDtGAnuIJVOP7xZONYDgEvjJfuezeMqDWtvHB0POqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880068; c=relaxed/simple;
	bh=nib8F95UZBHIkvsgKRgDHam5AsiuTEtg6tBahXJN6/Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cF+uUWZf8Ud2trbxOEkOWgoWIxq/uch4sgrBuDqxzAYCvz0GDBl6ptAvqEDeuDQ14Fk4KRtKaArKR8+1qBB5ucJPfoCgJldWImAyz7HjOnGpMD+qZJ5dvNCgSh26xk5EoRBt1ksx2uUwLnVjUC0CHGcgd1BtrGKfz3HdKtKDGeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bGN/LraB; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713880065;
	bh=nib8F95UZBHIkvsgKRgDHam5AsiuTEtg6tBahXJN6/Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=bGN/LraBEVJdD1k/MZ2viZkxUY9oxP8GBJivAx7QzKXInUHc4YACjfmlOB6c3JKXw
	 dEGnt852Qvroj+AmBwv7jOhhUBdzYcrWrKkFM7rsUBIejkTG2cbRPbTpkRzvpj+IN0
	 s85H/m7gN2t+k7plu8I+s+yqg3d6XRYnNhwX6pl40j3JS942jpttnWY70vxh4+W8OO
	 X5zsD0bH/+I3/NLl7iMNEFlBO/ASG53H1Qj3L3QPmq0KaW1kZiFuEjSiEEfcILrKE/
	 8VAp2fSjG9GI2x93npaQCpyz8MbN9g5OW7nlNkr++bUPN8isPe7YepT13hCcFsEmff
	 6uYBK/T7/JzRg==
Received: from nicolas-tpx395.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0CA4B3782136;
	Tue, 23 Apr 2024 13:47:42 +0000 (UTC)
Message-ID: <d8cfb08ac44523c9235a858a4bd78dcd297a62da.camel@collabora.com>
Subject: Re: [PATCH] media: mediatek: vcodec: Alloc DMA memory with
 DMA_ATTR_ALLOC_SINGLE_PAGES
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Doug Anderson <dianders@chromium.org>
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
Date: Tue, 23 Apr 2024 09:47:39 -0400
In-Reply-To: <CAD=FV=XSyLJiTCHYF7UaLersix0zP-q-MybW+nOR3A2WfccQcg@mail.gmail.com>
References: 
	<20240422100354.1.I58b4456c014a4d678455a4ec09b908b1c71c3017@changeid>
	 <022936a6704d08fbed22e7f241810d857eecaeda.camel@collabora.com>
	 <CAD=FV=XSyLJiTCHYF7UaLersix0zP-q-MybW+nOR3A2WfccQcg@mail.gmail.com>
Autocrypt: addr=nicolas.dufresne@collabora.com; prefer-encrypt=mutual;
 keydata=mQGiBEUQN0MRBACQYceNSezSdMjx7sx6gwKkMghrrODgl3B0eXBTgNp6c431IfOOEsdvkoOh1kwoYcQgbg4MXw6beOltysX4e8fFWsiRkc2nvvRW9ir9kHDm49MkBLqaDjTqOkYKNMiurFW+gozpr/lUW15QqT6v68RYe0zRdtwGZqeLzX2LVuukGwCg4AISzswrrYHNV7vQLcbaUhPgIl0D+gILYT9TJgAEK4YHW+bFRcY+cgUFoLQqQayECMlctKoLOE69nIYOc/hDr9uih1wxrQ/yL0NJvQCohSPyoyLF9b2EuIGhQVp05XP7FzlTxhYvGO/DtO08ec85+bTfVBMV6eeY4MS3ZU+1z7ObD7Pf29YjyTehN2Dan6w1g2rBk5MoA/9nDocSlk4pbFpsYSFmVHsDiAOFje3+iY4ftVDKunKYWMhwRVBjAREOByBagmRau0cLEcElpf4hX5f978GoxSGIsiKoDAlXX+ICDOWC1/EXhEEmBR1gL0QJgiVviNyLfGJlZWnPjw6xhhmtHYWTDxBOP5peztyc2PqeKsLsLWzAr7RDTmljb2xhcyBEdWZyZXNuZSAoQi4gU2MuIEluZm9ybWF0aXF1ZSkgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPohgBBMRAgAgBQJFlCyOAhsDBgsJCAcDAgQVAggDBBYCAwECHgECF4AACgkQcVMCLawGqBwhLQCgzYlrLBj6KIAZ4gmsfjXD6ZtddT8AoIeGDicVq5WvMHNWign6ApQcZUihtElOaWNvbGFzIER1ZnJlc25lIChCLiBTYy4gSW5mb3JtYXRpcXVlKSA8bmljb2xhcy5kdWZyZXNuZUBjb2xsYWJvcmEuY28udWs+iGIEExECACIFAkuzca8CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFTAi2sBqgcQX8An2By6LDEeMxi4B9hUbpvRnzaaeNqA
	J9Rox8rfqHZnSErw9bCHiBwvwJZ77QxTmljb2xhcyBEdWZyZXNuZSA8bmljb2xhcy5kdWZyZXNuZUBjb2xsYWJvcmEuY29tPohiBBMRAgAiBQJNzZzPAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRBxUwItrAaoHLlxAKCYAGf4JL7DYDLs/188CPMGuwLypwCfWKc9DorA9f5pyYlD5pQo6SgSoiC0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPohiBBMRAgAiBQJVwNwgAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRBxUwItrAaoHCZ4AJ0QwU6/G4c7h9CkMBT9ZxGLX4KSnQCgq0P7CX7hv/M7HeyfMFZe8t3vAEW0RE5pY29sYXMgRHVmcmVzbmUgKEIuIFNjLiBJbmZvcm1hdGlxdWUpIDxuaWNvbGFzZEBibHVlc3RyZWFrdGVjaC5jb20+iGAEExECACAFAkZjGzoCGwMGCwkIBwMCBBUCCAMEFgIDAQIeAQIXgAAKCRBxUwItrAaoHBl7AJ0d2lrzshMmJaik/EaDEakzEwqgxQCg0JVZMZm9gRfEou1FvinuZxwf/mu0R05pY29sYXMgRHVmcmVzbmUgKEIgU2MuIEluZm9ybWF0aXF1ZSkgPG5pY29sYXMuZHVmcmVzbmVAdXNoZXJicm9va2UuY2E+iGAEExECACAFAkUQN0MCGwMGCwkIBwMCBBUCCAMEFgIDAQIeAQIXgAAKCRBxUwItrAaoHPTnAJ0WGgJJVspoctAvEcI00mtp5WAFGgCgr+E7ItOqZEHAs+xabBgknYZIFPW5Ag0ERRA3UhAIAJ0rxl2HsVg/nSOAUt7U/T/W+RKzVAlD9orCB0pRVvyWNxSr8MHcHmWCxykLuB34ouM4GuDVRKfGnqLzJRBfjs7Ax9K2FI3Odund9xpviLCt1jFC0K
	XL04RebrFT7xjDfocDaSLFvgxMVs/Jr2/ckKPId1oKvgYgt/o+MzUabKyFB8wIvq4GMtj3LoBKLCie2nCaSt7uVUt6q2t5bNWrd3lO6/mWn7YMc5Hsn33H9pS0+9szw6m3dG08eMKNueDlt72QxiYl2rhjzkT4ltKEkFgYBdyrtIj1UO6eX+YXb4E1rCMJrdjBSgqDPK1sWHC7gliy+izr+XTHuFwlfy8gBpsAAwUIAJJNus64gri4HAL632eqVpza83EphX1IuHzLi1LlMnQ9Tm7XKag46NhmJbOByMG33LwBsBdLjjHQSVkYZFWUifq+NWSFC/kqlb72vW8rBAv64+i3QdfxK9FWbweiRsPpvuHjJQuecbPDJpubLaxKbu2aqLCN5LuHXvdQr6KiXwabT+OJ9AJAqHG7q4IEzg4RNUVn9AS6L8bxqMSocjqpWNBCY2efCVd/c6k4Acv6jXu+wDAZEbWXK+71uaUHExhigBYBpiHGrobe32YlTVE/XEIzKKywhm/Hkn5YKWzumLte6xiD9JhKabmD7uqIvLt2twUpz4BdPzj0dvGlSmvFcaaISQQYEQIACQUCRRA3UgIbDAAKCRBxUwItrAaoHJLyAKDeS3AFowM3f1Y3OFU6XRCTKK2ZhwCfT/7P9WDjkkmiq5AfeOiwVlpuHtM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hey,

Le lundi 22 avril 2024 =C3=A0 12:25 -0700, Doug Anderson a =C3=A9crit=C2=A0=
:
> Hi,
>=20
> On Mon, Apr 22, 2024 at 11:27=E2=80=AFAM Nicolas Dufresne
> <nicolas.dufresne@collabora.com> wrote:
> >=20
> > Hi,
> >=20
> > Le lundi 22 avril 2024 =C3=A0 10:03 -0700, Douglas Anderson a =C3=A9cri=
t :
> > > As talked about in commit 14d3ae2efeed ("ARM: 8507/1: dma-mapping: Us=
e
> > > DMA_ATTR_ALLOC_SINGLE_PAGES hint to optimize alloc"), it doesn't
> > > really make sense to try to allocate contiguous chunks of memory for
> > > video encoding/decoding. Let's switch the Mediatek vcodec driver to
> > > pass DMA_ATTR_ALLOC_SINGLE_PAGES and take some of the stress off the
> > > memory subsystem.
> > >=20
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > > NOTE: I haven't personally done massive amounts of testing with this
> > > change, but I originally added the DMA_ATTR_ALLOC_SINGLE_PAGES flag
> > > specifically for the video encoding / decoding cases and I know it
> > > helped avoid memory problems in the past on other systems. Colleagues
> > > of mine have told me that with this change memory problems are harder
> > > to reproduce, so it seems like we should consider doing it.
> >=20
> > One thing to improve in your patch submission is to avoid abstracting t=
he
> > problems. Patch review and pulling is based on a technical rational and=
 very
> > rarely on the trust that it helps someone somewhere in some unknown con=
text.
> > What kind of memory issues are you facing ? What is the technical advan=
tage of
> > using DMA_ATTR_ALLOC_SINGLE_PAGES over the current approach that helps =
fixing
> > the issue? I do expect this to be documented in the commit message itse=
lf=C3=A9.
>=20
> Right. The problem here is that I'm not _directly_ facing any problems
> here and I also haven't done massive amounts of analysis of the
> Mediatek video codec. I know that some of my colleagues have run into
> issues on Mediatek devices where the system starts getting
> unresponsive when lots of videos are decoded in parallel. That
> reminded me of the old problem I debugged in 2015 on Rockchip
> platforms and is talked about a bunch in the referenced commit
> 14d3ae2efeed ("ARM: 8507/1: dma-mapping: Use
> DMA_ATTR_ALLOC_SINGLE_PAGES hint to optimize alloc") so I wrote up
> this patch. The referenced commit contains quite a bit of details
> about the problems faced back in 2015.
>=20
> When I asked, my colleagues said that my patch seemed to help, though
> it was more of a qualitative statement than a quantitative one.
>=20
> I wasn't 100% sure if it was worth sending the patch up at this point,
> but logically, I think it makes sense. There aren't great reasons to
> hog all the large chunks of memory for video decoding.

Ok, slowly started retracing this 2016 effort (which now I understand you w=
here
deeply involved in). Its pretty clear this hint is only used for codecs. On=
e
thing the explanation seems missing (or that I missed) is that all the enab=
led
drivers seems to come with a dedicated mmu (dedicated TLB). But this argume=
nt
seems void if it is not combined with DMA_ATTR_NO_KERNEL_MAPPING to avoid u=
sing
the main mmu TLB space. There is currently three drivers using S5P_MFC, Han=
tro
and RKVDEC that uses this hint, only Hantro sets the DMA_ATTR_NO_KERNEL_MAP=
PING
hint.

It would be nice to check if VCODEC needs kernel mapping on the RAW images,=
 and
introduce that hint too while introducing DMA_ATTR_ALLOC_SINGLE_PAGES. But =
with
a now proper understanding, I also feel like this is wanted , but I'll have=
 a
hard time thinking of a test that shows the performance gain, since it requ=
ires
specific level of fragmentation in the system to make a difference.

Another aspect of the original description that is off, is CODECs doing lin=
ear
access, while this is mostly true for reconstruction (writes), this is not =
true
for prediction (reads). What really matters is that the CODECs tiles are mo=
st of
the time no bigger then a page, or less then a handful of pages.

Nicolas


