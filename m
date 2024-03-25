Return-Path: <linux-kernel+bounces-116909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C1388A506
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CAAE2E70FE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BDF157E90;
	Mon, 25 Mar 2024 11:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OuCrG1Pm"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62A0140369
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711364894; cv=none; b=VCuT/+yNgQI9u7DA3jLP/NCVr6Lfm8FmvFVE5sm2SIpTicaggpqBNhAqq1KdZM46QZnjCOKQodRn1nl4Q6DgLw22xkNZcvx10Lr0KsI5WTd7E6GaSpvT8GXyKj+M7NWpfMJhcC2SlHFW6uZjzHsGl7K7gcBtuwHWjd92b28Geu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711364894; c=relaxed/simple;
	bh=ezAPP2P2PPbuTGyeyRYKrbU7UaJmXOkE9BooJfHj9dI=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NW9D5kyQfs4MQ0SG7FBbf+7SKGz1MIXmyzvhHdOHZlzeUNl10SVDtF+BizvGfDzQDWmjM+QHloU+80mS2dHnBCil2HIG+rwTr++i2aa2JUiSxbMngBHo4I6Jsv4knz1QYGOpX2ZLuf0CxVZcn89FPIWySCPZy8MuCHxBKdqYGz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OuCrG1Pm; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d228a132acso58650041fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 04:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711364891; x=1711969691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Jt7rSiI/hIUR7DCEyNZg9o+TR15XAeC/vsteKXpff0=;
        b=OuCrG1PmyRMhM+yDD+eI2kZvY8VEW4WVjhocLQE/9qRAXWgQHN28vSa461yTqLBUWA
         3zHtyWzvvzeQb/GOEli6n9VNP5OE95Iu5eziZNRs1PuzsJt9fz/C1m91POfA1dOe5SI/
         hqmwG8m+Z/mYt+nCo8oV2dBGuEwuib0G2kb0ty4phU8zQqtU+A0oSoQtJMmNMtp7El2x
         uFxrvdIwUhLMYhpWOHuPFp9i1w6QHQ4US/inbJcWwUHjFnMcY3k9Jdqq2CLe47mJ5Wh0
         EyEL8bp2/+qE5IzsG4eLChJo6v9lybFCvnx8cvSi/zs8AENo0twnqjkaqCig/EGjk7mx
         vNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711364891; x=1711969691;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Jt7rSiI/hIUR7DCEyNZg9o+TR15XAeC/vsteKXpff0=;
        b=C+7lPdLYP4PeuMQ4h3uh1NlzWQlvnZiMuaH4Plcz4imTmaGgSJF3JRZVEZdk3wGRYX
         WsfE/c/VH+57siSlgyhKGAEpEMTChh+h+KvSsiNx5yIdcAr/9Z4XWputGp5LfSKrn1os
         PQXKsOxX3kdsSU/sxskBX/kHYey2WnYRV0yWORCeAuTuhGx2su9FY3Gx69o7BORjjJzk
         Y7MH8hCXnUivQPsYX0oomNGtpJdaf4+p/lO86xGOZ+onxNDCYpkBIEwStpdk/ORo9gLp
         HruOE2o2WafFwBGwHgRzgJ+njI81YpAOoaYbsmgSMmebWe4DWakbbe8fGeworR2E11CM
         ncuA==
X-Forwarded-Encrypted: i=1; AJvYcCWSRzwCpg/X+xeqcqYAXVRGl+FA31s2OKJ8ZNMlrOV3UA7O+ePqhO6LXxpizjIlqgcZRxiwnIJ7SZ3g86hNLwHv0rlTzKxRTmRogrem
X-Gm-Message-State: AOJu0YwsVo1Gqn83zhN853LZ0FPeiaWqZjkm3bpfAXz/mMrhDS9swV3g
	/jG5CGZmEZgLp8/AynyLL1Xy8DdcCbY08XRWGscl5eMLkfJsLxANGLKELUk6qmWfWmH6GcHXS19
	S
X-Google-Smtp-Source: AGHT+IFl31fTwQBrf2A1n7YW+5LseAR40B0gCjSXJ75ZTI4oFnBpN+0WzlOMbBO3OODZVfTiwxO+Yw==
X-Received: by 2002:a05:651c:199f:b0:2d6:cd05:1891 with SMTP id bx31-20020a05651c199f00b002d6cd051891mr3302850ljb.15.1711364890761;
        Mon, 25 Mar 2024 04:08:10 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id r8-20020a05600c458800b0041478393b8fsm8136642wmo.42.2024.03.25.04.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 04:08:10 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240307143644.3787260-1-andriy.shevchenko@linux.intel.com>
References: <20240307143644.3787260-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/5] w1: gpio: A set of cleanups
Message-Id: <171136488931.37433.15331191759765247216.b4-ty@linaro.org>
Date: Mon, 25 Mar 2024 12:08:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 07 Mar 2024 16:35:46 +0200, Andy Shevchenko wrote:
> A set of ad-hoc cleanups with making driver to be used in e.g.,
> ACPI envionment.
> 
> Andy Shevchenko (5):
>   w1: gpio: Make use of device properties
>   w1: gpio: Switch to use dev_err_probe()
>   w1: gpio: Use sizeof(*pointer) instead of sizeof(type)
>   w1: gpio: Remove duplicate NULL checks
>   w1: gpio: Don't use "proxy" headers
> 
> [...]

Applied, thanks!

[1/5] w1: gpio: Make use of device properties
      https://git.kernel.org/krzk/linux-w1/c/8b39a723ef1fa3737e11832ca11183bbaeda2498
[2/5] w1: gpio: Switch to use dev_err_probe()
      https://git.kernel.org/krzk/linux-w1/c/9e085c045868a6a727b3bd0fc7840ccc9e04d3a3
[3/5] w1: gpio: Use sizeof(*pointer) instead of sizeof(type)
      https://git.kernel.org/krzk/linux-w1/c/ef2b810e1152d77686032e7dc064ff89b4350b00
[4/5] w1: gpio: Remove duplicate NULL checks
      https://git.kernel.org/krzk/linux-w1/c/540d3f15c0aa2baf7e9b48a4e516391c179daab2
[5/5] w1: gpio: Don't use "proxy" headers
      https://git.kernel.org/krzk/linux-w1/c/cde37a5bdb0ed2c4c7b86ef688e5fdb697525a57

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


