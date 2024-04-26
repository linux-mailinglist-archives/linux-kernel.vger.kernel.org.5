Return-Path: <linux-kernel+bounces-159861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F6C8B3534
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 957681F21DF0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFD8143886;
	Fri, 26 Apr 2024 10:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A8/o7vi+"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E2C142E64
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714126858; cv=none; b=IaH1Sv4wYlmBC0bEj4AUlmDNpeWvDH8f0ov+dy1FZj5oH4oZsWkMwFwIvPU719+bP2850DsvIMVq+0nbu0/7OL9eWutNJNJryaJ5vMoJ6S+pGKpDh12n8CwaSnOHPenqR+3ulpSovzRcLX/in9TatGBEmbwk2eROI0OnqNgRNz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714126858; c=relaxed/simple;
	bh=IjXJYA5Q88JBRncKCAE8ZYdsQF4jhAftI0NHQOw9IJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BMlSQ3rPobbWVCPmj4XT/VZ/FvhN8+SIC+aSXYm4vkJkCMH7DYRf8WlH4XmuAH26MtQpkBpANR96fzMhNaOV72VSRhhaokEgGSOnaQKyUShl3E8Z/lzHGoAThkYhSiGp46tqBEsOGZzv5Xw7ueNYPGioY1UpSzvpdhHs12Dt1mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A8/o7vi+; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcc71031680so2016302276.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714126856; x=1714731656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjXJYA5Q88JBRncKCAE8ZYdsQF4jhAftI0NHQOw9IJE=;
        b=A8/o7vi+E4VKhGkL92v2BIyXvDJ/ltKG+TZGs0bVVt4iLMyP5wXH+jyt8N2HMF+Fps
         9x2kxAiaayPyyQ2dj/18JYq/besN2QlFMz7hz+lxAmhLjKeOW9Zi/0Vudqs7gTV2P5Mo
         GT560I9/cSyv6z5pNyeDbESEz3otbXSbvA4Ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714126856; x=1714731656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjXJYA5Q88JBRncKCAE8ZYdsQF4jhAftI0NHQOw9IJE=;
        b=MrM1cYGmx1tj2IXycR7O9afgIcYLyi+4TvuE18afJacaP5wkPdq0b2LGZdFYA/GmES
         pnAYv1+BzZkbZ/m+Uyi+rc6iM+AhN6UzcYoLLtPhtOyAZ4GSuj+zLhU8nmRoXZcdQ1is
         D3Gq29XyO0dM9BEAash+n0wBGdFAuuiNkFoUjlshrnT1w/lc+hjQL0eQAwyPwnRXmozV
         bDGuUSODYmxlHzOEe5DdzM06MYGNOVkTJj+Vcffe112QsjlbvoGqHljoGMzh05Eo/0gF
         Kz67QIzS/LOEMRPpMU2FEvsgTv6bO+hI+TvBYTvKREV2EAPsmP76czkugFA2NMH0kjEx
         /lvw==
X-Forwarded-Encrypted: i=1; AJvYcCWoKipA0cCIc/PGQ+0tB7RtD9vejOMSHwDsc3T+2aLz8zSTrlc6bBshTmj+ANojie7kNroXxCEfrpq6yRA4MkCr0CFA4+m6ROKr1ReB
X-Gm-Message-State: AOJu0Yy3s+tnbBQS8dGSpnNYLTYRLhPkYaUC1KI8J0pDNImLjA3S8172
	3500dFvhzpSanJAAJzriOMTAziNWzJtouofGY2RbIoYvUHVauHgCsxKhpdKoqQlFcXDZaKHdnIG
	5o3agBJoDWcELVKEfGWI7apfJawQNIrNd7ykO
X-Google-Smtp-Source: AGHT+IHWnmyJ6qY0q7iyDyA3XOCFfbMc89g4bmjlOa0MiZ8jfng1uljxIs6yB4rlgqQh0CKOxXSCfqT44NRv/pXIOtM=
X-Received: by 2002:a25:800f:0:b0:dcb:e0dc:67ee with SMTP id
 m15-20020a25800f000000b00dcbe0dc67eemr2211823ybk.45.1714126856342; Fri, 26
 Apr 2024 03:20:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422100354.1.I58b4456c014a4d678455a4ec09b908b1c71c3017@changeid>
 <022936a6704d08fbed22e7f241810d857eecaeda.camel@collabora.com> <CAD=FV=XSyLJiTCHYF7UaLersix0zP-q-MybW+nOR3A2WfccQcg@mail.gmail.com>
In-Reply-To: <CAD=FV=XSyLJiTCHYF7UaLersix0zP-q-MybW+nOR3A2WfccQcg@mail.gmail.com>
From: Fei Shao <fshao@chromium.org>
Date: Fri, 26 Apr 2024 18:20:20 +0800
Message-ID: <CAJ66y9FrpyzEwa1J=5L1OwRkrSBm308g8OZKnasYQcJYJpRbRA@mail.gmail.com>
Subject: Re: [PATCH] media: mediatek: vcodec: Alloc DMA memory with DMA_ATTR_ALLOC_SINGLE_PAGES
To: Doug Anderson <dianders@chromium.org>, 
	Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc: Tiffany Lin <tiffany.lin@mediatek.com>, Andrew-CT Chen <andrew-ct.chen@mediatek.com>, 
	Yunfei Dong <yunfei.dong@mediatek.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Wei-Shun Chang <weishunc@google.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Rob Herring <robh@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On Tue, Apr 23, 2024 at 2:52=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Mon, Apr 22, 2024 at 11:27=E2=80=AFAM Nicolas Dufresne
> <nicolas.dufresne@collabora.com> wrote:
> >
> > Hi,
> >
> > Le lundi 22 avril 2024 =C3=A0 10:03 -0700, Douglas Anderson a =C3=A9cri=
t :
> > > As talked about in commit 14d3ae2efeed ("ARM: 8507/1: dma-mapping: Us=
e
> > > DMA_ATTR_ALLOC_SINGLE_PAGES hint to optimize alloc"), it doesn't
> > > really make sense to try to allocate contiguous chunks of memory for
> > > video encoding/decoding. Let's switch the Mediatek vcodec driver to
> > > pass DMA_ATTR_ALLOC_SINGLE_PAGES and take some of the stress off the
> > > memory subsystem.
> > >
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > > NOTE: I haven't personally done massive amounts of testing with this
> > > change, but I originally added the DMA_ATTR_ALLOC_SINGLE_PAGES flag
> > > specifically for the video encoding / decoding cases and I know it
> > > helped avoid memory problems in the past on other systems. Colleagues
> > > of mine have told me that with this change memory problems are harder
> > > to reproduce, so it seems like we should consider doing it.
> >
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
>
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
>
> When I asked, my colleagues said that my patch seemed to help, though
> it was more of a qualitative statement than a quantitative one.

The story behind this is that I'm looking into an issue on the MediaTek
MT8188 Chromebook, where in some scenarios the system may emit 30+
video decoders concurrently (e.g. generating thumbnails for excess
amount of video files etc.), and such behavior can easily hang the
system if it has a smaller amount of memory (<4GB).

In addition to seeking mitigation in the user space software side,
we're also looking for ways to optimize how the video decoders use
memory, so Doug suggested this improvement.
My preliminary experiment showed that it has some positive impact -
the system doesn't freeze up completely with it and is still
responsive in the UART serial console. However, just like mentioned, I
didn=E2=80=99t have any rigorous numbers to support it.

To test the patch better, today I set up a local WebRTC demo to
simulate a video conference with 49 people where the mocked input
stream is captured from the device's own front camera.
With that, the original system easily hung in less than one minute
with less than 40MB available memory at the time; but with the change,
the system ran for several minutes and had an average of over 100MB
memory. It's not a huge improvement, but it's something.

I know this isn't the most scientific experiment, but I hope it=E2=80=99s a
good enough representation of one of the multi video decoder use
cases, and gives you some confidence that the patch is worth merging.

With the test above I think I can give this:
Tested-by: Fei Shao <fshao@chromium.org>

And, since this patch LGTM and I support it, here's my humble
Reviewed-by: Fei Shao <fshao@chromium.org>

Regards,
Fei

>
> I wasn't 100% sure if it was worth sending the patch up at this point,
> but logically, I think it makes sense. There aren't great reasons to
> hog all the large chunks of memory for video decoding.
>
> -Doug

