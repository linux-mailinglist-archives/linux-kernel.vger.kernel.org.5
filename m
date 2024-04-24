Return-Path: <linux-kernel+bounces-156986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7198B0B37
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC354282592
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCAA15FA8E;
	Wed, 24 Apr 2024 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oY+3fx0g"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DCE15CD7F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965693; cv=none; b=uNYqNFLq5ruonOsTzj1gOKVy7/BlV/dBpDzISTH2iAuLcUWb0EoeS9J5YIKYV+OkaxZA7r9NlCksxUDdaf2p4fcak34CKucXEiZZ9lomRVtWS1sBTPq1Yc4+uOMPVk9crVwwcigeybT9vFtw+qHINxZidEJ0d3CgcmRH0BHlfE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965693; c=relaxed/simple;
	bh=v5uts0F+G005dBPvbk0jOnlqwhvA4TASHvWq3ETeWdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tCeilAZFufcHddGcnRdw9wTiJEiq3yYRxDAhA3ov76btNU3S2mOV5+2Wej6qoyn7LLDRjVTNRmqTFNDLA/Btwg5spXDYAi/kLhOWw017cUCzs8oNIbm1OFGbiv6veM9b8aJJ84GOSjjMQhndoom24cVaSlhptKPrQkhLBFyTjHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oY+3fx0g; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-de55708c616so1723456276.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713965691; x=1714570491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5uts0F+G005dBPvbk0jOnlqwhvA4TASHvWq3ETeWdw=;
        b=oY+3fx0gQCP4JdIzfu5YUlLxKHqmaBqlM9oZmXqM5rMYPv8WRwObnn/i/Acl2Lq9PY
         qewv8MG2IXzRg/2YB59vw824iXr3W0KwztRRhxzubXLzsWu44yFyvIDTEiRqhjP3U/IH
         yb3KWNb26saDPdkdn9YLVigbqTNO7ezBc2Gns+fc0iG8+UXcKW88vys5zWNVcshCaPAf
         MhS/Yvn3wnNY+hSsA4kvwd683IV+P3PxDT+SEr9BqiAyMuA1579t5Ng5wsfBsHDETuem
         +NhXucaYEu8wECoq47CFc8kPjVZOEcl5evjYRXJUFRTWgXZ7q+aE+lTiPU1vlzliy5LN
         o8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713965691; x=1714570491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5uts0F+G005dBPvbk0jOnlqwhvA4TASHvWq3ETeWdw=;
        b=EC+EEpIxtAa7hbHd0IrZCYSUBl5H7X3GCFpRHq2U5QgESwFZ1eAmiXbannovIu0+Cl
         8p5rMw3SCQ78/2An9uTfGiQo46iGYJWhQk3keeVSzkaqiZlepr1gmPdCs0w72BUb7Au3
         FTLLKDBFfoogebORKqERj6WGCKEgsJvTGBo3GHx20/WBbOuTs3v+m+i+evntPL04fIIb
         cHSljElWbCtJ/KEiO6B4s7/VKao/yDX9JJNExfiKulZVjE80r/qLGstWO/RrCikq8AJv
         5nFmQPa32ZT+eK8q/s35/V+nJ3ncwjjlYDZFsTDzpAB+lBdDzoEpEtiSCnH5J6gNGvo1
         xMWw==
X-Forwarded-Encrypted: i=1; AJvYcCX/Z5/XcNxI8CtDMitxsWRvx7YlseVkypVuKCxSvckMRV+zsVljC6MlfblBZwMVp3DwCMfP55qg3uPHnWtnapph6bUXCPe3Ni2AAu+3
X-Gm-Message-State: AOJu0Yxeo2OILlDmlK9viuIzd/N8uiLY6Wfcpupqezys8beBEG6NwUd4
	V5fuuO3MP05uVYGPGmNcAW/Fw9zDEKrGP1ng0pz96a1Q79L5ezsKZQdnAXDrjwGQrQK3Y8St0uq
	WQJ+Lncapt6FSKkSE4Xk4I0FUCps6t0AJmOvEVA==
X-Google-Smtp-Source: AGHT+IHyyl3VXRzVgrpc497VuwR/tGfdtBR3F2BBQ+lp1bkMbMbay8ctwKEQp7xRENbiJ8Hez152lECflDB33HFqk9M=
X-Received: by 2002:a25:a1a7:0:b0:de5:53a6:24ed with SMTP id
 a36-20020a25a1a7000000b00de553a624edmr2514259ybi.50.1713965690752; Wed, 24
 Apr 2024 06:34:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422164658.217037-1-sui.jingfeng@linux.dev>
 <Zie3ebHOEpWHj1qV@smile.fi.intel.com> <d5bc1e73-a553-451e-ab74-f5f0ca259c6b@linux.dev>
 <hcltp2bbxxg2t7ibmzgiib7mgbwgmvzwnnq6mochdh7c4h76r3@bxj6yk5zq64e> <ZikE4qOVO7rgIs9a@smile.fi.intel.com>
In-Reply-To: <ZikE4qOVO7rgIs9a@smile.fi.intel.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 24 Apr 2024 16:34:39 +0300
Message-ID: <CAA8EJpr1FSjizAh6Dp5Bmux3NrGYh=BfHFL4D1fa87Og4ymY0w@mail.gmail.com>
Subject: Re: [PATCH v2] software node: Implement device_get_match_data fwnode callback
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Sui Jingfeng <sui.jingfeng@linux.dev>, dri-devel@lists.freedesktop.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Apr 2024 at 16:11, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Apr 24, 2024 at 12:37:16AM +0300, Dmitry Baryshkov wrote:
> > On Wed, Apr 24, 2024 at 12:49:18AM +0800, Sui Jingfeng wrote:
> > > On 2024/4/23 21:28, Andy Shevchenko wrote:
> > > > On Tue, Apr 23, 2024 at 12:46:58AM +0800, Sui Jingfeng wrote:
>
> ...
>
> > But let me throw an argument why this patch (or something similar) look=
s
> > to be necessary.
> >
> > Both on DT and non-DT systems the kernel allows using the non-OF based
> > matching. For the platform devices there is platform_device_id-based
> > matching.
> >
> > Currently handling the data coming from such device_ids requires using
> > special bits of code, e.g. platform_get_device_id(pdev)->driver_data to
> > get the data from the platform_device_id. Having such codepaths goes
> > against the goal of unifying DT and non-DT paths via generic property /
> > fwnode code.
> >
> > As such, I support Sui's idea of being able to use device_get_match_dat=
a
> > for non-DT, non-ACPI platform devices.
>
> I'm not sure I buy this. We have a special helpers based on the bus type =
to
> combine device_get_match_data() with the respective ID table crawling, se=
e
> the SPI and I=C2=B2C cases as the examples.

I was thinking that we might be able to deprecate these helpers and
always use device_get_match_data().

--=20
With best wishes
Dmitry

