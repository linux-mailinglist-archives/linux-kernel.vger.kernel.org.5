Return-Path: <linux-kernel+bounces-111376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA60886B6F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF75B286372
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7BE3F9CB;
	Fri, 22 Mar 2024 11:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b="TiO96eF4"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7333D3E49D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711107792; cv=none; b=ZEnbLpYRQlBNePLdE5RdbOwz69DWyyG+4YPavWAqNuTF4gz4qPXXUT55DSRv2czotl+mX1pb4g/P9K3WFWEPCIPRAQ3XUZr8jf6I0Pou8NAHcNrMb5kdttYMvJSgcdgbjPMQNUMvgFb8FsBkNtC2bFC93XVIMCBH3QngbgIzjnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711107792; c=relaxed/simple;
	bh=W7Q4P/rzj0G3q79QAASFJ4CLV1Bmjoq68CrSY3p+Pi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Zazmif6vYfbhH+5FAyBtNyk53KaJ4nbrgM8wTIedE0U9//RR3DxYZO2AGc0OqeZVwr1+2ptlES8SP7olTmNB6PfZ6runWaqnk37GKSHzHFbbAP3QLXENkWd5ZUHru/RjbSxCfwoGzcSqC6aRvS93kTdGfdVPL8tNoZSPilQBqas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net; spf=pass smtp.mailfrom=iwanders.net; dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b=TiO96eF4; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iwanders.net
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-430dcd64e58so13610981cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 04:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iwanders.net; s=google; t=1711107788; x=1711712588; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DFtkdxWg3YTDXubNhIb/ZMO3gxbH9gnrT5pvNADSnCg=;
        b=TiO96eF4Mo+81tGU6k+TFPiNR/c0kE4MTLM2wEAoUb+fA9hlwWYQSgvt/CHw7S78C1
         6+9uj/uOgSdW20IP/rhFXCgctQO0Agq9y1IPtv6+msE6XmFoJqAETsvJZD0CdF/oguwW
         yOK16/CdlnLW9CIMsQmmNjQWB9XckGTXWBgp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711107788; x=1711712588;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DFtkdxWg3YTDXubNhIb/ZMO3gxbH9gnrT5pvNADSnCg=;
        b=h6xkr9ZYFscLZvvSKNy2EyEzvNTfoVyZWgIS09u/wydrH0uCiGWSWagflkXwhrlsVz
         iBN97DHLUiEWhIL84DG4jXMqXFH0KAYoWxZytHgE7rFYu1M/6L0WgHNKwc8rPgpAGQUA
         VoYwDLwIv2pkEsplcly5DBQcaI+Ewtqzvo09gaMNx9IqkNwtxtgF71YOxaRpynkbDb+/
         aAKZfPohpd6XMYYCYC8eJXVocJHLxg6vA91nx6y06W5G6ppEI44PGcVwE8Xtjajj7q2z
         1ATuFGzAKBk0NaSYhWL8DAwBj9kpobxW8vNGFNL0IAbAuUX9jGG2qLaMaZzckClDO/GL
         /Paw==
X-Forwarded-Encrypted: i=1; AJvYcCUUndwvhdHipodk4XPkFvDWcP4vhGwMZwzCzLMXlnBbT/S5vbmUIUqagehvpZc2l8+15FQezcxfh2Icj5HzppYvD3ptMdcmb0RXqDp0
X-Gm-Message-State: AOJu0Yy27iiaX81UWoPjHG/4p4HFvA5l/sU/sWM32sUz81rNU9ioQR+4
	NtVENqvh58Ywu+CDESp7X/98Wqn0Xn3netukowpCXKWafZdOG8u9VuNrLaMWhes=
X-Google-Smtp-Source: AGHT+IE+3zHeeoIhE2g6TVXkodbfwvwwsGK9eDPW/sZjxsDKs2z7Sz1XXBTnamJ7SLqqIwckBFiBbw==
X-Received: by 2002:ac8:5cce:0:b0:431:1274:9833 with SMTP id s14-20020ac85cce000000b0043112749833mr2187480qta.65.1711107788334;
        Fri, 22 Mar 2024 04:43:08 -0700 (PDT)
Received: from eagle.lan (24-246-30-234.cable.teksavvy.com. [24.246.30.234])
        by smtp.gmail.com with ESMTPSA id e15-20020ac84b4f000000b0042f14f31cd9sm782853qts.92.2024.03.22.04.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 04:43:07 -0700 (PDT)
From: Ivor Wanders <ivor@iwanders.net>
To: ilpo.jarvinen@linux.intel.com
Cc: hdegoede@redhat.com,
	ivor@iwanders.net,
	linux-kernel@vger.kernel.org,
	luzmaximilian@gmail.com,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 1/1] platform/surface: platform_profile: add fan profile switching
Date: Fri, 22 Mar 2024 07:43:04 -0400
Message-Id: <20240322114304.3615-1-ivor@iwanders.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <424d43f0-bcbc-f904-03bf-9f4c0488d706@linux.intel.com>
References: <424d43f0-bcbc-f904-03bf-9f4c0488d706@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hey Ilpo,

Thanks for the detailed explanation!

> We're currently in the two weeks merge window (the time between kernel 
> release and the next -rc1). Usually, nothing happens during it for new 
> patches that are not fixes (there might be exceptions with some 
> subsystems but that's a good general rule and even with fixes severity 
> matters a lot if they are considered until -rc1 is out).

I see, time flies, I thought 6.7 was just wrapped up, but that's already
over two months ago.

> Our tools take care of the tags such as Reviewed-by when they're made 
> against the latest version, there is no need to resubmit just because of 
> tags people give to your patch.

Perfect, good to know, I'll just sit tight.

~Ivor

