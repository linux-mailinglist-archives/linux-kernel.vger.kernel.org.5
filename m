Return-Path: <linux-kernel+bounces-38567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F4783C233
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A95041C22AE9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0C24439F;
	Thu, 25 Jan 2024 12:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cICzTw1o"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113A01CF96
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 12:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184690; cv=none; b=cR0qWjxkBsebwcpQB3MVDIg09bYLXuBOlnoH+ENz4KCgrrl0FNXpazzV2nSwmSyu6r7TcAYnQyEl8nJYNyg1w8q6WvBAgZrPeyKd5Em5IYlY9gXcpbjmtbVAtE9+R1HLarVXrecZ/iIBw6hY/i2is1aprU3G/QckBDtacs6l2/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184690; c=relaxed/simple;
	bh=wl6qeStvWY/KbT1X9oM7F92Ws4lF1AS0XXrsCQhBdmk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A2jRvvX/ppvAojEKnGcAV7iwymkOvV+ZJ1eoKidFtEJcGkQuNsClpaje60XPeeQ63xG+Shvx/sHR20cAN4kNhdfX21JxkRxluTZ3C+MlS739INyxEU8ZS7G7px6Ym3i2B5wvgHB9x9ypEi5qpR0yO12GUrZhlKxY0TbjMvy09Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cICzTw1o; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50eabbc3dccso8351310e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 04:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706184687; x=1706789487; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=foLLMhETECK6dzlBqhWcUTWgNJQ57VgVtXN3QUrlVos=;
        b=cICzTw1o1r3seciKj/M2hP0aVDxDxsJQNdThl3Xb/uTHyCGrncgv0a4hBiRTLDEBwH
         OwtPYaI8kxwJ+febqYSevIkDAFw6OkNCCdl8/C9lF/5mW4uC7qLGtSRHX1S8UsD2rbID
         o5ataTZKBp1dgNyD/Z8RULlw0XnjXRp7I57aIFiTT1EsO8t+XUD2QC4vKUEjN3K0bDqO
         i3Ds8p8nigm2mz8eq8Toc9NXl8cULnKm/oUXiSyHMY1AMp6iqP7hykIPeaLHjNMlxNTG
         SgVu+p9T8AG+9dxUj/7zqNzqMLQ/RG5tBgmXyq1LcUKkLjARZ4xms4T4LF/vEdiC9erf
         GkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706184687; x=1706789487;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=foLLMhETECK6dzlBqhWcUTWgNJQ57VgVtXN3QUrlVos=;
        b=XXoHI5Q+mBS1sb1IDTzTcHMnEJCIwfq4Q5TRj8q6yJtsXhFfUctEMXGX5en8zva1wq
         CMjLGXcnHPhZKcen1Yzv92BrWByu/UZ+EHgvjKuuDjLoH0lGDMUT7EQXyYLvORLSBdtk
         AIbqdF2p6tK7CDPnso6pOWor7MBw/75G2bvQnYifRfzmfIBNO9iH0+mZt6XiA7SHVO3W
         8yxagAGSrFhNU96K/ohsLP73DQCioSZ9FMx9zgTHllm28WAUu346BJyVixUW3W0fcZbP
         IM0b3jL2V4BFfRYWC92RnZuMViADMkEM2LVaGwzPHN4Zsa0FVQcKNaQt7YODCGWMS45h
         x8cg==
X-Gm-Message-State: AOJu0YzqKo1LXRMfbQ/QpJlhsV1vz3qIQmUh0pwGbOH5Mt5JdbpgPF0h
	eAK8rWMmnycQzoU3vxg45ZJ67m5Aw5G9R8kJUMv5hXmdQ2tCnQeD0J9QUiysJQ0=
X-Google-Smtp-Source: AGHT+IGsG2nw6oX09siaTNeP3ehcDDpZ1k2uPqejFE0ZYYX5t8B39pBj6rqgdd5C+97CXcXi6kGqLA==
X-Received: by 2002:ac2:46c7:0:b0:50e:cc3b:b21c with SMTP id p7-20020ac246c7000000b0050ecc3bb21cmr243260lfo.43.1706184686982;
        Thu, 25 Jan 2024 04:11:26 -0800 (PST)
Received: from [127.0.1.1] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id y20-20020a196414000000b005102188d154sm21221lfb.108.2024.01.25.04.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 04:11:26 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/2] Assume polling-delay(-passive) = 0 when absent
Date: Thu, 25 Jan 2024 13:11:14 +0100
Message-Id: <20240125-topic-thermal-v1-0-3c9d4dced138@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOJPsmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQyNT3ZL8gsxk3ZKM1KLcxBzdNEtTk+Q0C+O0ZFMDJaCegqLUtMwKsHn
 RsbW1ALxkgodfAAAA
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13-dev-0438c

As it stands, setting 0 explicitly feels like spam inside the DTs.
This series simplifies it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      dt-bindings: thermal-zones: Don't require polling-delay(-passive)
      thermal/of: Assume polling-delay(-passive) 0 when absent

 Documentation/devicetree/bindings/thermal/thermal-zones.yaml |  2 --
 drivers/thermal/thermal_of.c                                 | 12 ++++++++----
 2 files changed, 8 insertions(+), 6 deletions(-)
---
base-commit: 01af33cc9894b4489fb68fa35c40e9fe85df63dc
change-id: 20240125-topic-thermal-f954cf83fc50

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


