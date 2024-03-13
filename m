Return-Path: <linux-kernel+bounces-102399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C7D87B24C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41A24B3163C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61E75E066;
	Wed, 13 Mar 2024 19:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SJxpdiHv"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9991E4DA13
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 19:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710356706; cv=none; b=H77O377kXD4AGVXCDRqH9Twje4LH9YlV1Hk6Oj8FxFFrSLX6osMEOgaV5i//6oVKSNOtgfpBM4+cfwD3Upodu1khnYO7B74+CGSj/EqsoylW5X5QOcH/QSMHGMhABwOqb+5E4hNjEpwVEU79xw6ZaikSsB1VXuBVQOQOGIF6UyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710356706; c=relaxed/simple;
	bh=JjFDLPWpxqjU2QEEdDwkP2gB3hpAsOJy37rkMIzHD88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxieFSx2FhbBgph2JE1jnpOHVDHiGzhQC8OQUZGLxkrli/yROtlc3im/I5TW45Prj0FkpfLs+EY5quArgY/OQAKE7a2203J9viS8fRGGzyM9Zs8wOHH6/9MKuubv/+AZ4BWQ4RPPaGprVys3/Nzg7+EygmyjUAOTDd2qPoS01c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SJxpdiHv; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dd81aee2b4so1610165ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 12:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710356704; x=1710961504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4huMKqPxqzLf5OCIAsTKzbUWeR7Lg0yQNTBgZN7mj/M=;
        b=SJxpdiHvik7/dbI8Kno7TotkgL1dUs9r4Kwbf9voAgvl3TS/l4f+bGh0boDT+cESI7
         T9HmL690hjqmh5ohtCymKEglD+zbu3uUBIkMmqU1SKPDDZZ2HPlnHTzrxCvZvlGHTigG
         aZR+XJYTRQ2ezxEow8QTNislqP9g89lQUlI+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710356704; x=1710961504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4huMKqPxqzLf5OCIAsTKzbUWeR7Lg0yQNTBgZN7mj/M=;
        b=aKCt9GGQWlLWqQuMAu4+6C5FnNV4L1zoZnJQ58R4NMO/YJ9T32mYzK7UWy0nq0+NYD
         BFbvabJILgavv2yLcyn9LXRDxhr8OhwlaetoXgXLowmryUdAvDPphA9f41zWknu2elNM
         5JWfrNLro8Pv192/Cab1wYjHUOfvnXxi1QN5G8dccJIWifiKiU3qhIpzQCJimyUZyN94
         D39gGgsDjFmZ4/zZTP5mgEZwIadoRpLCUmo8CUGtigwVujqY1ISJDRLmxza9DPXfmWD2
         e5X6p/JkHS4iokNjkAb/GaRTi1HJgBr7knxMl3O7bHqcOElH2IsEjTAsWYUaCKCJTLzG
         WvkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFh3M2GVTby5mOlZ9A/GFOa4SqHv5270iEBPaHCESgdeMmVlIu5YuntN41mHKYBzTdaQ9fW4mC6wGfb0UZMm+U0hLlw+fPxGzZUnpJ
X-Gm-Message-State: AOJu0YypB6F/+293A8hSBkRl7yRAUtqbakRKjcdRWxzGZn69JQyRYX/H
	GnHcr1CGoSYFueBJ7q2CZbM8urszz75ymeB+YGoeWN6LNaxXer7X0kC6XIOxWg==
X-Google-Smtp-Source: AGHT+IHO7jXGQDKaRXkUme504UD6kNd5mIw4KUxjBzwWwgkI0TfIS5EUk+wbR2Pl9l0sLSRI4YfEug==
X-Received: by 2002:a17:902:e741:b0:1dd:a120:7761 with SMTP id p1-20020a170902e74100b001dda1207761mr12028570plf.14.1710356704001;
        Wed, 13 Mar 2024 12:05:04 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u3-20020a170902e5c300b001dda32430b3sm5998581plf.89.2024.03.13.12.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 12:05:03 -0700 (PDT)
Date: Wed, 13 Mar 2024 12:05:02 -0700
From: Kees Cook <keescook@chromium.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
	kernel@collabora.com, kernel-janitors@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] selftests/exec: Add the overall result line
 accourding to TAP
Message-ID: <202403131204.FF098416C6@keescook>
References: <20240304155928.1818928-1-usama.anjum@collabora.com>
 <f877ce53-a5ee-4447-a57c-339a1e9701f4@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f877ce53-a5ee-4447-a57c-339a1e9701f4@collabora.com>

On Mon, Mar 11, 2024 at 10:10:21PM +0500, Muhammad Usama Anjum wrote:
> Soft reminder!

Ah yes! Thanks for the reminder on these. I will get them into -next
shortly.

-- 
Kees Cook

