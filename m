Return-Path: <linux-kernel+bounces-81065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990F6866FB3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7541C26664
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461245B675;
	Mon, 26 Feb 2024 09:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBXLb9s/"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10AE5B5D6;
	Mon, 26 Feb 2024 09:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940277; cv=none; b=hu+EN4mM8z7paNXReksp25EYUFYf/qhMdoyj7LJST506rPB9VKpqv79NeQSr0KbyjennxZbnxghfQYnNW4cc6GOoUGwEGGmoaJxIk8qjIVRrkT7HiLQXT26HoNJdRpK09cm4IQ1Ww7KfXnDBOPxyJrfQeEzZHvxMY7lT9rU/OKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940277; c=relaxed/simple;
	bh=31a5GEP8D1PpwdN5PyjwuEtq748f/aUOFXdtpk75vgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNvzjUigW+4hCS/LBNsDWqYAjcFS0CvhvuwQmGL/FiLEl2lgjKBfcapCaKKfFnzg8jPXGOf4S2WtzdOaIViPmdfdWTR1vqh4+fr9I47+SrqD6ormUm8veyhAePu6kq//xdyfmqco2i5pY+MhtjCgZ3xRF8kYxwBfAhz6G07qEFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBXLb9s/; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-565a3910f86so2428406a12.3;
        Mon, 26 Feb 2024 01:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708940274; x=1709545074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyUeNBz/6EL4JMqPMkzQBEjM7Nv00R+NzMPMSoNI1/U=;
        b=fBXLb9s/fCzDlz4nLwp9Z496SOhk5r0xR8E3vzH9mApUluPelJKyumo3hgq2v4J8j9
         oxTmyqE6pgRF1U2ba+psWAO+CWFq8OUCqXcJ+QgC2jnzSH5TcvDuzpGvhmnyP+VyNxMg
         MtN76Qxnc6ZA8ap61IZS8QkUulWxoqdr5On+lFyNB26xT7U7HKXWJpVl3iUyS8Z8enMO
         PneuKWEIz4ZwLkQld+eCXgnjH3Ck6NizufN+ZjM3j6VvTS3RAGaFpK80ecOAElP6Fghf
         bcAQedrAav5y2k+NCKxjGQMsW7iBqlfCeJB1wxL0IlWo/QZFnQFd/hJGknc0STlMBBhD
         FZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708940274; x=1709545074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CyUeNBz/6EL4JMqPMkzQBEjM7Nv00R+NzMPMSoNI1/U=;
        b=UxLVO+VinENRg47iG8zG6T4Y/XSPyDpD3IadH7FlROgOahfk3g9rGn8MFUdoKwFaB6
         9iUrm+qJZ4mXROefcQw514+gF1PHUQ0QpOcKMk+/p83oEhw4jIVWKuX5RMRSI/Hls8/S
         X7fxwaRbiwoEN8TBDHV/HoaWqinQtR6ihcNX5SDvTPURg+ghCmaiu31Zb85dggcRfG6/
         cgFYz7WBTTkCWM+iVRis8nh1WOtm9HY4HiWkkUjmnlkgj8/6PuvUOcFZspBlfbdxBB2j
         IwMRoxguxkoHWz8CJI0pyu24m7lh66gMBdLZApYJEJYZWB0Rg6lMZqA6+mk4apIKCHj0
         xF6w==
X-Forwarded-Encrypted: i=1; AJvYcCVYZJ9caOy9PWHaS/I0wZwTDr0aSUq+qw+4J6CvJryTjigmUWNSktuE9atf9jKKgd4BWsmzaj/sM5iGRbc4dPCTmSxJxenprFYJFb4Ex/ZRPqxfk6YBQiPOLGDcIU9aczOs5YCDB9qlxamqWj6D9QmsWYQeY72zHYU1WLmrpAjJCOy84kOfCVpu3ude8SM0ZEfdCOuASGXX42LRR3UCGx9lndjr
X-Gm-Message-State: AOJu0YyZEnbjw6atZTOzAW1xz4om5jFJYBTKWOn6vNUP1+fWyJE8NtA/
	at2y/6vW7BJGlraOah9ifICLPsYelIw1wJWfirUoxeUhFs03ULHm
X-Google-Smtp-Source: AGHT+IFifGzyr3LK1SSjtuuU11sn/HNG0Z2ba5Z40uQCDiVX5/aUL7LTVxGyeUlL+JrHP+dYe7+lNg==
X-Received: by 2002:aa7:df93:0:b0:565:e294:5124 with SMTP id b19-20020aa7df93000000b00565e2945124mr1717988edy.42.1708940274312;
        Mon, 26 Feb 2024 01:37:54 -0800 (PST)
Received: from unknown.netbird.cloud (net-93-65-126-20.cust.vodafonedsl.it. [93.65.126.20])
        by smtp.googlemail.com with ESMTPSA id fd13-20020a056402388d00b00562d908daf4sm2158595edb.84.2024.02.26.01.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 01:37:53 -0800 (PST)
From: Gianluca Boiano <morf3089@gmail.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Gianluca Boiano <morf3089@gmail.com>
Subject: [PATCH v2 2/3] arm64: dts: qcom: pmi8950: add pwm node
Date: Mon, 26 Feb 2024 10:37:31 +0100
Message-ID: <20240226093732.3478845-2-morf3089@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240226093732.3478845-1-morf3089@gmail.com>
References: <d17121a0-ca14-41fd-9802-bb4118629e34@linaro.org>
 <20240226093732.3478845-1-morf3089@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This node is actually found on some msm8953 devices (xiaomi-mido) and
allows irled enablement

Signed-off-by: Gianluca Boiano <morf3089@gmail.com>
---
 arch/arm64/boot/dts/qcom/pmi8950.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmi8950.dtsi b/arch/arm64/boot/dts/qcom/pmi8950.dtsi
index 1029f3b1bb9a..b4822cb17a37 100644
--- a/arch/arm64/boot/dts/qcom/pmi8950.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8950.dtsi
@@ -84,6 +84,14 @@ pmic@3 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pmi8950_pwm: pwm@b000 {
+			compatible = "qcom,pmi8950-pwm";
+			reg = <0xb000 0x100>;
+			#pwm-cells = <2>;
+
+			status = "disabled";
+		};
+
 		pmi8950_wled: leds@d800 {
 			compatible = "qcom,pmi8950-wled";
 			reg = <0xd800>, <0xd900>;
-- 
2.44.0


