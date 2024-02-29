Return-Path: <linux-kernel+bounces-85998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD37486BE48
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EEFC287347
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B232E40F;
	Thu, 29 Feb 2024 01:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jiPlFYOp"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93EF12E5B
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709170507; cv=none; b=u3QbGmjolUiCWnpXnMx98BSOyGR2uVf/7u4hws6u+bIRbsBzsA5buR9z1/xKzvTZ4yNC44zT6yFvsqFETbHAAQPqytAgBZfe2uE4CLKSz/ieInN3WlISFwx+7vZs7og79Ac5iZ+ezqvMaPZSoOpQJRLJn+psP5M6X0OCRV/jOCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709170507; c=relaxed/simple;
	bh=rNhXvztlPIMQxaT3uBcxWgppme382OuBdUXTLAuCzMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WAZlw2c9xeYt+bS8vQVvom6vvsaVQMScu1XML1A0hn26+qdxR/DEXHIkphSYAm7LfuT7ddkmjpOwnb1QqLG8pGsZcYkot9evTBqOplCLojHaZSZemheaGfBX/NsRqdkGHpIrbWnQCOvD6gm4x47g/j5g8luJJpnJh4nvCr1WUDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jiPlFYOp; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e5760eeb7aso306888b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709170505; x=1709775305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+iy/LQHSKsmIm2Ae2f5kmdkaP9KIdMysWT/fEuU36SA=;
        b=jiPlFYOpUGz9wYjFKfG1HdNQe55ZF6z44B5lFhR9TB4twaDKd8MsQ6u9kPk6n1vXxI
         APuBjVtKWLDs5IxvahQSunDhoR5kjO3OjIXtv0d8lyxErLAh0FVvaQzAbY3INgcP4L6i
         Y+kop3OMLnCpPW2Xlg904RVRrjThXBswRTBMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709170505; x=1709775305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+iy/LQHSKsmIm2Ae2f5kmdkaP9KIdMysWT/fEuU36SA=;
        b=LZIjJ+Rit2An+oFNdVIzkRiS7UcR+Rh6/bObk8iirYuhB6+VwHXHDYP7D7v1Am7H4k
         0pCkn6x98yPlBzoVXyhGgwv5Vn5qIInK7X8GSIr4/jzG6Yr9Nx/9FR4J6rC7NZkY4vC3
         shGPR9w+0vAm9cwecZepABwgx1Nc/uFFfirDWf/8AzAS85hk8FGGnHzz4/pr/IHqEeQO
         ch/8lDKZVY0BCDHk/iSzwzauOHlEyQhEzsjEKG9p/NRxeFkNl10/ozj3q8FAvFjZR0ju
         Zz3FIDzS2rOXvrkeeIE0UhfCbwYCt9yzOR0dg4uF/7EqsNQi/UfIB7XPpdYY5tqSkDwc
         BRTQ==
X-Gm-Message-State: AOJu0YyH59LwXp51FkZc0/TWizHqVQX89cHE6ShE1p6YWZZupQcRVwew
	u+ZnbuZqnzt7mUxrh9uLC72lLt3Cjw2mWg6x0LKJMKu2Fmuvc+k8KeSwPjs8pQ==
X-Google-Smtp-Source: AGHT+IHe8q/7Uap3Rq440sONVc3d/cawGrolo7Z307D4Y05inxotsQMMYjUjiMMfqtXROHeogJrWVQ==
X-Received: by 2002:aa7:8482:0:b0:6e4:eb29:357 with SMTP id u2-20020aa78482000000b006e4eb290357mr839544pfn.12.1709170505147;
        Wed, 28 Feb 2024 17:35:05 -0800 (PST)
Received: from localhost (217.108.125.34.bc.googleusercontent.com. [34.125.108.217])
        by smtp.gmail.com with UTF8SMTPSA id b26-20020aa7871a000000b006e13a88d52esm97174pfo.61.2024.02.28.17.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 17:35:04 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	cros-qcom-dts-watchers@chromium.org,
	Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: [PATCH] arm64: dts: qcom: sc7180: Disable DCC node by default
Date: Wed, 28 Feb 2024 17:35:01 -0800
Message-ID: <20240229013503.483651-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't use this device on Trogdor boards. If we did, it would be
enabled in the sc7180-trogdor.dtsi file. Let's disable this here so that
boards with t he sc7180 SoC can decide to enable or disable this device.

Cc: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Fixes: add74cad7c9d ("arm64: dts: qcom: sc7180: Add Data Capture and Compare(DCC) support node")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 4dcaa15caef2..f390bf3eccbe 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -2239,6 +2239,7 @@ dma@10a2000 {
 			compatible = "qcom,sc7180-dcc", "qcom,dcc";
 			reg = <0x0 0x010a2000 0x0 0x1000>,
 			      <0x0 0x010ae000 0x0 0x2000>;
+			status = "disabled";
 		};
 
 		stm@6002000 {

base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
https://chromeos.dev


