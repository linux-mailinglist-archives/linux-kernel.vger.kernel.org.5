Return-Path: <linux-kernel+bounces-120009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 611C688D017
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122641F80DBD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C90C13D889;
	Tue, 26 Mar 2024 21:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXct5rwb"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F77F13D61C;
	Tue, 26 Mar 2024 21:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711488686; cv=none; b=JrOXXgS/ctDuDe+h4f6es7D3iMVhzb42jtnzO4akxfXhW59lmDo1qk3YaR+kCBgCfA1PoCaKMpWEvcWerQr8QobMMLfw8S/1xG/lFVbL6hVVZ7KyQK6i80ctT1rsmpxmOkNNs4VftsJTaJupUnvFTkBGUsKoLxA+F79kgqMAiSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711488686; c=relaxed/simple;
	bh=PiGUvrXT9lLzrsrKPCPoTMei8/8USegfYO7EBaP7sv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jjnOk97P21ysncpwHRZNd/GX7Z8zb45fHQxuTRd09cpxgegnMcdy8jC303SiwDyaTgD3o/Lj46RGKG217QIDuGi+GS424kZSh0Ts+sTXfhNnlYhEoA8J9Oc1CemhpTNf4hf60EOCd+XM6M99OTWoX5s3NtRTt/hfIA1/ecQ7v+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXct5rwb; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29dd91f3aaeso4283575a91.3;
        Tue, 26 Mar 2024 14:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711488684; x=1712093484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PiGUvrXT9lLzrsrKPCPoTMei8/8USegfYO7EBaP7sv0=;
        b=HXct5rwbMYDUBy6NwzLthEFDDM9ZILac+5NfjwkuYVKrBbdgXtDVVW0uC77gIqf7FG
         T84+MwnMzelForKDbneVjAPGHtY5s52JN+kqWx0oqbqhdAxL52zU5FGmUVQA5BisfyUt
         jEjnOSlU7BqRdqmk+VeHgQFQv03FXqmhWfle6wzZJMp0KUytUX0vGEEOQKqyzjGcWwKB
         CDkx5T3FzndsDQNwrgY7EyFdeXMYnzFdXPMdXP5UBBROSc9ggmL7ie5GFxLaPVlPaf2r
         sXOQg9ots3m/sYgPm83awHmOOcO32HQ6eejWLaHU0nZfCmqE0uyycIGlRa08OEvWK96K
         h9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711488684; x=1712093484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PiGUvrXT9lLzrsrKPCPoTMei8/8USegfYO7EBaP7sv0=;
        b=uEiYXEewdPC4E0ai1trHcQCVNkzKmpCeW7iD/pH5BfRO7sNxet98bM/PUiiTrHq3K5
         NvuCzODR5ebv2myTFLkaMG9PPBgPa4I2mietUK+S4Ssx83oWdJrtYAQdpIJDIUOFJ8rF
         A5nwC6WM2NZ1x5rhQG4Y79U8+v0TecKb3X61gV/VoDw9F0gCGXNrz3bUbJXwWDhg/AQz
         lbLl9smFUtrase2HQml8C6MGq0GCa2YZaPu3bmpAfsjsJOXvp77L1pH3LxLL6/LYolxU
         2GM+5ToLLCVYhfPxjx9pjLhu9wmn8mCAPfckIjpGN12Vwef6z1maXzsLYivim747TBCf
         msjg==
X-Forwarded-Encrypted: i=1; AJvYcCWy59YbgFLNmOW0seuolHxgI14UOCcTYw6bulRN7FkVQVhZAWcZt8xMAT2262q09rvL2hkfb/mGSohgfiqUR5MbH0gPaomrPLU18bfFx8roxZOQU0zyY7VMsd5esGikGgxIzdL8BNuVHcmvvQ==
X-Gm-Message-State: AOJu0YwHJKP+3KbPd3Y5HpCJch0Xf82nEvd3eEs2G9Ek/55E4IA+cAaJ
	cUr7YiVMAGpGcQj+dlKHG5mYcC0UYwB8XXI5PXYzwwLGRZnmJtdKaF7+U2kY+gY5Yl9Dnqv4ETr
	1AEjQW2wYdFENwYxa9LfM2993aq8=
X-Google-Smtp-Source: AGHT+IENOACbX5Muhn3hNLP+uwrnNmzoaIn5nRqBxQrlvY5RyvzULA69EFRihpg6ANmhZEBWdyMhfxe4vy25DunBJIU=
X-Received: by 2002:a17:90b:4017:b0:2a0:3fe1:2e1 with SMTP id
 ie23-20020a17090b401700b002a03fe102e1mr8867114pjb.6.1711488684568; Tue, 26
 Mar 2024 14:31:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72mjc5t4n25SQvYSrOEhxxpXYPZ4pPzneSJHEnc3qApu2Q@mail.gmail.com>
 <CAA8EJprTNFgKJ_3cdZz4f_LCkYFghi-cfaj3bZmYh3oA63my6A@mail.gmail.com>
 <85204b78-7b24-61cd-4bae-3e7abc6e4fd3@quicinc.com> <CAA8EJppqrF10J1qExM=gopiF4GPDt7v4TB6LrQxx5OGyAL9hSg@mail.gmail.com>
 <671d2662-df4e-4350-0084-476eb1671cc1@quicinc.com> <CAA8EJpppre8ibYqN7gZObyvzR08yVbTevC6hDEDCKQVf8gRVRg@mail.gmail.com>
 <0280fa9a-cdb0-5bf7-7940-3c2cda1da829@quicinc.com>
In-Reply-To: <0280fa9a-cdb0-5bf7-7940-3c2cda1da829@quicinc.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 26 Mar 2024 22:30:56 +0100
Message-ID: <CANiq72m05v8iYtkHOzmZSmyBx2OvEOzS09Fu7F8N1a2SeboBeA@mail.gmail.com>
Subject: Re: drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:843:6: error:
 variable 'out' set but not used
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	linux-arm-msm <linux-arm-msm@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, 
	freedreno@lists.freedesktop.org, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 8:56=E2=80=AFPM Abhinav Kumar <quic_abhinavk@quicin=
c.com> wrote:
>
> Alright, in that case, Miguel can you please repost this with the Fixes
> tags and in a patch form.

Done at https://lore.kernel.org/lkml/20240326212324.185832-1-ojeda@kernel.o=
rg/

Thanks all!

Cheers,
Miguel

