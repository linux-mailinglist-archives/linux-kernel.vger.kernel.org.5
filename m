Return-Path: <linux-kernel+bounces-38784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE17D83C5F6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7B41F26F0A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F349876902;
	Thu, 25 Jan 2024 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EJGUEt5E"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE57768F8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194769; cv=none; b=VwsNrc3x21v65ymrp98fw6hE2e9Q0Bo3WkWVyJ8+ntoRFOKg3U/i8U2NWs5rJuLdwi1l3X0POzXaeYg9RWnWb7yad1ENC2TW9XsMdw6mbEoAt7eh5h+ymH8JcKUH4+g1SevFMjqCNZ4jSaYFuavtGQDGDoRbuF6IFkCAUSiVrnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194769; c=relaxed/simple;
	bh=MIK+QxFxsRFVsK0JI7umRqsFHJP1cu+AgJYKYupHzD8=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=XKXR836lgnHJjUASHSS9sJYD8L6ueS9IJJKyuNNWksS6QRwK4fY5MsPmiyyi/NpS4uEB5TqDvQCaLftRcpyi1P5kHw+5DieeOvpa+rYI6j3jjL4T4vyyaQMg9ralOnBz3KzgRwOyaz4VPPRiEvAtKIpdz94+Cu6tT8kqkrRju6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EJGUEt5E; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78315243c11so438388685a.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 06:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706194766; x=1706799566; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QokRh4sTQUfkR5bLB823ppJrMrKDL4nb6Ul8jfaanJ8=;
        b=EJGUEt5EzcW0W2TEafctDGLnax7Gem1JWD/XRvyaYBOuqyf3xhZh9VPrXOOR6A8gK0
         Oom9s78uRXj40iODYRe5+frCC310Np2YkZhIN8JVHY8sedULs2XHuiQ9IkCccwMt0f4L
         72piT+jImKhWVdpAxvs0KlIWjtL6f2KW+oFaH9/dJeWL7NLeu/dMd/kYfCf2DLHwbKdH
         LDBrABMqhRlWHS7JbdAy8pdZFkYnCvKTbFNdjmsUal70Cn9V/ZjTwcOuoDdRy0pj+LrR
         qcvx52HgvlqYJND3n8dqUJbxpVkFzbAR5izYXpnauj6BQl6TWxXc+RFW/burEgPSB1MZ
         QZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194766; x=1706799566;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QokRh4sTQUfkR5bLB823ppJrMrKDL4nb6Ul8jfaanJ8=;
        b=Ktoe31GEZ1aHQpYFb29OLX1wCfeLWkXkry2+4K4JkcqPji4cbrq36J15QJsLy3Og8g
         vnFyvjna2IGnIrdkPN0FjDVN6q8NvHtV5WS/u2/2JOjma4JQJq1Rki+2KmdjlCI+eoLC
         GUPgHz9+i3ArHn51VVlUvODFJkddOTKro/V8s0/wInO4WLMQUropnoli2KdT0hog9bqM
         639dHFZvKLpN+kR4FMfxZ9XVYaOBW7x/QmTrCc/TrUnngwXN2HVZWtuA8y0QB91BgL+s
         piiRDTHrdYuDpEUlUUP4oZh/ItdDjfu9lYP1//VSOTaAP10GxzXSt1aKV5j4enmQDqc9
         or/w==
X-Gm-Message-State: AOJu0YwXED42LHUwIkpzluv00HvQ1NKB9UCmbfcj8WV8Osj+qlRl/iww
	B/8upvbxnKteD2ZtAXrP/CD3IjdCACk0Jml1S4B/G6YAeTbPLRfd+j+g1bNLQabQHnWUsz/BNtQ
	=
X-Google-Smtp-Source: AGHT+IF1Hke1j7fCAq2l/nqw+mSJkIzr6GHG9KukUEeDR56kC+lW1t7KmwvMNfBY5TVqXw/h82D19w==
X-Received: by 2002:a05:620a:4483:b0:783:2516:58c8 with SMTP id x3-20020a05620a448300b00783251658c8mr1406385qkp.19.1706194766644;
        Thu, 25 Jan 2024 06:59:26 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id t8-20020a05620a034800b00783a206381csm3472154qkm.37.2024.01.25.06.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:59:26 -0800 (PST)
Date: Thu, 25 Jan 2024 09:59:25 -0500
Message-ID: <736295ee70e12c5e1ba8a19b9a832b5f@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Li zeming <zeming@nfschina.com>, eparis@redhat.com
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: Re: [PATCH] kernel: auditfilter: Remove unnecessary ‘0’ values from  ret
References: <20231228025600.9796-1-zeming@nfschina.com>
In-Reply-To: <20231228025600.9796-1-zeming@nfschina.com>

On Dec 27, 2023 Li zeming <zeming@nfschina.com> wrote:
> 
> The ret variable is assigned when it does not need to be defined, as it
> has already been assigned before use.
> 
> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
>  kernel/auditfilter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into audit/dev, thanks.

--
paul-moore.com

