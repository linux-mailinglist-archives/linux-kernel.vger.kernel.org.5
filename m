Return-Path: <linux-kernel+bounces-112821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6CA887EA7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 20:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14D041C20DBD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 19:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A860DF49;
	Sun, 24 Mar 2024 19:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKElanrZ"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C70D8BFB;
	Sun, 24 Mar 2024 19:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711308035; cv=none; b=gv3yB4RmCivd+vdCFEo4LEuZNxblCZ3h5G7D3+yimI1ZqQWTIu40J4d4x6NX9pdKHdn9a3KTOa1mHPzWkE4Tv1Oypif7sWLr3R6Vnfx1abwOHkPZgcT1j0hT+aBSCwxScFsfBw/xpj3Qv6uzK1U05FGwxNDAajZaRmL77X/dGec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711308035; c=relaxed/simple;
	bh=Er5GBnzVe/KFfP0S3TYugCdKKihnu/L5ghpJinVa9Wc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=plaAo86HgsfblUak+klQYwI6WsQ6WaxqLWKsAAmHe9C8WeS5N6bhLuoOhleU7SyMKgB/qF1ZDaJIE8M6XEGWdCjt8332IwRSOWKjeDMYm5hp1Yw11iTLeqUvMtG0kb9VcjxpoFHwb+/PPmbdB2GoZ00MsJToO++ibB5Jhkf0fYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKElanrZ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a4751063318so74314566b.0;
        Sun, 24 Mar 2024 12:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711308032; x=1711912832; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qp49UxTBiimSI/COLl0XIUAhbu1Qghgrvb01M/mt8ko=;
        b=MKElanrZU0xSYNt0HS2HqBtn176FPDXJEhxBOaJJM4aJecafDpaE08n4W5gQlK9Evy
         NQNNqvFilMyJ7sCSNvrZAVjmFAFO2cc8G43SQdvR9Fy0qnGowUGV3S0R6rrh40LHgB+0
         N/kcu+GK9hn1fDbRsF/oTnJ0dbkLMsCos/C9rBi6srIfbdCU6RYkjCz2ycFqTki+fPXm
         MB+SUrWmRruNqP7M1QLg0TXIdpOVbJyddxvfXH+O41mudiRO8SLsPqxQr7RpAxElz2zx
         BnymImYXfMFTOto+EZjPjzzS6OgMUw4/BfVj5n6tzaIi7MsngHjhxp91cf2cCNi3GmDw
         Uorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711308032; x=1711912832;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qp49UxTBiimSI/COLl0XIUAhbu1Qghgrvb01M/mt8ko=;
        b=vNyf+P39KxBGNl+Whqt+VrewBgR7Lv+Tl5lyErOATNtJAQKPjvQxqwgu/IJ91TzUSZ
         /jWHAfIsZWMLb1Ug3AU95khNK0e2QPJLZyqjxRYRvdiGE92qbwwbLVlHg4admHCwkyOx
         5gIURAbyfsSaILM43L3ygFKu5142pIu3VeOQZZvyZ6JbxPfws+xKurvofhJNn50oHLBk
         hLXKiLe/Q5b7xz7XH5hQUvzKTsckb7V9hB05Ih0cYvXJoB4DI71oNAD+OUtmDHup4L/f
         b4jJnU10tZ/84PW7efNqd8LZ0XfFMlaqU1HGreUodahGYLPDxKFmDl3Webu1PLtNvtF5
         zCEA==
X-Forwarded-Encrypted: i=1; AJvYcCVe6R2GvT6WP0OPQtQ3GPq/VatJr7Kojrm1UcVJTbxX9Rz0wjM2+/2MNMX1Kwgma4qu9YFdDWcnqXxDIj6W1hinGIezQugF7yxoRtvqBIePZ5eDJIvHBRQJmEqCqeRRz+NW0jLOSWBy4w==
X-Gm-Message-State: AOJu0Yz4ZKjvWg1l2R+Laf8LSvRwqcBb5nC/Wh4LdeIChLTbYMuJgx52
	FoBn4k83A+Ko+Ptk+LmDxajtnEMPyuQ1qaCqTpkryAMGBsDhzHfGRQBONDrw9Xoi4Q==
X-Google-Smtp-Source: AGHT+IH2ijDkw5fizP6njqW2wrC6Pq/y1YBbcqSwtAlMR6N/iXuPH7s7dfAKbFjriTUVK3vRbwQntg==
X-Received: by 2002:a17:907:7e9a:b0:a47:a340:c9c1 with SMTP id qb26-20020a1709077e9a00b00a47a340c9c1mr1463975ejc.27.1711308031741;
        Sun, 24 Mar 2024 12:20:31 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-2e5e-f14e-aa7c-2010.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:2e5e:f14e:aa7c:2010])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090639c200b00a471cbc4ddbsm2248205eje.26.2024.03.24.12.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 12:20:31 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v2 0/2] iio: health: max30102: add support for max30101
Date: Sun, 24 Mar 2024 20:20:27 +0100
Message-Id: <20240324-max30101-v2-0-611deb510c97@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPt8AGYC/0XMQQrCMBCF4auUWRuZJDVGV95DukjasR0wTUmkV
 ErvbiyCy//x+FbIlJgyXKsVEs2cOY4l1KGCdnBjT4K70qBQ1ajlWQS3aJQoBXWezMl6Y7SGcp8
 SPXjZqXtTeuD8ium9y7P8rj9EyT8yS4EC0VtNF2Osqm99cPw8tjFAs23bB85tf8SgAAAA
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Matt Ranostay <matt@ranostay.sg>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711308030; l=1456;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=Er5GBnzVe/KFfP0S3TYugCdKKihnu/L5ghpJinVa9Wc=;
 b=QOekeNLty5PyaXvePZ7PhrfSpuv/ToV6tNQo0EWtTjQonCT7BwoCTxwBay6NDy4mlIa8lm5rg
 XArPQVqGRh8DpirWR+DIT6cQ0tbnw+Gy4AqXCtdz+sjbJutM/Wi6cV9
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The Maxim max30101 is the replacement for the max30105, which is no
longer recommended for new designs [1].

The max30101 is described as a pulse oximeter and heart-rate sensor,
as opposed to the max30105, which is described as an optical sensor for
smoke detection applications. In the end, the internal structure is
identical, as well as the register map, voltages and sensitivity. Only
the pinout has changed, which is not relevant for the driver.

A new compatible has been added, but the logic used for the max30105 can
be re-used for the new part.

Link: https://www.analog.com/en/products/max30105.html [1]

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v2:
- dt-bindings: use maxim,max30105 as the fallback compatible for
  maxim,max30101.
- PATCH 1/2: Typo in commit description.
- Link to v1: https://lore.kernel.org/r/20240321-max30101-v1-0-00b83e966824@gmail.com

---
Javier Carrasco (2):
      dt-bindings: iio: health: maxim,max30102: add max30101
      iio: health: max30102: add support for max30101

 .../devicetree/bindings/iio/health/maxim,max30102.yaml       | 12 ++++++++----
 drivers/iio/health/max30102.c                                |  2 ++
 2 files changed, 10 insertions(+), 4 deletions(-)
---
base-commit: 70293240c5ce675a67bfc48f419b093023b862b3
change-id: 20240317-max30101-edbe658b6633

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


