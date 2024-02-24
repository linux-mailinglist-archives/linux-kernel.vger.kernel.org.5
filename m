Return-Path: <linux-kernel+bounces-79535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A23FE8623C4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 10:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E88AB23363
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 09:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EB3210EE;
	Sat, 24 Feb 2024 09:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YAUcGtyA"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF90B1B7E8
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 09:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708765967; cv=none; b=PPrdtgGe3KzKv9dJ+RI7ol5rjitmPAxeGfaUnnEX3S5Cx7CF+TEbGhOSc/jqZOGpmPnJXM9HAZNvoRwpo0O5gRWKj5BrEqHAeB0JZ+B2i3lp1Naj8SfkgMZA1LcUo2kGTKaoCFBaJkYwdil3U54mI/xgLnZmrD9m01FS7v5PKWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708765967; c=relaxed/simple;
	bh=d0VFOfOH3/XDFGCEN39cKeYLTeNfespjyWL1U0WSFPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LDuRNv/AM8AiNn2gepOHkpXdwqm+zqFRzjsZGBRcMUppmMHUvnkDwvotenHgneOzeiZhNhDKbuhSR22ldf9nMPZ6QvAxPQTObnnM39XuK4cLuH3I+IBXbY5z2cbMclhjWLXUPqPiPbNV3WcBz/4OdUTTJewYlWo81d1O8K2nvjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YAUcGtyA; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-564a53b8133so1196850a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 01:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708765964; x=1709370764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbUWmxXPQmtEJUwryo3H5edvLFU7yMZad6wo2IXtDvs=;
        b=YAUcGtyAaij2RoTYdOUTqz/OtYEeuofW6E7dLHzn0xrM2/4X9IXkaku49WvUqjKn6c
         QxlLzgLjJSO1bbIsvwfC03WWc1HNEDJdxdvQA8n5t0gTeA8wlvLRNkUv43xvmGo1EAUJ
         VQkI0BQCg8UHwFNmqzmEJNRFquVl+sAVei0h61YxHDTUwtq+oHBErpdVSANxskDpVrjt
         enPiIGWpbVqUpodto8ELaavuGzNlWIW71XGEO0gA87a22bjSmh0+1W47ogfka43DhlQM
         LQi+a59u4QOWx1htbffFDjONFn3TnclW9MNEfigP0z2CTEMx3uJyDOPq4d8AFKaNY80T
         rG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708765964; x=1709370764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbUWmxXPQmtEJUwryo3H5edvLFU7yMZad6wo2IXtDvs=;
        b=VYX+TsowiLIcuxCrVFGkOBhcZ0DURm050tUg0OkcMW3ZvOrn02QXsfnlvWVg3ed1Qn
         oi+U5V5h54oxL8qgoPAY89V2OA1Kd/cFNgoAOqVVEtLuQezwvmr6FLT5Q5GGUnaa0QC0
         Et+iGqpoVfbL934LW8ZMW13m3J9RSKfFtMoymCtXzODBTPb/iwU1y+ukb1CKr//C/jzg
         IYFfU/t9dX6HSDZifB5rozBromQWqtDbGUp4drUwOLdWam23cHo8F7qYf8oZhXVDivce
         z9GpiaoTqB6ny+edbJvjDVWYTy+k5exzwPydfx9DtWHI8kn+WCageJAEQqjr7ttNKz97
         giBg==
X-Forwarded-Encrypted: i=1; AJvYcCXHL4QIlv0DikVpE0tdJWpIHnV/MsSD/WXJH04UXjGOFuBaZrSXvXDlrZFhM+Vbh6PFtrHMMPLrAI+sTdlb7etnysRoqSbTTHdDaT73
X-Gm-Message-State: AOJu0YylUa2+p1kXqbTbzA+2H7QUpOAp3I74LMRiITZeAMvdMUSaORB2
	vMhZ6eoQ+Ol6RGKx73j4QXAPL96QVexecD2tWZvL5GLdWg+hIJQ+R6GgRTNsZMIKvO5gb3e7ESp
	EvHw=
X-Google-Smtp-Source: AGHT+IHPkmdY/2JX+2DxbAffRxrLnVnrTav9C+myuLjv86tAmwyJIFeyB4pKDfYDM9Pizs0gbNasYQ==
X-Received: by 2002:aa7:d0c9:0:b0:565:7d4a:1d4a with SMTP id u9-20020aa7d0c9000000b005657d4a1d4amr1230145edo.8.1708765964241;
        Sat, 24 Feb 2024 01:12:44 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id s8-20020a056402164800b005652f6a9533sm363120edx.74.2024.02.24.01.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 01:12:43 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] dt-bindings: remoteproc: ti,davinci: remove unstable remark
Date: Sat, 24 Feb 2024 10:12:36 +0100
Message-Id: <20240224091236.10146-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240224091236.10146-1-krzysztof.kozlowski@linaro.org>
References: <20240224091236.10146-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TI Davinci remoteproc bindings were marked as work-in-progress /
unstable in 2017 in commit ae67b8007816 ("dt-bindings: remoteproc: Add
bindings for Davinci DSP processors"). Almost seven years is enough, so
drop the "unstable" remark and expect usual ABI rules.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/remoteproc/ti,davinci-rproc.txt        | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,davinci-rproc.txt b/Documentation/devicetree/bindings/remoteproc/ti,davinci-rproc.txt
index 25f8658e216f..48a49c516b62 100644
--- a/Documentation/devicetree/bindings/remoteproc/ti,davinci-rproc.txt
+++ b/Documentation/devicetree/bindings/remoteproc/ti,davinci-rproc.txt
@@ -1,9 +1,6 @@
 TI Davinci DSP devices
 =======================
 
-Binding status: Unstable - Subject to changes for DT representation of clocks
-			   and resets
-
 The TI Davinci family of SoCs usually contains a TI DSP Core sub-system that
 is used to offload some of the processor-intensive tasks or algorithms, for
 achieving various system level goals.
-- 
2.34.1


