Return-Path: <linux-kernel+bounces-65944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2CC85541F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D59A1F22950
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB082128370;
	Wed, 14 Feb 2024 20:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="tbvpd4ac"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB7D1DDC1;
	Wed, 14 Feb 2024 20:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707943121; cv=none; b=K5SDyjkpZNhxhqTPp+4/WtZFsZPmStB4ishWKTkMw5+uLd6mciAnVkXD0+o8zLAFFEWwANsOPnXMPBMOpswEb6a7USv37CFYIjRskfZEdnaw+besPRjx8uwKucDyZjT6j9ZJmFdU41EKXt8mU8pQ685ZlKQqaepjJ4O6jS9IQNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707943121; c=relaxed/simple;
	bh=DFjL+6b7AkoxeUWqvnBND32t0iwJZ+FDcJ3KKCir4IA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m2TdaZ3y4sgKjyIm/hCGtsMtFV26pF7xB1pwqz5Q5UsxTdYs2wvw0aB+u/JdLqJJITZqw72nbawizNvuK54LNgedvu4Rd2sgMc/AAOs5zBoh/Iee0j8q1bAPyHP+uOvhPCOce6jQGtN67HdlxIO+hL9xRZpp55asYjUmFY3LoVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=tbvpd4ac; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707943117;
	bh=DFjL+6b7AkoxeUWqvnBND32t0iwJZ+FDcJ3KKCir4IA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=tbvpd4acCdRprsVF7V9gvcrGE2OA37DjlqK0iPQsf4xO1oKgW5vebs/Cr9ziIgYUy
	 qGuP2ucQGNuZ4rKCx18z//i+F4dZW1u7FgWGuUmdIGJO/UCK8paQ66tFqmRPfGxHfs
	 YEfXGzBkeLyFkWyLDnsgkxKq37o8KjURMkbnpSO/RjqUh5rI1hD2R0y8bxBxH/e/0m
	 GDF/88iyNniO3O6cEY3EcX/tyHPklfU8ZAa7pYm9kEFyEwbC27YUhbLukqXJTxYl0S
	 0l0tyaS1IOtnsjbU4QVwsDhJPqKWuH9yHb2mp7Tr6FKb8pWKoiN674GP7e36R/s6Og
	 iF2hXZd73ZlxQ==
Received: from nicolas-tpx395.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5E8203782088;
	Wed, 14 Feb 2024 20:38:36 +0000 (UTC)
Message-ID: <a43eaa0cfedeccc85410d2e26f296bda8de635cd.camel@collabora.com>
Subject: Re: [PATCH] media: v4l2-mem2mem: fix mem order in last buf
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Hsia-Jun Li <randy.li@synaptics.com>, linux-media@vger.kernel.org
Cc: mchehab@kernel.org, hverkuil-cisco@xs4all.nl, 
	sebastian.fricke@collabora.com, alexious@zju.edu.cn, ayaka@soulik.info, 
	linux-kernel@vger.kernel.org
Date: Wed, 14 Feb 2024 15:38:32 -0500
In-Reply-To: <20240210180414.49184-1-randy.li@synaptics.com>
References: <20240210180414.49184-1-randy.li@synaptics.com>
Autocrypt: addr=nicolas.dufresne@collabora.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

>  media: v4l2-mem2mem: fix mem order in last buf

mem order ? Did you mean call order ?

Le dimanche 11 f=C3=A9vrier 2024 =C3=A0 02:04 +0800, Hsia-Jun Li a =C3=A9cr=
it=C2=A0:
> From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
>=20
> The has_stopped property in struct v4l2_m2m_ctx is operated
> without a lock protecction. Then the userspace calls to
                 protection   When ?                   ~~

> v4l2_m2m_encoder_cmd()/v4l2_m2m_decoder_cmd() may lead to
> a critical section issue.

As there is no locking, there is no critical section, perhaps a better phra=
sing
could help.

>=20
> Signed-off-by: Hsia-Jun(Randy) Li <randy.li@synaptics.com>
> ---
>  drivers/media/v4l2-core/v4l2-mem2mem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-=
core/v4l2-mem2mem.c
> index 75517134a5e9..f1de71031e02 100644
> --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
> +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
> @@ -635,9 +635,9 @@ void v4l2_m2m_last_buffer_done(struct v4l2_m2m_ctx *m=
2m_ctx,
>  			       struct vb2_v4l2_buffer *vbuf)
>  {
>  	vbuf->flags |=3D V4L2_BUF_FLAG_LAST;
> -	vb2_buffer_done(&vbuf->vb2_buf, VB2_BUF_STATE_DONE);
> -
>  	v4l2_m2m_mark_stopped(m2m_ctx);
> +
> +	vb2_buffer_done(&vbuf->vb2_buf, VB2_BUF_STATE_DONE);

While it most likely fix the issue while testing, since userspace most like=
ly
polls on that queue and don't touch the driver until the poll was signalled=
, I
strongly believe this is insufficient. When I look at vicodec and wave5, th=
ey
both add a layer of locking on top of the mem2mem framework to fix this iss=
ue.

I think this is unfortunate, but v4l2_m2m_mark_stopped() is backed by 3 boo=
leans
accessed in many places that aren't in any known atomic context. I think it
would be nice to remove the spurious locking in drivers and try and fix thi=
s
issue in the framework itself.

Nicolas

>  }
>  EXPORT_SYMBOL_GPL(v4l2_m2m_last_buffer_done);
> =20


