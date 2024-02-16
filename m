Return-Path: <linux-kernel+bounces-69029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C291585838C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDA781C21C24
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72BA130E3A;
	Fri, 16 Feb 2024 17:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="hOkJCiC8"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C50B130E27
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103263; cv=none; b=M5Mc+g3p1rYcgArW+C6BTJHnLO7QTuNteodJZOS9WteUibhwtR86JXJsIzbFW14AUVjlrsNBq+p9ThcqFXBA2nyRMk7bKiQg9yGj8hTKmfnOk/BYJ+QvHWnUkr/J4SFGlCD5IRt0iKWZLOmkJm/cYhL9F4Av3rTDNLufl7FV1rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103263; c=relaxed/simple;
	bh=hv233QVBwAsUo0Zdqwhyq2yzmCK3uyGXUq9pEROZ7lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIs03Qzz/Y9GLtm6nIk26l/ETasvvAkgyCzZ22K4wKekSSrZ0I/WuJMpdj+XxX9hUjQ6vNgX+HWhyo6c8RB3r4MY2cTyBNzt7LAa0a9P+qVMljyXtE944kWvXcL3yle20UJsVxCccpNi1XyXhk4QasGNzLZ0lVlryZWeOYOm/Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=hOkJCiC8; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33cd856478cso596838f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 09:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1708103259; x=1708708059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ijTea4rY9Z92lLGWfWJZg4eI/pmK/TMqoH5QWxKStbU=;
        b=hOkJCiC81bNLbwNUNAvGojRAzgIYTMFUdnAN5uI3aXrHqHGJPE5JnCzot210fHqXjQ
         AkHe1FC1ohcAeTCVfjh7t6HcH9PpMj4uLwe1jX3HlEstozgwPpQLxzy02gEhnCy5ddbA
         vU4wUFWPaH3otzh8hQkr+9QmSNG7m9+gVRGDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708103259; x=1708708059;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ijTea4rY9Z92lLGWfWJZg4eI/pmK/TMqoH5QWxKStbU=;
        b=L2lehgU6cvo17QNbJ+w7usj9D5MmJAEIFtXBd1FplQVeWf7fjzgzujBbAxq7LaS4/H
         JL2ifZoIY16jJvoEbRBQUwu6E2aQApfKHXZww2v1rkaYn7MomK564uyVtMO1f77Yof/S
         ZM2FYK/W5mCP8/zMQxnLk1dfwu58NJZYuZ76j49r8rgkIZcB1qygLC6VCdBFXl756faI
         pz/r5mzBjXIaQ4bFUnQAb8YnzbYtXGIuiQj7A6olu/ANHVWjJflQdPhvO3isO1c4PoGH
         xi+EaegZvFkQB+9Nri1TtDULZHn24I9Wdoej4nN//j7QPiketeglimTsjfZnzFGiel+r
         SIgg==
X-Forwarded-Encrypted: i=1; AJvYcCX7XSlerriv20CV5G3E78Mf4QkKbqbziae1JoExRtbUS46zOV5ciWJIalIQz7Yyaw/WqbSGlH853q/p/OTli8fi6lmaQcLSyJFL5CcR
X-Gm-Message-State: AOJu0YzAlbA69t/lROfPu+/uuP6RblpUzF1UaDe4pSm3gYFz/VABfN+E
	LTIQ7RdNVQZChWeZr6VPamEHo3dy4Q5JrQ4ox4jo8QbSg36aAzeGs1KsKpezC4M=
X-Google-Smtp-Source: AGHT+IHUqALZqMVn2fADheMNqneRMmQ3MvAb+MA7p/LnwiMi9nfwmdjzZU7ByFi7IURD8OofvvbuPQ==
X-Received: by 2002:a05:6000:803:b0:33d:1d45:c658 with SMTP id bt3-20020a056000080300b0033d1d45c658mr1572596wrb.6.1708103259500;
        Fri, 16 Feb 2024 09:07:39 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id e14-20020a5d4e8e000000b0033cdf1f15e8sm2702656wru.16.2024.02.16.09.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 09:07:38 -0800 (PST)
Date: Fri, 16 Feb 2024 18:07:36 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: airlied@redhat.com, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] char/agp: remove agp_bridge_data::type
Message-ID: <Zc-WWH8_UNBCOlri@phenom.ffwll.local>
Mail-Followup-To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	airlied@redhat.com, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
References: <20240213111511.25187-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213111511.25187-1-jirislaby@kernel.org>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Tue, Feb 13, 2024 at 12:15:11PM +0100, Jiri Slaby (SUSE) wrote:
> agp_bridge_data::type is unused (and I cannot find when was used last).
> 
> Therefore, remove it.
> 
> Found by https://github.com/jirislaby/clang-struct.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: David Airlie <airlied@redhat.com>
> Cc: dri-devel@lists.freedesktop.org

Thanks, pushed to drm-misc-next.
-Sima

> ---
>  drivers/char/agp/agp.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/char/agp/agp.h b/drivers/char/agp/agp.h
> index 5c36ab85f80b..67d7be800a7c 100644
> --- a/drivers/char/agp/agp.h
> +++ b/drivers/char/agp/agp.h
> @@ -138,7 +138,6 @@ struct agp_bridge_data {
>  	unsigned long gart_bus_addr;
>  	unsigned long gatt_bus_addr;
>  	u32 mode;
> -	enum chipset_type type;
>  	unsigned long *key_list;
>  	atomic_t current_memory_agp;
>  	atomic_t agp_in_use;
> -- 
> 2.43.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

