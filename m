Return-Path: <linux-kernel+bounces-80028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEDB8629E1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 10:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F3A128150E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 09:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA8BEED0;
	Sun, 25 Feb 2024 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvhgI2up"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533C5DDC7
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 09:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708854602; cv=none; b=POZbYP+WLQlPjMA/4mDq55XJ55Ke9cNNKEP/sWJUV2OlDXpPRbNy1RWtF/QyGkP61LKkrq9VkSAlqFdmAEbt/pLTYqDcfv0sc+4QKkZEZYSueou9Fe3hSVLtIvD/O3IoM7eZGSA7hWgW3tUz1Tsw+tkB2NxkyZ7xj0OwToTEvas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708854602; c=relaxed/simple;
	bh=PjhNiUkoD3+h2lHi+yUUNRpw9+3krebCCi9rOPTdNfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4BxuB7sxptkpN0IAHivw338Tlpq63pNJmUvv6+wrJykOst2BYjo6cTWT2X6R0frjumWTl7V+cxNmmTiZo3J49WV4Qw/XOLHwt9KIpCRuJ2EBYbt/yQKxAAXPQce5SwR6Rtsnc6A3lyPp6Jg1Nns7q6SNTENCNrRcS51jI2O/WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvhgI2up; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-608d490a64aso8493787b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 01:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708854600; x=1709459400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4MwmdceTTW6yTK6dn3O1uN2xQAdcjCnqlQIDQJMZQo=;
        b=CvhgI2upn4GgRANejk7M7iQLZx1qyt2v5s2BuNQr90o5UTiKXvcWgFkM/j29bEmRxG
         LKKJKEv/vDz+/aiuPrnhtV+rxpBdV+xNazfxPtWZYWcI2jpnMlh2Lh3lcPuv51WJy6s0
         9k+Ckc72LGc+RO1oN4X/Sqdn0wv4cE4cnKsMLfiAGBQFdNEwHF4L5hGxggYB+l2XLxel
         Vrce/KCxIeNNNG9OhcOOewElXisywC2hlcuCKREeyO+9rQtX7EkgOXeeMmlSsJFhjfj9
         w6wSf8l4TcolwZeKSzCCoUrUFAYH0SOQ/MhT+N1NpDd1OJWTSsmQdQvr6FsEptM4Wz0H
         fMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708854600; x=1709459400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4MwmdceTTW6yTK6dn3O1uN2xQAdcjCnqlQIDQJMZQo=;
        b=rY/GUra9p2Pru3Zf4R8hRaFsNXyQutrDgbu+RekSAK6ao5+yx/KvfI9NLTNPJcjB1v
         RLZvpyjEA/LHQRUJQJWrGP6jLfO6CS4MCX8VB4z3YVLCMrNyno3t7goODYQqfnQKcAnP
         60y+FKuJXUCgN3oRjfk0wKrJ1WSV050g47YUzvffJUCmX2msMYAz5EsKywqnfmXGtAVS
         YReCDVS9W8wxMrtQDQ930lCKqlzpypuobAik2LJpR++aIj+BmY7qb9sJBk/diJECQp4L
         G5olOWlkXkgOxpAyNaRtGqRlIUHt+gvtBifsT+V/wwigntg4th+dec/fTIZeFTKYX6A3
         wEZg==
X-Forwarded-Encrypted: i=1; AJvYcCWjSEM/byAOxhhSrclSrhAL5RrID19nSue9Opawqj/y9TOaut1S+Z+iXhzApMo7+XGTVniiQwSJQ1VNbPsnWRvCYxFhMXVIW1zTsl8B
X-Gm-Message-State: AOJu0YxuAZxx9KjuApA8kz0EkXjatZfVveECPqQqZX9T6ViV9Lol3QBJ
	qAi3dnywazdWWjvr0PXYgv4kfqQqPy1M78f5y5A7pyrFXO/VFvRAIGnRPneB5Bu1Sn3wgbOHXe8
	ArCPFmQc5Z9ILDBKKlHPYglR1Adc=
X-Google-Smtp-Source: AGHT+IGliUFzZzSMB8+3Z2QJ9rdqkRgFL0iBBELGWFni7I8zkucsPnyVtOLt5vCl0HnYHKO9ztyFFZNjBPCDyrJR8WM=
X-Received: by 2002:a81:be0e:0:b0:607:87cd:9395 with SMTP id
 i14-20020a81be0e000000b0060787cd9395mr3610315ywn.17.1708854600306; Sun, 25
 Feb 2024 01:50:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225084017.418773-1-dileepsankhla.ds@gmail.com> <2024022538-buffoon-praising-f748@gregkh>
In-Reply-To: <2024022538-buffoon-praising-f748@gregkh>
From: Dileep Sankhla <dileepsankhla.ds@gmail.com>
Date: Sun, 25 Feb 2024 15:19:49 +0530
Message-ID: <CAHxc4bsFj1=VFVDWbdwo3W3CmSyPG1585p2zBePpsD9qy6VKdA@mail.gmail.com>
Subject: Re: [PATCH] staging: greybus: put macro in a do - while loop
To: Greg KH <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, pure.logic@nexus-software.ie, johan@kernel.org, 
	elder@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 2:26=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
> Did you test build this?

Hello Greg,

Yes. No new warning/error was encountered on building the kernel.

> >  #define gb_loopback_attr(field, type)                                 =
       \
> >  static ssize_t field##_show(struct device *dev,                       =
       \
>
> Why did you only change one if you thought this was a valid change?

1. As per my C background, I think no other macros in the above source
code file need to be enclosed in a do - while loop.
2. I am writing the patch because of the Eudyptula Challenge, and I
have to fix "one coding style problem" in any of the files in
drivers/staging/. The above one was one of them.

Regards,
Dileep

