Return-Path: <linux-kernel+bounces-157749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 516108B154B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08D891F22411
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F81156F59;
	Wed, 24 Apr 2024 21:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eIHrY/65"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C63156F25
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 21:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713995076; cv=none; b=HfREYOZgeuIh7rQyc+DRIrD1PE7hevo0OddrRoprl7F0ZTKYAB7gXg7J/ovOdSBLhksxqYG1h92QRX3URELccnDSro8BwU29EqILlgFlIhci9iSCO+GzpT23zERrz+Bc3DVh6IvMbDcbgPm25h7pnrSdTaVCTInDtrJAIxdwCm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713995076; c=relaxed/simple;
	bh=OZzQkoDyfS/g02WWRwDMj0BwYKXTWglUCgHk5r7lLoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lUva4UuCROA1FkdMzdkjbqlK9hvTr8ZBoQgRRdaSc40pubG+JVIQM9547LkUoSBfAyi1lgNkOES6KQCHRwRJhgGdXK0onZgUbtIE0W95phZW+7A1WdMd79/hCgxVpRui+81Z5Uv+eb3Pp25enIpvy2Jd2607+GMhx1UbT0+JpBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eIHrY/65; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-479de34dc36so150421137.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713995074; x=1714599874; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YP575gq/gmDMB9w/VjeltQDFfmbUMJx+bMv5C2CUKNs=;
        b=eIHrY/6598V1V4YZve336IxuqoRrYr15u3Yr7eOymfIl81s0xC5icrh8zHFVrR4H2l
         ed+hqoGGMxp3vkVxa3mUq8LF6j24vvB8GqZir06jsrgFAEwD5kL4BBXxbTzpUsR+SGzN
         WfAfGQ+7OVNsVam6cITJGobv5VkgNBS4kBPyeGb2bbM4DlOfiAzLayWhodk7XI3SvSKG
         w+VSDWWwsmEUkmN+Dq8d9xAVkFqzMLmcc7DZLf6NPGM54LYF8gukZfjEOUtXSHPG09ZF
         qkRmMUqIKI7kdau0+z9eowqD/pxKMM667HODDUEYZkdUZxR7WH1qtTI2ZLKVNa30d2ma
         0fKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713995074; x=1714599874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YP575gq/gmDMB9w/VjeltQDFfmbUMJx+bMv5C2CUKNs=;
        b=Hti5CZNvFVf20nD7vAxt9QHpZ6DT5xUo87Z1K+EzPCsmk3IkFch9N+bOq1mjyR+wlf
         GIR0TvzMqKuf+FildUx08Omzph1bcusePgiML+9cwQGUiBjPi0jS5PS7whsy3gAu3sEr
         kMEPHKermXF+GPfmzezDm/42drYa8lYhUFhIYTEf/BcV1E7ErZaX/9PSNSISQLtzicrX
         hMgUaO3Yfftl1aW0+Tvbk7RNl9DmjuqrTR75XIkl3WEB0hGFESr9Oin7MvQ96xRbuV7d
         uyeEDm5idcY70YJKi2gR/algR3iSZI1YRvr7kZUhkdXZ555mSkh63V5PpFISwJ6ln5qD
         nqGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvouJQCValHkQCibBbySbB4HJzSFpgoyrtDNjSStbnSvCrdEaXWCmRn+skH8chO5XQlLgtnbBUx7zUNVyajDyQ/F+WBFibnVgko8eb
X-Gm-Message-State: AOJu0Yw8RsoIZ71w6QsLtOLzJUCZu6ryQVE5naAz8hE9HbzLQvNs4BKi
	Cg0hkRMvWLgnI2Z0wZDGOZmtWZpIp2YfTTAegwCc/z/SJV4/9OyexTaK5R8rxzlSHZoMX2YY4OT
	3eDYS/5rUoxDZTStZrxaJd/+zNBzAt4l9QZ7d
X-Google-Smtp-Source: AGHT+IGibJG1QixHqLqkUPSGmCxwUM9AsgORVqD4w9KCwYrcsWkqM4k9cyi+ROsBfqAKiZsbvvF0RMG/Itxk3zQcbno=
X-Received: by 2002:a67:f8cc:0:b0:47b:b94e:9162 with SMTP id
 c12-20020a67f8cc000000b0047bb94e9162mr4484501vsp.4.1713995074217; Wed, 24 Apr
 2024 14:44:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424162722.work.576-kees@kernel.org>
In-Reply-To: <20240424162722.work.576-kees@kernel.org>
From: Marco Elver <elver@google.com>
Date: Wed, 24 Apr 2024 23:43:54 +0200
Message-ID: <CANpmjNN1+bZdQJSdc4o0EY4Kpe_L5s3JyT9smAEx4O_w08GaXg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add ubsan.h to the UBSAN section
To: Kees Cook <keescook@chromium.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Apr 2024 at 18:27, Kees Cook <keescook@chromium.org> wrote:
>
> The "ubsan.h" file was missed in the creation of the UBSAN section. Add
> it.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Marco Elver <elver@google.com>

> ---
> Cc: Marco Elver <elver@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: kasan-dev@googlegroups.com
> Cc: linux-hardening@vger.kernel.org
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7c121493f43d..5acac5887889 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22653,6 +22653,7 @@ F:      include/linux/ubsan.h
>  F:     lib/Kconfig.ubsan
>  F:     lib/test_ubsan.c
>  F:     lib/ubsan.c
> +F:     lib/ubsan.h
>  F:     scripts/Makefile.ubsan
>  K:     \bARCH_HAS_UBSAN\b
>
> --
> 2.34.1
>

