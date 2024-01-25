Return-Path: <linux-kernel+bounces-38910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65B483C853
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9B121C226CB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7430130E3C;
	Thu, 25 Jan 2024 16:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qS9CYNVm"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1C312FF94
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200971; cv=none; b=Drd8rmF1eBk+iT7KJFIZ7QZPmcIlXg+H7u44ej+751e8XGRnGEvlaUwBk5YparBely4wCIWLZqYUkfNyFVZwhNczJhtghOYH+uCAhP+w6HyrBjl9zQ+uyYM/zefGegcMHKOnoRqn52jMaZlZ+o/2dKvhu9kTaNeW5iPHwGxCcdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200971; c=relaxed/simple;
	bh=L/AEYsPK+lOVA3XMrw4EQq1xfeN7Xl1wlXueNsNSoe0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=b+a3+JM6sG/U84gyEyHTyFYy5mfWEkExsUR4CeTWPz9rASMS4PgOTzX+yHIUUjrGysEmE3r8gpCeGlMpkQNDOKKn5WzygFdEENkJFSHYh/YTT7HBAD/zRuEJQYRUze1cUy9dpbvngoglIiBXwCLZ9FV7nX4XXkyXPlgtyiN6xFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qS9CYNVm; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2901f9ea918so3874106a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706200969; x=1706805769; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V4A/B+fGo6SoJVPZLDbDqwvVEJrcWXHPl47dbcCvQxU=;
        b=qS9CYNVmCzamUxyBxmbi5tdH6C8sKB44wRbsjMbLYCZu/Q4zJmvk3dXfsQx4gW+CjH
         bOaqG8LIBEij/c9ALHBD83dfaSx56g8Gdy8EYAuk95ywRFjh2TtTzmPoHXJ4lB1SDfI6
         4XB7++thsVSStxukPQLYbfgiMFSQATv57HUHqS8MgrxRVASZcCj/hvghqxJLPTpvqTnX
         o+AscjlpMvjINQNoMNcInB68oCvepnIydtM4rmOXNc9WC8Sh85+XouidnHMrmOZTrcjD
         V3647mGdJ5Z0IACXR4Kt6Of4t8lYBk7dtqM8ATNbgeNSfCtIFw8Zp5jydi6F8ytMMb/o
         sfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706200969; x=1706805769;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V4A/B+fGo6SoJVPZLDbDqwvVEJrcWXHPl47dbcCvQxU=;
        b=dCarOlBqKopHLFVh3/1yJcEoJeukxsS5vBxAT4rqWi4TcRYw2OegAszpp0H88wcBca
         ZoKrW8WaGtg3GXnbdfAKtaBM09Z1pBE6GeF2XQnrbOfqHhz8TSS1vLwb97vvc5aVWT80
         t2ic/jLVTWmLxWT4GIwdt8auBPfjP94V/217BlS0Yyvc+4MRKxeEeIKSE9BhEdoKDh6K
         SSnFORv4bi2qPuEhA7EUkpTsfDAhmUvaETeQ+LByg2deQi9BnGBql7Z0JBqy9bpmwUtp
         ucnJNnOp32LDEL4KpYf2yfsURLwsnB6cPw5TZUk07u7GED5AAqpkyEjpCqgIZNyEltRq
         83/A==
X-Gm-Message-State: AOJu0Yyilw485OfUz3X0a9VwXAv/R1P+ANhyiJx/iLq47A8QTtpfNeHY
	acBZS7ytJrZAHStZEMWXtDPsxhxbjcHQml54gYEktCsP+8UA1oQ7iYkpSwbO9Ms=
X-Google-Smtp-Source: AGHT+IHB4jeyfnh57rSSIKEeaeUGRNa22GAGU9uwwHYehgMbsAPf9L+fI66IOZb2OwKGZBlGgti9sA==
X-Received: by 2002:a17:90a:6c25:b0:290:4acd:2751 with SMTP id x34-20020a17090a6c2500b002904acd2751mr874986pjj.20.1706200969047;
        Thu, 25 Jan 2024 08:42:49 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id u15-20020a17090ac88f00b0028c89122f8asm1769170pjt.6.2024.01.25.08.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 08:42:48 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/3] arm64: qcom: sm8650: enable Audio on MTP and QRD
Date: Thu, 25 Jan 2024 17:42:40 +0100
Message-Id: <20240125-topic-sm8650-upstream-audio-dt-v1-0-c24d23ae5763@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAICPsmUC/42NSw6CMBBAr0K6dkzbyM+V9zAsxnaESYSSaSEaw
 t2tnMDle4v3NhVJmKK6FpsSWjlymDKYU6HcgFNPwD6zstpetLElpDCzgzg2ValhmWMSwhFw8Rz
 AJzAeHVZlXdcPVDkyCz35fQzuXeaBYwryOX6r+dm/06sBDR7btnK60WTN7cUTSjgH6VW37/sXb
 u7ehc0AAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1284;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=L/AEYsPK+lOVA3XMrw4EQq1xfeN7Xl1wlXueNsNSoe0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlso+ERtibcSIQNvpJ1ASQ/lsmge+3QC9MY0Xn+IJa
 PdPHsYiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZbKPhAAKCRB33NvayMhJ0XNqEA
 CL7GRqDT9P7QPI0nqOeYJLDCH+6y8BPY23xs9oCgbh/IOeH3cjUgAtu1hqpgbzGpBqs2bFf0JhLKTY
 7BnKcpAilxW4uYBFr/5JgbSBFH8RmVLPdqSikmUHSurLa3j1cQ/DYMEygKVMk7jRwy2HdW1oMbna7j
 5G0BJwr9keKsV6qDA0MoZGVDyGlurhlZyWRRzhwSKPyYkWXPrsuHlJwHv/OU1TAVCePVUGkChraAdo
 nuOsW52kRhYYgQDCqL0fmdQzCf//ZcxZbABcskCZZS7Gwi+9zRCw5dDKwwT06n2Pp9t16AXYtekyPn
 9RIRsldqWDmCjsPkE+MOlYD46Oa7W7FYxBbt1+VnscVlBQl+ixoaJvs9QxdsTg90QvzKKz9F0Kg9mq
 cXQZarT//conQOL0bAeUU+H/tkmOsMKZ0Ka2DShE4QRXMczN+qKcYk7tKnA7tYK3HB+8PMcHpTcD4N
 mUck8fgbSep3Im/fXYZpMadY18A8U5pE+nFRZOcBNgvTC0+bnFqpp/UEflQRtFELpTh+SlUewjPStz
 o4Dk53SmEz3JPH8nCHYefbDMaDo3qpKvxyiNcUe5yFFsU9Yav8vHye+vRzAbM6AU5mfA2EBhxAJO60
 824aE7mEAni2hWVBCPE4yRMXwHnn3wzlLGzPNjgghJFTbGCZRw5jQ/4bjVDA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add the remaining Audio nodes on the SM8650-QRD & MTP boards including:
- Qualcomm Aqstic WCD9395 audio codec on the RX & TX Soundwire interfaces
- WSA8845 Left & Right Speakers
- Link the WCD9395 Codec node to the WCD9395 USB SubSystem node to handle
  the USB-C Audio Accessory Mode events & lane swapping
- Sound card with routing for Speakers and Microphones

Finally enable the missing modules in arm64 defconfig now
the WCD939x codec driver has been applied.

Dependencies:
- altmode: https://lore.kernel.org/all/20240123-topic-sm8650-upstream-altmode-v3-0-300a5ac80e1e@linaro.org/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (3):
      arm64: dts: qcom: sm8650-qrd: add Audio nodes
      arm64: dts: qcom: sm8650-mtp: add Audio sound card node
      arm64: defconfig: enable audio drivers for SM8650 QRD board

 arch/arm64/boot/dts/qcom/sm8650-mtp.dts |  23 ++++
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 203 ++++++++++++++++++++++++++++++++
 arch/arm64/configs/defconfig            |   3 +
 3 files changed, 229 insertions(+)
---
base-commit: 63be584a33c3c63114aa3866f7cbcb45fa751e60
change-id: 20240125-topic-sm8650-upstream-audio-dt-1daca65777ba

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


