Return-Path: <linux-kernel+bounces-87603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE68386D667
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A58284738
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134E36D527;
	Thu, 29 Feb 2024 21:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CKKg21h0"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C766D513
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 21:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709243583; cv=none; b=Nsl13pCpGPwbeO94lAKgPBFoC1qVNZOKp5aykhfTTY62rmMQpVZNLqaynp5LUxoa2gO3QB0LKOl0TJlGoj+X8/pz3ndNKhDYNFegixxFSLv0n6mUR6YqUHz4Ib6cDjaNF8VcdrTTCGzGPjJlCGexvr2Svu+wcyYCoYmua+RLOSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709243583; c=relaxed/simple;
	bh=40LOGwLLO1L0EdJYZW5tRFxEBHq3W8RHKzr/KIs3gAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJql0gTMjx9DvL+AbuAZXVvqGviST1o+OrN417Al7wZiPPKqDxYVBxD1SY2CK0oant8uyWnEYPKplfPzc/rlIUhHaRLinYfDo5Okf9+S89DQxwmYo4n5RFMjzOY1PWJpj6q9Hu1rrC5EM9DUoxRkA1749Z2TXT9HQFX8u+Ud3MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CKKg21h0; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dc1e7c0e29so1118635ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 13:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709243581; x=1709848381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfVmIftr9u8G53CVoGBCv9uMSPlzLWhBX0yxZViPO7o=;
        b=CKKg21h0vpw6xzLXV5wJwTLWeJopuFECBiuk8h23l7cNxO0xeZ9RVnFLq2hzHEj5Bj
         IYFg4tYrIWtWaFohxBvyRb1wZp5uZSQiiXAJQOuuy5af4J7rE6uCZ4gkLDQL2/DJtOuP
         1dKLmU6NqIlSrk+eHS0VUSuyhERE2Iyy7aSo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709243581; x=1709848381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfVmIftr9u8G53CVoGBCv9uMSPlzLWhBX0yxZViPO7o=;
        b=eg3sVF0MEMZMCjFWe0T7xCY3rS3H7n3TexvIESlGj9vvadPJ5loC7/6hliYrTOVAsc
         PCaPw30UhLyES7ZEMfKO4LVtUqeT3kUtK0FDPLkNS1Ov9hqbbDgBCVXYaxP2VB3PqLWG
         Rh7QSraBg8l+tgdvOUz45DH4Bpcu/KSd9FZP1xvvnlAvZOfF72vtBHqMRbx0Djg673b8
         8BxXGAHNb2nFnWcqbuFCR8g7fl8JItcpzcRWJ+HXVqf91HMCzrvW7acLY911vBlNBX9S
         Hw2W7eeg9wwUplgkrOCYF8LXJn5IjLao5CDf4vNQxkrmT+DbvHRsuJsYob4HPDfG9DxU
         wt7A==
X-Forwarded-Encrypted: i=1; AJvYcCWGsEdJLlkIO7wrEXkaq3CXwJdzMHcoL94JYKWK51R8L+GhO+x6EyKv7kP9mvaKYdTL4tiRGHnxIEzD1FJoI7CQ28lveXH7w5MyN6/B
X-Gm-Message-State: AOJu0YxcNj5kZ5DEd496zoTg6dp/Y6vzKi6zcbWFOnjm87ad5kRHBDiG
	4vXhlHGR4bY9Y9zbuDfgVeAnpjXvjgrbTCK6c+AfY0rmJzqkzPg3WZ6pUfw+rQ==
X-Google-Smtp-Source: AGHT+IEjOzizZx4W19g0cQia1GAOC69UKAExPf80Lg4HJzLCbfInVD20wOPFxsp6aKfWtETmCZseew==
X-Received: by 2002:a17:902:f603:b0:1dc:c45c:5d1d with SMTP id n3-20020a170902f60300b001dcc45c5d1dmr4470230plg.24.1709243581294;
        Thu, 29 Feb 2024 13:53:01 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902a38b00b001dcdb39613fsm1911625pla.244.2024.02.29.13.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 13:53:00 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kees Cook <keescook@chromium.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v1 1/1] lib/string_helpers: Add flags param to string_get_size()
Date: Thu, 29 Feb 2024 13:52:34 -0800
Message-Id: <170924355200.1509550.2313379734413200100.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229205345.93902-1-andriy.shevchenko@linux.intel.com>
References: <20240229205345.93902-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 29 Feb 2024 22:52:30 +0200, Andy Shevchenko wrote:
> The new flags parameter allows controlling
>  - Whether or not the units suffix is separated by a space, for
>    compatibility with sort -h
>  - Whether or not to append a B suffix - we're not always printing
>    bytes.

I cleaned up the Co-developed-by/S-o-b and applied to for-next/hardening, thanks!

[1/1] lib/string_helpers: Add flags param to string_get_size()
      https://git.kernel.org/kees/c/ec8815c56558

Take care,

-- 
Kees Cook


