Return-Path: <linux-kernel+bounces-90646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2D38702AE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407871C23A6F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5CE3E46B;
	Mon,  4 Mar 2024 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fazL1CHy"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D1B3D3A8
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 13:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709558853; cv=none; b=Bc3Q+CTu/Xzbh2dKKbAo84prgMpt4tbyKA3KdJDaS2DlroTRUBGZ9iozbNbDjD4/CWS5qYZbicFjFuu3uS7cefbKLNf1ohstkBBSpe6p0CSzEtxWLSwPjq1bYPB1wF5Gfawe6s/gVZY3BdRyKfpMtLbqH9Kfg1Plv76TRBX21jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709558853; c=relaxed/simple;
	bh=+RqhSmrSrFYjO/WvnUVFmfbY5xP48JgVMgt8tLaHkuk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VQ3hFLT/I8Q2FRb0Jm6/dh4gPoUGc05sbgB3aQh813LkKF6btiKhfYjanJBASSsT1nuvgLCRircC8benEtGjlrWkkWnLK6GYZS5YTY2X/t8EePpJFKw/TzxBMhdN7sqzwHrLatMQU/qvxiN+88hVQLimLI9cyXJ8odlU5+eyQXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fazL1CHy; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56759dc7ea6so1070788a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 05:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709558849; x=1710163649; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Il7WGqFl44AfF17lTuHv5NBgNOasTcj9Ggen1b7rvc=;
        b=fazL1CHyhhZ0CdEwB1BikLwwqkx0a+KqrcYJZaeYAspjhFLVz6VxiVVEjRTYOquz4L
         vVXPQpi9sfRLI6jBfc/pIOUb7KNZr/KTS4DkHdb9ODRSnNQ/8sz4+gCCiireiJybSzwV
         MlBNYOoIX9YR95PLOCEsEsO0Q2psZnXBJ1Rw3hPnPRq2anj+a8GcAKycNjGUo4gmNamq
         YVUXWCc+FgtAIa8f4ug0j3XYZk3j4qeLXDg0KkgJ0ywgiA3ry8UN0cYw+9wnlTlhjzw3
         9umqsRGjB8qX/192UBJcYXfBEBMlG7AUjRFLEPWX1QhTjJBlTACLqf5UCFok7PaFUxVT
         pLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709558849; x=1710163649;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Il7WGqFl44AfF17lTuHv5NBgNOasTcj9Ggen1b7rvc=;
        b=cPIlFnhc0ZYZCrnbbJUBYGsp9+XNORytjuowm34rP+FTRFTCVcZEEnHy3YPzbEuEv/
         lsa2UYBqynaA8WsdHaqAcHI23HzLNYBDh2DtlP+go7d49BOTWow2bgcO8xduqUwer/Kl
         ZvPE236w17h4lIJmPxdGGFQvM5g6z8f8YiF38PRRv8NFqadhfLyFbb3zWy7IGQtSHLtU
         4FZBTvwioHHHXbiapkKNFM+gC/u1Bpfsin/37fVRXKaTok23H4yta2GpX9BY5CnMCmum
         15Q8ShPFtl9PmZIyVSBJ2Xpzho9k0dI+eSjuW1kQrywJCBECRMwxP18YsWaJNb1tV4FU
         UgOw==
X-Gm-Message-State: AOJu0YzD1+ivUELh39oKZ3KC/PL76Vc/B18UZd+EIcmwkTdFqXbt0VsG
	W0kPZZXgQ3Q8H8+10KImI9IVzz++QqElT/FgqM8tHkqFXa5pqljnwIiOItXJL4KYBKAsmM5jIKr
	1
X-Google-Smtp-Source: AGHT+IEyllblhYtJQrtPvZ3Qg5J5x6MA5AQO1G5GPdXsMuXDvx7aa+s+I01lireZgZtMHmj5nurMeA==
X-Received: by 2002:a17:906:1906:b0:a44:7db8:a343 with SMTP id a6-20020a170906190600b00a447db8a343mr6236750eje.76.1709558849464;
        Mon, 04 Mar 2024 05:27:29 -0800 (PST)
Received: from rayden (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id x11-20020a170906710b00b00a4434e9938asm4803437ejj.84.2024.03.04.05.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 05:27:29 -0800 (PST)
Date: Mon, 4 Mar 2024 14:27:27 +0100
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	op-tee@lists.trustedfirmware.org,
	Sumit Garg <sumit.garg@linaro.org>
Subject: [GIT PULL] OP-TEE fix for 6.8
Message-ID: <20240304132727.GA3501807@rayden>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello arm-soc maintainers,

Please pull this small fix for a panic in the OP-TEE driver that can occur
in the error path when registering devices on the TEE bus.

Thanks,
Jens

The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-fix-for-v6.8

for you to fetch changes up to 95915ba4b987cf2b222b0f251280228a1ff977ac:

  tee: optee: Fix kernel panic caused by incorrect error handling (2024-03-04 09:49:03 +0100)

----------------------------------------------------------------
Fix kernel panic in OP-TEE driver

----------------------------------------------------------------
Sumit Garg (1):
      tee: optee: Fix kernel panic caused by incorrect error handling

 drivers/tee/optee/device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

