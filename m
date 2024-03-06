Return-Path: <linux-kernel+bounces-93356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F98872E78
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97CDD1F226C7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2925E1B948;
	Wed,  6 Mar 2024 05:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LPq9Et/x"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E26DDBC
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 05:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709703562; cv=none; b=VvjG1Qwe4aQz9MX8C2he5LPxVw1oWjhgKuI2DFgf5cunVfte6OdayCHH1/IJUGpbY6BYFRIU3DvBlhfuyoNf7/b6dPvC/JngiwTcsgk9t5/UMaQR+4JhVEND+2O8/wsEQO0EFtcih8s2W2qscXCBuFv2Bik8GAxS9ZbpOu53YGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709703562; c=relaxed/simple;
	bh=ddSA5zzRYE4Z6GgeQ7m0thELYbzemgtwrUdnT0mQQgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r4uBJZy9Eab5CRBw3wWqFlZvAF33uIJ2g6/VfKIQ8dgYVQ2wDGMD+iklMevOgB0LSKLvh0BAsQKUDKtRvZnDXWZHVMpZo5624UJhYXK4e9KkPli3OCSKDWnRx/eji/UwQrD0We6+9PwHGyKVC6eqqKB+1uV5rWvA8885bBxKBOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LPq9Et/x; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-299dba8fd24so4359846a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 21:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709703560; x=1710308360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcUilGZ4h9+6q9Pt6yhuKYLmboCM89xOd3b/ir0MpKQ=;
        b=LPq9Et/xK+FQNxYFWus4uoyW3z/Ck4R1/oodNJS+AUpSuOA0QPpHBQhrUG3KZ6xPt5
         o3O8PHb4/PwoBRp6iARgK+km8yg2YX+MWY1TE7uy33c1laocmRt2MyTqsFKTOIeppPbn
         KENK00KoXx7Ft6N6E2HfOUduG4p4aWbLhJjk0gXtCts72YI21eCoE/gqCVW1QcGlBQdG
         n/QLpu0uqViqxp8BPN2oXJ/uNeFxZe6k/NZR5JkjajD73IJiKwcqdl/GiJMxYcK3PzMH
         awpyI8NyFfTZXrcJtB5TW2hZVtWwz+Wr3sYx4O8Qptf5Mui/4b6+D0bCfl4ylXT5tTEr
         Q1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709703560; x=1710308360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcUilGZ4h9+6q9Pt6yhuKYLmboCM89xOd3b/ir0MpKQ=;
        b=ZNaPv5KOs/tBdJZkfg7bRzcMEa3xjpcFKabHlb8QuZv7/1Tzo7I6loVhQj2yMGHvAx
         26KtzuGZLuJWF5xwb3HQjUEf5g74bcx88CkVKUr7/Mzwcs2HXU+BehNAC4tci0wur92c
         5xSmsTk/W7najsNBMaf5LIVtSJHORRDPNf0Iy5OGXhNv4k4Ok5ceMOsvUsptj4WhrsZh
         2wOUeBOJZPH69haa8+qaJ8unqVKbkiVIGlCpTiwZMR27GaOHK1KZPraUANSJ66p+umiy
         F2g1Ac2avCj7NiJtraseIIuim3bsU2V5RnMeS3pwODJ/SxtZ1LBIPiD9X1XdBhMl9GcM
         Z3Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUODcRhtgbOh9g3wnwWWD70ryMa0FHnCgjB9nCX+tv97jzoNgtnBWR7QVY/8ScxrGkX6IZSYWGD7iG811gJS4Ii2CLgf9NoSo/1nIli
X-Gm-Message-State: AOJu0YyQP4IexkdrupHxlIyN+eJWCZT52QijRgFPAbSgHLT0RtV7UHju
	3Q2aUmppc1EodAzUkJA2W5GQmf/BVt3Qh8Vmy0PB0+F5o1bO+Er2U3qvQji/9ErSGeeIFGq8sFN
	cPKebaKZV4OYEqKAw4NRvKFxucu+n3Q6THwdp5w==
X-Google-Smtp-Source: AGHT+IGRZyAT81pD6X1QOmiFpoQvC39nCipzeG7JdrCxsGsdvCjP7koRXqRQWO8jSQhWMylo7OsdCSwgbU90nLHqVEg=
X-Received: by 2002:a17:90a:1097:b0:29b:2779:6ceb with SMTP id
 c23-20020a17090a109700b0029b27796cebmr12289518pja.34.1709703560306; Tue, 05
 Mar 2024 21:39:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305012604.3869593-1-yangcong5@huaqin.corp-partner.google.com>
 <CAD=FV=XUhBUscqx5TY6Ax94_St6xggnirP6hiy_VG9Y_1uB-kg@mail.gmail.com>
In-Reply-To: <CAD=FV=XUhBUscqx5TY6Ax94_St6xggnirP6hiy_VG9Y_1uB-kg@mail.gmail.com>
From: cong yang <yangcong5@huaqin.corp-partner.google.com>
Date: Wed, 6 Mar 2024 13:39:09 +0800
Message-ID: <CAHwB_NJqu==AMT9LMM3Cdzp0iugOcFC3VnT01HTPx2HbjNX4OA@mail.gmail.com>
Subject: Re: [PATCH V2] drm/panel: boe-tv101wum-nl6: Fine tune Himax83102-j02
 panel HFP and HBP (again)
To: Doug Anderson <dianders@chromium.org>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	hsinyi@chromium.org, swboyd@chromium.org, airlied@gmail.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Doug Anderson <dianders@chromium.org> =E4=BA=8E2024=E5=B9=B43=E6=9C=886=E6=
=97=A5=E5=91=A8=E4=B8=89 08:23=E5=86=99=E9=81=93=EF=BC=9A

>
> Cong,
>
> On Mon, Mar 4, 2024 at 5:26=E2=80=AFPM Cong Yang
> <yangcong5@huaqin.corp-partner.google.com> wrote:
> >
> > The current measured frame rate is 59.95Hz, which does not meet the
> > requirements of touch-stylus and stylus cannot work normally. After
> > adjustment, the actual measurement is 60.001Hz. Now this panel looks
> > like it's only used by me on the MTK platform, so let's change this
> > set of parameters.
> >
> > Fixes: cea7008190ad ("drm/panel: boe-tv101wum-nl6: Fine tune Himax83102=
-j02 panel HFP and HBP")
> > Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> > ---
> >  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
>
> I actually already made these fixes myself for you and applied. My
> notes were mostly for you to keep in mind for next time. This is
> already in drm-misc-fixes as:

Oh! I see. Many Thanks.

>
> 9dfc46c87cdc drm/panel: boe-tv101wum-nl6: Fine tune Himax83102-j02
> panel HFP and HBP (again)
>
> -Doug

