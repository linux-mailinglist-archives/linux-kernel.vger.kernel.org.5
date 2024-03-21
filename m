Return-Path: <linux-kernel+bounces-109621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D324881B74
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 04:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9841A1F223E2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9B279CF;
	Thu, 21 Mar 2024 03:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1pWz6mk"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983CD79C0;
	Thu, 21 Mar 2024 03:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710991597; cv=none; b=ZloV69Ig+0ABIGsirSHg027nkaXBtKlJll3dKvF0TcxnrqPlUrrQSKB7MPy3PO6lAp7JewC4iUn6/ZHZeZackYkKXCZY0FkubiUV0bVTfaayKSJuLI/KVSXol1hE0VBZPmaXHQv/6QfYOGwA5URkVm+PiWMiSXBiH7b6zuzQe9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710991597; c=relaxed/simple;
	bh=ke/oAGc/MrcXkP76/nykPwcNPE4ORuVefrIwaF6dT7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mkAiHLF4JXV5F8/eBVMOrrRh8KhKHUYslq+KUB/h7AIqPnbm3w6VaCHjizDaogAiTTSs5qhv6xdiDZmRXU3c9lewYgbXreKiBHSreAysOcp/H2eqdJuzeVhICpg8Cu+abJz+uGFTKyk9XuqRH0ytX8R/S5+x2zamHVlwzS6Z9YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1pWz6mk; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3686717e82aso94805ab.2;
        Wed, 20 Mar 2024 20:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710991595; x=1711596395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0MuB5ySDlf80mKLJwWBjBqQwGvGCqX7FdKX4jErWIQ=;
        b=Q1pWz6mkhk8MnVWuBIeJ2pd8xEXA3vqQLAwgrlmM/Tt/HkiaTHXHOUYVIt/qDmGlOR
         7Hui8t37Y4ThqZjon6RhFjZ15pVxcTROb92z9VFfcWCI5epwRmXicpE3ZQNJvSNh5k62
         iIRV29TbChdgud1g92cR7Vsrp345YysAKpSp1YKi17Rbi0Tmf1RIazjlIGjL7JIPYw/e
         /58dxAw/6AEDTLnpcgDCXnLxls+j3Du6oI4SrSWkcbXuWuqcg8yWZfjyRkFJ5Tgpsz/Y
         aiABh91nep6x/WeMxJjgw2bxnb3DImky0N2nk4j1pUooMA5VQR7UyZSchXxTD5VZnjD6
         Nk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710991595; x=1711596395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0MuB5ySDlf80mKLJwWBjBqQwGvGCqX7FdKX4jErWIQ=;
        b=qqPPHxxH1O5kNEHyChcXD3Ic0umoEvo0zsksTP01MBHdUCYtySuoLXjGW3h0xEM/Sg
         bwz31N6O7JKfl7ywM3f45s6ozgbbaK56HC3tscLl9Q77n/HUPxwm4n2dRdihPzvYqDvV
         r3mMXYUUyS4RoGO2/qgeQQZEJgA/dtI0GZmvC1+46jKslvo7lO5rmIq0gr8Ml30LzCj4
         Q2jOruDkorIyNds40oWnlrquS9zoEpBBAst4RtKKr8M2RlQJFfS1oqwUGyygbVcwSTei
         B1NjsdVsVwpk0HuWADShQaUgqmavycNXWH9Hyy3lGDMa/m06PtNzVITMhZLhgzDZcskM
         MNcg==
X-Forwarded-Encrypted: i=1; AJvYcCUSHHx39m3G7gjyKljKjgo4P5QyEtc4+jHVqRL2ZUCv61E/xqv+45FoCQmV7bOPdNyJj6Qf7uCADWT4rzbOqooeQdOXJv2Ibgb4bKIf48Tdm4pW+LcO8XmiuwpXesIuvvKuNFOUfg/ceYI=
X-Gm-Message-State: AOJu0YzhTT7q1lQWgOSdKdqxlRWc47hQyq9tJ1sVQZPoEki3nauq64/k
	grc2euhhBZnch+/XR10dFaVd/R9ofpPZTYjgk57hJfVHqMFamfLDeZod5dREiM86RMeq+SDt5Hl
	qVSdg5m4jFf+ca0ZdMaT9eNEiok8=
X-Google-Smtp-Source: AGHT+IFc9RGbcaS9BK4282AsGdS9WHC1k3cMjtHAAfPxbdpowTsLcJUO6T6GCfuC6nwd3Y1eBaJZ6K2ufci7CeLK2Bg=
X-Received: by 2002:a92:d812:0:b0:366:43bd:f0f5 with SMTP id
 y18-20020a92d812000000b0036643bdf0f5mr4561373ilm.17.1710991594728; Wed, 20
 Mar 2024 20:26:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311111349.723256-1-chancel.liu@nxp.com>
In-Reply-To: <20240311111349.723256-1-chancel.liu@nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 21 Mar 2024 11:26:23 +0800
Message-ID: <CAA+D8ANGAw3MVPiR7oXY0-FDxvGfs3KDQ5CqxhLQa3Oaxd5jwg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] ASoC: fsl: Support register and unregister rpmsg
 sound card through remoteproc
To: Chancel Liu <chancel.liu@nxp.com>
Cc: Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com, 
	lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	linux-imx@nxp.com, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 7:14=E2=80=AFPM Chancel Liu <chancel.liu@nxp.com> w=
rote:
>
>         echo /lib/firmware/fw.elf > /sys/class/remoteproc/remoteproc0/fir=
mware
> (A)     echo start > /sys/class/remoteproc/remoteproc0/state
> (B)     echo stop > /sys/class/remoteproc/remoteproc0/state
>
> The rpmsg sound card is registered in (A) and unregistered in (B).
> After "start", imx-audio-rpmsg registers devices for ASoC platform driver
> and machine driver. Then sound card is registered. After "stop",
> imx-audio-rpmsg unregisters devices for ASoC platform driver and machine
> driver. Then sound card is unregistered.

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
Shengjiu Wang

>
> changes in v2
> - Fix build errors reported by kernel test robot
>
> changes in v3
> - Add a new patch for fsl_rpmsg to register CPU DAI with rpmsg channel
>   name
> - Update imx-rpmsg.c to get DT node of ASoC CPU DAI device with rpmsg
>   channel name instead of using undocumented bindings
>
> Chancel Liu (5):
>   ASoC: fsl: imx-pcm-rpmsg: Register component with rpmsg channel name
>   ASoC: fsl: imx-audio-rpmsg: Register device with rpmsg channel name
>   ASoC: fsl: Let imx-audio-rpmsg register platform device for card
>   ASoC: fsl: fsl_rpmsg: Register CPU DAI with name of rpmsg channel
>   ASoC: fsl: imx-rpmsg: Update to correct DT node
>
>  sound/soc/fsl/fsl_rpmsg.c       | 43 ++++++++++++++++++++-------------
>  sound/soc/fsl/imx-audio-rpmsg.c | 21 +++++++++++++---
>  sound/soc/fsl/imx-pcm-rpmsg.c   | 11 ++++++---
>  sound/soc/fsl/imx-rpmsg.c       | 28 ++++++++++++++-------
>  4 files changed, 71 insertions(+), 32 deletions(-)
>
> --
> 2.43.0
>

