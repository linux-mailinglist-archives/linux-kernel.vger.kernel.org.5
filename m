Return-Path: <linux-kernel+bounces-64620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8E48540F2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07C65B20BD3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3883290C;
	Wed, 14 Feb 2024 00:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyI55Nnc"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720FC7F;
	Wed, 14 Feb 2024 00:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707872069; cv=none; b=o9+0AsWq7Rl9Hm1WPlITM1levEGFmEjNofqJi1pNaL+0np/+6CvLSdNIFTp7qPJVHarLFguE3Qk6Hag+pPYR3jC2lUraF2ZmK7F3MUyubHa3OBQhz16GGhCz7ZmBh6jl6gsxM7koy7FPXSq08kC8dZUKyBKPhMfErE2ju0XTo5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707872069; c=relaxed/simple;
	bh=+MpH6MyUTdWv3FaAVCTooanj1lBPt+xls+adOgFJAzY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QIKLl8dqdEZ+RBsTODcTfyjxa+1Ek+g3FCMQ+DFf8dIWLsqDDWwkz/KKoPbMfs5F+KPLRuTvNVU25ZE33LZyKL+duoPhDYVKVXkGTEOWWD927Byg3AtxDeEX7MAzqIbmUpK7luW3oeHkoDOAfLP5XpEY2/++93WXQeyGSV8+ltI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyI55Nnc; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d8df2edd29so1101739a12.2;
        Tue, 13 Feb 2024 16:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707872067; x=1708476867; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IRAv5G1mvUWjYBsrE0YtysVB4o7+LEIixKnLnZc8qP4=;
        b=EyI55Nnc7AD3sdYkJ73MAVWdWwp8ElI5yuifLCB5c5HyLaE/jIXNNpDp31P16z37uQ
         pvjgBoxnVFPXDVqIuc439C/pub1JorCB1PLdFMNRV8WZpX3PbJzr3Y8p+APar8OXF/9G
         z45jkln8Wb/Xty/7mVzcvhkXozzZCg9u+NBm/IdBsHwFPXnxZ5Rdm4hRYPbNVcJim2Fz
         5jSbXIjJv4Vqb3gIO7eZ46rnGs35mUzJseqIslbV4b61lUNVLQ/dZuJ7deFTkyGp2Lw4
         xMNHhqokcNEMOotlzbaP12mI2ySz3u/XLYiSFN5Hwr3V7RbCl1WLaM7Ma5W85sQkSXem
         gUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707872067; x=1708476867;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IRAv5G1mvUWjYBsrE0YtysVB4o7+LEIixKnLnZc8qP4=;
        b=Y0F/yhIzMPd9dY8sZduOFcsdnD7ab89PXhZE8c4XRS6KoB9N0z3yK9t1w+4cyww9eH
         ujR8cH1uJFnP0XH/nCZLWyD3N5957oZwr5zrzEaYrqtzSHlvN2/9Lkj3XyPXbrIueJAw
         zlnXpNHsDQtPCGpehNBtDpi0zvVooynFv0PtAavD01ghdo6+sxKadEqELvMzYR3SgAkM
         b2K+6J5fsbUkPS+ISVqxJIGF+iOX6wK9Bf9gINbFv7+m4HvgSbv/JTL4xDHyBcgii8cQ
         ooaq/ZrQ433VozICwIj+AvorW0owMT4v8TqVo2mmXNMt3YaCmWAeSLc7NWMO6MV/MboT
         TomQ==
X-Forwarded-Encrypted: i=1; AJvYcCUckiCxdRNF9v7A9Bslq/c7bWC3W3iANEAW72PQW3/xDlNzl0f1MrnQHoWnffzHaxpovh+Pt2P8LOh7iExeOkmYiTSeawo3n7G3rl6421/VsQQ1h8N388v0vtgh83Co/2eEOeoUG+pGxw==
X-Gm-Message-State: AOJu0YzJdrxpHDur86qU4MekMWT320yt/mmh5ERFuymESxifKXN3II1L
	ux1/3yzUlpJHnQMhaaPywtHJbKvFYbG00jkAUwGQX1hFzWiO6Toy
X-Google-Smtp-Source: AGHT+IHMDwwoT3BKADBeEicpLQUF/XmxqD8G8bt1SAgGiBJR+XjDvUYZMi2w90n9bZWA9TQFdxzxSA==
X-Received: by 2002:a05:6a20:bc01:b0:19e:48e9:5052 with SMTP id fw1-20020a056a20bc0100b0019e48e95052mr1098724pzb.22.1707872066763;
        Tue, 13 Feb 2024 16:54:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX+oLq1TSbRAwIsNWJvgzFoXR36Vm7QOY4/URojqtbdaMuz+f3u/duTCMGUylCSr4/nQOJauPk5aCJu819NPbv3FYt2YX+6kV4Nd2OlFoDlpd8WXTUOY0rU2VCkJnJnSaJ1NJ0OfvMJ9YSNfIF5inYHC5cUNj+GVNK0giAb8UoiJ7eeYLUqZCwGdxQdiyJjzuxOsQd0rZkb2Upf8p+px0ziJ/NRfvOAa+QyOt/d+tTaUl1gAABGiuywlbYJkmv7TO0U1gT8JTajajRoTb5AE25GzphwoJbPWlTLiei1yLc7WwTEyxi3FdQFPacLFPLLH1Uf60AJlPd4W76EnR/woSmDnVCVE7IesoIHEhrOER7qz2cAeJEXIJL+PACGGNsC/vQ1Id9dx9t08h2lXQvWtJ86Fm3/vn+9hQrMLQETfbwVGnHtzJmtlAeHw7cfy5Gq/T59Q1QwY57juhSxkUwJzG+OnR979EB6MIvNClPn8qKjOCNwzOcCrYsYOCKN4Gyv2iaQyUWj+lbgIoZ4w8YFjhUztgyuSRuwLr5KtuzbK5n5ggFwZFD0
Received: from tresc054937.tre-sc.gov.br ([2804:c:204:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id q10-20020aa7982a000000b006e094bf05f4sm8005694pfl.213.2024.02.13.16.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 16:54:26 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [PATCH net-next v3 0/3] net: dsa: realtek: support reset
 controller and update docs
Date: Tue, 13 Feb 2024 21:54:14 -0300
Message-Id: <20240213-realtek-reset-v3-0-37837e574713@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADcPzGUC/x2M0QqDMBAEf0XuuYH0rBD6K9KHxK71UNKSCxIQ/
 92jT8PA7B6kKAKlZ3dQwS4q32zS3zqalpg/cPI2J/b88HxnVxC3itWoqC6E6NPMQ0rMZJtfwSz
 t/zdStiCjVXqd5wWUKiYtaQAAAA==
To: Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2247; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=+MpH6MyUTdWv3FaAVCTooanj1lBPt+xls+adOgFJAzY=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBlzA89WGb88ILlID120vimjP3ywfQPNEK9cImoT
 znBvY35E86JATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZcwPPQAKCRC7Edu60Qc7
 VvNvB/9YKsxOUQbfYacjU/vvdQf7EwylJ1tfxEDWTZloC9x0dRrYlr+AxSzy8yiErFx4BeAy32a
 17OhSANqYzoEnwP8VcjnmBfRteKclqD7fDl3ksY1Duo7qGgj7cNwgvZ6fNeJXfL1nyq6swviH7g
 u/a6vmoI0qDgEvN/iCt2fKMU6kP8dyAqx9GiCGg5xCbTn5KV51PpxJaBxPCRIzOgiYEVUmlTLGk
 sO0U8Xciyv5YLkLLAq4CST/XjgZ1Wc5FNJPqM6of+n/FmDV3WyJ4cHY6jzzusdSIfI7a1EJ84R5
 8F0CbQO5ZfiIdHqAapcIZT6jDYKCIKfXNgXaAKeNU/uDFcN2
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

The driver previously supported reset pins using GPIO, but it lacked
support for reset controllers. Although a reset method is generally not
required, the driver fails to detect the switch if the reset was kept
asserted by a previous driver.

This series adds support to reset a Realtek switch using a reset
controller. It also updates the binding documentation to remove the
requirement of a reset method and to add the new reset controller
property.

It was tested on a TL-WR1043ND v1 router (rtl8366rb via SMI).

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---

Changes in v3:
- Rebased on the Realtek DSA driver refactoring (08f627164126)
- Dropped the reset controller example in bindings
- Used %pe in error printing
- Linked to v2: https://lore.kernel.org/r/20231027190910.27044-1-luizluca@gmail.com/

Changes in v2:
- Introduced a dedicated commit for removing the reset-gpios requirement
- Placed binding patches before code changes
- Removed the 'reset-names' property
- Moved the example from the commit message to realtek.yaml
- Split the reset function into _assert/_deassert variants
- Modified reset functions to return a warning instead of a value
- Utilized devm_reset_control_get_optional to prevent failure when the
  reset control is missing
- Used 'true' and 'false' for boolean values
- Removed the CONFIG_RESET_CONTROLLER check as stub methods are
  sufficient when undefined
- Linked to v1: https://lore.kernel.org/r/20231024205805.19314-1-luizluca@gmail.com/

---
Luiz Angelo Daros de Luca (3):
      dt-bindings: net: dsa: realtek: reset-gpios is not required
      dt-bindings: net: dsa: realtek: add reset controller
      net: dsa: realtek: support reset controller

 .../devicetree/bindings/net/dsa/realtek.yaml       |  4 +-
 drivers/net/dsa/realtek/realtek.h                  |  2 +
 drivers/net/dsa/realtek/rtl83xx.c                  | 52 +++++++++++++++++++---
 drivers/net/dsa/realtek/rtl83xx.h                  |  2 +
 4 files changed, 54 insertions(+), 6 deletions(-)
---
base-commit: 0f37666d87d2dea42ec21776c3d562b7cbd71612
change-id: 20240212-realtek-reset-88a0bf25bb22

Best regards,
-- 
Luiz Angelo Daros de Luca <luizluca@gmail.com>


