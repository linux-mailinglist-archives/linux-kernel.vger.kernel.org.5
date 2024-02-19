Return-Path: <linux-kernel+bounces-70941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBEA859E6A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B1A281FCC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA8921360;
	Mon, 19 Feb 2024 08:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YdDr/1Oz"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA392135C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708331777; cv=none; b=aLAQ/bQdWrS0ishaWsSU9MC/9Q9wlsVBAi54LNxBj2sukwurSLJ2cPHDbfgIAMFAyXWnt3NyfybHWeG9k/DnIP+fgGU4UtIyhPIraJi9lJTidJVcREvQhaAF79jBtSVVDuLgt6wdMssgzCpSgNxnXsiL74/Xp4ZXSfb4ScaLJMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708331777; c=relaxed/simple;
	bh=Rx9ZJKs/bR/usyBx3lVmlWkCDToMSZHSILyEGGUJ6aI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Izmuxfvu3dBYp7GCv7c6J3FLTKwl68Nrx05fWqQ1EVKrQFGOgL1u0bUlwY9q8OIKhNGiVg/doUi59sBfbsybKPGksNn4T2UU+BYYHyZRunNOYxF/IXrgv0lYkZdmV+J8d3/cTgAs+XLTv2rygNmiDcxQFOe8O1/JhUwYyuIYBkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YdDr/1Oz; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-563dd5bd382so10700a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 00:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708331774; x=1708936574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8QoRFayjt/6bleBBpTu5vM12K7hqxhYDmZf5s1lnAg=;
        b=YdDr/1Oz8JYDQ2flZsPaGpxoiBdsL8C8Zev9YL3hR0wsj5LRUUqQAnIuSSFVIFfk5m
         COjJKQ2uYf5INL02sVySv+0ec2YckJFvrqS8c11Dix9oEPwywPZ3Q7b7cWqvnCNpJgPo
         QeeGAOzgLfkMirb4ZOzryiy1M/r9MKyy2dvGbsozNr7VqjGi9XdG1eBel4GqD8P1eWJJ
         WQqbJ6bGiRGv2EzA0n3z5vBL6XRpFX6OH14eActBy/anKnfvM/2p4NerlVeQamyyKxtw
         iMghrU/KvzlvUBGj1ROGm3SFV0ScgVzsHSwrF7XmxOL3PVk4h5DUkoXss1455ObA3LBG
         pj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708331774; x=1708936574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8QoRFayjt/6bleBBpTu5vM12K7hqxhYDmZf5s1lnAg=;
        b=ZTRNEx0h12M/+2pg+U4uHxruUCYYF3mxK4N5+ZQQvubDftcd2M/zPJaTkyejOJRCTD
         aT//gzNO/H1ZT6A8q70xY/qg3I6PKbWMwepY/cJ9WpO7aeRUx0uztemfAItywUTWQOTU
         RRP1lTtLsza67hvcHXzbfomMe0irM0qw7r0X26rqFJ48FO7u83u192iE35hy5iud2cg7
         qbIbFD+6xyiW7HDxJ27UwYTVQx+n+tR8uJuASe2+3lsG3NPMtn7POGTWXz6UuvKnPCUT
         ZR+o2rxSfnF8Aj8oT39l0bng/Poy2tohgqUzjiGWzJpn+RWuisENHBV63zdvyMJLjSOA
         XmWg==
X-Forwarded-Encrypted: i=1; AJvYcCUNj/gaXmc9TLLuKQRpVt7yg/yQBONUgS2V2j9RLOuoyKdsoOVuoxW76A2bLwTChkiyzq9Y40gqYKX7rU4ssy5nm2R8oBYD4eWCpOjd
X-Gm-Message-State: AOJu0YwdZfe4TaYjT01Fnnfb/tvm3sqvNr//aDEHL5dBFSeXtxqCFcMw
	HUS0tcqCA3ubK8zCZoKNjSK16sxTGLY9BJE3bP9jJWGvI4cNoYjddoZVHviXgr2+m0ANiSWW+HY
	Unse4nKHSvJljSJLJGdZbs5RtPSzBsY1JDaZE
X-Google-Smtp-Source: AGHT+IHY6CT7bVLUITQoLpctqBSsq7nAekyPp9XNaT4BIubHaz9rpg4bjl/zXDzr3cCzpfHEsPfJO1FNnKV5xNnneeU=
X-Received: by 2002:a50:9555:0:b0:563:c0e0:667c with SMTP id
 v21-20020a509555000000b00563c0e0667cmr221141eda.0.1708331773467; Mon, 19 Feb
 2024 00:36:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219061008.1761102-1-pumahsu@google.com> <20240219061008.1761102-4-pumahsu@google.com>
 <2024021951-coping-ferment-2023@gregkh>
In-Reply-To: <2024021951-coping-ferment-2023@gregkh>
From: Puma Hsu <pumahsu@google.com>
Date: Mon, 19 Feb 2024 16:35:36 +0800
Message-ID: <CAGCq0LasRTLQA59g+kPekWb5ZKzeHSX9c4C8LCsHwFNfT0JHTw@mail.gmail.com>
Subject: Re: [PATCH 3/3] MAINTAINERS: Add maintainer for Google USB XHCI driver
To: Greg KH <gregkh@linuxfoundation.org>
Cc: mathias.nyman@intel.com, Thinh.Nguyen@synopsys.com, badhri@google.com, 
	royluo@google.com, howardyen@google.com, albertccwang@google.com, 
	raychi@google.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 2:31=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Feb 19, 2024 at 02:10:08PM +0800, Puma Hsu wrote:
> > Add Google USB XHCI driver and maintainer.
> >
> > Signed-off-by: Puma Hsu <pumahsu@google.com>
> > ---
> >  MAINTAINERS | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 960512bec428..dc0e32a3c250 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9081,6 +9081,12 @@ F:     arch/arm64/boot/dts/exynos/google/
> >  F:   drivers/clk/samsung/clk-gs101.c
> >  F:   include/dt-bindings/clock/google,gs101.h
> >
> > +GOOGLE USB XHCI DRIVER
> > +M:   Puma Hsu <pumahsu@google.com>
> > +L:   linux-usb@vger.kernel.org
> > +S:   Maintained
> > +F:   drivers/usb/host/xhci-goog.c
>
> You are not paid to look after this?  That sounds odd, can you work with
> your managers to do this, otherwise this is going to be tough to do over
> time, right?
>
> thanks,
>
> greg k-h

I misunderstand the definitions between Supported and Maintained,
will update to Supported in next revision. Thanks for advising.

