Return-Path: <linux-kernel+bounces-89792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910C086F5B6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 464041C21A7F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 15:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24B56BB47;
	Sun,  3 Mar 2024 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ADaenkqS"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994DA6A002
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709478098; cv=none; b=DbEp2P/wwXP3T8X8F+Lk5tt7CE4dk3aT2ZSKkNzXK8OE1Q+JDHbIo4kNVCtvoFoFgjkMBvQTZebmD+rjVL+GEIZVM02D8N8ahr01y/KOz2YnzDKI9iUuyRZlOU31k5hDhqRBIf7QViNr3ZvZ79GpaLVPbJRvwikSXpxTsEQJXRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709478098; c=relaxed/simple;
	bh=r4MrdpfQItW+VY2TV1TWENdOVO+4+6domQX8f1WokzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZjsCzTEF3fFzwrMuhXVy9FjtHg764/Lr1UvBYXNo0pDg1iYil5WPEo4LuMua8MwSdOXacVMrCrtt86xJRcBtN3t6BUGp1JaKxE3+t+9+K2pWT6dEY74myJH55Ddiab6FURLhkxoViTx+mosOotOEUGfNaqjarDbqPsBXkpiG6zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ADaenkqS; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-564372fb762so4904899a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 07:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709478095; x=1710082895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wfEydsGbvddKil/3Z8l6vz+rSpkbDji/d2z7vS115c=;
        b=ADaenkqSJZTdy1iD5HXeDXQ6qAg/NB4ipyYmj7G0qKZ49nloYL/0dx7+dbVQ+4o0oA
         AzeKinUtDEC6uFzFmBOZTuTA4oLuIjNYy92iSjG1pHT+LIZlo0wo0K8FTrU6pr08Lf7z
         Fn9yYZ7yeVWdxHzEb2fngBWuyB9oQXYv9RWU4TvIOUFACH7Lxp2bRm5cBt+NJR+rv4S0
         1pE2GyKY61fNaCArkPWiXhXGWBSF98l4pEyhw5lH4DQYVuf3ejeEUWS7w+yh8PLkeHxG
         O6oEhFu+6a46r6S01pYv35ED3+bc1y4UPbunZmJsrAoX7e9DRaqWRSZw1tvd7DgjTc3m
         7rPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709478095; x=1710082895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wfEydsGbvddKil/3Z8l6vz+rSpkbDji/d2z7vS115c=;
        b=KDGyAlU+RFbM8PovGpeQRYlGGTwYIkm2GQCxE/odtTyH9Fm+rwfpBaT/cWghv5RG9r
         6I8fcbVNcW8YYw0CVd3OWYL6mErXrJaCxP567kECLsFEqPnpBjq8RlSmCsVqVniBwxOi
         Z+Rhj29CM+cJqsYg1q0GhJ5JOpE3ewdwHp/K6+9bvkLlNDcFOxwg/zCK+K2jcgjLDR73
         HCo574a+bi+23p+IdM8cdHtDoyaOlZpmXiWSPta+YT4sYzRjpKU8CGOfNjGY37Ol9o6b
         mmFBdD19RCozAgamhn6AsF+8QKe1ClYSU7ixtsrE8Qeek3A+DScNrhfJJ1sTBupgRVwu
         GNxw==
X-Forwarded-Encrypted: i=1; AJvYcCW5eVPIZ3pLP3xIGrZ9jUwPkKeQiDsMMIXWRm7VmOqN3TCFzLphoEY2k1msINzPQnxhl41IeIwfTF1NEtZIxDMKNg90qFO/JtWNLe53
X-Gm-Message-State: AOJu0Yx5GKZrGvz2pfjh4NR6Tf2cl2Kicr0NgIYAaj38tzGBUmRdw6eb
	okGjZFSXIB9+sCGq5vp3jLxMKrz4ttXM2nA+ruR1FXD/Fv5N4HHizAq03wCpU0E=
X-Google-Smtp-Source: AGHT+IHaKPYTKkceAREIbdiaxB2ZZXS4LTPdk7piZ4fOASBtCzFFy+kH4Zbu3DN08O6YHZeK1/WFjg==
X-Received: by 2002:a17:906:24d4:b0:a3e:d835:5685 with SMTP id f20-20020a17090624d400b00a3ed8355685mr4362651ejb.67.1709478094847;
        Sun, 03 Mar 2024 07:01:34 -0800 (PST)
Received: from brgl-uxlite.. ([77.241.232.10])
        by smtp.gmail.com with ESMTPSA id ch14-20020a170906c2ce00b00a42ea946917sm3740293ejb.130.2024.03.03.07.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 07:01:34 -0800 (PST)
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
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@quicinc.com,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Deepti Jaggi <quic_djaggi@quicinc.com>
Subject: [PATCH v8 12/12] arm64: defconfig: enable SHM Bridge support for the TZ memory allocator
Date: Sun,  3 Mar 2024 16:01:15 +0100
Message-Id: <20240303150115.133633-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240303150115.133633-1-brgl@bgdev.pl>
References: <20240303150115.133633-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Enable SHM Bridge support in the Qualcomm TrustZone allocator by default
as even on architectures that don't support it, we automatically fall
back to the generic allocator.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
Tested-by: Deepti Jaggi <quic_djaggi@quicinc.com> #sa8775p-ride
Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e70a599046b5..281cdcacc627 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -252,6 +252,7 @@ CONFIG_INTEL_STRATIX10_RSU=m
 CONFIG_MTK_ADSP_IPC=m
 CONFIG_EFI_CAPSULE_LOADER=y
 CONFIG_IMX_SCU=y
+CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE=y
 CONFIG_QCOM_QSEECOM=y
 CONFIG_QCOM_QSEECOM_UEFISECAPP=y
 CONFIG_GNSS=m
-- 
2.40.1


