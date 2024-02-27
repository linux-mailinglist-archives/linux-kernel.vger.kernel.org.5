Return-Path: <linux-kernel+bounces-82488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1B786853E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8EB1C21FAF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328EE4A1C;
	Tue, 27 Feb 2024 00:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JRQIksFS"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243AE184D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 00:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708995183; cv=none; b=MROvU5k6OwwF7s4ZTlfxQA9OK9cv2UqqFaGkOwJ/HcXNvZaoE48y0qIbSiTnxQP7QX3TNR4jBs1CIx/MEvDtAy6g9RHITuY5AxJ++2yBLnsdzrvg9ObVvG3V72ydJuxw8zcSkCGzz0ZwVZ9Fsgu3akg18GZ9AQ9rjgJPR6soEiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708995183; c=relaxed/simple;
	bh=V6A7al1ppGka0azTB8qp3lV4rogqK7JhSynkjAKsxYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1VciZ6l3uASBAABA9PaUgLPoS9R90tQsdQe5vhK5Y39avkzwFp+FAmfHy41mwudIa3DEHFBvIQ2Wb5R78k3WBIGYENu2dhNmz9WTFdOWnAf04IKHf8YMT0Ro5fTAKJK61ejtkXhekJT/VTrBqFufi/h1JlDKtMMgZgVAjtVReI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JRQIksFS; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e08dd0fa0bso3205373b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708995181; x=1709599981; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BZbMzkvIVzOfkFlvvubcJk0J0hloUqaH3xyhrZRKFHU=;
        b=JRQIksFSOBMZLWcmRlVGnx75hNRXVEmKBqY2aaDC1XffXWmuaTAmRIAPzuxdLzyVzj
         9uRV+y4GAqDeOEXut+LFTDwtJyphzoT9IRwgVkA1PQxovXtPB9Up7OCF+m+AlWqUR+7S
         bw4ivt4B+D6xQlV126bErH9mRPtWuE0/frcHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708995181; x=1709599981;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZbMzkvIVzOfkFlvvubcJk0J0hloUqaH3xyhrZRKFHU=;
        b=YtVmPz52qFXHZH6nKlauIHwl9ySjzIfdmw5uswn73D9FID2xoUZU4mqYXvY6BkQT2T
         yh3NKhkPgK3B+jIbRKKSOckZ3GrQoRQGPn0CdblitAzfLU7WKbvCcuWPOAhAhxC2BcUN
         obM6mPsrXCYsq1XB2Yg/Yqsmc8lraJHEPsW0J5BOVlp8Lopt+wZMHw/jsSkzeCnx8io2
         zDZ9z7Tq9K1xV0ZUhnMGPHrRAFwj8YDchuZMBBufA6Lush//5m1pB0oGVrHwx6+uvbho
         UVIVrOVmgc6IdUhptmvZ1jsJXPq98jw4yExBOrYoDfpBIgscvWkYQ/9abSNv6WEoArUe
         7t+A==
X-Forwarded-Encrypted: i=1; AJvYcCXXyglYdkFMIUDXsYk8gB7lNNPhrw5fUTnZbdjmyvq2Tt3kilmFRFwiH0c3C/JmJBxJX2Miu0hXSo158Lk1ocAgSbAZhm0GQWEe2ZJy
X-Gm-Message-State: AOJu0YymCyREkU53qhrNjCBlwmoqbR0x/t5a/ImCPSaYjGkj5KU9bX1Z
	spz03meoj4b/QHSb74OZDKfsXjVFFlCCQsv/XZGJjGsIFZ2e1WMg8Gr3R9ifqQ==
X-Google-Smtp-Source: AGHT+IGymmYDQSZ5/XUv6z4QO2Px0IowCoCW3KGp+FsYBiIOOkSnr19mWBPp31IKLedgPuIEP0pvTQ==
X-Received: by 2002:aa7:8883:0:b0:6e0:50cb:5f0a with SMTP id z3-20020aa78883000000b006e050cb5f0amr10992854pfe.12.1708995181484;
        Mon, 26 Feb 2024 16:53:01 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 16-20020a056a00071000b006e3809da4fdsm4573143pfl.83.2024.02.26.16.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 16:53:01 -0800 (PST)
Date: Mon, 26 Feb 2024 16:53:00 -0800
From: Kees Cook <keescook@chromium.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>, jannh@google.com,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com, Guenter Roeck <groeck@chromium.org>,
	Mike Frysinger <vapier@chromium.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] proc: allow restricting /proc/pid/mem writes
Message-ID: <202402261650.DE0601F01@keescook>
References: <20240221210626.155534-1-adrian.ratiu@collabora.com>
 <CAD=FV=WR51_HJA0teHhBKvr90ufzZePVcxdA+iVZqXUK=cYJng@mail.gmail.com>
 <202402261110.B8129C002@keescook>
 <202402261123.B2A1D0DE@keescook>
 <1405e4-65dd1180-3-7a785380@32026879>
 <CAD=FV=Vh7Ctaj6N_k9gdkrqpb687zJqQN19qTZXMyDw6TujvLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=Vh7Ctaj6N_k9gdkrqpb687zJqQN19qTZXMyDw6TujvLQ@mail.gmail.com>

On Mon, Feb 26, 2024 at 02:37:29PM -0800, Doug Anderson wrote:
> Hi,
> 
> On Mon, Feb 26, 2024 at 2:33 PM Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
> >
> > > > [...]
> > > > +config SECURITY_PROC_MEM_RESTRICT_WRITES
> > >
> > > Instead of a build-time CONFIG, I'd prefer a boot-time config (or a
> > > sysctl, but that's be harder given the perms). That this is selectable
> > > by distro users, etc, and they don't need to rebuild their kernel to
> > > benefit from it.
> >
> > Ack, I'll implement a cmdline arg in v2.
> 
> Any objections to doing both? Have a CONFIG option for a default and a
> cmdline to override it? This way if a distro wants to restrict writes
> by default then don't need to jam more stuff into the kernel command
> line.

For an example, take a look at randomize_kstack_offset and
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT.

-- 
Kees Cook

