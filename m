Return-Path: <linux-kernel+bounces-32739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8C4835F8C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5530D1F2712B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69D33D3B6;
	Mon, 22 Jan 2024 10:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2JlqVaao"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B2C3D0B4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705918940; cv=none; b=TMYe1EZA+oRBQfDa2Lb6pZpg5PpvoZb4QuFvdldNQ1eoYSvv+44p375rAOeCVNsEtzMBr9ZFAGSgqeRjBXZl/wkZ4j7sRXzJL4ArYu/yRaegtsO0C4O0hslixQs6+AezkBerg046pniBItctgYkpSPCqAATKz0Jqk6vWDeERtd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705918940; c=relaxed/simple;
	bh=hmzNAsxjSvJ+4PERnPRzpDN6FX4/4anLfvTfR4Y4+GU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uR0T+MUbGfEyFHiIBN7JdLQlP6D9fetwbrQ8/PUawyHKmD+PFvqpf/705o8PghCF7K6SY8Ur0H4COtcqPSorG2en+olxQpSkMjsM0mMlCPKbDG82Tg+oEhGv5tTkBPxUxXSc67FynXmNvhVU6UsNtc2rb2EsATUFKvccwKkyO2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2JlqVaao; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-339289fead2so2102956f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705918937; x=1706523737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7SHOJjWn4ajTNVMkc896KlcCL3KSTkPo3OUGdVQzNA=;
        b=2JlqVaaoDv7/DCPSGpGCK5ZImNs6ZogM7BdWX7PHLL4FpBBZn94sPyz1GbPWfS57K+
         ScwnAtGQv9k3OQjezHPmSiKCvIsI88hWw0QCbEgF+vNwGLaJ3vD68zPgArqFSbETJKxe
         juTTGzKqtXToXL0Y2/1ClXG5dCCzwIaKT1uYLWndTEqpK1PdewVtRetKF/rYLL8WyMwf
         YDKC6aYBJJ7GFEUDDIX3xoIGfHgo+7MHrE3uifYlB7luEd5r9o3WYWnkxm82YGLOKmvh
         Aidv9J9Bx2CyEiNgzyW0z57V8IjVeCZq+CHMqbsmrTC269KXWSHhhKff+w3kUyDemFwR
         xqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705918937; x=1706523737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I7SHOJjWn4ajTNVMkc896KlcCL3KSTkPo3OUGdVQzNA=;
        b=mZpuCkWZ2EOOHNJcrGyP/f8vN/1aV1l5EAJZTUfiI+UVFKZmAGErHM7Tjccl2HvP5D
         ZFN87s5fqx5s1T6riK5/rBN4YT9JJNlmZJJYGOO4sQiv55/DFq+7deZ4Kbauh3suhlZ8
         6FIPKMCYQKoHEXGYVa/JrK4PpWw5PtY675T2Fl08qap1BCBeNfKLMeZYUrMIPhsG5EvQ
         iu0piBvVdbHdziMjd+RREbrNVWdIkhR5oNBoXoOOzKFcEe1MzhZp3Wume2t2hbFykjj1
         nI/+UlxNvrdOS+j/WU7fr025XaByy1ZQma7E0qb6pWECHkoJUtrayHgxvvCrqac4wvJ0
         8dWA==
X-Gm-Message-State: AOJu0Yz1TJ3e/SkFUKSbGtH6FVGHOVdebTUwQKstWqPFJXmTitYADhxm
	avFBNHgQebpmnaoUL+C3zhX1We+D/HgvXdZiL8JpPb5poI5a47P6QWvc757A7Pc=
X-Google-Smtp-Source: AGHT+IHVbNlOQgFdYPbkVMPjMwRGFVl4LkZjPMLDkULh+1emzr1igA8P8yD98ilTgwcQiDyDvQcP/g==
X-Received: by 2002:adf:eb0d:0:b0:339:3edd:1427 with SMTP id s13-20020adfeb0d000000b003393edd1427mr211328wrn.73.1705918936970;
        Mon, 22 Jan 2024 02:22:16 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:92a0:6172:d229:1898])
        by smtp.gmail.com with ESMTPSA id q7-20020adffec7000000b0033926505eafsm6377904wrs.32.2024.01.22.02.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 02:22:16 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Guru Das Srinagesh <quic_gurus@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@quicinc.com,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Deepti Jaggi <quic_djaggi@quicinc.com>
Subject: [RESEND PATCH v6 11/12] firmware: qcom: scm: clarify the comment in qcom_scm_pas_init_image()
Date: Mon, 22 Jan 2024 11:21:56 +0100
Message-Id: <20240122102157.22761-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240122102157.22761-1-brgl@bgdev.pl>
References: <20240122102157.22761-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The "memory protection" mechanism mentioned in the comment is the SHM
Bridge. This is also the reason why we do not convert this call to using
the TZ memory allocator.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
Tested-by: Deepti Jaggi <quic_djaggi@quicinc.com> #sa8775p-ride
Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/firmware/qcom/qcom_scm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 839773270a21..7ba5cff6e4e7 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -563,9 +563,13 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
 	struct qcom_scm_res res;
 
 	/*
-	 * During the scm call memory protection will be enabled for the meta
-	 * data blob, so make sure it's physically contiguous, 4K aligned and
-	 * non-cachable to avoid XPU violations.
+	 * During the SCM call the hypervisor will make the buffer containing
+	 * the program data into an SHM Bridge. This is why we exceptionally
+	 * must not use the TrustZone memory allocator here as - depending on
+	 * Kconfig - it may already use the SHM Bridge mechanism internally.
+	 *
+	 * If we pass a buffer that is already part of an SHM Bridge to this
+	 * call, it will fail.
 	 */
 	mdata_buf = dma_alloc_coherent(__scm->dev, size, &mdata_phys,
 				       GFP_KERNEL);
-- 
2.40.1


