Return-Path: <linux-kernel+bounces-164744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8632F8B81F2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3E611F2192A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BD21BED6B;
	Tue, 30 Apr 2024 21:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JsRQkcGh"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47B6770F5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 21:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714512817; cv=none; b=SVk0PpX05SRqCxsGStpPb+Gf3BLXrGMRzJkHAxF4F50Dcwkk+OkWkQ4q1yrgTV/UguYDRv3CNKoIxIB7SJWGBLnrtvQzmfKeE/0b5DtmtQQ1CKOPlGztmHgJlNeCs9kJS9xEDFVzN2Of6HxwysdfWcttJt1g0nDM9EVFTnpWKdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714512817; c=relaxed/simple;
	bh=wFtRpsD7d0rNrghB3f5fMpNzQwUW78IpVdQ+ztFvRfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tW9TeOfPrzzNEDKb/4ZmQEWTSDVZJRdUHqc8YrJ4zcyjry8O0sWc2PBj8iBLBZcvNB2VfUhkcAuHp6DxY7eNe+f8NJ9JGLy/z4FljwLnPDGuPyqOEQi+F3i+K4Ept6O3Iz9jjd3A3D0aK5JhZHKrm/TlbHRPoYX9WS1F7m9hoSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JsRQkcGh; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78f02c96c52so444217685a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714512812; x=1715117612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+HzTkd4i5A3Jz1EV6LIGTPt2WPRL2keGYFaIW+UNwc=;
        b=JsRQkcGh87xI7rLR2Zl0WV2IDhRHB15wOMYIAqsG8Ujdn4Ex2XGHTL4a1xge2wDKSk
         CHG/0hTAxUO2jNSl6njPa0hZvv/0pa3fFahr/8N7H2EfDtXp7fhaL7k2uphEiAjZPO/N
         QPaHmExjXbsGKaAI7JczANmheknFzcjyk5h+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714512812; x=1715117612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+HzTkd4i5A3Jz1EV6LIGTPt2WPRL2keGYFaIW+UNwc=;
        b=HPVVFPHZwtBMv2W2pL/fdfRnNrspVxkLa/ggKlX5LFpkIFFdAcfGRzKBK1rrIiiMnU
         8QM6gQJ4sJKOesl7ts0SGK7JEQr9VbAi9sfTrXoBCLQ1Kr1K0NtlnMqgQptFp5xdtuwh
         kegHFM6HWg0WhMJOOtuLMM6YkfTn/8yDJS7rn32STnyfl6WZR6I2v0ISRqLaHhHdkUB2
         UJqMNJzs3Uhv8jBnSYp5KygtuZDeezVqSaf0vv2V7O/g222vpKWykrEB+n12EzLO5uvb
         J0vzmu+Wuxddc2RCw/BPXzI+5seCfT4MHVmmXrgV4LfRPi+qavRQqtt8L/k33LUuNbqL
         r+PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsWrV4eZr6rMrEsV6+2EPwHGNBab7PoA6/HqAFpSDUXJCpiVTDxKa3uAvIX6zaLdpPgSapmWgJlDD69wDsNEzxhDWv4gHD2eqhMjPt
X-Gm-Message-State: AOJu0YxO0P73xUaiqhk7kjuc35eqdSHr9jCUIfj05Oow+MW5d7UUW3P+
	TN4tDxEZLaJbR56keGfg8rbcvACYcKND85256GG7A29DIU/ux1H5SqknPd5eEBks7YmHB4D5J6c
	=
X-Google-Smtp-Source: AGHT+IFTcIMGpXv7JOZZNuRV5oJyEWNnTLgyq2t55N0MyS9e9ZmJluWW8xTL/5h6hKEgZCqq8cHEtA==
X-Received: by 2002:ae9:c302:0:b0:790:e76a:33db with SMTP id n2-20020ae9c302000000b00790e76a33dbmr549993qkg.31.1714512811552;
        Tue, 30 Apr 2024 14:33:31 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id oo8-20020a05620a530800b0078d693c0b4bsm11704620qkn.135.2024.04.30.14.33.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 14:33:31 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-43989e6ca42so52051cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:33:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXrbFMUyvyE4Ek+OZyro1exb0ZkDnTUd4ueW7tkmIFMBeJHZ3uh+VhGz0Vpezyx3McBhnad3CAKs2GUNxkBTjUR0HcsMNQG2FRvmGSO
X-Received: by 2002:a05:622a:301:b0:439:ef72:75fb with SMTP id
 q1-20020a05622a030100b00439ef7275fbmr25727qtw.1.1714512809499; Tue, 30 Apr
 2024 14:33:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321222258.1440130-1-sui.jingfeng@linux.dev>
 <caa6fb05-8080-444a-93c3-2d9283ccb74d@bosc.ac.cn> <20240429-enchanted-cooperative-jacamar-cf2902@houat>
 <6db82a3f.c7.18f2c927d9f.Coremail.suijingfeng@bosc.ac.cn>
In-Reply-To: <6db82a3f.c7.18f2c927d9f.Coremail.suijingfeng@bosc.ac.cn>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 30 Apr 2024 14:33:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W2ksFLtv3o5tqrpXY4aHD_wUq7R7rT9hOHCQa8FLmeoQ@mail.gmail.com>
Message-ID: <CAD=FV=W2ksFLtv3o5tqrpXY4aHD_wUq7R7rT9hOHCQa8FLmeoQ@mail.gmail.com>
Subject: Re: Re: drm/debugfs: Drop conditionals around of_node pointers
To: =?UTF-8?B?6ZqL5pmv5bOw?= <suijingfeng@bosc.ac.cn>
Cc: Maxime Ripard <mripard@kernel.org>, Sui Jingfeng <sui.jingfeng@linux.dev>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Biju Das <biju.das.jz@bp.renesas.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 29, 2024 at 6:16=E2=80=AFPM =E9=9A=8B=E6=99=AF=E5=B3=B0 <suijin=
gfeng@bosc.ac.cn> wrote:
>
> Hi,
>
>
> > -----=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: "Maxime Ripard" <mripard@kernel.org>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2024-04-29 19:30:24 (=E6=98=9F=E6=
=9C=9F=E4=B8=80)
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: "Sui Jingfeng" <suijingfeng@bosc.ac.cn>
> > =E6=8A=84=E9=80=81: "Sui Jingfeng" <sui.jingfeng@linux.dev>, "Maarten L=
ankhorst" <maarten.lankhorst@linux.intel.com>, "Thomas Zimmermann" <tzimmer=
mann@suse.de>, "David Airlie" <airlied@gmail.com>, "Daniel Vetter" <daniel@=
ffwll.ch>, "Douglas Anderson" <dianders@chromium.org>, "Laurent Pinchart" <=
laurent.pinchart+renesas@ideasonboard.com>, "Biju Das" <biju.das.jz@bp.rene=
sas.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
> > =E4=B8=BB=E9=A2=98: Re: drm/debugfs: Drop conditionals around of_node p=
ointers
> >
> > On Sun, Apr 28, 2024 at 04:52:13PM +0800, Sui Jingfeng wrote:
> > > ping
> > >
> > > =E5=9C=A8 2024/3/22 06:22, Sui Jingfeng =E5=86=99=E9=81=93:
> > > > Having conditional around the of_node pointer of the drm_bridge str=
ucture
> > > > turns out to make driver code use ugly #ifdef blocks.
> >
> > The code being ugly is an opinion, what problem is it causing exactly?
> >
> > > Drop the conditionals to simplify debugfs.
> >
> > What does it simplifies?
> >
> > > >
> > > > Fixes: d8dfccde2709 ("drm/bridge: Drop conditionals around of_node =
pointers")
> > > > Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> >
> > Why do we want to backport that patch to stable?

Technically it's not CCing stable and so it's not really incorrect.
..but I agree that this is a bit of a stretch to call it a "Fix".
Maybe drop the "Fixes" line?


> My commit message is written based on commit of d8dfccde2709
>
> $ git show c9e358dfc4a8
>
>     This patch is based on commit c9e358dfc4a8 ("driver-core: remove
>     conditionals around devicetree pointers").
>
>     Having conditional around the of_node pointer of the drm_bridge
>     structure turns out to make driver code use ugly #ifdef blocks. Drop =
the
>     conditionals to simplify drivers. While this slightly increases the s=
ize
>     of struct drm_bridge on non-OF system, the number of bridges used tod=
ay
>     and foreseen tomorrow on those systems is very low, so this shouldn't=
 be
>     an issue.
>
>     So drop #if conditionals by adding struct device_node forward declara=
tion.
>
> > Maxime
>
> I'm just start to contribute by mimic other people's tone, there seems no=
 need
> to over read.

I think the fact that you skipped the reference to commit c9e358dfc4a8
("driver-core: remove conditionals around devicetree pointers") was
relevant here. Referencing that commit makes it easy for the reader to
see that you are following convention used throughout the kernel and
not just asserting your own opinion about style.

If you add that reference into your commit message and send a v2, I'm
happy to apply it.

-Doug

