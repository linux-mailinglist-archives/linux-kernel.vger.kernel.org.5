Return-Path: <linux-kernel+bounces-32160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A09835770
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 20:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2B31C20CAC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 19:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C3A38DDA;
	Sun, 21 Jan 2024 19:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4lPCo5e"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2648D3838D;
	Sun, 21 Jan 2024 19:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705866302; cv=none; b=fLYOrGVtVn5rsXaWqOS7355x49XxnIalOzsv1m7CPyagOhyiBPK8DUh80c3NFxufy30xBszh8+nmIoF/hobQ4gsis1r+1RS+2hbGoC9cZUIDP7oh5GUAMll4gpARUzBXUQ3lubWzg5HtzPvLSHGlaOYfeJ6eTl63lcSSubCjSOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705866302; c=relaxed/simple;
	bh=s69aQi+AWzuXjIxRNjHaV+PmF6u3aDBeCfdrZ0FRr30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Av7hhI4mrxk+nWyM/ltDCvLvk938wCYSn9dyVlSvOZYUuqjj9xx+yo9yZZjEiAe4D9U7kblnqD879gLq12h8XvZl84GolAJxyScvoOxAzy67GpbXqtSBPqP1QtPvbYP4zGT4haGhAEelf5m+0Is2JHPvozskTFLy7Ka33j5Ls5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4lPCo5e; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40ea5653f6bso16786825e9.3;
        Sun, 21 Jan 2024 11:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705866299; x=1706471099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSyL8oZoH+O2H0crbStcYmTW6WZwzQTT2b5q2v+e/vo=;
        b=C4lPCo5eqP0iUDzNUGBtpMaMiHr9oFE/UnL+nxFvslm3+2tU5XDMVJUjtMQFlIHWpn
         3yQLXfH+8gsCrMsvhw3C9VmlHVMwm4Ba0SZSk1UK0Vk4qB3vhrzMlFdCfY63+NP9juWP
         nUKwtRL4dZUtKXneauayNAXVjF2AQUVLhz4blRZhroelXPD4YJUFd+2jb7liT7RB3/0R
         els+5k7/CLSH8QsCRk7EM96Af4QDYHMBGjyEWywlakVAv3nO0agKHay9Vy4twWn0zj7H
         fiC0S3IcKMe9gRpI7zCDo9JEZWpKF1K81yXbRm8k6hN2AMgR5zXBBK5DqcOVuEfqyj3/
         rPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705866299; x=1706471099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSyL8oZoH+O2H0crbStcYmTW6WZwzQTT2b5q2v+e/vo=;
        b=fD6oLFBzmNs6JIoy2T/obvLJWoYWPDOo2bJif2eQ2xD1d7/GEDBR2IEaehaO93cdEv
         2FupYHdcuX6zIaiImDoal6QbFOXFbw+TriuC7dSQ+sw3a7KjrPYi+LszZGAu3aTxLBtc
         rHpm8PRxOcPfrfDr4C52iOaFzbxdq3MU0QmAdt83UhdGgYYWl+yo6aggRGfgjHe4vaNO
         o/zDCSaf7qOnPjTCLWtOCK4eYZDYUdowKLpeNCTdvyG+lTz6MDoKeGt1k6Fa56GMyadr
         7prJCcMOslCSzFfSw4gEUvQfxH4csgbGn88QEXe3Jz68TKwidx0Dt+n5Xz/ui8I211p9
         79cg==
X-Gm-Message-State: AOJu0YzsDAB5JZunZPWQaUFZ9+zjvT9uB+sulZjZno/bdL+DvSVaOB0u
	zs5DGNhqUoJv3Ym7LxLMm90ue08HoGobiLdUjSWR96xMZpCk9dOwpJhmy/9pLHY=
X-Google-Smtp-Source: AGHT+IEA8QU6DB7njfuZDTzVSpd/QY3hGWifA+4SqNBDW2kARLb253E8gMCC7I8DvuAnAIwJag1OVw==
X-Received: by 2002:a05:600c:a3a5:b0:40e:aae1:e3cb with SMTP id hn37-20020a05600ca3a500b0040eaae1e3cbmr689767wmb.118.1705866299057;
        Sun, 21 Jan 2024 11:44:59 -0800 (PST)
Received: from localhost.localdomain (byv51.neoplus.adsl.tpnet.pl. [83.30.41.51])
        by smtp.gmail.com with ESMTPSA id k6-20020a170906128600b00a2b0b0fc80esm12547134ejb.193.2024.01.21.11.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 11:44:58 -0800 (PST)
From: Adam Skladowski <a39.skl@gmail.com>
To: 
Cc: phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Adam Skladowski <a39.skl@gmail.com>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krishna Manikandan <quic_mkrishn@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] dt-bindings: dsi-controller-main: Document missing msm8976 compatible
Date: Sun, 21 Jan 2024 20:41:00 +0100
Message-Id: <20240121194221.13513-3-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240121194221.13513-1-a39.skl@gmail.com>
References: <20240121194221.13513-1-a39.skl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When all dsi-ctrl compats were added msm8976 was missed, include it too.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 .../devicetree/bindings/display/msm/dsi-controller-main.yaml    | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index 4219936eda5a..1fa28e976559 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -19,6 +19,7 @@ properties:
               - qcom,msm8916-dsi-ctrl
               - qcom,msm8953-dsi-ctrl
               - qcom,msm8974-dsi-ctrl
+              - qcom,msm8976-dsi-ctrl
               - qcom,msm8996-dsi-ctrl
               - qcom,msm8998-dsi-ctrl
               - qcom,qcm2290-dsi-ctrl
@@ -248,6 +249,7 @@ allOf:
           contains:
             enum:
               - qcom,msm8953-dsi-ctrl
+              - qcom,msm8976-dsi-ctrl
     then:
       properties:
         clocks:
-- 
2.43.0


