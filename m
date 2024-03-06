Return-Path: <linux-kernel+bounces-93161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7501872BB1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849561F267E5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A40CC142;
	Wed,  6 Mar 2024 00:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lRhkRyeA"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D12263CF
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 00:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709684619; cv=none; b=kf65f+hYfhiOC0A3xsS/Bl1sLqwXp09z5Yr7DCofuR0/IHiitVVpE/DyTpqGTzs4Zn75z4hMtAqf4l2hdVDG05RpI63s1c41K1PF6ChjCga+N45Rt/gAYJpjdHu9Y5E0aWU9Uu5h4df7iHZGidcQ5xKs892eLzKz4ZXnm5XkohA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709684619; c=relaxed/simple;
	bh=inIrOcNkYayxA9apxKIBrNWVP7rVZSaJzSTWLCBHFMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JWKjilTuODL4x4/TBIRx+iorqgJwaXfq088rgInQj+98lH/ErLUoHOnbh8oqnlw5iOoEurDxBYb+cLN2SJdW3iJ0QoqPDY0UPx0RZsE7m9E5N5HUJETSahEUiJfe8pdUSqYqpIe/WTp19V4qYxQ84NeqrJ9XuzGCMkT38dhBBdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lRhkRyeA; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4d345250ee1so1493510e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 16:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709684615; x=1710289415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBN1BqbcbZ76mWTdYzaQ/VGjxsv9OMJI1R5f8bpftUs=;
        b=lRhkRyeAZ0I0unAkbN5FYkJSM6rcDsdFtEZNmVsBg04ITRW5rNwn3Pbo70O8ZGq5Kn
         70qv3D3ghVUsP3QJJGLc2AzQJ4FvWFlIRwBiLOtO+MtQgyhzdum98MMyRl9uk1PtzwF4
         z61CplACjCJbhjArC92cx95lscjpBeT4IPavs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709684615; x=1710289415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBN1BqbcbZ76mWTdYzaQ/VGjxsv9OMJI1R5f8bpftUs=;
        b=YLccq+b5vdHzs33Zzby/ef83CpAyDk4NEo1rzwM6o/P6qC1NBKC+MCe9fxf1s3kjO5
         JcbW07bL7n9lMWdToqpZsAk/qI1/Snia6CVi0pMqoWexbhj9XnFPEzHQnfNeHEGXsqF5
         Ad3K2iG5xugGEFIkNjRNfznvMpLKPfP5n7Jw++76poF1z1ih3qmHBVwJHbQwNJtw5Yqm
         MzdgNgDIpNsi1knT1tYBK+zwLqsMtzsfi7zHJfxc21hIWpQMc7HDRmvcoi53BG/NhuDF
         zoaVlvXjJK206/jl5Xa3RqdFMuT1ngpHyUVgXjEs4NMjVD/KCw/Xzuso/yNWomDtq29v
         TdQA==
X-Forwarded-Encrypted: i=1; AJvYcCWWJdRGs/+yj3tQZMXWPt16DPUCGHI9GDP+LM+JhX5Ppqfy8Q5DHd7sugtaPm1F+EdB4Sj/hRuC/n5BIOLi6Rbpz0tx4A4Xratds673
X-Gm-Message-State: AOJu0YwAIWmhWAJVOjG8D2Eh142HFQ5UORpZbFJyGDsQ0o9lj1oQ5PVL
	Yuhfq7OPZsE4hcUIglejrFyAsakz4EqqsjWDbA3yZUK2O3wTPNC4cbCwGqShnD2hhviV/UZTrn1
	YWtHf
X-Google-Smtp-Source: AGHT+IGaC7OJ+3dwDxen4AhlXRRJ2Oxb2bUfC+JExxaKBr+ynXAMt2x3C4kxoYvgaxzwt1HqtyiJvw==
X-Received: by 2002:a05:6122:d0a:b0:4bd:29f7:53c4 with SMTP id az10-20020a0561220d0a00b004bd29f753c4mr3395743vkb.1.1709684615484;
        Tue, 05 Mar 2024 16:23:35 -0800 (PST)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com. [209.85.160.169])
        by smtp.gmail.com with ESMTPSA id d3-20020ac80603000000b0042ec8412342sm4856978qth.80.2024.03.05.16.23.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 16:23:34 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42f024b809cso123361cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 16:23:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU55pNl+/BZSW/Hvtk8WkBVWOGxaso+bxrHWSAXMWo9RkIPTp+65ghrXD43EibrnU0CzSfj25trp7QzGqS4kmrHyCE6pIn6ovagP+qj
X-Received: by 2002:ac8:7e83:0:b0:42e:f49b:8753 with SMTP id
 w3-20020ac87e83000000b0042ef49b8753mr321969qtj.11.1709684614147; Tue, 05 Mar
 2024 16:23:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305012604.3869593-1-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20240305012604.3869593-1-yangcong5@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 5 Mar 2024 16:23:18 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XUhBUscqx5TY6Ax94_St6xggnirP6hiy_VG9Y_1uB-kg@mail.gmail.com>
Message-ID: <CAD=FV=XUhBUscqx5TY6Ax94_St6xggnirP6hiy_VG9Y_1uB-kg@mail.gmail.com>
Subject: Re: [PATCH V2] drm/panel: boe-tv101wum-nl6: Fine tune Himax83102-j02
 panel HFP and HBP (again)
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	hsinyi@chromium.org, swboyd@chromium.org, airlied@gmail.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Cong,

On Mon, Mar 4, 2024 at 5:26=E2=80=AFPM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> The current measured frame rate is 59.95Hz, which does not meet the
> requirements of touch-stylus and stylus cannot work normally. After
> adjustment, the actual measurement is 60.001Hz. Now this panel looks
> like it's only used by me on the MTK platform, so let's change this
> set of parameters.
>
> Fixes: cea7008190ad ("drm/panel: boe-tv101wum-nl6: Fine tune Himax83102-j=
02 panel HFP and HBP")
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

I actually already made these fixes myself for you and applied. My
notes were mostly for you to keep in mind for next time. This is
already in drm-misc-fixes as:

9dfc46c87cdc drm/panel: boe-tv101wum-nl6: Fine tune Himax83102-j02
panel HFP and HBP (again)

-Doug

