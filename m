Return-Path: <linux-kernel+bounces-101450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA07F87A74A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94CDD281A0E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E92405E5;
	Wed, 13 Mar 2024 11:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eGsun923"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3403FE2E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 11:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710330838; cv=none; b=sFw3lC3VzokN62GOV852kPnWw9mqwGVVSXAySOEwOil4RehBK3CkEKHUa6bPLUmlo0tKZi8vJeH9FzYXvOsZkHWtoavXisjVXOi0XnhxHj7U2viD1Xfy2PTDQRBq3PMHwO4hzZ9L7Afqlg9Qz+xASQff5ATWue7XusG7jsyMFt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710330838; c=relaxed/simple;
	bh=xIq1Cxt6Ky1vqIZb7f65O3yalptD2xDs8qqjYFp1+30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCGJZeXUXaJzbJgvJ5v53Ha4+vf+KEeAuwKiSgTf3pLzNeY9X3cSGE0HznxId0GUV0hWxUtSaOZEwwV1kCNWemgPTQNQIfGz1yGDDxAhoVo/Ju33w7rr46tZt0DyX1rN8F+Bf+yIsJXLAbmyevhu+kbytMEb2DLhzUU1KYMoCFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eGsun923; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56878bb1abdso1986873a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 04:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710330835; x=1710935635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ewxFmA1gMurqYMDR124wjxE1wehEAqBleVZNQFFIZcc=;
        b=eGsun923FZ540v19rLujn/AG7Vw0mYm19ENd0Eo71iJVyJXbVpSDBoiRHA8e80qYyg
         cAfQgoQpGh4S03pK8zHCLi2orEC0RKguwQQxjXSd12pNGnn3F5PMsli9MKgMeniqLHir
         J+3km7ZnroJ9jrK3tUa481NOm40135mBopHSSuDpg3SxrserWrBMNOoDLn4AN77JBoeD
         EfmipEYlt+yzSMZiqFRtzRZjFzPBC70ZWbH2vdPHROzxBkSAM4oPhZ3inaFgaGf2Swct
         gRknU+uvetxgEmnU/lzwYJ776V6Jxy5liK74zLQBNGGpFXxhCAXD+cz1J7T2xxlIWkxX
         +kYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710330835; x=1710935635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewxFmA1gMurqYMDR124wjxE1wehEAqBleVZNQFFIZcc=;
        b=sHD7KW7MJs5DoZwPiY/mrDBSU9l1ZJPFm8qnOwJMWbcyXDh9xrB4cCo2t5c72pBMRM
         NVN+sQkJEUXBRJxE4bWNBOcENLbomfeJpQIPHU9jI7cyxdF/9zjeQs/LLeZWjtp4aDKj
         rkonhB3jZ5SFYsxe6/5U1VnpO4h98IB9zA9BEjLSMSqo8q2LFfgESfKDjRKgC+XAXj+W
         dfvRgm2Lh2oZe0+5NwahX3yUg3mGcH+ihWGeNL9rNjHTDDEcE0PWUMicsxtDhb2ab63n
         MBHFLPqipXlRnUV6G0fhx0Iy0hOfO7EjU9hzZReSvHRfduCv76pQcg9NKr71gM85z3H0
         fFuw==
X-Forwarded-Encrypted: i=1; AJvYcCVtndnp56g76GlU+f0lg9hNSpaY+dCCiYW+FSLBvMzmt8Ap71CzuerFfWtyuNNbqJLkJL0gRAGJ58w4GanLQ0B9yMAvmr7i5O4dgAJC
X-Gm-Message-State: AOJu0YzObEBHILm9nbWAPeqTb6f+kEwXgc5vEVXDatauPydRc3t3Axbd
	iL4TOqSBNiwRyEMrIazLnzdhs6lhLiEtQtOYkkbo2SWz2BCuqjbCh5Rj49Wh9bo=
X-Google-Smtp-Source: AGHT+IEdOvbULeMh/tQVIie//HKNMWTJgx+FlUNx1CBPgE6UX1FJSdyGoL/SrVaj+FRhjtvqrCJm6g==
X-Received: by 2002:a50:9e48:0:b0:566:ab45:e6c5 with SMTP id z66-20020a509e48000000b00566ab45e6c5mr3240410ede.28.1710330831292;
        Wed, 13 Mar 2024 04:53:51 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id fg3-20020a056402548300b0056889f3cedfsm393582edb.55.2024.03.13.04.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 04:53:51 -0700 (PDT)
Date: Wed, 13 Mar 2024 14:53:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Prasad Pandit <ppandit@redhat.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
	rjui@broadcom.com, sbranden@broadcom.com,
	linux-staging@lists.linux.dev, linux-rpi-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v2] staging: bcm2835-audio: add terminating new line to
 Kconifg
Message-ID: <3fcb3702-5af2-4b9f-a362-4f08ee626b14@moroto.mountain>
References: <20240313091259.1413854-1-ppandit@redhat.com>
 <0a1aa580-50b2-4657-8308-94bffb194aea@moroto.mountain>
 <CAE8KmOzcD+__7xdC7tegbHO9HEP48s7=reA4j-tvqVDwzHr+8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE8KmOzcD+__7xdC7tegbHO9HEP48s7=reA4j-tvqVDwzHr+8Q@mail.gmail.com>

On Wed, Mar 13, 2024 at 04:44:09PM +0530, Prasad Pandit wrote:
> Hi,
> 
> On Wed, 13 Mar 2024 at 15:47, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > Why does this make a difference?  Is it just because it's annoying to
> > cat a file that doesn't have a newline at the end?
> 
> * It's not just #PetPeeve. I'm trying to fix parsing errors reported
> by the config-kernel tool[1], so that users can view all CONFIG
> attributes without errors.

Huh.  The seems like a very nice program.  I've wanted a way to enable
config items from command line for a long time.  I wasn't able to get it
enable the CONFIG_NO_HZ_FULL.

~/config-kernel/configk -e NO_HZ_FULL  -c .config  .

I'm going Ack your patch because adding a newline is the correct thing
but you should probably also change configk to handle that.

> 
> > I checked, and it's not a checkpatch warning.  Perhaps it should be though.
> > KTODO: make checkpatch.pl warn about files that don't end in a newline
> 
> * I'll take a look at checkpatch.pl.

It's not required.  The KTODO is just a shared todo list and anyone can
add stuff to todo list or do it, but it's not mandatory at all.

regards,
dan carpenter


