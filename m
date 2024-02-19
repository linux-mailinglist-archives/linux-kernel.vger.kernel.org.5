Return-Path: <linux-kernel+bounces-70644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3D1859AA0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 03:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484D52813CB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 02:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980424405;
	Mon, 19 Feb 2024 02:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKkk/BcT"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6836EEDD;
	Mon, 19 Feb 2024 02:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708308554; cv=none; b=A01xum6K4EwKfn6YU0MEgBwOJDHnCMp6cp+U2sIBN+1yThhRM1uZsFRTTpPO3C8DFDnYhMHbFCc8tFASa3EpsiGlied8rtZbzBH32un7E8K8VrMF0eYJ9vMufoGX6xdfbJ8TQY7fbhwToKUpmEBtXwKAurUaChxVcYl3X0Cc6Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708308554; c=relaxed/simple;
	bh=nh9PlCY5GHhOe6k2T31PX2SYfQhyKcaZxGHW7Vhc+2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=DLZFrPA61W32fSQtlus7mGaOaP7uSP1unLLyMnJXomT7QjB+PCPZUiwJdzhg99NIYk7Y6O7G6uJXSpv6XNaPgf1VEaL71Bu1HKCeyUATvjD39wuGtB6h1PWf9MY2yI8eXSXyNmGuIA7vn77sFQe+PKg+3U1ujWXH73JPaR4M5LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKkk/BcT; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5ce2aada130so3466007a12.1;
        Sun, 18 Feb 2024 18:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708308553; x=1708913353; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIWM3tJrA0wlobXoamzegxBja/IHtDSwJBifnTDGEqo=;
        b=RKkk/BcTlOfWAuWXfzhG1FHG7LVc6+GLG4JdnHeu/PTLDt69SO4tN6aKjqtkwrXFOZ
         3RXEU/GhKhwq+szqSHFd22y8swkmMM/OxkzNzGOG/cRVRmZz8KS4fPex5xqfzWojrY3m
         k/zL7uSHioUKR83bC8Sd676J2bDYxhgtfYmcGepcauoMnC15E4e7DFTE3EMmdYn5roG0
         CLfB6EwUAlPlpvHebcCVOspJIdA5dJu6vqenKpxDnxEWdW3BKcNJCuzkT7iPv6hIUZpZ
         ATlams5XslWVoQcxBeaBysY6+W3wVMF78LK4vaZmJKnGYU7gG+GlZjLQEXzcYRc3nnL6
         51pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708308553; x=1708913353;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIWM3tJrA0wlobXoamzegxBja/IHtDSwJBifnTDGEqo=;
        b=N8rIyWq8eYcGtyzFmo9yp8D/CBz5qQiRFiD9mg1rY7OLNGivwg76ZPr0ZJPyWqTXWh
         E4OyBVMFx16McRgW/JlztEdf24Fz3xMiatggQKoQchgFU2r5iaYrTieMuKzmbP99TGcg
         oTfdCY5DUCerXZKW2duHov+e5OtZnLwu1eBy3ZFmaEc/+TbslPmL/84Ut6cgPmjTdLDM
         AsEDEUolxpUTCKt5+NyGo5u3W4aURKHrrOhOHyFcn8EIrsYjMZqdNKR0FXnWXOyTEjAZ
         lJZlJsLRGsEedv8fdXpGKy5KJ4y29+HF+XRmHhNvwVz2wQhwqdcxLo/7mu4KRCgY3138
         IeVw==
X-Forwarded-Encrypted: i=1; AJvYcCUrn238jSfMXhASi0iRP2iwHE1lM4yzOMEpldmN/JQQH9UeccX2YUCF/5+jmWCsKSyoTJor7FlTP08F65L8T3kaF2oiM7bpmX9bRSmaUvvr51aMddM6muinMRwVtjH7SMrsaPav11dp/hk=
X-Gm-Message-State: AOJu0YwEKLjY/tkhvmf5GvbKuH8IQ/5lRaBsv3pkEV6NpZP0mpoOk4V4
	/CwXAFesIQoMVI2LnRtfayz+8jgm5hMJuSzlTNe1YIaic3F3iyTi8a61giDKFUKNJKnHNdheyoz
	GN9Zny0OwMKcqEenUUJmytOmyUMA=
X-Google-Smtp-Source: AGHT+IF2RMqM34fBFV5KxmziGBjHWSjfCqPFe/feKRYt3Cj0E4XU20PqYJXg760XTmA/7Ftm2iaw1V181fxcmgHDFEM=
X-Received: by 2002:a05:6a20:9f91:b0:19e:b614:48ad with SMTP id
 mm17-20020a056a209f9100b0019eb61448admr10957320pzb.5.1708308552507; Sun, 18
 Feb 2024 18:09:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217185202.1754750-1-megi@xff.cz> <20240218205908.GA12766@pendragon.ideasonboard.com>
 <pftafukuzq7qzbhlvwtmeg3mburnttylgy4246timlghtrdgx4@r6munvmj6oqt>
In-Reply-To: <pftafukuzq7qzbhlvwtmeg3mburnttylgy4246timlghtrdgx4@r6munvmj6oqt>
From: Adam Ford <aford173@gmail.com>
Date: Sun, 18 Feb 2024 20:09:01 -0600
Message-ID: <CAHCN7x+zi3WxnY-mxZFKePs1cS=-DprEmh_CnypJ4XK7xBzjMQ@mail.gmail.com>
Subject: Re: [PATCH] media: rkisp1: Allow higher input resolution
To: =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-kernel@vger.kernel.org, 
	Dafna Hirschfeld <dafna@fastmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, 
	"open list:ROCKCHIP ISP V1 DRIVER" <linux-media@vger.kernel.org>, 
	"open list:ROCKCHIP ISP V1 DRIVER" <linux-rockchip@lists.infradead.org>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, 
	Paul Elder <paul.elder@ideasonboard.com>, Umang Jain <umang.jain@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 3:02=E2=80=AFPM Ond=C5=99ej Jirman <megi@xff.cz> wr=
ote:
>
> On Sun, Feb 18, 2024 at 10:59:08PM +0200, Laurent Pinchart wrote:
> > Hi Ondrej,
> >
> > (CC'ing Paul and Umang)
> >
> > Thank you for the patch.
> >
> > On Sat, Feb 17, 2024 at 07:51:58PM +0100, Ond=C5=99ej Jirman wrote:
> > > From: Ondrej Jirman <megi@xff.cz>
> > >
> > > In BSP driver, it is allowed, and it works in practice. Tested on
> > > Pinephone Pro/RK3399 with IMX258 at full res.
> >
> > Paul, Umang, do I recall correctly that you have a similar change ?
> > Could you review and test this (especially on the i.MX8MP) ?
>
> It's also a limit from the datasheet, so the change should not be that
> controversial:
>
>   https://megous.com/dl/tmp/d2b333043ecebaf3.png
>
> (so that it doesn't sound like I just copied the BSP values)
>

From what I see in the i.MX8M Plus reference manual, it has a max
resolution of 4096x3072, so it might be necessary to move this off
from a #define into a structure that varies by product family.

adam
> regards,
>         o.
>
> > > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> > > ---
> > >  drivers/media/platform/rockchip/rkisp1/rkisp1-common.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b=
/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> > > index 4b6b28c05b89..74098ddbeeb3 100644
> > > --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> > > +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> > > @@ -33,8 +33,8 @@ struct dentry;
> > >  #define RKISP1_ISP_SD_SINK                 BIT(1)
> > >
> > >  /* min and max values for the widths and heights of the entities */
> > > -#define RKISP1_ISP_MAX_WIDTH                       4032
> > > -#define RKISP1_ISP_MAX_HEIGHT                      3024
> > > +#define RKISP1_ISP_MAX_WIDTH                       4416
> > > +#define RKISP1_ISP_MAX_HEIGHT                      3312
> > >  #define RKISP1_ISP_MIN_WIDTH                       32
> > >  #define RKISP1_ISP_MIN_HEIGHT                      32
> > >
> >
> > --
> > Regards,
> >
> > Laurent Pinchart
>

