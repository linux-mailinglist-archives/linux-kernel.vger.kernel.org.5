Return-Path: <linux-kernel+bounces-16120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D85282392D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0FB228388A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 23:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C0C1F609;
	Wed,  3 Jan 2024 23:30:59 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FA51EB40
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cdbc7bebecso3342581a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 15:30:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704324656; x=1704929456;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NPKuGIxWLQkrxq/6HJv4rBrlgdO9b/KHP8c8IcA9QQw=;
        b=GXNeMbpFGHl2FQOEj6lYrVcHWJ7B0U1jgjpLNo8r8/cf1sWKRvV4BTmunnMwp06N53
         jp7uMEdka6lorketP4rab0l0FeE+O0/+TA97nXTAfL071/yh2tZEA1RUVvaspXY4KjV8
         SPnxrtKVjMnxGPP79PCHdxITF9Qr0OYHMP9HSeGi8A3cNIke2LmBP3Lh7IzVNjGf2TDu
         +Kah3d74UHSzqLBBeItIc2HsKlRy2WoKZLaRGDoiWkMEwDSqIpr4WJDhG6RPzz+m4zgH
         Rypj1N0rFqsWF1eQnhaXfdQI5IJeuQ1/y+YwtQG4n8eQK5CInq880146Vx3oXkHNAaF5
         PJOA==
X-Gm-Message-State: AOJu0YzsXQH7pWqxQrKTS7DOjhZ2bZuogcjNut8IzHX06rtYKunRMXVe
	ZNhwuuqTBKtkrtEz0ItShyrB2UDrLTikQg==
X-Google-Smtp-Source: AGHT+IEJCBdZg1COiav9DFGhNY/oMbK6nuckRXEunUknRy40h+ZiVhN86tqyGQ0BWUQxq5YQITU85A==
X-Received: by 2002:a05:6a20:3d01:b0:196:a52d:94fb with SMTP id y1-20020a056a203d0100b00196a52d94fbmr3672706pzi.46.1704324656277;
        Wed, 03 Jan 2024 15:30:56 -0800 (PST)
Received: from localhost (75-172-121-199.tukw.qwest.net. [75.172.121.199])
        by smtp.gmail.com with ESMTPSA id e27-20020a056a0000db00b006d9bf71461asm16450490pfj.86.2024.01.03.15.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 15:30:55 -0800 (PST)
From: Kevin Hilman <khilman@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PM: domains: Move genpd and its governor to the
 pmdomain subsystem
In-Reply-To: <20231213113305.29098-1-ulf.hansson@linaro.org>
References: <20231213113305.29098-1-ulf.hansson@linaro.org>
Date: Wed, 03 Jan 2024 15:30:55 -0800
Message-ID: <7hcyuiatao.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ulf Hansson <ulf.hansson@linaro.org> writes:

> It seems reasonable to collect the core parts for the generic PM domain,
> along with its corresponding provider drivers. Therefore let's move the
> files from drivers/base/power/ to drivers/pmdomain/ and while at it, let's
> also rename the files accordingly.
>
> Moreover, let's also update MAINTAINERS to reflect the update.

Acked-by: Kevin Hilman <khilman@baylibre.com>

Kevin

