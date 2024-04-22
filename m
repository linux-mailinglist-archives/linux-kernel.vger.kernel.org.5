Return-Path: <linux-kernel+bounces-153916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D138AD4D1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF0D9282120
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B480155334;
	Mon, 22 Apr 2024 19:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XEVqKda7"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50364154451
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713813969; cv=none; b=OkDFdFn+Cs37kjHGnTzekuQAXsLveYfD1vnXaoz1vK/OTI6+ADFN03fL5+6a9ygJaj+VHzlme+7rpdZVdkbnM0dGw0ECxOeUiaasMudneVIhvSgZNAMPwDYcyiQVXh8vlIbt9jxVsiyriVenDUKYG/HBh6KySlmRpKQdRbL68ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713813969; c=relaxed/simple;
	bh=mqHcqubpcdGYAMy1VnzK8VjEKBwDIL3z9gbkSQbzIqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FIv/fAqQYnM6UC0vEo+JjEEDtzkTwRgm6ewwGixeRfvzI9pAUrzPv/diamaDfdxxZ/zKaPFeuE3Ba9F/AMnSuCt7NCVG3ZiSA01qMM3d2yx45Uo4YUH6TTc5O7xjY7jlfJthyqospkfFqpf4kZ8KDYiLfYrWvEkXKYZAfIfIL8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XEVqKda7; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-434c3d21450so26099831cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 12:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713813963; x=1714418763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqHcqubpcdGYAMy1VnzK8VjEKBwDIL3z9gbkSQbzIqc=;
        b=XEVqKda70BnBryt0U3GNSBOzmSbmCAr2/8fTgDILc2ZUkdI8JA4/83wEirKQj+FcK5
         Z0mfkPVrZoa2VHeT6bDQlLV01F1/wRDvZTwfcWwEpBiIlyUSQDX+Bi+R/KNuP0v0hlT+
         Ekq+S5HlEbd9i08wzurvlSMwlnmfmVd7wYSSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713813963; x=1714418763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqHcqubpcdGYAMy1VnzK8VjEKBwDIL3z9gbkSQbzIqc=;
        b=PFwqlzzTjVs0GPeU9xRhGOENlvan/nIo3uETyk/wUO6F69bPQoWFbdK55TqsCYlhqo
         IK4MApt/ZhUzcB3pRUVyCFTyMMOhKypt78d48b+NNn1xdUpI8Nv4IQhLGyiEQksiMCqt
         +FQjHOn/KbHJn9bcb2wdSXGcS39W1dxSIBCfHUeQ7t84NFJhT9Rxqi1G27qLE3W7SwFD
         46wOG/Fa2QvlHt0HjEmAalHg0GLP0Y1694vcG2lgM2opD9vUt0+Hktq9wjS4qjFrcwBX
         aeWoyEdzkDW+VQTi+F/3Cv9Yz+rwbOhKb9JaDbOYoxEA5+19F94whXTs3rNqNHC7nRzC
         4dWA==
X-Forwarded-Encrypted: i=1; AJvYcCXGDliPY6pf8Nk+noMS+R9j1CIrSGmMbTjct3ix5s1J7UQ5k0N9h5t4S+V76rZhvQBXaybv8iYjsdtuDJS9SJVxhkbNeZ2tshWVbm6e
X-Gm-Message-State: AOJu0YxnIHoGBkQsMPowWCUF/u4L4IJ0J1SacViFXrtjrDwOPF8wYIAY
	9wy/+2jO767CeNEDqLNfSHkPXCoMP4R6PyTjxjfZISKOVgiVsdbRjymAv87a22c9fLj1Vq+LybM
	=
X-Google-Smtp-Source: AGHT+IG0jpIHR2taoOQVk1aOEHBm15PustXYanEaZ16x0iK01g96UlIxMEZhNaxbD6nCrQ/wtY/7Kw==
X-Received: by 2002:ac8:6f17:0:b0:439:d05b:764c with SMTP id bs23-20020ac86f17000000b00439d05b764cmr3346791qtb.46.1713813962304;
        Mon, 22 Apr 2024 12:26:02 -0700 (PDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id o22-20020a05620a0d5600b0078d5a756e61sm4560598qkl.60.2024.04.22.12.26.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 12:26:01 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-43989e6ca42so68081cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 12:26:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW42YT3p6uj+ela3VjFB/dRFeCOy7heVO6TuVrJIhEIQnvpQuaXY2Rn2A0FzU3ac621YXPQ7PzEFEBuBOEP2lZ6CdVzUHr5W8/uSKZh
X-Received: by 2002:ac8:4dca:0:b0:438:d778:5b17 with SMTP id
 g10-20020ac84dca000000b00438d7785b17mr47685qtw.12.1713813960387; Mon, 22 Apr
 2024 12:26:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422100354.1.I58b4456c014a4d678455a4ec09b908b1c71c3017@changeid>
 <022936a6704d08fbed22e7f241810d857eecaeda.camel@collabora.com>
In-Reply-To: <022936a6704d08fbed22e7f241810d857eecaeda.camel@collabora.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 22 Apr 2024 12:25:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XSyLJiTCHYF7UaLersix0zP-q-MybW+nOR3A2WfccQcg@mail.gmail.com>
Message-ID: <CAD=FV=XSyLJiTCHYF7UaLersix0zP-q-MybW+nOR3A2WfccQcg@mail.gmail.com>
Subject: Re: [PATCH] media: mediatek: vcodec: Alloc DMA memory with DMA_ATTR_ALLOC_SINGLE_PAGES
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
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

Hi,

On Mon, Apr 22, 2024 at 11:27=E2=80=AFAM Nicolas Dufresne
<nicolas.dufresne@collabora.com> wrote:
>
> Hi,
>
> Le lundi 22 avril 2024 =C3=A0 10:03 -0700, Douglas Anderson a =C3=A9crit =
:
> > As talked about in commit 14d3ae2efeed ("ARM: 8507/1: dma-mapping: Use
> > DMA_ATTR_ALLOC_SINGLE_PAGES hint to optimize alloc"), it doesn't
> > really make sense to try to allocate contiguous chunks of memory for
> > video encoding/decoding. Let's switch the Mediatek vcodec driver to
> > pass DMA_ATTR_ALLOC_SINGLE_PAGES and take some of the stress off the
> > memory subsystem.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > NOTE: I haven't personally done massive amounts of testing with this
> > change, but I originally added the DMA_ATTR_ALLOC_SINGLE_PAGES flag
> > specifically for the video encoding / decoding cases and I know it
> > helped avoid memory problems in the past on other systems. Colleagues
> > of mine have told me that with this change memory problems are harder
> > to reproduce, so it seems like we should consider doing it.
>
> One thing to improve in your patch submission is to avoid abstracting the
> problems. Patch review and pulling is based on a technical rational and v=
ery
> rarely on the trust that it helps someone somewhere in some unknown conte=
xt.
> What kind of memory issues are you facing ? What is the technical advanta=
ge of
> using DMA_ATTR_ALLOC_SINGLE_PAGES over the current approach that helps fi=
xing
> the issue? I do expect this to be documented in the commit message itself=
=C3=A9.

Right. The problem here is that I'm not _directly_ facing any problems
here and I also haven't done massive amounts of analysis of the
Mediatek video codec. I know that some of my colleagues have run into
issues on Mediatek devices where the system starts getting
unresponsive when lots of videos are decoded in parallel. That
reminded me of the old problem I debugged in 2015 on Rockchip
platforms and is talked about a bunch in the referenced commit
14d3ae2efeed ("ARM: 8507/1: dma-mapping: Use
DMA_ATTR_ALLOC_SINGLE_PAGES hint to optimize alloc") so I wrote up
this patch. The referenced commit contains quite a bit of details
about the problems faced back in 2015.

When I asked, my colleagues said that my patch seemed to help, though
it was more of a qualitative statement than a quantitative one.

I wasn't 100% sure if it was worth sending the patch up at this point,
but logically, I think it makes sense. There aren't great reasons to
hog all the large chunks of memory for video decoding.

-Doug

