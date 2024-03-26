Return-Path: <linux-kernel+bounces-119727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B22B88CC74
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E50D61F682CF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03ED213CC44;
	Tue, 26 Mar 2024 18:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZkbwYhy1"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD4813CABB
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 18:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479342; cv=none; b=uEna36nop7iphsC019AYjx4oTKuHsDJ/083lbjbh+VspUn28YESI5MD8ztQK35RmFSY6k/1uwlC3fxHqB88v05kTtCI8OKdg+NIPfXHh+HK3Yp/6aQMsiAR7+QLSCVy7BBZvsJ5aaZSkeoiNAL6X69bZ97fTp7rfWBsirhnBERs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479342; c=relaxed/simple;
	bh=OXTwQCFaZAj0sjd3yq+jvLdZ002w8j6x4hmq5jp5QuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ov+NHkbZtYHBS25p+2DykgNUk0X3Im43XjMTtAwvginQfhjlB5UxevMCT0rFtj84h6e3mvc/gZtJQFhmBUoFjYBjHpjz7TyYj+Crn4dCXRkDmspU2p7T3ywfiz8rppReuOZTLCGWfNbWE3g+Us4VR2HHCi3ybm0dNiIyJHOC+mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZkbwYhy1; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-476588b3c3eso2026368137.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711479339; x=1712084139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXTwQCFaZAj0sjd3yq+jvLdZ002w8j6x4hmq5jp5QuU=;
        b=ZkbwYhy1n5dHpsx+9PQM/XC0DMncSMmwk5d/RSrcOOr1fRCBQBu+Ohw2zC9HoV1iCz
         a4mcAlic6dnfHa7+b7cnAQR6Ub6OgMcHRFc/HLVD7KmE9jPcjAgslCsT/8E0wbZs4v9W
         bL4Sd0yp2IwcOP02sqzZ4VE5huZfRqydCx8L83vMlc9ZQR8NhKyGwdT7i5hZHyFuogkM
         PwD5avBxBBO7LQ46a1WKWIJWisHOT0YkXLFiEyU6+1HrqJO1bOhagb/LKvrG4Y8P6rH/
         R6tjgRaoxTXK8QuxbArXdBUQ2WR4IwdXjLdWW31NCxXEx0Ytxys3zyAfx/biNjoXZPmC
         wgtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711479339; x=1712084139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXTwQCFaZAj0sjd3yq+jvLdZ002w8j6x4hmq5jp5QuU=;
        b=SQ6g+na83dA8E4licFqcCG08Yy5ZeECvRFj/im0mWhl8vm+UDE1lB8jRjbB3hT2cKl
         VmAXkEbUHh3ieMiaecoLOebL3N6k4xPWJMYP8Pb9hu0LpKN/k6kLw034a9M+4GqJPaRI
         sMwCSzTT/oWVY7xbmFFkfDn0O38AMk0SyAtdLQbB0BLbIFALp7XWPIultZJYRZK3lh2k
         W8b/TBs5GXJSLIfXYPc+4l+rnIb7JQSBhYFSftZo31+L3AQBFMecqYUknUYCfDmoSjws
         QILfAgofkNyUGxHi83n756XK0DlEsYgYnZEFoWSktjhVi1du/L1k8EGQZijZ1qhOiO81
         lLrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPvTFX/BC4/fskIhX/MYDjSY20vJhy46dskWR1beS3CaLr74PBQwLPVUnkDDe8WUAff/PNLE0/z/pagV0Uf4EDoL/mPpMZl6cwb/gZ
X-Gm-Message-State: AOJu0YwwrjQkQx4eot2UgGmJZwXnIynUPHo5anoCxTBSkZ7tI+uk4mZR
	kUHg/n5oVbeP9GEyqSUDd9SVDjGtvajdE4kCA0vW0HAyFmZeIzNuKaLk5vKhAKP+E7WbQ1Y2ZGn
	8fGkcCNax7Cgrwsx5KHmR5sA8d8aVmqw/GO5C
X-Google-Smtp-Source: AGHT+IE8JrH0I8/953zvrzCMR+hs4V4VMkFMJbs6d/MRRtDQ+IzoyJJNkxrTzBfqLyeMkE0r30YIW3GMqVQZIGPYLOM=
X-Received: by 2002:a05:6102:3969:b0:474:50f5:723f with SMTP id
 ho9-20020a056102396900b0047450f5723fmr680505vsb.18.1711479338882; Tue, 26 Mar
 2024 11:55:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326153712.1839482-2-samitolvanen@google.com> <a083fe56-19ba-4c12-8364-944d8bbcc043@ghiti.fr>
In-Reply-To: <a083fe56-19ba-4c12-8364-944d8bbcc043@ghiti.fr>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 26 Mar 2024 18:55:01 +0000
Message-ID: <CABCJKudxjhbLo_2zHBcsPh42vuLUGFj9wUxk+jf5USf2mvUZGg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Mark __se_sys_* functions __used
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Kees Cook <keescook@chromium.org>, 
	linux-riscv@lists.infradead.org, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, 
	Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 6:43=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> Do you have the link of the report? So we can add a Closes tag.

Sure, this was reported here:

https://lore.kernel.org/lkml/56d3285a-ed22-44bd-8c22-ce51ad159a81@linaro.or=
g/

Sami

