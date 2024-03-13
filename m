Return-Path: <linux-kernel+bounces-102103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B51D87AE6F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A47CDB2532D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455025A4D3;
	Wed, 13 Mar 2024 16:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JaRzCwMH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2B55A11A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348592; cv=none; b=cFivHZWMv/GaWWZ22MJkQF277P0qJPGzpS00PC6T6YGqONw7sPj+SeDXJTwl+oPRKPAxMPWgpBQEZk+A2SiKSgoA14P41RJub7gWfoswlruc1yPZX8V6lhrmIUuWcSGqXSkDSKlS5ff36XTpOgbo1aGTusPkAkGP4kYxc3mc4jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348592; c=relaxed/simple;
	bh=VzkYuJhJxHAlsoBEWu8SsfwFLEo1Gz2XkJeX8uCY6dQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=skxYiCkvWOJRzNp/iswf15tRHAbiJ0w7NmQ3fpjvDGU09AQSjy+g6u73fRFMUM7OvLnScVxCDgipua1kyf0vFZdCQmccRUZj4hN49zoSWhtNYwPnJ0u1dnxlAY4P/Y6IWwtz+8/yCWm2lCNuVxoG31a+oEmnyjlA6n9ryEXEXFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JaRzCwMH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710348589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q2G67iTaaE7P6XAuMXpD/jw+pGFtD3L7nLatsyiWBEw=;
	b=JaRzCwMHHM0mp2q2UM3DydGiuZrMwPuskPWan2lRmyeKXFLipBsgvwPNhpH99Pz2qucBbh
	+yM4QxRGukJ2cNzz+Rzeo4l/KzBir+Oked8gCjuaons4BRhTAqzTS2eBm0QiquJ1xMQ8Wz
	815rahexbU8oXK4dEWtXcpCRZtQdWMo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-6chHg1SuNHyg8keOyRqVBA-1; Wed, 13 Mar 2024 12:49:47 -0400
X-MC-Unique: 6chHg1SuNHyg8keOyRqVBA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-513b1027dd5so66113e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 09:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710348586; x=1710953386;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q2G67iTaaE7P6XAuMXpD/jw+pGFtD3L7nLatsyiWBEw=;
        b=H+JzVAsqtOCEZM32pVnXKxvvT4/gaLhOVQFCo6fSybNwnOoKRNIybK72JA1X69gtV/
         1+t1T2j22HPInjlYHAkw83kchgGoeheQKee10JUv7hiovYqbre5AA7a6Z4NMVXy879s0
         LvDvKfDr5yo6M0ixqhUyA2IHl/CnldghfO/ZV/Qe0E7Kk5n43+XIiGAHYUDU0RgbVT0H
         nmFNPDW3HAyekOUlHzSbQqn1qiWuTffiR4UVNK8bCsSFIUd5bnPHqmqQRgcGMmLBeKN0
         GOxsZbRfYeCKCX6/SokcBvVbAqBgfWJgsfUIzyToWmy1cIxxfrtti1Bdm8M0eRJf5vbK
         JiQA==
X-Forwarded-Encrypted: i=1; AJvYcCUIA9uy4qBAzUJsS5ZMI83IaPRlfsmCrHnOmMy2ai0c4CfFNBbeInxCeYn/j4AmjslkSinQ7rDlt1hzTiv0XV7scEcWqycuoagiar6C
X-Gm-Message-State: AOJu0YynZgx5sJ6tSnLDkNay+dwnl+4B2KrCJBPqXKLmDJvj9K9YOxCc
	8iUMY2fjJZ0yCX5KEbXpQII9Czu2IiKscFHJL4HoDpUKcEjDB85+x/wsdaMZCAMPQ90+VZOhoDr
	xtkc32fuk7t8rb1g5zWUnfMPyjX8FI8xRk54e6QVe1Nnm0r+mUbX72Su0M+wm4smsmhypbEnuEQ
	g3rqr/XPhQZ76uhvLaL5003WubextXK+Y6MCjn
X-Received: by 2002:a05:6512:48cf:b0:513:c25b:8fe with SMTP id er15-20020a05651248cf00b00513c25b08femr3633374lfb.58.1710348586398;
        Wed, 13 Mar 2024 09:49:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFecCVULiWKXEpUHHmxzAFehkHi4UGzzQMhebCu4KpJosY3gPTZT5VnVDgEMzok8/FmGbE0MAM+WicaEPuoM8s=
X-Received: by 2002:a05:6512:48cf:b0:513:c25b:8fe with SMTP id
 er15-20020a05651248cf00b00513c25b08femr3633356lfb.58.1710348586028; Wed, 13
 Mar 2024 09:49:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313091259.1413854-1-ppandit@redhat.com> <0a1aa580-50b2-4657-8308-94bffb194aea@moroto.mountain>
 <CAE8KmOzcD+__7xdC7tegbHO9HEP48s7=reA4j-tvqVDwzHr+8Q@mail.gmail.com> <3fcb3702-5af2-4b9f-a362-4f08ee626b14@moroto.mountain>
In-Reply-To: <3fcb3702-5af2-4b9f-a362-4f08ee626b14@moroto.mountain>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 13 Mar 2024 22:19:29 +0530
Message-ID: <CAE8KmOxEyCHbCt=7PZi_xAnCdc2H3mFYYxBJ9YAq6imGmH6aJw@mail.gmail.com>
Subject: Re: [PATCH v2] staging: bcm2835-audio: add terminating new line to Kconifg
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, 
	rjui@broadcom.com, sbranden@broadcom.com, linux-staging@lists.linux.dev, 
	linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"

Hello Dan,

On Wed, 13 Mar 2024 at 17:24, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> I wasn't able to get it to enable the CONFIG_NO_HZ_FULL.

* CONFIG_ prefix is not required.

> ~/config-kernel/configk -e NO_HZ_FULL  -c .config  .

* This command works. It writes informatory logs to stderr. It helps
to redirect stderr to a log file.
Enable option:
  NO_HZ_FULL
    NO_HZ_COMMON
      TICK_ONESHOT
    RCU_NOCB_CPU
    VIRT_CPU_ACCOUNTING_GEN
      VIRT_CPU_ACCOUNTING
      CONTEXT_TRACKING_USER
        CONTEXT_TRACKING
    IRQ_WORK
    CPU_ISOLATION

* To see enable/disable/toggle options in action, a command below
(without -c .config) could make it easier perhaps.

    $ ~/config-kernel/configk -e NO_HZ_FULL=[y/n/m]  <linux-directory>
 | less -r

> I'm going Ack your patch because adding a newline is the correct thing
> but you should probably also change configk to handle that.

* ie. Handle files not terminating with a newline? There are not as
many such files. Besides I agree having files terminate with a newline
is good. It makes all lines/records of consistent format, otherwise
the very last line/record becomes a special case.

Thank you.
---
  - Prasad


