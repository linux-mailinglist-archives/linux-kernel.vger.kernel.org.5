Return-Path: <linux-kernel+bounces-70483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFD085987E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F921F21617
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A04B6F06A;
	Sun, 18 Feb 2024 18:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pJOTZ959"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4539D6F072
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 18:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708280515; cv=none; b=HUsAErjvobVvlWi+rTGIzp51hQyEQaye7tjpxnK/xxc9FkpsMyxZ6sclLG+H2JmTb2lvWWrrHZm0Akv034tQ6uxxOqZ2S5ghe2DC/hfJPEPvwEa+3bDibbOy5+pi6AkpqkZayZxVv8eA+BSGbdaQiqpq0J6Jo9ri3j09eKrg4fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708280515; c=relaxed/simple;
	bh=LJxopLRjYY608VyXan9A7AaAXQEYNJo9WMc9BDYf3lI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XT9vdfU56tK4cAWBsQPg9N6wBxwCKDRdMAN53G+sVdik6y7s3G+96GrzfOI1ReuqZVVGhBzwOwKeQjX9HKlR1rSByLOZ5aruJRAmb03NsEzektJBhhUmFSEk3+8D7IWfRDfkbQu4kvwbwXBSH4MgyVwtUIffnxHrG1mDSCGpDNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pJOTZ959; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33d2b354c72so876772f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 10:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708280512; x=1708885312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KN2+Eq6M3kaqLi0K2pEbsSinjMNz96Hcn5dAVh4QPNs=;
        b=pJOTZ959KQir4IqTQQVBRf1pjq+nwEOOIBZK/hN4dAsuN7THtUFZ2OAdHFIHiEGIzj
         FZ8LpTDj375fDMKvJtyo9Dhdikx44AGLWp+/fCHUS16AypmyxbtLhVPi/PqTRvVDA/GD
         etLYunZ1Oa5k9F3NatgK7aYgZgaB1R+eOqqztjS1La2rxZww/sekhpISXnaW84jh6VZx
         IzQI7Ppeh03Kgs/pJTWs64ceFAhAKryRKmUFWqqlIhUjgm3KlRq1uzplR8DTlukkEVWr
         kl1LDcDZbsFjTs1OCbsyo0N8LgGnudbP70ByVZO5f6SqvYH3JZtUUhO7DKxvm8BI72z+
         0yZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708280512; x=1708885312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KN2+Eq6M3kaqLi0K2pEbsSinjMNz96Hcn5dAVh4QPNs=;
        b=vr6zywmPWDIyyPNEecDZyYJRWC2xGUel5r9VNeEk5NNLOqTozqz8LqlEt2PxvVQAH0
         lU6eLRPlWB2mxuQy/vOdpRvVxFzL2mNX5QVuHjHlcedUC88CxhM6nvK4ktMf7odPKfq2
         i+EQBC5ibPaA2No40bhZTVMtpVpPq+ipEYBznawpC5qCSLv1cad3VMv6S+VVgZILjFE6
         N4nO9qPBNnkY/yXInq3UryxW/cUnMLNyBoL3U+MW6ZaKSOtvjCJU78AWN7W7gr+pj+iz
         tHhHBaGN76XvnZEE8W9upPyJ8ElBXS5DYjdGMht5EcWijVWoZucBrRLlX99xWzauSJrz
         iiCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcbJ8D57tclIdan6Ca83Tesuu3TgIN5ujiMj4dWhz9Cg+2oSV3QX7tNsd+TQakBhwvQZdtcqOvLYk+GRjh+wxaRwJU5sgTN33+27uR
X-Gm-Message-State: AOJu0YyYYr6biEykY694zPWfJC//4gKgfeAsMKEsAYvoSgf+WnBud/E1
	he7Y3O4xCK1D9sCfvvqVuMKQ6Cl7BKUeYO4yXZD4MYV4ejzbpJkY1ioxbOslCOc=
X-Google-Smtp-Source: AGHT+IHuj1yYst44BTBRKd1yoMt+P8wTEeoo+gGgmG1sod8COMU81at5eXmH7/21JETmWBv+qcbvcw==
X-Received: by 2002:a05:6000:1542:b0:33d:28a9:2fd8 with SMTP id 2-20020a056000154200b0033d28a92fd8mr4631677wry.39.1708280511691;
        Sun, 18 Feb 2024 10:21:51 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id s3-20020a5d4ec3000000b0033ce06c303csm7867116wrv.40.2024.02.18.10.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 10:21:51 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Olof Johansson <olof@lixom.net>,
	Arnd Bergmann <arnd@arndb.de>,
	arm@kernel.org,
	soc@kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 4/4] ARM: samsung: soc for v6.9
Date: Sun, 18 Feb 2024 19:21:41 +0100
Message-Id: <20240218182141.31213-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240218182141.31213-1-krzysztof.kozlowski@linaro.org>
References: <20240218182141.31213-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-6.9

for you to fetch changes up to a3891621d4a0783ae178d6f2845517e3dd571dd4:

  ARM: s3c64xx: make bus_type const (2024-02-12 08:28:44 +0100)

----------------------------------------------------------------
Samsung mach/soc changes for v6.9

Just cleanups: kerneldoc warning and add missing const to bus_type.

----------------------------------------------------------------
Randy Dunlap (1):
      ARM: s5pv210: fix pm.c kernel-doc warning

Ricardo B. Marliere (1):
      ARM: s3c64xx: make bus_type const

 arch/arm/mach-s3c/cpu.h     | 2 +-
 arch/arm/mach-s3c/s3c6410.c | 2 +-
 arch/arm/mach-s3c/s3c64xx.c | 2 +-
 arch/arm/mach-s5pv210/pm.c  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

