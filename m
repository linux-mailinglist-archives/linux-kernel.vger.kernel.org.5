Return-Path: <linux-kernel+bounces-159082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CBD8B2917
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 804F7B24A14
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CDB152516;
	Thu, 25 Apr 2024 19:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1Q2xsfLc"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA04B146A74
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 19:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714073998; cv=none; b=TVzP2wMIQRAJLIW9Ce0fBLAdg77Xr7fOR27t0h9RSVZezWxxUb7QitCj/CT67hOKu4R35VPb2jGdNYOJug2pyGnGmOBy+znqueKVoB7OlzcdzhJvjpRIhtF8bHCDEMJqeoC1y58xZcd5eGvKjF4L9Ksm4WrlbOVJRr/hhcEllW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714073998; c=relaxed/simple;
	bh=cVmgM3N26ERCIMk23K6mhgHWejmJqnYBxxeRO6Km+YE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YZzCIhpE4plwanAHfkNgoCyAhioSQny4hqOO3SO7iZiTeoB0PtpsB/zHOR8M8dI7k4Rg6QRo6KD51Hbvd+2g0sfsSOT7OuFUbMG4YCT84zxWRMk0KjjBFm266TwhTd4MG/4PJG7vIc0A4r6skmUXXJHlLa8olTCohqVlzFLDmCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1Q2xsfLc; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ed9fc77bbfso1194982b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 12:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714073995; x=1714678795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6MTGRYaUIHK6Fet8BjuAzpG4Jp++enVeHDo3J8VQ3BU=;
        b=1Q2xsfLc+ySXgkrLftucOHW+ze15/WGt6YAl8xwhQMb5Bv3dGHsZgV5ymVNt3asSDe
         lYNCHqPhQ8ieQm5oh/dVpra2x0OWkjRU3uLCAfe/5Tjo+I9HE92qy3YgRWFrxFGFgQQY
         zHfGIGhhkhEvrz7Jbf/MkHF83kmtcFq7MVJa5hzoIpzO6pSQ22T/IVci6rpCap3wBNCF
         bvesiRymu4Yq5zDc5SRs1JhFuBFjVW0mvHz1mbWfznfp01iY3qnLYYHXxVKN1o0/58aq
         tT8q9o79jpzDb7apsTDf3JXQ8xgcVGo5P9ketp2Q7DUHMQHbn70XhbsBri3F9omGaLWV
         rHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714073995; x=1714678795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6MTGRYaUIHK6Fet8BjuAzpG4Jp++enVeHDo3J8VQ3BU=;
        b=JL6vP2BYjsIsOBvvFZPzsTCk5UwlnguMzjP2jSadyoceLhTHEWukBsD72AuqjgGMg9
         K4ZCcJGcozCs1Fuh3IWb6q7Era5LM0dO1cqbeAfPIUa341BBbProYWVhW9AQSpmPAJNg
         xPLMspyaxycRe/1xIUy7BAgsnikBUSckdeZijxJNxAr45K6GtAroiYBtL5hWZqqgqVnf
         xBpVRPt5sAtYeI22w1bP4WQLj1SpBOTT61HkfUA5BZ+aqqf3tDM/Dlj6Q+N4QHWKjadZ
         UjUTW4g5Atn3U15yNDY7gXPvtlCMAPmMvWxESoCmSE2auI0FA2ABrJCIMQ44Lb5emoSs
         snkg==
X-Gm-Message-State: AOJu0YzF/cO3qhoHnH78aiDc9p5IZMC5lcNp8GasDAwTdhpRP8r8Htlq
	yDj61mT3sA0kfSxMwU/Td+MW2sK3Ek0haafFdMiBx6BrQlZgSGFZQQ23JI+m4BoJmWW52xA54We
	n
X-Google-Smtp-Source: AGHT+IEVwY448vWFB2jsVNySqj5bBnZ/RoQHWs45mANoicnS0fF3sAvuTjEUyQlM04N/W+0OKM0nDQ==
X-Received: by 2002:a05:6a20:1046:b0:1aa:14a1:e5ef with SMTP id gt6-20020a056a20104600b001aa14a1e5efmr737836pzc.38.1714073995020;
        Thu, 25 Apr 2024 12:39:55 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id fk12-20020a056a003a8c00b006e6a684a6ddsm13525487pfb.220.2024.04.25.12.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 12:39:54 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Will Deacon <will@kernel.org>
Subject: [kvm-riscv/for-next 0/2] Fixes for kvm-riscv
Date: Thu, 25 Apr 2024 16:29:30 -0700
Message-Id: <20240425232933.4111680-1-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here are two fixes for issues found during review/testing after the
series[1] has been queued for 6.10.


@Anup: Can you please squash them into the original source commit 
22f5dac41004 that introduced this ?

[1] https://lore.kernel.org/all/20240420151741.962500-1-atishp@rivosinc.com/

Atish Patra (2):
drivers/perf: riscv: Remove the warning from stop function
drivers/perf: riscv: Fix RV32 snapshot overflow use case

drivers/perf/riscv_pmu.c       |  2 --
drivers/perf/riscv_pmu_sbi.c   | 49 +++++++++++++++++++---------------
include/linux/perf/riscv_pmu.h |  2 ++
3 files changed, 30 insertions(+), 23 deletions(-)

--
2.34.1


