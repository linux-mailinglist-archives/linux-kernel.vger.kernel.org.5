Return-Path: <linux-kernel+bounces-119224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A4A88C5DD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C9F81F612E4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55E013C812;
	Tue, 26 Mar 2024 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jio3+1Y4"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B3D13C673;
	Tue, 26 Mar 2024 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464766; cv=none; b=DQC7CXqwitkVV/A6xSb4As3mZ2S3rhV5W/s0TbBc32WQ0U0ZzlrugEMplFlEX357Y3eG5eAYASTGRizp65eFjyS5fdjBcZ95K7gWVLW9GTIpdCyRnfqAbUUT7pof+sAWo9URpkLuzvn65gOaCDtFOGUH5Iw9Uqb7ow7tYaLe58M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464766; c=relaxed/simple;
	bh=48qYaG5edmKWVxU7jCSj3GMdlFUPUTS5DhkGbsiLX0c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gmksChGOqVqSoMgIQ6l+nD22bMRWRITqkmM+pdPD00PCRYvnLULaN/WiaNNWWAt3Aikm9Q1nmXYr40MvtAp0s0/UDt0EcldOmHUnAZkUabj0S4R9AITmovEZWuQ+I+olU5KNTzQDZ0mYOKaue0WjDT0zJT1KfvcjV+albh04/hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jio3+1Y4; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-512bde3d197so4067967e87.0;
        Tue, 26 Mar 2024 07:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711464762; x=1712069562; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUFpOWCdwX5PIn0uu5JSZ4OifiAGsxGZIZB/Orwyxs0=;
        b=jio3+1Y4mnjSrgrZM+gPajzlZcIYuO6F5BXZyIWoejnmKzL0HDLH4E7QDqlSALBhfL
         GeC59b7xV4CErd6eCrVy52C6HxZlSCjyj+MVwTNu5gWJLAcbPsMNj9uEX99GzraThhjn
         RVIH+SbCI9ekNrTQEw8PNuxnGA/Xv1xWBo9FEOxw7ggS5GtsJrW6+4PkNv89EXp0kWub
         6/Fou4OKDF/RfTJA1mj6IoIr+fHgNtCfGXRktheeMagvsq91S9ZvalGfvD7mvL1d+FIY
         PxxwHJmjn7ltJqAYsY/GBhLH2jLl1IU3o8YD20MxLlitiiFV2aTwbsvGbS7nZ2o3Z5/Z
         q6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711464762; x=1712069562;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZUFpOWCdwX5PIn0uu5JSZ4OifiAGsxGZIZB/Orwyxs0=;
        b=V//qFQrQHltZ3RqUGBnRvmWJQuJzAglT+n5fOfZD0XsmQ73t/yoAhqzB6dSg7M2Lfp
         apeao2fnoojOQgrIOQUccRLRBOQw19tKMuvQ0PI9pZvA8mGlYlk8UowQsLmQE+ooDPo6
         QWsQjXrY8q32g9qjyh9Mt9T44Y2hLBjbjqlDmWY6cQR+AbTk1KqX+LXvHe8pWGxRPbPg
         mJ05FKqhHLAsy+Ezd87VPirr+/HUnU/CJpmIFxUp1Z1mRPp7ieCiC8Vqz1PFvI1ozkzz
         CIG7WKcp1+FcE2VivDrut7gVWAh9VxMa4mEPYHYqR3gfkv5VBFvnLFcbAFZukDhlZhbq
         lW5A==
X-Forwarded-Encrypted: i=1; AJvYcCVMUt8ALS2ZOAfkWzYU7ZTfbXsJVnNjjtMI7R2U4VXe2Xy+fDxoSzeBdEZP1Zze7wUaLtss+zomLlTIYQ3FCeK+4y6iNyf/ga0ZCSueJZGf00uSnaFbdVxWLe8jnlPjUozg97MYKgaQNw==
X-Gm-Message-State: AOJu0YzUOCRqc3zgwDtsGzh2PG8jt8FDrTpksetb+mMUZjDxYKfq3LWa
	mO+9X+AX5wn8FIfEh4lE713Q1/2A1r7ovNdE7J7aOGkCd0hCd2ikBwj7ddjJ7dg=
X-Google-Smtp-Source: AGHT+IG1apLsno33veYb/2xN+18z+q4qYAPoWNjs2z4AzP1gFJuxnTl5dib0lXriyO52e3bUioaEPw==
X-Received: by 2002:a19:7417:0:b0:513:aef9:7159 with SMTP id v23-20020a197417000000b00513aef97159mr6821099lfe.39.1711464762210;
        Tue, 26 Mar 2024 07:52:42 -0700 (PDT)
Received: from [192.168.1.253] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id h8-20020a05600004c800b0033b66c2d61esm12281738wri.48.2024.03.26.07.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 07:52:41 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Subject: [PATCH v4 0/2] arm64: add minimal boot support for TP-Link Archer
 AX55 v1
Date: Tue, 26 Mar 2024 15:52:26 +0100
Message-Id: <20240326-archer-ax55-v1-v4-0-dc5b54a4bb00@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACrhAmYC/2XN0QqDIBTG8VcZXs+RnrTc1d5j7MLsWMKqoUMa0
 bvPgrEo8OY78Ps7kYDeYSDX00Q8Rhfc0KeRn0/EtLpvkLo6bcIznmecM6q9adFTPQpBI6MFYK2
 YVoWRSBJ6ebRuXIP3R9qtC+/Bf9Z+ZMv1l4J9Kr2MKmVLq7mBUpS3ptPueTFDR5ZU5FsuD5wnD
 kUhsZLM5sD3HP4c2PF3SNzUKrXR6kqoLZ/n+Qtt4KXgKgEAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0

The purpose of this series to add minimal boot support for the
TP-Link Archer AX55 v1 dual-band wireless router.

There are two patches:
  - the first one adds the compatible for the board into the dt-bindings
    documentation,
  - the second patch introduces a minimal device tree source which can be
    used for booting initramfs images

---
Changes in v4:
  - change patch 2/2 to use new LED_FUNCTION_* definitions introduced
    in v6.9-rc1
  - rebase on top of v6.9-rc1
  - Link to v3: https://lore.kernel.org/r/20240313-archer-ax55-v1-v3-0-cd9402efab59@gmail.com

Changes in v3:
  - change pin configuration to use "gpio20" and "gpio21" for UART pins
    in patch 2/2
  - rebase on top of v6.8
  - Link to v2: https://lore.kernel.org/r/20240226-archer-ax55-v1-v2-0-3776eb61f432@gmail.com

Changes in v2:
  - reorder pin configuration properties in patch 2/2
  - add 'Acked-by' tag to patch 1/2
  - Link to v1: https://lore.kernel.org/r/20240223-archer-ax55-v1-v1-0-99f8fa2c3858@gmail.com

---
Gabor Juhos (2):
      dt-bindings: arm: qcom: add TP-Link Archer AX55 v1
      arm64: dts: qcom: add TP-Link Archer AX55 v1

 Documentation/devicetree/bindings/arm/qcom.yaml    |   1 +
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 .../dts/qcom/ipq5018-tplink-archer-ax55-v1.dts     | 128 +++++++++++++++++++++
 3 files changed, 130 insertions(+)
---
base-commit: b55a22fa35e9d4e07d3ee6ab2557a41c2711433b
change-id: 20240221-archer-ax55-v1-73ed91a97c6e

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


