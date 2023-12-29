Return-Path: <linux-kernel+bounces-13012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A1B81FE6C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 10:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22AA228470C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 09:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E5C10A00;
	Fri, 29 Dec 2023 09:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lisIMhwL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75711096C;
	Fri, 29 Dec 2023 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-593f7a1afd7so4037740eaf.0;
        Fri, 29 Dec 2023 01:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703840807; x=1704445607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2DPFdhO8FM0AKoSOmyY+N/OCGFWGsQxO2iQGpz9jzWk=;
        b=lisIMhwLo5Y4i63TBE+PkeQXwfz7LvlfXek/mbabI+9vXLxJyrY5zg555lDniPfW6O
         W+J/q4TFltsY273GcZ2XGfL7Na+Q9GuoSL35WbOBJ+w2Vfvm5Tsd5yRgDvD/3AatONVl
         4b6FtgAcNvwUArLHFK7OxV6nHW97ElOlA5M6DA3pzYJ+wv6gehKSGwrTlbmo8BQ0TYuh
         bIqZrCgdy18JqXOxOhRk8qvzdVDHxGLdAiV4pNvvO78ZzX5wfi7VwnuD0j9K4/tnEv1O
         DvxK+IrJLcC4oci18x2oihBho5WUx+JREsn9ogLyGEKfm2i9FdmZYtTU0Nc8pc8gKlJM
         kf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703840807; x=1704445607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2DPFdhO8FM0AKoSOmyY+N/OCGFWGsQxO2iQGpz9jzWk=;
        b=V8UoyUKWj5sJxzqPqhDW9gaarERK0tWL0qpsnPrQ0BYYWrOdcDBqBc0/gQ2FzF4ygj
         yYH9OC2C9hBH2gDKYnX8bhw9O8kJpM5qWi2XIpHlG+8qeyJwoaFWaUVzad3HApNCwXjA
         6ufx1h4fJT97Oh9tTmrY5OmqJocT8A3fry451XPM2UpzP3Cz9FfzYSMSpO5dU7foIbYF
         gkkfbuvffF1P3R1ag/hAjTTs2JHVPQNqdG0hZYLW2Z3XTw1+AnDETas4hUcdIeIiYoXK
         LKLTjGsJ66cBI0qVixT0qeDfCCn+er2rVlpQWc6vOYh62PeFmOSxzfS8IBJCIYmaaFzJ
         nIWw==
X-Gm-Message-State: AOJu0YxXzIUnSM1jH3ugfeSSZofi+fXawQxCd8iHaxbauPPLoGUKjMrk
	sLsEwzxdCYA6euAjim/H4bY=
X-Google-Smtp-Source: AGHT+IElZoem1Y++ThLGOY+NagnEum+6p3IqQzr8m5JU+vui0qmTLDzr+f+qVOwOH70eOfkTFcHQ7Q==
X-Received: by 2002:a05:6358:528e:b0:174:c1a5:7724 with SMTP id g14-20020a056358528e00b00174c1a57724mr11199940rwa.42.1703840807375;
        Fri, 29 Dec 2023 01:06:47 -0800 (PST)
Received: from localhost ([46.3.240.107])
        by smtp.gmail.com with ESMTPSA id s61-20020a17090a69c300b0028afd8d128asm10556668pjj.0.2023.12.29.01.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 01:06:47 -0800 (PST)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: a.zummo@towertech.it,
	alexandre.belloni@bootlin.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dlan@gentoo.org,
	inochiama@outlook.com,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: [PATCH v1 0/3] dt-bindings: riscv: sophgo: add mfd RTC and power for CV1800
Date: Fri, 29 Dec 2023 17:06:40 +0800
Message-Id: <20231229090643.116575-1-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch add Documentation for mfd and its child node.This hardware
block is an independently powered module within the CV1800 SoC. This
hardware block provides a register map for RTC, Power-On-Reset/POR.

The drivers corresponding to the hardware will be added next version.

Jingbao Qiu (3):
  dt-bindings: rtc: sophgo: add RTC for Sophgo CV1800 series SoC.
  dt-bindings: power: sophgo: add Power-On-Reset/POR for Sophgo CV1800
    series SoC.
  dt-bindings: mfd: sophgo: add misc MFD for Sophgo CV1800 series SoC.

 .../bindings/mfd/sophgo,cv1800-misc.yaml      | 69 +++++++++++++++++++
 .../bindings/power/sophgo,cv1800-por.yaml     | 29 ++++++++
 .../bindings/rtc/sophgo,cv1800-rtc.yaml       | 40 +++++++++++
 3 files changed, 138 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/sophgo,cv1800-misc.yaml
 create mode 100644 Documentation/devicetree/bindings/power/sophgo,cv1800-por.yaml
 create mode 100644 Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml


base-commit: 2726b01362a5132f18b978711d84aebae286facb
-- 
2.25.1


