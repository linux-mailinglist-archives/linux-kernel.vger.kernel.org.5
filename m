Return-Path: <linux-kernel+bounces-97620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8020D876CAE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9B481F2223B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92DD6026E;
	Fri,  8 Mar 2024 22:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W7epss16"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571541E515
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 22:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709935715; cv=none; b=hN26QWslDGPdg2dNaexcJ7rf940FnWpqHV/U47x4wrQIG+ZRKAgu2MV7eJOODUDs7zeLJ2knw6ErFInH8UKiPmR5c6lGFkL2hJgk57kLukth7UCDzlMXbconW14XT+k8lQ8UAzuxAL4vRj9+bpdZj+BFV16svDa0N2enOXx877k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709935715; c=relaxed/simple;
	bh=6hqLrE2kGzcpPPlaLbbol8vDLZeqtCffaioj6zahxA8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V77C654xCTdiprwlU6ZEeY+RAw8VDWqf2JZspoe4UeDsjedqS+mCZefP03+Cd2uqtIDVbOssGI6B/sNBh22X5l7ZWIJayXIWwgmMf+1BMxOkhhye+ly+kRu0uLZpCf9MLNgkgrj3j+K9dv/RSneFrvYtslowORWg8DGBvAJh0bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W7epss16; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-513298d6859so2530705e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 14:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709935710; x=1710540510; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=444788bR8YBECKjRiKnANVI+jwd9C5/5ss16HCbJeCs=;
        b=W7epss16OhMlSxauvCOCN3QjqlDzgzdrYthPdAIi58ucs4cZQd+BHwMgUElrUyB3Hc
         gExBPBHj05CUly/jPcZ848GB8cM8TOssgswcE0C4h8890xFhJdMl1YScRplnHwMor19b
         +7lJRHm3ERoLD6lUXaD7WFhiKAj7yUmde8I0seTiz+jCr2YDQXeMnUOQf7bfCt85y4mv
         il9FK2d4Q36bgpvocxPLrIM8mYETklD+XKU2dR5lGo9ZKmR/rwCf5f0eRhJgpZnhHP4b
         GPDeQq0HBx7NTVY3/NgLCxyof3XFGhxxAslGIHJR7iQN0a4tLnRH1Hd9iz4YSNkOO6SV
         Lzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709935710; x=1710540510;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=444788bR8YBECKjRiKnANVI+jwd9C5/5ss16HCbJeCs=;
        b=O9bwcpvJ0tJh2zaeVfXZ08x/FFhy4kxtV2hgM1EqoBDr5UDrzlHW8DH7m1P+Bs23YU
         f3uiCkQTTWKecI14GE/CWwiUUA7z7cD/N6TRMmvSTRfSGTHgW9PTQvOdTE4VRXon5czE
         R/8JC+XLDn9Pe0oHWkJ+LL21gbiY6vuqHSwSFpeoRF7lFELQEb9OsBdd0TSuRK1pxuGM
         lzg2Xc6s98gSZzBJjJWZP/NPg+SBQNKN2wMd/B6dqMjFixmpiOpF6/66X/rl+9MWA5rv
         4MnLOfk0kz8hM03mcubW7WBufg/J6GRbfJyyQvNa3ozOU/r1WPoTFlMavm8u19RRAGcv
         eNWg==
X-Forwarded-Encrypted: i=1; AJvYcCWKG79ozz4l1LI6ma27lCwzj8CogDMQ1m6NHYbAifuilrrZ4p/0klmFAZNa0QvBofCw8MbbqVr/IkKlT6nD8byDcDiw2fN/MUoJFumu
X-Gm-Message-State: AOJu0Ywrpcae2YEUHXP95+bbZ5B4kjG56BAloQyaEJrv9D+ESdL+RNty
	yZ6Dqd/c6Slt0kHfN+jU2pcIbsTGh/WDQpZCksPUIgMUEnoHD+6Xm5m9Gt2Bkos=
X-Google-Smtp-Source: AGHT+IGfdV0sn6fso7vz9UOJkRQBSyomE8U61mJRksNWd2WuskneuQ8WFl+tp7BYBYK96WxWaFtgLQ==
X-Received: by 2002:ac2:5bd0:0:b0:512:d575:4745 with SMTP id u16-20020ac25bd0000000b00512d5754745mr222889lfn.1.1709935710464;
        Fri, 08 Mar 2024 14:08:30 -0800 (PST)
Received: from [10.167.154.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a14-20020a056512020e00b005130ff68b87sm78241lfo.109.2024.03.08.14.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 14:08:30 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/3] QCM2290 LMH
Date: Fri, 08 Mar 2024 23:08:19 +0100
Message-Id: <20240308-topic-rb1_lmh-v1-0-50c60ffe1130@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFOM62UC/x2N0QrCMAwAf2Xk2UDa9UH9FRFpu8wGajdSFWHs3
 xd8vIPjNuiswh2uwwbKX+myNAN3GiCX2J6MMhmDJx9opDO+l1UyanKP+iromOYQKI8XH8GaFDt
 j0thysap9ajW5Ks/y+09u930/AGbD0iJ0AAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, Amit Kucheria <amitk@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, stable@vger.kernel.org, 
 Loic Poulain <loic.poulain@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709935708; l=807;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=6hqLrE2kGzcpPPlaLbbol8vDLZeqtCffaioj6zahxA8=;
 b=a0axESlwZwu80bUuECyc07XfWyvUNwVbZgVKdTsfIs74EWLuM+j4lhtnGG5ZoJ8T/oa+7Ed8C
 WEN6GC92xCXDcwyiBqcfRG8tfAjyqhBfZEsuaXPDebvLzxH5pT/XrdR
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Wire up LMH on QCM2290 and fix a bad bug while at it.

P1-2 for thermal, P3 for qcom

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      dt-bindings: thermal: lmh: Add QCM2290 compatible
      thermal: qcom: lmh: Check for SCM avaiability at probe

Loic Poulain (1):
      arm64: dts: qcom: qcm2290: Add LMH node

 Documentation/devicetree/bindings/thermal/qcom-lmh.yaml | 13 +++++++++----
 arch/arm64/boot/dts/qcom/qcm2290.dtsi                   | 14 +++++++++++++-
 drivers/thermal/qcom/lmh.c                              |  3 +++
 3 files changed, 25 insertions(+), 5 deletions(-)
---
base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
change-id: 20240308-topic-rb1_lmh-1e0f440c392a

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


