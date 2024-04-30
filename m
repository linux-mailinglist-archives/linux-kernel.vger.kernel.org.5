Return-Path: <linux-kernel+bounces-163583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE208B6D52
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6DA1C225C4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A17127E0D;
	Tue, 30 Apr 2024 08:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lbBNQ0+4"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1A9127B7C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466993; cv=none; b=UBFX+AAmzCAek1UHRFKyQ4IMMcKY0/nCmRn6X62TC16gBwGIpiYoMXp25aYzs7/ONQzLP55kJj0q/WxJY1VwuK38XMhD6Zf7xM8VP1pWbtZlC+kPPjpj1inyqMvPOI3JID6hFKSOR9ADjqUL9IAysAT9QGoEDdIX3nLBrWKXnUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466993; c=relaxed/simple;
	bh=iY96bY5jpA38NI/A4AML69uae1Cuf1NIV9ttHrW3VGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MRc8ObSYNDM27kzzuNb82q43QvY3k6TPFJans8znxTPBI/LNwnQBE+nfEfLqVe/0VljL3sKB5J1JO6f3XXGSDoC34zPhNfINtQ7rGLls5wO3bQ46m1mPAcECXu452pKu0GQCJh8k+jEqtlkXXCW7Kq02yeXW8CCcRJKrNAMf+f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lbBNQ0+4; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41a72f3a20dso38599105e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714466990; x=1715071790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TYzBphmsxuF/IXtV3sfN72fqNO+/5QlqjE/STTtJPI=;
        b=lbBNQ0+4ftPlILcdWCef91gLN1YALoZupBL6pxs3SiI4qmuBG9dT/0BMkOA3VucQyp
         8MEvQ5XtU4/ZYeJspa95dqOCcYHznDMb2k2/PA/Al5X4VeEOahHN4BnnQRDqYyM/afyK
         RVCmfcbu3QE7oUxBR6bIoavQLT1lcKB0WiGwWn/pVFXOn9HstNl3PdpCD6aq4ZSQS/bO
         VSVDDpK8rYSKUFKy0T42GDyUs+hx6DEy4YcNEMOWp5zYXOOrc8+eRF+M8KRlDg8lvN7O
         rMxw8sq08wQpNBH+N4rbYrbygDq7tLjE+c/WxPDimSueSkXvsFGHS6YX2UqmI5YuEXF6
         iXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714466990; x=1715071790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TYzBphmsxuF/IXtV3sfN72fqNO+/5QlqjE/STTtJPI=;
        b=Rm5xBO/tJdSUlPwuHtc6uSwNKYQcBxFWiCL4lEUeDZ9n0+LM3UkZFnz+yaWcntmONP
         /YJOOBJR2URMMr/lhWJl+BL61buYOl90Zo+B5qeM4ifPU4Wfcs93K14xgsr0UsBFs3vx
         jpSQlQyG5hXbFASP7L4gZIbfEWDEm7Bialjn3/cf1nKCuL5+OVRMWKgB3RaIqasxR5y2
         5FUwPI3rCLJMGB85puNLbD2ALQNldYdTMcWw1CUmnueOYeB7QHBKB6n4Zzyb+jaamht0
         i670aocLwEiPG/mOeBTc0gHtoTLGb4ZHXALXx9k1Om5B73E5wK6J9m/JpdEHVE8afKr3
         Oc0g==
X-Gm-Message-State: AOJu0YxWaFkRpEcztyatFvt8xVis+IjHXw6EhiaUyQUGSO4T9oaBcrvx
	VYzGnvgjNDJ2tbF2sDiaLkPUsxXU1u8RKeauiXMqQm1rKB6EzswjBjm8fjBZF+s=
X-Google-Smtp-Source: AGHT+IH+Q3TgFLlhltmJOez4q+i947yck3h3uN6VxH/kEnFl5x7asV6f9tAYlSFm5/gM7ChovHfUiA==
X-Received: by 2002:a05:600c:b93:b0:41b:ca55:2e2c with SMTP id fl19-20020a05600c0b9300b0041bca552e2cmr6250949wmb.17.1714466990498;
        Tue, 30 Apr 2024 01:49:50 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b0041892857924sm44490309wmo.36.2024.04.30.01.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 01:49:49 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	David Collins <quic_collinsd@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 09/11] dt-bindings: nvmem: qcom,spmi-sdam: update maintainer
Date: Tue, 30 Apr 2024 09:49:19 +0100
Message-Id: <20240430084921.33387-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240430084921.33387-1-srinivas.kandagatla@linaro.org>
References: <20240430084921.33387-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1267; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=o+lhyyxmrHZy2n2HY16UKZbmUEZfAIVnxoH2p0qIWMo=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmMLCNF0dreF/Ug4tlO05xbnr4NsTYW0CaYJjrb aS4tJE5SPuJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZjCwjQAKCRB6of1ZxzRV N4JlB/9hhxMQTSLLT844BO7WGStYlFUNRmb2Juaip+CItvvvk4v8qhhl585lsufZ8NqIfLfXdrE xd6A3h8xY6q5K6uM9LNXwtsFBU1YdKr7eigFX8xJVZ5Xq+ma21L+r1jffBlWAlC5aPFgszLnjQD ta2dX/M5kkwrww+mVIrJhjXUC7qEo5b03ZJiKVUFNGm9eSJOEhZLU4Wn5etdyHXrTQqoMNSt/DI LMTYua9nL89xyc6zm6z/v3Zt382p7tlkTFX9Q6q54gxFTU740e9m9GZlkUWU2RwhD/ShIKg77HM e1JS8+2Ny0lrZUPZUhJxu3jRAbcAej1vf1coCmw1LcHGo95X
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: David Collins <quic_collinsd@quicinc.com>

Emails to Shyam bounce (reason: 585 5.1.1 <sthella@codeaurora.org>:
Recipient address rejected: undeliverable address: No such user here.)
so change the maintainer to be me.  I work on qcom,spmi-sdam as well
as other PMIC peripheral devices.

Signed-off-by: David Collins <quic_collinsd@quicinc.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
index 068bedf5dbc9..5d7be0b34536 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Technologies, Inc. SPMI SDAM
 
 maintainers:
-  - Shyam Kumar Thella <sthella@codeaurora.org>
+  - David Collins <quic_collinsd@quicinc.com>
 
 description: |
   The SDAM provides scratch register space for the PMIC clients. This
-- 
2.25.1


