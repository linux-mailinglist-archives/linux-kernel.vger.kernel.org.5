Return-Path: <linux-kernel+bounces-56332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED89684C8CD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DD581F261AB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFF81D539;
	Wed,  7 Feb 2024 10:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CyVpQ0u3"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFB51D527
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 10:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707302394; cv=none; b=F77an/yX+U230NkgANDy0OZVatd3p+cPZkXhhg9GguZU/4wnznBeVLZeV8CE8zB4DxmntSHCWXM6i+uTm7KprTr3ij1OCGWoG4y70CVNdJP4490JEe0ytH67ZWHlQJs/tWgKdgzGcUUjW/uzotCN+OsNWBc/S+nZlLbgpJc+6wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707302394; c=relaxed/simple;
	bh=UJHwXXpE/nAuR0fBfVAXevegqGAPMSKwW1mmeyrTcM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jGvmlEyezC8XAa2kqfY0xHZtqM/5K/NQtjk4M+ds49Alrm+c50GA/M3T4SUCgtdLTcxEGAsq3m0nOJPf9RB22Zp5DtVJOxuSFyqiuLO0Lgzc3v+no6BxMdgCdy67ETtCa0h5id4QIIraYHGrXz3eiEWzrI7cVviMfE5oyG3mlOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CyVpQ0u3; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc6c0dc50dcso320136276.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 02:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707302391; x=1707907191; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GvY+WSiS1zI1+PqrE+k4bBcggoEtuFvZaH+5w24QDOs=;
        b=CyVpQ0u358vdfHNU38mldQM7TWeWx6ceOgf4lFBfqiMP3sDpZxEHYDs8JSXztgRVop
         fnKc3cI2mN5hhgLABCl6k5JzS7uHk/GyTJwgbLpDLSw3ZowpwmnIfm2vSrr9IbDpgu4q
         WLjJx9gKcjKC9Avn8HX9mGRd+5I7yjcHapuzvpbZbesOpkvasMnJVt1v0veleH7Oh/1I
         M59lBUfNJTBs+BgUrfIiOOHDoqnvLrozPxnZhST4gb5bAoVTJHhEXmZ08RKM9e0ivY81
         bTE1c98DOZqsyXs8jWMSWhFK+tlXowKyt8dpuIs2A2bkZgrfavprsS8hmc4kvw5wNzQE
         Mjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707302391; x=1707907191;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GvY+WSiS1zI1+PqrE+k4bBcggoEtuFvZaH+5w24QDOs=;
        b=o/ayGSCGhSLnun+5MGgUW7PVKoNEWg375J/WeSyfLphEb1DawrCdmGGmGvyJrJsxxQ
         /Bazipo+4tbANT/QbnUEuG7YKVwuM+7itLLWestWCIOOwZstpIJN3fElWks14GSrk7GA
         WxyN4FePdZIbe0eq/ZwjKhjDlsdPZ3/+Ran/TtFdfOENLCOION385y/7VUI+LXkVcfyu
         3UxU8wnd/5lXzZM7BJIQP8glRPuaDmYlh1KmwbWYafl6D0ywt+omd8AF9/P5QaRvACzu
         qOAPiOkl667vAL3uN9AgzqVTuexgB1BVbCpHMURtyx4rxqHPx8tmckdG9ibzzq6BuqJS
         Qu9Q==
X-Gm-Message-State: AOJu0YxOQT2C0w543eDu2AcMWda49TQsWt1utxckS7t1vvbFdAtVVZn/
	VtxHyMsyO477FLzUu6ZWiXljO34xasLJSQd0UllBn39ISW3QolmhU/K9vzG1Hp9zh/vMb+53b8Z
	BZNk4D29y4GoIxfcmGJ00aQrh/NF6ep/tEMFYug==
X-Google-Smtp-Source: AGHT+IFHtFKOIhSveVFD/TROCOxd/QHma4B7KzpMcCU9j8LUGg8Tqu/tNwIMsfwXilDzhbXzrjZZBZEpZ33fvT7mMq4=
X-Received: by 2002:a25:ab50:0:b0:dc6:f90f:e376 with SMTP id
 u74-20020a25ab50000000b00dc6f90fe376mr3978312ybi.45.1707302391434; Wed, 07
 Feb 2024 02:39:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203-bus_cleanup-gpu-v1-0-1b6ecdb5f941@marliere.net>
 <20240203-bus_cleanup-gpu-v1-1-1b6ecdb5f941@marliere.net> <CAA8EJpqYH3CM8exv68S7KU-CK5r=jM81UPjiW09qOiqrg1ThKg@mail.gmail.com>
 <ZcJKSCbAwm7SYx4v@phenom.ffwll.local>
In-Reply-To: <ZcJKSCbAwm7SYx4v@phenom.ffwll.local>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 7 Feb 2024 12:39:40 +0200
Message-ID: <CAA8EJpoiAad1Sgjgt-gxKf4YxEQ8T9LcC=DQQy8vn82KAf5USw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm: display: make dp_aux_bus_type const
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	"Ricardo B. Marliere" <ricardo@marliere.net>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Feb 2024 at 17:03, Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Sun, Feb 04, 2024 at 10:24:46AM +0100, Dmitry Baryshkov wrote:
> > On Sat, 3 Feb 2024 at 22:20, Ricardo B. Marliere <ricardo@marliere.net> wrote:
> > >
> > > Now that the driver core can properly handle constant struct bus_type,
> > > move the dp_aux_bus_type variable to be a constant structure as well,
> > > placing it into read-only memory which can not be modified at runtime.
> > >
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> >
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
> Just to make sure this doesn't fall through cracks, I'm assuming you'll
> push this to drm-misc-next too, right?

I was out at FOSDEM, now done.

-- 
With best wishes
Dmitry

