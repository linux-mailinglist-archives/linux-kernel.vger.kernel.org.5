Return-Path: <linux-kernel+bounces-40667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB45383E3D8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37C43B20E6B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AC9249FE;
	Fri, 26 Jan 2024 21:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JKJQguYs"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A780B23770
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 21:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706304185; cv=none; b=F8Jbk0cO//u4Tc1lI0GVTS7OVXYqm8KknnaAZVVGIOQXBOvVSQaMTCJnM8ZFzNJiA8uu0nZu+z249/z0XMdQHtQHj/8/7zjyHQcphHHgtMHPQFI0yRjQFQ6UseFVbd7BuY2UbJTcj/86zWI5Vxre3hEW06lSy86pTaaWn+pvWw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706304185; c=relaxed/simple;
	bh=OHfGdigSiNuQI05LLiv9w76Mce3WFxHYfN3o31XlRzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ik1TnsW8zTWXAYHL0cCEbbBPxzT453++4rJDQJCbD5YWKI6ouKR2POum0enoevlR/KAWBZ2efuBSLQvAWN0rPLeB+L2nYmG7aZZ37WsDL65cfVy2m/Chbq2La+qG0XxFthC34CR+JrjhtUOD18eg7H3MuzXVvjqcJdH4VXbV2dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JKJQguYs; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e80046264so17900025e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 13:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706304180; x=1706908980; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VzYJT0Ks7UjMwY3R/pERVBkgLI/CNkWYntnCR1F4u48=;
        b=JKJQguYsfLoW56IFUPSUXWW9/uayect2U5qYbZRNQjr/nCaWH2Lg72PH90TFnPmu0O
         Rmkxg70qkzmGercDV40W5CbOOFJYKB7iYCY9K+G0cFeRoTJN/HiEE29xZOgIWt0aDs0W
         3VIoF34c5zZNvFzfx6bFW6sEJwhc5sAYkChpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706304180; x=1706908980;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VzYJT0Ks7UjMwY3R/pERVBkgLI/CNkWYntnCR1F4u48=;
        b=pL0bpEj58Zf28k4MSSTdE6ponAWwmbjf3WgK1krYqiBSgEI2Y0TgUr0lPCDq/3wtKw
         B1h55hdm8zvc2v5epJsLHzRSk6eeg2ImVPuVFdTLVX9RCJak2mlyjJcV95zFaQflIEm+
         2ozq9x9IJMBI0qyU95HvZsTJj8SOPDt+dTtLnE7luBW5z+MKVi0Ej3A/eRHCilVi77Kl
         eFbXESzbbIN6359oWLSxaRbyepjo18hvBwMTDfpULAjyP28+glEjDn5h1zUHHqz3abWL
         fXsEYHtSfKuOq+kp/hMX/jEwu/l8+mPcpGbMftLL1xuyMf3PXGTLcJUDXG4FGwJIK6N2
         rndA==
X-Gm-Message-State: AOJu0YwL+dz70Nv+QdfbjotGLFxqfpblDWpzstnkP84lBpltlU5zG1WN
	e//C+XFZpZW69EgR8Rdjqisle678upV5/ZOFh5SwxoS54xS5mz+18iBoMjT1LMynkbHFpwO8pcZ
	thuxO3Q==
X-Google-Smtp-Source: AGHT+IHtkDxvmJu+aJK6N/JqX6goY8XKI6V/w8CYdfo6yjmMZlR4UjPetO70pNxHA0RLSGPB8FLcSw==
X-Received: by 2002:a7b:c38b:0:b0:40e:ce97:443a with SMTP id s11-20020a7bc38b000000b0040ece97443amr317307wmj.42.1706304180640;
        Fri, 26 Jan 2024 13:23:00 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id q7-20020a056402248700b0055c83efc9b5sm981094eda.62.2024.01.26.13.22.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 13:23:00 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-339261a6ec2so1030532f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 13:22:59 -0800 (PST)
X-Received: by 2002:a05:600c:5352:b0:40e:4179:d060 with SMTP id
 hi18-20020a05600c535200b0040e4179d060mr323434wmb.65.1706304179586; Fri, 26
 Jan 2024 13:22:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Za6JwRpknVIlfhPF@work>
In-Reply-To: <Za6JwRpknVIlfhPF@work>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 13:22:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjG4jdE19-vWWhAX3ByfbNr4DJS-pwiN9oY38WkhMZ57g@mail.gmail.com>
Message-ID: <CAHk-=wjG4jdE19-vWWhAX3ByfbNr4DJS-pwiN9oY38WkhMZ57g@mail.gmail.com>
Subject: Re: [GIT PULL] Enable -Wstringop-overflow globally
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 07:29, Gustavo A. R. Silva <gustavoars@kernel.org> wrote:
>
> Enable -Wstringop-overflow globally

I suspect I'll have to revert this.

On arm64, I get a "writing 16 bytes into a region of size 0" in the Xe driver

   drivers/gpu/drm/xe/xe_gt_pagefault.c:340

but I haven't looked into it much yet.

It's not some gcc-11 issue, though, this is with gcc version 13.2.1

It looks like the kernel test robot reported this too (for s390), at

    https://lore.kernel.org/all/202401161031.hjGJHMiJ-lkp@intel.com/T/

and in that case it was gcc-13.2.0.

So I don't think the issue is about gcc-11 at all, but about other
random details.

             Linus

