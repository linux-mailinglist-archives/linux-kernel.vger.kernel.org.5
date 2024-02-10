Return-Path: <linux-kernel+bounces-60305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA2B8502EB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 08:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C321B26566
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 07:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C2525632;
	Sat, 10 Feb 2024 07:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RDIBRpS+"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350BB3611F
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 07:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707548790; cv=none; b=iNrxd9HDf+I/UA7OIwm9wabQ6aGB4xaSMb2AHZQ3OxU8Au7SFdSJPayItcep89mSjX94nZeemFqyp7x927oc+cV1iBzEsfONgTNw7zvVUHwpmbjEhny2fYNu7+gyag78EVXbWVkzj2oz4PQbAKrkAAQpoysreybvlnP2KwmY0As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707548790; c=relaxed/simple;
	bh=ir2eU4ZeGjl5Y1G4iwc/uXJYfbxwBRUjFst7H/ZK7Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tw3VXbpb72QIbO0vUnC3Dn+5x6nyihb8Xl4YFGY6V/+u3X7+OwHCcm2G5AJagdLJcq+h1dGMYoJ2x0xxcdTH7lRdUyV7KURGptSaU46u2xRUz8apt0qSsrs90OtyMpqdG/QTyDD5ul+HdhY70HjpVeeyVnRItLSZa+lvFlEaRRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RDIBRpS+; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e04eceebb5so1247156b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 23:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707548788; x=1708153588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iCqZp7vIiNiDCK0cy20SXg9L894FR7U3RGqtXfQnefI=;
        b=RDIBRpS+3/6WY2U7At+whg8SCUWQP94czhYxQsZuBH3pri8yOMIO/iWKErzDs4vw+L
         PP71LbzMC8zJrQdHJiUzR+DOiRNELlCq7/TYU6/YzECotGX9p15Bgdl8vv9ss1GBTtsa
         8Hu6W9SQ+vdO9lwngkmtW/S1sKiffzuBHt4Ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707548788; x=1708153588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCqZp7vIiNiDCK0cy20SXg9L894FR7U3RGqtXfQnefI=;
        b=s3yFkhFJhA0qYAkZxNJJyJqqOQOQdUR+mjZ8YbDcbMTz64/2A5gmD00Jm803jDpJVF
         wuHzbw/AoisCAMk6X4qk5Fn24v1YPMfwIr9EMrHrc0bi9gxwsSsLi/Lkfb3JZCvRgkfs
         q/T1Yi6viXhJDMFBZl3oe2X7MtyBA9OcDvEnc107tOWP7Ji5/qM1I6qN4dzcgbss5Gme
         yUgUW/AdU5ad2wRJZKXB5vvNvO+nQvez47DiocgMiyMM+HSEMQnv+EvzXsUdKBWKYEIB
         LzMyZWbLKPcXzNrz4KUQ+LTua7ICax8OUbQOtD0ob7RsqSNx/EC7t5TUYwfsl5F98Jxl
         LNgA==
X-Gm-Message-State: AOJu0YzA73i9Vh/mCPvspii04rAfKY3fEqFz7HElCsAwSIXgjwpyBgxQ
	TYf+287UyKEpvx99CZwH7BHu3gEGZUCQx0lfqAAL/UO+x1d0CmWinxK/SSYfkA==
X-Google-Smtp-Source: AGHT+IGkHWNGUSeXP4u+5TcuucyTd2GKgyI8juaMx8P42FtIBV9XRh1JzYI28ll1lWmPtifSnL9VaQ==
X-Received: by 2002:a05:6a21:788c:b0:19e:c3f1:2bde with SMTP id bf12-20020a056a21788c00b0019ec3f12bdemr875076pzc.16.1707548788473;
        Fri, 09 Feb 2024 23:06:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVxw8VRzKF9uH6Nf2zL7Ax94CWw4MwemBqyMhhzI3dwcvQOLn6rSFaxMAGypT/S8o2/B0Ld+aZ5lHigen/kW6A2LWzsnhJRnXbJ7JHOh9Fdv1502yljEDJuNMohUj9qKzT9AoESJ1j+TjSKQGn2Qom/2TtZxpVDGDXy10FK6s6Rg4RwfavfxdSf0AbErjLghjFuRUydYBOZVmxmkgO8cPuwEDelJuDcmF8hKg==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id sb3-20020a17090b50c300b002961a383303sm2857513pjb.14.2024.02.09.23.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 23:06:28 -0800 (PST)
Date: Fri, 9 Feb 2024 23:06:27 -0800
From: Kees Cook <keescook@chromium.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Hannes Reinecke <hare@suse.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH 08/10] scsi: aic7xxx: aicasm: Replace snprintf() with the
 safer scnprintf() variant
Message-ID: <202402092306.0ED53F66A@keescook>
References: <20240208084512.3803250-1-lee@kernel.org>
 <20240208084512.3803250-9-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208084512.3803250-9-lee@kernel.org>

On Thu, Feb 08, 2024 at 08:44:20AM +0000, Lee Jones wrote:
> There is a general misunderstanding amongst engineers that {v}snprintf()
> returns the length of the data *actually* encoded into the destination
> array.  However, as per the C99 standard {v}snprintf() really returns
> the length of the data that *would have been* written if there were
> enough space for it.  This misunderstanding has led to buffer-overruns
> in the past.  It's generally considered safer to use the {v}scnprintf()
> variants in their place (or even sprintf() in simple cases).  So let's
> do that.
> 
> Link: https://lwn.net/Articles/69419/
> Link: https://github.com/KSPP/linux/issues/105
> Signed-off-by: Lee Jones <lee@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

