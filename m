Return-Path: <linux-kernel+bounces-104174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A19C587CA2A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE6BB1C2245C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543801799F;
	Fri, 15 Mar 2024 08:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCz9L90Y"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F52B1758F;
	Fri, 15 Mar 2024 08:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710492261; cv=none; b=oRayvup99Pg62KWcwaa+qYjCdV6X7qOWDN4w2CLrdQ/tDElEYmirawJhH/hKc85Jg16b4rmP0q8xBVEj2+0Py1tFFo2k0+CUJF+gIY5rFXaH9nsta/1tvBYro6KqgSfQlJaKcGCVEiF3HN8LD748YdUHca7aE/11xvt+hWw4ndk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710492261; c=relaxed/simple;
	bh=eboxEemuoMBpfUMJuSUDq1+5op6MV/iDzeyXPzGFq1E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hq5sezauYII2FDlOysizTllbC3lCBoBWh58ExQI9YQaWGli/Gklp7dpUe2KNR8Vzy45OW6t460/06csusMQFKMqcPqtUXZkdlM9Fe8+45Szs31Sb99NAN/cATDxDNzZnINGDHV0JMpBMANi/Szv7RY5fqi+kc4DLPn1AMch3xfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCz9L90Y; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-413f4b5171dso9781095e9.1;
        Fri, 15 Mar 2024 01:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710492258; x=1711097058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FW3yCpbxBl23teCsezuEGVc6kArdNsNwxBzB8IiZkLY=;
        b=YCz9L90Yo7aQnPImZsyHJh/o6/RNQCAigMu17FlmWDf8xBAXb4c6wXmju2by1INN+4
         I3kQMXHO059zU62foIV+iaoBlzXvlUy2syF4GcwdXBWMX6dwXWJowlAPA185l7SOQGvP
         zM5HfD7lHQ4G64bhcTRaqxX13j236lurwm6cvpLJ178dnibYthjID1fFRJXnGz5zj8ti
         QffXSMylpiIXIQTQn9UWo11K5p1hClvRsQUqVZxO99WDxDDDG9JNMsHZppA4jGmxX/we
         E11Gh/KcrW7e6QEgrlE2YDAy9zW9SWCgB0iJpunng6zoGFBf7V/W7WZwKdAIYe6v6cke
         ltTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710492258; x=1711097058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FW3yCpbxBl23teCsezuEGVc6kArdNsNwxBzB8IiZkLY=;
        b=IiRi7a61YS1MYMBgXST0ve7AE5gEpJDztyyhG+ib8fsqWGORJLDPWFbfp9+3CbgKLY
         T73pCNoVklZQavgbxqv9htQAh+lPgGxBihjxiQzq4FUi/E4MfxOE5vSbXAOKqHKCMHLS
         6vnl5QJsHFOJ4oiztaIUTz52AFsSuhztd6GM6HpgDO1iYgGuNqk+5zJ0uvyTgwbAC+LJ
         /z/Q6D0lanBOp1nDm5tbMg8IIEtDVKlDdtygvj9BeKQaUXA0vrZtGWaZaShKZkjtxGcV
         R9no9Vqpjmh79nIFvi8N1mHIjyvK832nBKMbI9LwmFA0hKiglO3hKx+s9UAL5aVp/U6k
         +V5g==
X-Forwarded-Encrypted: i=1; AJvYcCUx4HtcxEst+0yzVHP9hdRNzeaTldl925sYYT987ZF4ja/bSr+7fvYwX7nq8lALhGQ3wJDaDm8QOn0cuAoESDhDguL0531MD7pY9qCH
X-Gm-Message-State: AOJu0Yw+OLzQ+0WYKLPr9hpn4pbeXd48nEZSnM1OA8EjK6gL1IZLHVaF
	tDDmql4UrReZfx6o/Er9SbsJSwEj2n21VCOgAoYhQtvym4RIi+N3
X-Google-Smtp-Source: AGHT+IFs1KRXUdXWYknTj2c91AcDYkFaQ4sCY76SBCUMRsoLddPMfyaGad3L8TXdLREQJdFUuEKjBw==
X-Received: by 2002:a05:600c:3152:b0:413:1ae3:8dd2 with SMTP id h18-20020a05600c315200b004131ae38dd2mr1758822wmo.37.1710492258179;
        Fri, 15 Mar 2024 01:44:18 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c3b0900b00413ebaf0055sm5074927wms.7.2024.03.15.01.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 01:44:17 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] regmap: maple: Remove second semicolon
Date: Fri, 15 Mar 2024 08:44:17 +0000
Message-Id: <20240315084417.2427797-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a statement with two semicolons. Remove the second one, it
is redundant.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/base/regmap/regcache-maple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regcache-maple.c b/drivers/base/regmap/regcache-maple.c
index 41edd6a430eb..762eb2da70b5 100644
--- a/drivers/base/regmap/regcache-maple.c
+++ b/drivers/base/regmap/regcache-maple.c
@@ -294,7 +294,7 @@ static int regcache_maple_exit(struct regmap *map)
 {
 	struct maple_tree *mt = map->cache;
 	MA_STATE(mas, mt, 0, UINT_MAX);
-	unsigned int *entry;;
+	unsigned int *entry;
 
 	/* if we've already been called then just return */
 	if (!mt)
-- 
2.39.2


