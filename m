Return-Path: <linux-kernel+bounces-111686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FA5886FA1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A3191C22139
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A54524BE;
	Fri, 22 Mar 2024 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+GWbH8Y"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC74B4DA05;
	Fri, 22 Mar 2024 15:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711120428; cv=none; b=VogyOxJU88qNe4rYyrrktcqMe9U9P05wfwwYNnqI0I8DjDGUbhXodhjHpfZl95WHzwsnf31S3sRw2txqWE7zhfNXl70prxktZy9SIHg3mv9rtygvYNkpIxJI9n63r63aLRLP5FFFUIo8XEFCqblYo4prvlRS0u0yK8UyVloyd5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711120428; c=relaxed/simple;
	bh=+CQIorDHr3r99/Octkr4IbMOib2EsF0eYFfs/Y17Mh4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YzjevNy6fRIncYgncjDFlN+SfbbYe3ET/lxCi0JJYyPia64psXfzxml/2mEE9VZ5SyjnBKvvqeB1DooU4SIDypB80/zyAknOfK5Gbm4z6WWF/Cuj/iC2syMm69SfucaoXdZszpmKeXgKUWYfEaHMpgLz14s+rkx/VzbHvg9KDcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+GWbH8Y; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d476d7972aso38499691fa.1;
        Fri, 22 Mar 2024 08:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711120425; x=1711725225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hObi+XxtpfLczBRTk0qRe5ECb6282JKAinCyXcTcfZY=;
        b=Q+GWbH8YpKEXSQNXjQuL6ysDNcBJeJPbMZWt3P21mXpLMg1xtf4wIbCEaIF8F1+zh3
         v2EaC39f4ka6791sW3MFAC8y+WGMqB0rmPc5yp2dlPrlYykuHvu5HSGlxImhDB2yGyuA
         2buCCIGsSbIybKNN5RQ0G65NoLWsgJrC2WChylJEaS68wkAPELjBFB21lN3373+ot3Gw
         7YBmeE4AZHAw5cumsh+CIc2fc0Qx2RGU7VZN6dhjpVTb6ptqqXISh4GHuVQYUBYWo4G2
         tA0L/8Ka+ApXNBxU27l/lEnA/9GjhztDmE374SktAt4k/bVMwjiaI8OzL/OA6g/bq/3q
         C8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711120425; x=1711725225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hObi+XxtpfLczBRTk0qRe5ECb6282JKAinCyXcTcfZY=;
        b=SF8Izl508+QmjL1/vhmx6aV3RsmRcClMGfYGAkAPBCFD1npoPHTepytVL7sXzz2Gvk
         dxAu/hD3x1s0UZFkouPvzbGiQHIsg8x/cYtSFxAY5RMYUoFzHtTRsBGlIz5liHwk+g4T
         s06xsr4f7GWu0GNxr3OxlYsgh0ZOKr7omCUgtJ0I2ziV5mx8V219QMoq9i6dXdanCbNj
         ucbpHwHV8WxpubAa+1+RYJVvvgoUNwrkBOOH7jCrsUAjEcpWHKuTzeURyaNKlkUtXUxN
         9whtfTRYZQ2rX2dzckeT9T8OSRhY8Os8w2UVNUVFags+5PJzyIp6NPR/Dy5k2eY7nTux
         sUlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaZC5LScIuuKEDXq2fbC6oHxhQIaA2qpOEStC91iOLyf7vrIeI9dTLCi3SARvYBTwyOCMrK7cnqc643J2/Pxu9Ay7ngJgh1hcfamxFcOLs4MdMi943nwunG5FEtgxvo0A0qFYt/Ym3ky0Nv+l/
X-Gm-Message-State: AOJu0YyljGhMT1aQWHRfPDBIx0Ld4BsWZzg0qzTVesKDXzjY/VDVfNKm
	xXsiPxC65zq6lxfuZb0ZQxJ/ahGa9GJp9Plcyniz/NxSVEM5hvlk
X-Google-Smtp-Source: AGHT+IGoEgyc5YgBBMy7C4N06fXvInXJjntJDzsGMZ9OiiA4F4uBX0wXWVthDY1RyvpYzQVdG0IPqA==
X-Received: by 2002:a2e:3015:0:b0:2d2:dfd6:8335 with SMTP id w21-20020a2e3015000000b002d2dfd68335mr2119548ljw.22.1711120424754;
        Fri, 22 Mar 2024 08:13:44 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:7b89:721b:d6b0:d7e8])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600c314d00b004146d736fcdsm8626677wmo.36.2024.03.22.08.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 08:13:44 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Brandt <chris.brandt@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 0/2] Add OSTM support for Renesas RZ/V2H(P) SoC
Date: Fri, 22 Mar 2024 15:12:17 +0000
Message-Id: <20240322151219.885832-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi,

This patch series aims to add OSTM support for Renesas RZ/V2H(P) SoC.
RZ/V2H(P) SoC has 8 GTM channels.

v1->v2
- Inlcuded Ack/RB tag
- Updated commit description for patch 2/2

v1: https://patchwork.kernel.org/project/linux-renesas-soc/cover/20240318160731.33960-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (2):
  dt-bindings: timer: renesas: ostm: Document Renesas RZ/V2H(P) SoC
  clocksource/drivers/renesas-ostm: Allow OSTM driver to reprobe for
    RZ/V2H(P) SoC

 Documentation/devicetree/bindings/timer/renesas,ostm.yaml | 2 ++
 drivers/clocksource/renesas-ostm.c                        | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.34.1


