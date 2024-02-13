Return-Path: <linux-kernel+bounces-63176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BBA852BEE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC07283504
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21211C6AD;
	Tue, 13 Feb 2024 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E2TySlSW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6242B1B7EB
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707815270; cv=none; b=SK3E5nRZwjx4ZWLu8GEUcGtEAx8+J5WZ7bpC52tF7+PnGDh1oNAMTmr/lKsx7e7ybTCOdEwoD0qRTJb1wdt1lxk12T42JJlGFK77jsJIcIeSUBnHWc+LIBO71EhBem0rbZAd0zP85gtbLsio2uZ16BDf9QqAEKk1KiGK8D/cP1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707815270; c=relaxed/simple;
	bh=ybnop7dbPwRnees4BYoRMUIBLz2OAtisOjmESPrNXtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fk7ShixGo1JJhc+V6qQAo8r4SstGKfg4yMdyyNF0lfRS+wormgK13gYBMp/WGsmEsR5Qjb/TGfl1Vxwwcvyx1oinVEgCjlaWEpWA+125K1BRhMTps81k/eUqJ26Y6HoyU2xN6MEfdkmGjMEmtULtYkIWOIWI/wony6pq0mtlzjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E2TySlSW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707815267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=varjZjBxBFqiVHNuiFV3KRQmhIyNRarw3ydRqMvY0A0=;
	b=E2TySlSWYLkJZF9Fkwcd3W6VQfKq6YDrcOYy73A7FPck2MEN9LJM25r16bbWq+2XYUIu2N
	EyuEAYEKNeCvz4VI+V+RbjdhP0dS49zCfeslw+vvA8ypP9nK2H6lGcQPMIi81zWLqy/s7N
	fbpCZY7LFuJhArGIP8ZEPVVLBFSwi30=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-QtCSk7HaPVeKyOP834nIFw-1; Tue, 13 Feb 2024 04:07:45 -0500
X-MC-Unique: QtCSk7HaPVeKyOP834nIFw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a357c92f241so243260766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 01:07:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707815264; x=1708420064;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=varjZjBxBFqiVHNuiFV3KRQmhIyNRarw3ydRqMvY0A0=;
        b=uvWse0xzEns9rZz/q9R5eS6LJHdCY69F7p8HORCiuA2BtKkmBnD+FwVf2m24huKyDX
         I8feZeR1h0OyT7kCeiO0VNlyu7HBfFDC443XqZ0pFRHfLYIUbN8X39HKVivY/dZcqF+9
         ZUhxxPt16oRpP4IdnQG+LsKpGagV+L+53jyqZTMPXQKi3l8yVvBxbkJluCF1IQMAoWIF
         ZGlni2z2ph865HznsfGYbhZENcav9DC0KwXQrNDBH6XtBQqphyll2qhENe4aAyhPfRcz
         Yb1tygP4bQ1ibGX6P8+1AXyuY7gQzr7FDwZ5yqb5MWVia0y5n6OauLlqtjiH36vXkcet
         cM0w==
X-Forwarded-Encrypted: i=1; AJvYcCW05ktsyah76YPzfJ+vmAPSGYi6SYU0orvXePwZqk4+jX+LYk3QyYwv8Fzisb5BjXN4FKdOJEaODG0hhOYK5VQhvD/gZnvaSj7mJc+X
X-Gm-Message-State: AOJu0YwC71y7OIuw7PUGy4Uo+1D81INv5p1Pa/drcjRZf93nQ/LN8ZUj
	7FhmBm/Mfl0/3BKs/i5MTC81eHu67owvn0y04zacPl9ynHzQEcorpv8/VX+1KH8G5BAmOFEUnfx
	yM++n/K7oK5jpkaB0vsvjjfkjj5I8gmIs2O5oltzC5HLG7AUz+tLllj4j14RtCQ==
X-Received: by 2002:a17:906:5a92:b0:a3c:9d1a:8dc5 with SMTP id l18-20020a1709065a9200b00a3c9d1a8dc5mr3568434ejq.63.1707815264367;
        Tue, 13 Feb 2024 01:07:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/xK+Aor/xzZTH8ME0aRC9uoXcmBdxOZhpQPgo5eNwxfgfoP2CKnpOj1sxDSyFQjvppURq7w==
X-Received: by 2002:a17:906:5a92:b0:a3c:9d1a:8dc5 with SMTP id l18-20020a1709065a9200b00a3c9d1a8dc5mr3568406ejq.63.1707815264001;
        Tue, 13 Feb 2024 01:07:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXxvJmPUdeHNhcIV56A+eFY+jIFHXqBuVrnXrw1vzKVCoicf5DD7YBH2FP/A75tPGUjqR+Bc7XZxFsYsZeq0HBoO9Z0tCIO7k3EOLK7Rl3bi2ETScxzuLVtCBJnX3e+hJlelVaztSoUjWIhiujpMwgrFJYAVTVbhAuD9h4nK8+Qa9yOlIrhcgi4L6nIlbe4ExdIO/Glr2sj0sGQ0AdFrmnLWj1QJTyzoyL39rGoAVKf6P5LmQxe4NxPIURm9wuOYcJx6pnp/UaAWrUVKxMf4He4d7A5BK1KcuvGNcHh16VSgmMvr1WDs2UlPvaBp6qNb03Ks8prSMV4bnZE6DRU+xOIr0Jyu31lfSci5aDKPE5sB258A8v+eetmK06xPCqZFYiUwkTWjnhftymBZcIEPA==
Received: from redhat.com ([2.52.146.238])
        by smtp.gmail.com with ESMTPSA id h12-20020a17090634cc00b00a3c838b0f1esm1091205ejb.31.2024.02.13.01.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 01:07:43 -0800 (PST)
Date: Tue, 13 Feb 2024 04:07:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>, jasowang@redhat.com,
	perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	virtualization@lists.linux-foundation.org,
	virtio-dev@lists.oasis-open.org,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	coverity-bot <keescook+coverity-bot@chromium.org>
Subject: Re: [PATCH] ALSA: virtio: Fix "Coverity: virtsnd_kctl_tlv_op():
 Uninitialized variables" warning.
Message-ID: <20240213040658-mutt-send-email-mst@kernel.org>
References: <20240213085131.503569-1-aiswarya.cyriac@opensynergy.com>
 <875xyska8v.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875xyska8v.wl-tiwai@suse.de>

On Tue, Feb 13, 2024 at 10:02:24AM +0100, Takashi Iwai wrote:
> On Tue, 13 Feb 2024 09:51:30 +0100,
> Aiswarya Cyriac wrote:
> > 
> > Fix the following warning when building virtio_snd driver.
> > 
> > "
> > *** CID 1583619:  Uninitialized variables  (UNINIT)
> > sound/virtio/virtio_kctl.c:294 in virtsnd_kctl_tlv_op()
> > 288
> > 289         break;
> > 290       }
> > 291
> > 292       kfree(tlv);
> > 293
> > vvv     CID 1583619:  Uninitialized variables  (UNINIT)
> > vvv     Using uninitialized value "rc".
> > 294       return rc;
> > 295     }
> > 296
> > 297     /**
> > 298      * virtsnd_kctl_get_enum_items() - Query items for the ENUMERATED element type.
> > 299      * @snd: VirtIO sound device.
> > "
> > 
> > Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> > Signed-off-by: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
> > Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> > Addresses-Coverity-ID: 1583619 ("Uninitialized variables")
> > Fixes: d6568e3de42d ("ALSA: virtio: add support for audio controls")
> 
> Thanks, applied.
> 
> 
> Takashi

Why did you apply it directly? The patch isn't great IMHO.
Why not give people a couple of days to review?

-- 
MST


