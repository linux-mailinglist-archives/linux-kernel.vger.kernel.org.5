Return-Path: <linux-kernel+bounces-137336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3A389E0A8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78CF71F2427A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B638F153595;
	Tue,  9 Apr 2024 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eWYbsfjq"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576C36FCB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712680983; cv=none; b=fQfqP0UzXO39Ic9uJsudAfrmdD7pNVso8YwpFvhTPi61YEfwa13URWNn8NdePxu1IhXLrL4Tjnnv3yoREnErngAin6c9jInMVBrCvf98hKVuuPicTyJiUUsFbzmSCqHyEapIpgxkHEP2JEH+RjR+PbYIz2+4NmzhQvipfdK5oHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712680983; c=relaxed/simple;
	bh=0a8GFmlFDrP2qZGUYBXjIAA37zI8J6F9L2EQlfe/B50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UGCLo/+KYUWd4nq9QjhgK4tg0ypMtFDweZqhbM0APUSGjKN9P3tw7+8RVpUDILvzhduRpHQxiPbwWBMXo58BV/SIQr90oi/yjVcv4d1Bvv5q6YFj792y/9eN6ON7MzlplaXbe3+hMctHdnWNiQke1YmcgtJrN0X02wqjWxmf6+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eWYbsfjq; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a51c6e91793so469819966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 09:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712680979; x=1713285779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnTqlWbdyt+TuRAaYpRi/f7MpcKj9Cbb2bnd4lfqWzI=;
        b=eWYbsfjq5WmEWpU7GNpCh/YO3NnimCd4eK8JZAleHjYccDZ4RXZ831mw3grjdNfag1
         MteT8ZJ+GgTmu34TfcUw/ZIEn4kyPN41Ph51LTXr7A8iaV1245+GoiSpN85PmEdEnqxG
         Euj13N23ay1Zs2oCDkS7Md/hwJXhoFcl/jl4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712680979; x=1713285779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FnTqlWbdyt+TuRAaYpRi/f7MpcKj9Cbb2bnd4lfqWzI=;
        b=eVaxXYB+UTcoJ4mEYE2CBmFRLGqmPw7JCv67IKIlD5i6449PceKCFGY1uR2J0z2Yvr
         XRO9RFDuZzxItymsTaymtuQYOF2R/cfJAjqUX13sULDkYMqPNMnqb9DcG6htv8ZPYPWM
         bLvA2ah0VZGd1//Byo4s+MlHggHmzuRhXXxBc3nY6IFIJUra64rKuTDdNrzb+Xpb9SIL
         tiF4IYYK02RfHwDZTWF52RXDbsXKa5dIwoqqTnO9Tz/dpHNfDGyL3x6mqiEBLXY3rhm2
         XCG/2gJaA5RLKocJpui46PZSzeKOsrEqTWBTzET7tJ3WT1Xz3H3XHN6H1TvWm3tyOEYs
         N+Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUpXiID0nUXMqU/hEVq384fRCLqYTEOdqAWVw9yb+fIO22d3390JULc5oxz+oy9IsxQjp2l0z9GyyK3PJORPe9s1Iozh0qGn8BAoLU9
X-Gm-Message-State: AOJu0YzeIEptSkN5OAcS1f42sjnisi7i5hbnzclJELXLf1oMEHuzeYcD
	vrxkcvZau2bya3tCM6EAIMfw/XIRuwb3T+qJRAE2DJYmyRBGsBbtGLJPl0aKBjE/sskxSHMPrTc
	=
X-Google-Smtp-Source: AGHT+IEu8lnRC2HQA3FJ0NOmJQP6ngX1yB4sSHxgnOGwakt/GSmPcll1lOBCDfBVT9daqwW1uOL1UA==
X-Received: by 2002:a17:906:b2c7:b0:a51:abd8:8621 with SMTP id cf7-20020a170906b2c700b00a51abd88621mr2521699ejb.19.1712680979296;
        Tue, 09 Apr 2024 09:42:59 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id l13-20020a170906230d00b00a51f0f9a2casm1163016eja.188.2024.04.09.09.42.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 09:42:58 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41650de9e1eso16254795e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 09:42:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXlpNJfEmJWXvDgMwe8f1H6UiFCYNRjlUr+brYFT+Lgb7DJ8avC1I9++7T1APXE8p5eSkRzaw6y6phCATB2dDQMf8pMQhErsLuO+PsQ
X-Received: by 2002:a05:600c:4fcb:b0:416:6adf:fe44 with SMTP id
 o11-20020a05600c4fcb00b004166adffe44mr2880442wmq.17.1712680978184; Tue, 09
 Apr 2024 09:42:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408151700.1761009-1-festevam@gmail.com> <2024040940-resume-polygraph-5800@gregkh>
In-Reply-To: <2024040940-resume-polygraph-5800@gregkh>
From: Matthias Kaehlcke <mka@chromium.org>
Date: Tue, 9 Apr 2024 09:42:43 -0700
X-Gmail-Original-Message-ID: <CAKZ8rEMg8SamD_R46LpA9LAh4WUhH=6zsqjkXS0ABVdPAK9Czw@mail.gmail.com>
Message-ID: <CAKZ8rEMg8SamD_R46LpA9LAh4WUhH=6zsqjkXS0ABVdPAK9Czw@mail.gmail.com>
Subject: Re: [PATCH] usb: misc: onboard_usb_hub: Disable the USB hub clock on failure
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Fabio Estevam <festevam@gmail.com>, frieder.schrempf@kontron.de, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fabio Estevam <festevam@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 8:29=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Mon, Apr 08, 2024 at 12:17:00PM -0300, Fabio Estevam wrote:
> > From: Fabio Estevam <festevam@denx.de>
> >
> > In case regulator_bulk_enable() fails, the previously enabled USB hub
> > clock should be disabled.
> >
> > Fix it accordingly.
> >
> > Fixes: 65e62b8a955a ("usb: misc: onboard_usb_hub: Add support for clock=
 input")
> > Signed-off-by: Fabio Estevam <festevam@denx.de>
> > ---
> >  drivers/usb/misc/onboard_usb_dev.c | 6 +++++-
>
> This file is not in the tree for 6.9-rc2, can you please fix this up and
> resend?

The driver has been renamed in usb-next. Shouldn't this patch be based
on usb-next and the backports to stable kernels account for the name
change? v6.9 sits a bit in between, since there is no stable branch
yet. The fix doesn't seem super-critical, I guess it would be ok to
leave v6.9 as is for now and add the fix once there is a stable branch
for it.

