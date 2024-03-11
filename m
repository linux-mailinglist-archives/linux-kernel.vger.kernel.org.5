Return-Path: <linux-kernel+bounces-99616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB02878ACB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9551F223C1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467B958120;
	Mon, 11 Mar 2024 22:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b="CBzOWzWW"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D58482C1
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 22:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710196374; cv=none; b=F59Z7F97MboQy5RS5WS/4Q3gKt8OBYV1sWAHyWqEnKMKreh3Jui+Ez7xeRSAmsOmUne4nV3ysbJwzS3646yJMgpgB+ujOv2WyQZNdSDeEohGnnTVc0vsZkP2gj3f1XGqx1Yh6v/RoYEcbb2qw2BDFjKzyGAvD22eet7EYuy/Nc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710196374; c=relaxed/simple;
	bh=vwLn6pPMKhnjkaMcj/WgdNDx63eGUSsPz3XGpaNFawk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WXoa2YvinUzypZYnfPy2aBwwHrgI2VKrX8seR68YEUZjlpmmQskSNHY8PfaVQMsE8vgjTCm08BH00HNDyFbseiXGI5G8T12aDuout++ixBcCEjMItGcAoDq7h66TIVbdkcGdbSfAcalzIs+qwFNVZhbAAyHeUBn1O+vYPbUynQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net; spf=pass smtp.mailfrom=iwanders.net; dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b=CBzOWzWW; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iwanders.net
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7882e94d408so404805485a.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 15:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iwanders.net; s=google; t=1710196372; x=1710801172; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CArm0auKmwv8Q1uxyRuXJ0PLf8GkQNTL9Enxue9llQA=;
        b=CBzOWzWW/6z//lsY6fsPIVmmAg+pRQcPz7N4wMC70sBXg5tlcq+1W+fBgiIbPlIdST
         eflgfFFuxmCZs/wT2EUAAr7lQkC4li4GMHO5BjqFATJfo1mNYr3WBP4vT2QeFTPfKAzC
         73hU47t+bwpbzxfts6aJKoVlW0cb+H6e4+Ync=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710196372; x=1710801172;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CArm0auKmwv8Q1uxyRuXJ0PLf8GkQNTL9Enxue9llQA=;
        b=cDlEIfyMYUAm+9Gs7KDZFF6fTx6JVGr+TiNMyCnFGfQqQL/5wYxYVzya6V6VuFHNvq
         BJkwpD9jZMf1MNmRrLhtMJt9KtJNY1qM+5k1l6NoptwnskEKhNBmIZcV4q6Bh3XxvIta
         f2s0Kswpy/FZv17zUEtywDsm9oE6FLoYq7yM/g2H7PmSBfCz/d/h+kDA4h/LxrvNIo5U
         QJd3CUF+PitFoaIQfKzvnYRfMMRnSisqN3xMOfgf3phi5sFvGT30zWuulCQoGPsU/ZjI
         G+u9JfC9liYYvzsNRPlLJ4jGH/GRsG8qvpToPCG1ZfLKYTvsKmzQfZ8zjLDevQjlDXc6
         U6mg==
X-Forwarded-Encrypted: i=1; AJvYcCVRBRbkxspxoTP8kIX9RAJzM2z1wkv+yU0jmviczQvn3LLdR0HJJ7iAWI9UmhTlHG4B/xQ2wK0UYNbgQRAl559Xr6tMZkbTpu6cNjYX
X-Gm-Message-State: AOJu0YxNMedXZV+nRbje7l5SyqGK98+3/v1vp7BDoOLwnKlHZB3JBbqa
	AgOSyyvO5FiX2QjF98HHjb9Udpcmi1iG7M2qhlISIfQnL47pb3PcnuHXaF7WtajCr595AMLFu2l
	EKNU=
X-Google-Smtp-Source: AGHT+IEKvHUH5Vn2Ya7dsxvRmBmETgiXKV1KVbATb/H14J5Tw1iznBmhd4clegC+uNQb6ptxpPNBRg==
X-Received: by 2002:a05:620a:2455:b0:788:25bc:622d with SMTP id h21-20020a05620a245500b0078825bc622dmr11477842qkn.55.1710196371783;
        Mon, 11 Mar 2024 15:32:51 -0700 (PDT)
Received: from eagle.lan (24-246-30-234.cable.teksavvy.com. [24.246.30.234])
        by smtp.gmail.com with ESMTPSA id h27-20020a05620a13fb00b00787930320b6sm3096198qkl.70.2024.03.11.15.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 15:32:51 -0700 (PDT)
From: Ivor Wanders <ivor@iwanders.net>
To: ilpo.jarvinen@linux.intel.com
Cc: hdegoede@redhat.com,
	ivor@iwanders.net,
	linux-kernel@vger.kernel.org,
	luzmaximilian@gmail.com,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 1/1] platform/surface: platform_profile: add fan profile switching
Date: Mon, 11 Mar 2024 18:32:30 -0400
Message-Id: <20240311223230.4653-1-ivor@iwanders.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <fa16bf5a-b0da-2751-7109-fe76acbcd7d8@linux.intel.com>
References: <fa16bf5a-b0da-2751-7109-fe76acbcd7d8@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

> Is char correct type here or do you perhaps mean e.g., u8 that is more 
approriate for 1-byte long binary data? [...] u8 ?

Thanks for the review Ilpo. Agreed, u8 would be better, I also noticed that
this variable, and the profile_le one in the function just above it can be
const, I'll change this type to u8 and make both profile variable const in v2.

~Ivor

