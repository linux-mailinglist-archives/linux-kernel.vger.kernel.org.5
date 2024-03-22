Return-Path: <linux-kernel+bounces-111989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661558873D2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3991C22BE9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C46279B92;
	Fri, 22 Mar 2024 19:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iS8p4bI7"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315D55E3AF;
	Fri, 22 Mar 2024 19:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711135487; cv=none; b=bmvV13aYWkdyv1jGnSL71fckFl3/qWDJ7jTMCDRaRQhumsSd3B3bGcsVWFVfZ94Bnn+m0J617RkBr8kajDc88mo04pL930RgQAEHDkuCf5Q7F5REmd10CywXu+NWB38hgJBEFCibAMiDuAQ8VSPEQbm3CXw9puf8Axs0oyQVizk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711135487; c=relaxed/simple;
	bh=TRwBnRIKVJvP1oP0vOUbRxZfMz6ws9mrssXvYU2GQlg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hEK52llscxVUSAKd6qfNCo5eZZNNqgH5i2lqLVhj4R4/4UNF1+k9QRhLNikC6NnlzTSSSujHzxlLl15aRj/rzAah22A/yAtK3VCmVatZTKy9Ir98S7ItvzCE+kbuiLj47u8g4HQGLpS7SJtd7Zijs0Al2OL55J8s09GUtQtgV7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iS8p4bI7; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-513e6777af4so4634532e87.2;
        Fri, 22 Mar 2024 12:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711135484; x=1711740284; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vux8fc5fM7LNtFQnsX415d4fh0A+DwGLl9t/xPE2qdQ=;
        b=iS8p4bI7fUr8AYGnHxDygInK36GePngYkSsrcrH4JyCLyTtbnLSqHHXfwORGJVaSZC
         rcqZLQTR8AchlWONpKwAduqDOsfsC+kTw+eJyhwBwE0bu1faSnUD2T7zuAPNLbEofy+k
         EvgxK0BWsYVwirXjfw07OQKoSScbqOfgfhRXgDpkzxGTfU+e7BQe2TkzC1zuxyYA6f91
         a26RUiGZHvHvGDgruKd+KgiBuBlHMhNsL9pltPuq7vwOPE4TlCmrEO2IEfbdXdenNYDC
         wq4IMB7OfDbtSx9dgqzNcXhkzRkUBLLjE5HkMUnMIidMtEMCDDiQopeT2pLIuDttJMCi
         2oYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711135484; x=1711740284;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vux8fc5fM7LNtFQnsX415d4fh0A+DwGLl9t/xPE2qdQ=;
        b=VpXSljpLU0drcQxVVimpFJQJMwEfRg2nmz4K08wxbzHgrrt3YddUs4+vh1gD8iRuqn
         BCw4PtaGjcdwbsPSlp3MpfrUQlQ/gDLo6KNtk28UuYnsXicSOB6HgHh3ZE1MOBodsMgn
         jCVKXS0rmKGN6H85HYiY85xc030xzV6/qubpYhOaANN0HOJxUj0T5ndxyig59gHeyvDA
         TWqE0VDjHam8ulFeIYKHcb1rmqsT/FSdMCB6j9g8vtZn/CCUTelaUgv1tlHPhFyoE/69
         HqqFxdDzbl2zhV/x6L/yRnXjx8vr7dPcqlSjTMMBl2PL71wc7j4pXHEEaY6v93XS+dzT
         k7Vw==
X-Forwarded-Encrypted: i=1; AJvYcCXPtYBj354P1YJNa9xf9A515gw0xPijKZ0PCqnz/eQArHrKVIevao6kNGUXPca5gNwrl9VW5/1S41y7wQL72/DPdFuKNFgNbLpny50Tkg9x6cxoJHeV43qaIOSzoxX9l3ta1Ke1jkJ/VA==
X-Gm-Message-State: AOJu0Yxai51KZCe8vzcTQDPntfEKptva7ARG+wK5QGQ8KohjFvMHsOSC
	BG8LYRKsLLiUSteEFkw+ltJ+PkTBAqdDjebC8qYAZ4Z/IRDLbG2f
X-Google-Smtp-Source: AGHT+IEztkWv0lG4BchX5uTHqaHr01cPk54RdBLOUlG46H0Z9WQy5mDhfH5yA43OaaEk7mNjUJrofw==
X-Received: by 2002:a19:e04b:0:b0:513:cf77:48c5 with SMTP id g11-20020a19e04b000000b00513cf7748c5mr314380lfj.38.1711135483932;
        Fri, 22 Mar 2024 12:24:43 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b7fa-7d92-6b28-0504.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b7fa:7d92:6b28:504])
        by smtp.gmail.com with ESMTPSA id ku12-20020a170907788c00b00a46b87c32besm138572ejc.39.2024.03.22.12.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 12:24:43 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v3 0/5] dt-bindings: hwmon: convert multiple devices to
 dtschema
Date: Fri, 22 Mar 2024 20:24:34 +0100
Message-Id: <20240322-hwmon_dtschema-v3-0-6697de2a8228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPLa/WUC/2XM3QqCMBjG8VuRHbfYh+bHUfcREXO+uheai01WI
 d57UwikDp8H/r+ZBPAIgTTZTDxEDOjGNOQhI9qocQCKXdpEMJEzKRg1T+vGWzcFbcAqWvZF1ec
 155VSJEUPDz2+NvByTdtgmJx/b37k6/ul+C8VOWW0PmlZcaZlLdl5sArvR+0sWako9rn4y0XKi
 5K1AFxp0O0+X5blA9JRlpvrAAAA
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711135482; l=2035;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=TRwBnRIKVJvP1oP0vOUbRxZfMz6ws9mrssXvYU2GQlg=;
 b=aTmpAFD7euHIggSgchvepGmBQhKMqXWjtiu+W0Zi8S99e23udMRL7ydG7U2wn2xv3SAf/QGZx
 1WGULD4yNcQCcA68UZtJRyufTfd8L1k2rWnhV03P4SMgatFErH6KJiP
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series converts the following existing bindings to dtschema:

- as370
- ibmpowernv (renamed to ibm,opal-sensor to match compatibles)
- stts751
- ibm,p8-occ-hwmon (moved to trivial-devices.yaml)

Additionally, pwm-fan.txt has been dropped because it was converted a
year ago, and it is not mentioned anywhere in the tree.
I could not find the rationale, but its current state does not seem to
provide any valuable information.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v3:
- Rename ibmpowernv to ibm,opal-sensor to match compatibles.
- Link to v2: https://lore.kernel.org/r/20240322-hwmon_dtschema-v2-0-570bee1acecb@gmail.com

Changes in v2:
- ibmpowernv: fix compatible string in the example.
- Link to v1: https://lore.kernel.org/r/20240321-hwmon_dtschema-v1-0-96c3810c3930@gmail.com

---
Javier Carrasco (5):
      dt-bindings: hwmon: as370: convert to dtschema
      dt-bindings: hwmon: ibmpowernv: convert to dtschema
      dt-bindings: hwmon: pwm-fan: drop text file
      dt-bindings: hwmon: stts751: convert to dtschema
      dt-bindings: hwmon: ibm,p8-occ-hwmon: move to trivial devices

 Documentation/devicetree/bindings/hwmon/as370.txt  | 11 ------
 .../devicetree/bindings/hwmon/ibm,opal-sensor.yaml | 37 +++++++++++++++++++
 .../devicetree/bindings/hwmon/ibm,p8-occ-hwmon.txt | 25 -------------
 .../devicetree/bindings/hwmon/ibmpowernv.txt       | 23 ------------
 .../devicetree/bindings/hwmon/pwm-fan.txt          |  1 -
 .../devicetree/bindings/hwmon/st,stts751.yaml      | 41 ++++++++++++++++++++++
 .../devicetree/bindings/hwmon/stts751.txt          | 15 --------
 .../devicetree/bindings/hwmon/syna,as370.yaml      | 32 +++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml       |  2 ++
 9 files changed, 112 insertions(+), 75 deletions(-)
---
base-commit: ebc9bee8814d12ec247de117aa2f7fd39ff11127
change-id: 20240320-hwmon_dtschema-7f58f49118aa

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


