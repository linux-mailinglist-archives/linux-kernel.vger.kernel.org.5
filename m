Return-Path: <linux-kernel+bounces-103266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D08E387BD33
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DF311C20E40
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936495A11A;
	Thu, 14 Mar 2024 13:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cU4lGv+a"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA5F59B52;
	Thu, 14 Mar 2024 13:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710421346; cv=none; b=BGeIaoWKMLbLMkoN76mRZhABtnBJ1oR2XLZn35K7kjjs4z3BnRmf4NvVapZIJGKxUPjh6QrlM7Zq+hZN26rnFmDnaJbu+hSUfrNDQNQ8Md4EXlGh6u5Nhok/CCCCkfteq0K7N1X7ZAdbFvPGBqfaD7a8cYubFAtkjCv6iwG15N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710421346; c=relaxed/simple;
	bh=84bbEjvBlJ/24wVknFCROidZyrV2FJtAwZcxO3xPYs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1J6INgROV8xP8Slgwv032sm9jest1senUvrffZo8E/u48zJBBbUXKIQu3A3XOXCQtolQ9CLwMEbkiQqSezurxp8+bDuTCoWQaxZKk1Yk9ozZYs+Bk/80EbSnf2RWIdTSOvCvkIM2X/hcUrhjKgu0Xww8aq3WcQeVgWnFjtC/vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cU4lGv+a; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dedb92e540so3822205ad.0;
        Thu, 14 Mar 2024 06:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710421345; x=1711026145; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rlsLkZ2heubivONDblGycl3wo6hHBEpYjO72QZ11wxU=;
        b=cU4lGv+aRHgkow4dCb+WziD1dlHKg2oIqh09T5xBgXPgitD8gHtHXdGXnE+uFjY6uP
         6QTk7StvHdmuz9RzMZ03gAc+7Tvfh3AQR49jNOfl/Tz9q1T55l1UAznMmmhjdo6BNo5X
         cRuR+tVGskElZ0YgDMqAmZiA+rwM73uJShyO6c2uULsmnEyLLixvoGL/Yl/ZnXvMxo6k
         PKPMnMRxe3hKWXkCvO4Lv2kLq6S08JIUFQOvCEoWlZiZwRXKpc3qYTVazjwqBrIo+aNT
         Lr1m5kTMUbyDnVGe3kSedNjndE04jbiBkos0zV27ovfd5EsbsuFWLcszthBtUsf5ZyBD
         zS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710421345; x=1711026145;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rlsLkZ2heubivONDblGycl3wo6hHBEpYjO72QZ11wxU=;
        b=bIbkVk8G18V8mGLMwuEaQytOjvjshPLcskIzYEDp64wVyyI6mWfU3PLtrOAhVIi5TT
         vGme03CuFTobYg8kh8aexh3R5jRNprcL95Q2nsYMn4TsA3m0oHZyzsi7JkST0vu4vNYi
         RpSNLuVAIGaYHlZr1D0lc7ZyJSYbllo/fbXFCz+j+tN/zfA3LidgmBMh9MNHJ7yFkcAS
         V8zY2EHZggb14mhlNT9zg7wGH9HHhEiLX/UJypdXE25wUP9B0wIYpAoXXnG9MRE9gUw8
         pjNnMro2SHmbUnaFLHhT6d+GU50ScU9mIL3+2KL3esfPqAjvO4+vpZmeItJX3SKBunOD
         m9eg==
X-Forwarded-Encrypted: i=1; AJvYcCWz5XowwnnWgwk1KMtZ94S7uGeqs1WLLbfmobIvUakfDzar2L+rRrauInXo80ZSoI3KFht+RQ1EMpLHNUCneHFxfZFBrlbDkXzeiIODbOKe+AFLTHSNRJvRKD8HkzefgTtlJFW6
X-Gm-Message-State: AOJu0Yyuui2klku061pemwMzhdS3iiBnS+ab1frfJeVmRBp4niP2QA8T
	mxdCXnIc69qIA0AJDXWfajdYj8Wy6sUEOMaX+k1vktN9TCGksG7kuCSkHpKlBoTGtSujaUe0VhG
	R7qajE8POrH/21Y/yCmpWra6w7lo=
X-Google-Smtp-Source: AGHT+IHrZbDmNwRLArFfEalJLerPRZlrSgqbWY6ZoxUILhYTVEuZ7C4bocg1wvQ4xim/PI56zkz2GgOQbqQfPdZPwk8=
X-Received: by 2002:a17:903:2292:b0:1dd:aaab:7e67 with SMTP id
 b18-20020a170903229200b001ddaaab7e67mr2743377plh.30.1710421344898; Thu, 14
 Mar 2024 06:02:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313163019.613705-1-sashal@kernel.org> <ZfKzpiF4l7eRUq0d@archie.me>
In-Reply-To: <ZfKzpiF4l7eRUq0d@archie.me>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Thu, 14 Mar 2024 14:02:12 +0100
Message-ID: <CADo9pHirYZG2xoJm60ohEgp_5jQRtVa27R3Tt8jozV00QBZgXQ@mail.gmail.com>
Subject: Re: [PATCH 6.8 0/5] 6.8.1-rc1 review
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de
Content-Type: text/plain; charset="UTF-8"

Works fine on my Arch Linux desktop with model name    : AMD Ryzen 5
5600 6-Core Processor

Tested-by: Luna Jernberg <droidbittin@gmail.com>

Den tors 14 mars 2024 kl 09:22 skrev Bagas Sanjaya <bagasdotme@gmail.com>:
>
> On Wed, Mar 13, 2024 at 12:30:14PM -0400, Sasha Levin wrote:
> >
> > This is the start of the stable review cycle for the 6.8.1 release.
> > There are 5 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
>
> Successfully compiled and installed the kernel on my computer (Acer
> Aspire E15, Intel Core i3 Haswell). No noticeable regressions.
>
> Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
>
> --
> An old man doll... just what I always wanted! - Clara

