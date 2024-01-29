Return-Path: <linux-kernel+bounces-43222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BEF841114
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1398A281BCE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBAE3F9C1;
	Mon, 29 Jan 2024 17:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yy5o3rc5"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BE53F9C4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550228; cv=none; b=EDkoqeH7nCTZx7SUGjMtFxdrjqWQP/k8ZCzQk79b11pjfKlWyinhyHx9EyTo/6z8Lda7cfLDBL3WUIqsgBQnAygDwngCBLgha4vPnfS2oAzdgvZqMLdQ2le1yZPPq/+mIyBFL5JLejuLMIRkSzrGqorRWDvIvwz25Ef4Qkaccjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550228; c=relaxed/simple;
	bh=ezxaAWnO3x5MlzXMVPde2b8Z5cmfO15kjRpRqQ8IuhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADXEbGuuuVjRCQphj7L1jO9Xnc1Y+jVXgXowQcAF18YuJ09/oD4R4M+aQEV1RfVmcG0gfUwdLyb6T936BWKM9Dfd7j8S5zbeHbc0ApeocT+y0eF5ApMKcwOgwBOjQyU8cITQ0tNTAaQjP9uVrG6jSbUVSVhGPfv81b1r0EUDxi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yy5o3rc5; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e117e0fee8so1167597a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706550225; x=1707155025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cn/LQOeTBFx9zDrBTCXy4pCuw6SR0x8diD/cv0ohb+c=;
        b=yy5o3rc537NVtCklv0xRS8QgfjO+CRRC/TVNtNz7NmB3dlVBWgKx44vqYRYlp3/N/g
         sxCiiIsX0Nel9fYWhfxEV3JqBrJOMYAcRCZtmKEXMSggpu0Dfm9SZUhcps+uhc9eZB95
         Xj5VPBHkO0BzQQZ0eTIt6Thos54yH5I4KO5vZoZhdq9lTkmnCDxRVIpSgWvTW1Xv1494
         taQ9xZ/9IZQlL12XZgApwYp2gE6IGqH5ZNQPAAb88BvwZWNzCsCw1AALHndUoP5It2bj
         IoV26enEx1V/+0SBRKv/bDK1Gj1VgGN5JY6fv8X0495z5j1565/l1cRNWwSmqFMNOP+i
         YrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706550225; x=1707155025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cn/LQOeTBFx9zDrBTCXy4pCuw6SR0x8diD/cv0ohb+c=;
        b=OsV18HCoeApVom3FQjrW9fnpziWD25F4cIALaIKx2XG2MZcw8o3Csn6bthI43DOafP
         WcS56aEziqOD1NvpSRZwm5rz9WiJgwAEo6JMbnwLwX6OcL+Qzsl+br/qyOwh5cznJ0Q7
         z5aZvhdlxaA+KBxqpEZjcihPIHMLya9EdssYWP+DTAkG8WqNZpiNEfb2GQrspcuCN9ms
         fWj6m4eNCoHw3Obj/b1Y0ug7uPdZ5gkCGzyunm8XCHa1qSyMENaVRS97SqOyqGBqkRG8
         uLna8qqw6hNQX9wMc7Z/lPk6+vsj6otlrW6xuMuk9af67RMIX1yP4M97IdFLO8KpmhfB
         bAAQ==
X-Gm-Message-State: AOJu0YwpADBXOxVG47POYus43Hukp2UNL52M37pfjh+wbguUkaXQDj/k
	+KfZtOY3z4GZY00MNpKIvTh3FHycpNLDkPPw06Ui6QykBTKPsr0ezRhFue7qfZI=
X-Google-Smtp-Source: AGHT+IGwnhAee+dC3VpUdH+kLyGQuggTaELH+MHdmM/0AybMffHiQouOgzEPS/xrKJCH8YihXNdfyw==
X-Received: by 2002:a05:6830:2aaa:b0:6e1:377e:c421 with SMTP id s42-20020a0568302aaa00b006e1377ec421mr1355224otu.25.1706550225195;
        Mon, 29 Jan 2024 09:43:45 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id p16-20020a9d6950000000b006e126e4b05esm661334oto.2.2024.01.29.09.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 09:43:44 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 2/2] iio: adc: ad7380: don't use bool in FIELD_PREP
Date: Mon, 29 Jan 2024 11:41:50 -0600
Message-ID: <20240129174150.655088-3-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129174150.655088-1-dlechner@baylibre.com>
References: <20240129174150.655088-1-dlechner@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Although this technically works, it is better to avoid using bool as
a bit value.

Fixes sparse warning:

     drivers/iio/adc/ad7380.c:353:34: sparse: sparse: dubious: x & !y

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401280629.5kknB57C-lkp@intel.com/
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index 44b8b18ab213..a4aa0db47720 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -350,7 +350,8 @@ static int ad7380_init(struct ad7380_state *st)
 	/* select internal or external reference voltage */
 	ret = regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG1,
 				 AD7380_CONFIG1_REFSEL,
-				 FIELD_PREP(AD7380_CONFIG1_REFSEL, !!st->vref));
+				 FIELD_PREP(AD7380_CONFIG1_REFSEL,
+					    st->vref : 1 : 0));
 	if (ret < 0)
 		return ret;
 
-- 
2.43.0


