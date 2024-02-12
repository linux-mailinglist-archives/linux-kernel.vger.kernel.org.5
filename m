Return-Path: <linux-kernel+bounces-62338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5270851EB3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702B91F21BF7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91947495FD;
	Mon, 12 Feb 2024 20:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="lRmy+jsZ"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F1A1FD7
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 20:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707769994; cv=none; b=BMeVwCIbcuiDaYd4uAsrbGOVX519mntGtRf5ZcBXT1kQ6fJF9seBaCxfi39/95bIHas7V+CaaTEZVEEONUiflXyUo89Zn5zriOkbTWCBP5/bvoBNW6xQ+mPMFmScWV7Bj7ItMILB6oR3+bVZvkICkwtgbRHyi4hl4hfHpnerCxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707769994; c=relaxed/simple;
	bh=HGfQRSSIu7tHOFJNScgkWHqBbVDXLl7MxiMK+J2wuaA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=G2HFa5aX6nMR1HGg++yPWAydG2us3SPnuzKapILoQrwWv9MGBEL7d3eolY6gTnaw1YHablwYLjZCzDebAi4Vwtc/BkMaI9dhjNcrcS6a/k8EbGEZ6TaClyi905zEjFgwtrA37J504cdgJAM2XJyrvTXcG3ggHGZ8vEIdjoHXjcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=lRmy+jsZ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e09cf9a210so1887935b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707769991; x=1708374791; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dqaY4+/l5WNLEb5Hg75TqbMoglLYLwH7sdzyA+HpWPw=;
        b=lRmy+jsZindRJDEoEXy8OmWClr8Z+ZNpEVlbNjjXSORM6xcF39zw7d1zQGdw3QlDn/
         sm/4MuzJCzxnsg2XtStFYkoM6UUSyeJqSXy16A7DLkD2TjqdIJs5jovWV8C8+/vHCSA0
         3j8SAhKHgVAI5DPGVbqemM9Rf6VQrtaEJaTQ3MXTh6oT244f+Bsl+mDAMcWq8olGo33Q
         2FQYM0Oxwb9lSA8pzdhVCUeL4KXaBJPml7Kg8ZAHzbYIk9z8EA9oh7sOpbDHc/GT3Cd9
         8uGM/8jFTMgRmcvklrCWnWdGgZfsa7FAb7PMAZS3mAOZgVewVWp1N165OaKuNacrnW/r
         dcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707769991; x=1708374791;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dqaY4+/l5WNLEb5Hg75TqbMoglLYLwH7sdzyA+HpWPw=;
        b=mNUnX2eHv6d3bwSQkfFLw0mqv59ZanmXNirhFp1CinIsyR+FQ66MANS0bGeWWL7OwX
         y525yN7EzwEYYC3NnHUVUEq3UZu0+IR2FJxWWW0jKapoqBJWXzH/pQ7DlLJnYj3c8m78
         xaRWvtlSPURzTPZs1y30U20DS8fylgdLfUC/VWAC0QhqY3MmO5fg+w9vBidonRQdrD3h
         Ttpt7U6DMJZ4ByN2a939COXh2FTcqPOGx3Jc+pdOwzQwQDDsvlmU+vMqZ6DzBva8wbGO
         YhpIuQ9QDyZ4gP32Pfm8QWqjSROD7BTTiOOl+a5RgV0RMM/ALjamaqwB+Dzy4ArmJ5XN
         433w==
X-Gm-Message-State: AOJu0YyyKOxu1SXoFeHN2pzNlnJ5vvqAzP7BEEYOioNxXzFfD/ZHcrhH
	Ie49jbaYu1EeVhVLd1ni8bZoNKCLWnAlUtHu9gwhCLXA3UHgiJuRmHCSD5eHI3U=
X-Google-Smtp-Source: AGHT+IEg2kV7QDyYtrXWyUg7tDosJo/2q4UxsRgawb+TjXVKxjOQcP39ASOjwVubgJJPFJzdvxMtHA==
X-Received: by 2002:a05:6300:808d:b0:19e:9873:aa54 with SMTP id ap13-20020a056300808d00b0019e9873aa54mr9321792pzc.58.1707769991689;
        Mon, 12 Feb 2024 12:33:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVna2OboXHxD0qV6Akr5vzxfiG3oWdc439TYi7tulPVml9vXgLkdTxLa21DuFUPIEHZZTQ7L0Rw2a7pAkQDKm32KhOby4ZHd8YRAQMTAcg1ohHK28lCGaNIqqkePgAeLmnjWB5RI32Ug889xgDd7pvLE2DsDl+CdzSc17qNCH8EwXyrAHDcpvlMxRRxVcSpXIC068WULtFT/DaML8LCroRfOgdWZxDZpeoISRBRdehtaXn5iBQ=
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o15-20020a056a001b4f00b006e09e97b803sm5552506pfv.46.2024.02.12.12.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 12:33:11 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v7 0/2] lib: checksum: Fix issues with checksum tests
Date: Mon, 12 Feb 2024 12:33:03 -0800
Message-Id: <20240212-fix_sparse_errors_checksum_tests-v7-0-bbd3b8f64746@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH+AymUC/5XPTWrEMAwF4KsMXtfFsfyXrnqPUoItKx1TJhnsN
 LQMuXud2TSULDLLJ9D3pBsrlBMV9nK6sUxzKmkcarBPJ4ZnP3wQT7FmJoVUomla3qfvrlx9LtR
 RzmMuHZ4JP8vXpZuoTIVLE5wJoKJ1ilXmmqnu3Cve3ms+pzKN+efeODfr9AF8bnjDZYTYOxNdr
 XjNaR5LGvAZxwtb/VluTAkHTMkFDyBMMEg2er1jwqMmVJN6QrR9q2Rrd0y1NdUBU613ogwuSvC
 gccfUGxPEAVNXU0XnhQewpGnHNH+mFPaAaVYTvW9NfVzo8M9cluUXAwUeTncCAAA=
To: Guenter Roeck <linux@roeck-us.net>, 
 David Laight <David.Laight@aculab.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707769990; l=1791;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=HGfQRSSIu7tHOFJNScgkWHqBbVDXLl7MxiMK+J2wuaA=;
 b=mkvQ9chtkNFwPH/TvFiCmk+ANlPI7uuppXqEq6OwD1iuvND9Fc/lhuqN/GlwNadsFxlUmpEv8
 ibR19kpKEImD1byWOdIrGufDvLIPgpST/OU76FVxwxh/AHxHV7B8Seo
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The ip_fast_csum and csum_ipv6_magic tests did not work on all
architectures due to differences in endianness and misaligned access
support. Fix those issues by changing endianness of data and aligning
the data.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v7:
- Incorporate feedback for test_csum_ipv6_magic from Guenter and Al
- Link to v6: https://lore.kernel.org/r/20240207-fix_sparse_errors_checksum_tests-v6-0-4caa9629705b@rivosinc.com

Changes in v6:
- Fix for big endian (Guenter)
- Link to v5: https://lore.kernel.org/r/20240130-fix_sparse_errors_checksum_tests-v5-0-4d8a0a337e5e@rivosinc.com

Changes in v5:
- Add Guenter's tested-by
- CC Andrew Morton
- Link to v4: https://lore.kernel.org/r/20240124-fix_sparse_errors_checksum_tests-v4-0-bc2b8d23a35c@rivosinc.com

Changes in v4:
- Pad test values with zeroes (David)
- Link to v3: https://lore.kernel.org/r/20240123-fix_sparse_errors_checksum_tests-v3-0-efecc7f94297@rivosinc.com

Changes in v3:
- Don't read memory out of bounds
- Link to v2: https://lore.kernel.org/r/20240123-fix_sparse_errors_checksum_tests-v2-0-b306b6ce7da5@rivosinc.com

Changes in v2:
- Add additional patch to fix alignment issues
- Link to v1: https://lore.kernel.org/r/20240119-fix_sparse_errors_checksum_tests-v1-1-2d3df86d8d78@rivosinc.com

---
Charlie Jenkins (2):
      lib: checksum: Fix type casting in checksum kunits
      lib: checksum: Use aligned accesses for ip_fast_csum and csum_ipv6_magic tests

 lib/checksum_kunit.c | 396 ++++++++++++++++++---------------------------------
 1 file changed, 136 insertions(+), 260 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240119-fix_sparse_errors_checksum_tests-26b86b34d784
-- 
- Charlie


