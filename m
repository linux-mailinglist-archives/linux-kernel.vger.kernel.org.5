Return-Path: <linux-kernel+bounces-51554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D21DB848C70
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1029F1C21824
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B206F18C36;
	Sun,  4 Feb 2024 09:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W9Cr5io8"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7618A18AE8
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 09:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707038700; cv=none; b=NQwnX0xGOjAZKlZUHkNKaAPeCYkeFe8YOACgnvSS0/m8qOkZxolRSgoYQVOyU9dsq+b1TXB04MPi9rrme+mvIhzXUW9X5xi0SId0JE/e8zf8bwAFrzO0pRd7I8jgrfE/AEdleTyb5Pk7i83ojd2fJrcPKLgi6GDPx4rOSzgv5Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707038700; c=relaxed/simple;
	bh=c22ibbLWdRYtRiSU4q2uZwp1/sRlSaINMVqva6CigiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xlmilm8QgQE4qfhUOwcFKzxWCsXivQMRmO2XHO140ntf0GVqXfAiNAAF4qOXSxRzynVjyIr6MBVHkLR89aqOm15ODsj8SMngiBRTpj4BdjD1QCeiKA3QmV+wTQjUZ5jEKVtczwI1sK0ghc3tNtsHCqb5I3W6RRg93qAkfsxd+SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W9Cr5io8; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso3223802276.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 01:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707038697; x=1707643497; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2b+xr5BMCprvoEPQzNmAjEYtPrTUzef8KsERa7FbL7o=;
        b=W9Cr5io8QMNMmvcwsrNCSohdOGRTykIrHj4YZ5V3fQO7CfQuTxfC+Wcr06zRA+qyQe
         cOmbC6LFid37c0/YdlnBJVrs9838ZDTkMvLJ+jZRyf/qbgFLXry2PwubXjeWjKGxFeie
         CCo5Avi/NqODHDOACPs3l63R1jEQvkHNBCyeLG5burZCo9GoyKWD46Nk6UUqTLySNcwd
         K/zGPHFN72NSUN1yEWO4DS6Aow4JFdRiD3NKXeQMrwOzUrwKY5FGo7K+mjTtuQr3Ebog
         oQP1XXLFVgs0XtEbx7fbGcbOvOu5BvoW5gBIBcMdKQ1OxWQRWwAhwnJMzmkXKe2K4z6T
         1bew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707038697; x=1707643497;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2b+xr5BMCprvoEPQzNmAjEYtPrTUzef8KsERa7FbL7o=;
        b=sXCc/UzPXXndht6wt7P8rdR0/5gAG/sYYQXGVy31iZdJGOIKnCSmrT/9rvTn8NoZKd
         N7U6Dgjl8dgdbF38YiQW/PTrvLa4rW7jvcdTAuWkRQg6LhL6gQtRZkaXM3Tde7dCwaEx
         LW/NQg1SMke3kIg2YA415Fei/iuximfs+alThjHARLhRmrWnrrnoWZ2LMc+nxMe+vzI0
         HPOdcm7mC/7RXTYnEUZ0X+PPJ+vzQM4kpfvMHx7v3kjuFvzqJAPLFD9U5MAc3Jhwe9/7
         m/XZnMGeagrzZy1sD7xyRRnO2oFipIUHcHDbPrHtAp6u0+6AeIJBjir5Ylr/ssCrw5WK
         IvKw==
X-Gm-Message-State: AOJu0YzrxWllHOD453FYpODWUJe9GMne/K0ugk1jLDegBZTL/nlMu6Gw
	l6g44AsJ/XT1vr9OGHToAOXlBWYfj7h2xps4a9d5YtbAJXVHGcMTZFSWGrQF7gcMJAgh3EpU2UG
	MOpQQyub+qtjRbddcTublyaVrowcDHo2mSernoA==
X-Google-Smtp-Source: AGHT+IFrkRQIUKey6pKfK37oaP++0arXgCXewd6slpJVINjoeblGZW7FplqrnL3LLdE/WzwioriNr+me01+K3r66Xcg=
X-Received: by 2002:a05:6902:248b:b0:dc6:fff9:dd7e with SMTP id
 ds11-20020a056902248b00b00dc6fff9dd7emr2742938ybb.60.1707038697653; Sun, 04
 Feb 2024 01:24:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203-bus_cleanup-gpu-v1-0-1b6ecdb5f941@marliere.net> <20240203-bus_cleanup-gpu-v1-1-1b6ecdb5f941@marliere.net>
In-Reply-To: <20240203-bus_cleanup-gpu-v1-1-1b6ecdb5f941@marliere.net>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 4 Feb 2024 10:24:46 +0100
Message-ID: <CAA8EJpqYH3CM8exv68S7KU-CK5r=jM81UPjiW09qOiqrg1ThKg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm: display: make dp_aux_bus_type const
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 3 Feb 2024 at 22:20, Ricardo B. Marliere <ricardo@marliere.net> wrote:
>
> Now that the driver core can properly handle constant struct bus_type,
> move the dp_aux_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/display/drm_dp_aux_bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

-- 
With best wishes
Dmitry

