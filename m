Return-Path: <linux-kernel+bounces-61536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B91C851367
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5E31C20B89
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E3639FC4;
	Mon, 12 Feb 2024 12:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJPUqbih"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B8339AE1;
	Mon, 12 Feb 2024 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707740256; cv=none; b=K/cM6hZTlY5kLoqDXJWb168q24qybpeDgHLqzHckhonQN57ab9y6UtPhn5zgqj6ZU0gzn0GQRYHH9fcgJn3oWvC/pRW41WmjKnIodFMBHMPrOk1AsamU0XfzIvIJCdMCajhHtXvj3LTtb2oRT7uNSyaz7XkT7eMxF1nQLMBLFdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707740256; c=relaxed/simple;
	bh=h+eDKUqejupTNYV2ZlucWTDKZk68JVOgE7r1odf5v+A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FgA5RCyHP7y+6DyyDPIi7KffWwBoohuhgNK08PB3C/ONdqhh0cLP3JnVGDhv+sVcS8ipHpla4fPOmOoNFEehYLvCWbrS/UlmtLcbclc9TwwwjuWIi8ZHkxDkzlTdQvaHehJ0g7kbgIqabqTkdyuL1GMVzf9appntDct01RpAF1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJPUqbih; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d71cb97937so29474925ad.3;
        Mon, 12 Feb 2024 04:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707740254; x=1708345054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gUo2/Sg64m+gluTfzP+6rjHe5+qPkCNx3G6SYPGm/sI=;
        b=eJPUqbihtaQiAlSpBldnTA/cRH4entRjTG671rrYwyDVRKO8TcFv1zDBojlOYYB3V/
         17H/QdJnlKrDqBRQaXYvT1OdIrMBdoj8Nsz+aYvWxqKNwGUK9yJCESSYKEb4a8+n+WrR
         I8hEaa2s7UnluZPnoKgRRiBNKNlSbIh7ZBxQ75evb7PZy3GBru5m8MqKki1EDGJl/XKA
         5UXGbSTXNh3qnu7APLfPXLIy4dnGaB7ZrebQvKLN+zOjbRv2rNIOgBVvMxTJY2DCGK9i
         QcnJvhuNrvtV3uGjPsT4StPA2vSEaJ1FJz72DpteXvGiSvk4KF9/yigocD9Um9ZkCDRL
         vUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707740254; x=1708345054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gUo2/Sg64m+gluTfzP+6rjHe5+qPkCNx3G6SYPGm/sI=;
        b=Ikcc+vngzJE3l0Q2rCgnwfd9jsHYZHhO0+NjSt2TrjK5lfIdp+1S/hzmb1vRf+LRl5
         15TrTtdSUBq46cpftN+0E+lsOw12WsdbsSC15vpyXQyu4LNONyliGw/H3juBr9EFbIT6
         IwT3GOfB36ej8/YFsA5uCT9OjvUvBF/UIYhdgey/LOG3Bu1kVmmoYK0xM0DhnauVKCPQ
         bFp3WFHnBeNXDNVct9US4PPAzpSyg146JBC98HkujF54iDJJN6ChOt7IoBRkQWlHqADt
         HUnP95h8nIP3dcDVMDVDxawVshvRhQyuwdRv/mnS6JSzQXrk9d/EUmk1No+WUAnFYbAt
         2leg==
X-Gm-Message-State: AOJu0YxjuLyyTrfrNu4ZzXq3ryLPidjnesQw56j5j2Wwyqu6lW5XpICy
	os8jnUJvUt+soYhV9SFyvtg2gMWEEbOkKZO7hngBCYyuvnab6zfR
X-Google-Smtp-Source: AGHT+IFzZoWi800XZAi+x/ypG94jLrL9fnPO+EXDCwS1MscQgFPlWVxztSuKLwoHj+sgV2FOfGRUAg==
X-Received: by 2002:a17:902:b696:b0:1d9:5596:ffe8 with SMTP id c22-20020a170902b69600b001d95596ffe8mr5309450pls.66.1707740253393;
        Mon, 12 Feb 2024 04:17:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUYA8Xz5X9EaPh/+2SLYWC4a0TJgPvUOO27bVLQYpVaU5SGcwZsmMpHBougkK2XTigazcx1bA8Ak0t8ElLVcBUxwi1zB/8PJOrmrbKJN1FTyHVxMFLmgM4OyReOS/8ruOqxTSGJA4OWO6H4hhwYMLymcwuZoaOh92N3sy/nBfS/dR6iI6tCDs5gzJN/MIGAheQsCNqMO+JcVWBM7nJvk+l0sB+CrfCofsIvkh6NwWhcJVNfgcc8/5vbW8FpVOHdsZZK74eimU9+VKmawl0MhL2TVLc9ei8+aHK4TZClVLQN+MFdxONt/paHePhfZf46wQ0WK9cgEfEtthRrXnW5ZYTQ2a9+fdTXSaQdb5RrbMlno03vroOg1x/a6lrUBa1L1bCvtjYROSslGLWvl3nIqxkHCva8dRK+LpttCOfm/6z4GqbEc/Ig8PFW9o1IqBcdFh06Vu85JkTP50Pkd7DC
Received: from localhost ([46.3.240.101])
        by smtp.gmail.com with ESMTPSA id e21-20020a170902d39500b001d8e5a3be8asm242216pld.259.2024.02.12.04.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 04:17:33 -0800 (PST)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: u.kleine-koenig@pengutronix.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	dlan@gentoo.org,
	inochiama@outlook.com,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: [PATCH v2 0/2] riscv: pwm: sophgo: add pwm support for CV1800
Date: Mon, 12 Feb 2024 20:17:27 +0800
Message-Id: <20240212121729.1086718-1-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Sophgo CV1800 chip provides a set of four independent
PWM channel outputs.
This series adds PWM controller support for Sophgo cv1800.

Changes since v1:
- drop full stop from subject
- re-order maintainers and description
- pass checkpatch.pl --strict
- fix naming errors
- add "Limitations" section
- use a driver specific prefix for all defines
- using bool instead u32 in cv1800_pwm_enable
- check and set state->polarity
- use mul_u64_u64_div_u64
- use clk_rate_exclusive_get(), balance with clk_rate_exclusive_put()
- using macro definitions instead of shift operations
- remove shift operation on 0
- use priv replace cv_pwm 
- hardcode npwm
- set atomic to true
- remove MODULE_ALIAS

v1: https://lore.kernel.org/all/20240207055856.672184-1-qiujingbao.dlmu@gmail.com/

Jingbao Qiu (2):
  dt-bindings: pwm: sophgo: add pwm for Sophgo CV1800 series SoC
  pwm: sophgo: add pwm support for Sophgo CV1800 SoC

 .../bindings/pwm/sophgo,cv1800-pwm.yaml       |  45 ++++
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-cv1800.c                      | 248 ++++++++++++++++++
 4 files changed, 304 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,cv1800-pwm.yaml
 create mode 100644 drivers/pwm/pwm-cv1800.c


base-commit: 7afc0e7f681e6efd6b826f003fc14c17b5093643
-- 
2.25.1


