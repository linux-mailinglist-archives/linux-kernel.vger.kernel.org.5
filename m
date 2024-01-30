Return-Path: <linux-kernel+bounces-44793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D16284277D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A211E1F210E3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C4E7CF1B;
	Tue, 30 Jan 2024 15:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="Njl6Vr7N"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A7D811E2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706626984; cv=none; b=q/SsLomWip/j8yfU/xELXAGoYR6gusLLCHMmycEOm5f60Sq/AwUfhHRb+ntCjxZmlNC/llQnvquaShV3NdJVxv5vxIaaOXTV/e+KTiSCewyi2aiuZ/crFsXvVGS8z5bLwNM/ZPwedbNxEWcoDUQ01QtWvCJnMWEwDcxuB0SCQXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706626984; c=relaxed/simple;
	bh=e66UCmOx/jtyr6B4zzKxaiG4yuzE3yyOFRm+iNo6W9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DNDMnNYUhcCGJGwbi+jEGVm6JxE+llomsLxABcw9fAcfLS0VurXd8bfX9199s7oVdh/38AWzJbZDYKP3EZtFUhzl0hYZNNE7L7ZA5sQSIEk5SlwrUzlHApSg3Lb3l6f1dRM6yOVzQQhRDzeS1yudQpviMmhXwgR5qi2qnYG5whQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=Njl6Vr7N; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33af4b34e2cso1011670f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 07:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1706626981; x=1707231781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YqgeOjLTrp275fXzSVIM2wvWsQ14s/UmjFxWLGZ8WQw=;
        b=Njl6Vr7Nnc5i1YdAovMd6Q+tCyghoWem9DEDi1jVCKcevJPhENWi6lM01pvNZU4VZ2
         H8hJYhg++7/iwjORbMA9Q4raTBgeIahHIFtHZYLhmzeKzskw+VP8AEkPPukGgYAERKqR
         4mXe8RmEHMHMGUWcFSMx67MMJy636+qflTJWTr33+KXqC7NWKdByZiLHOloVtl+fG3iZ
         JhsVpmeTNfYIvoyzO2O7cV4C4m+ej+dotmfNPwvQ1VovLRCdYJ6rz/GIvS6LM6+xJsaJ
         NNahtqHZGlp5YwU23LnIoyuKvGxRzyPWnsINu5kHSzmvaK50UlkeoIwO/qmsaQmDnQmp
         rD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706626981; x=1707231781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YqgeOjLTrp275fXzSVIM2wvWsQ14s/UmjFxWLGZ8WQw=;
        b=luFfvKhgnVu0j0iy8fb7DWd8LSk8+cqZrqNcCLpWJZdghVj/clZYxCgXwMcxaLt6Br
         N1VZUPZfZ+GoIBFFqyatxrDNgtbZZXNRTYCHUZa3E8MBtSHU+dskhQjkGq5EPyM4xpAq
         B73FsOSayyClpVZvh9XVLNs6Q8lnTL3exCk5BNc/HjRbF+xBWJjYI+UeyVaxThEUGOcy
         vZ3RF+INXQVz7k7jE3WauRrZgOWZ5z8jfOuTYCsU2sL8hOTj0meAuafIeUOfM2avn5YY
         7lLwZIrr6NEA3N6dXvZ3BpUgzQaaS4jJ8sxDxRrOfa2liqJ3ffrjo4J1N52S2TXopRC9
         Y0Hg==
X-Gm-Message-State: AOJu0YwIDujS9IHtPDM6Yluah8a6Q7JxtqIn0lh/FOIJZDLowLFXIXJ4
	c3GQQtSHVj6UfKnAsdueMAnLpr7iVVcuQXi9a6pdHGWKBF75q5oHaxAvGaS8S7Y=
X-Google-Smtp-Source: AGHT+IFo+3io9ZclStyElATZa5w58n+SAeQR84TgpCIKUN+3SM6EpTEAtZob0myXjD8k4EQcBeqsAg==
X-Received: by 2002:adf:f851:0:b0:336:c79d:7504 with SMTP id d17-20020adff851000000b00336c79d7504mr1933342wrq.2.1706626980965;
        Tue, 30 Jan 2024 07:03:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVgO+p/Ww+pfMBpy2xKoWUuxucwFbV6RFbhYbCrLIxA5rYhv/NFEf8PNNpeSIRgQpgg/SJDagPAhsXgbPd9QWzibhp42mMYNxNFRpGbtx6ZnfOwfRs90nj6agBukBpa2/qrQNpWVBl1Weyof/hUJ4YPHMJEAnQsj7bW4YTDhQrEsD23QhA3jBvOBYGLvKwiHxaDogLmPAvjlFs+HydV
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id u17-20020adff891000000b0033ae55db108sm8395287wrp.20.2024.01.30.07.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 07:03:00 -0800 (PST)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: mazziesaccount@gmail.com,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] regulator (max5970): Fix IRQ handler
Date: Tue, 30 Jan 2024 20:32:56 +0530
Message-ID: <20240130150257.3643657-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrick Rudolph <patrick.rudolph@9elements.com>

The max5970 datasheet gives the impression that IRQ status bits must
be cleared by writing a one to set bits, as those are marked with 'R/C',
however tests showed that a zero must be written.

Fixes an IRQ storm as the interrupt handler actually clears the IRQ
status bits.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
 drivers/regulator/max5970-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/max5970-regulator.c b/drivers/regulator/max5970-regulator.c
index bc88a40a88d4..830a1c4cd705 100644
--- a/drivers/regulator/max5970-regulator.c
+++ b/drivers/regulator/max5970-regulator.c
@@ -392,7 +392,7 @@ static int max597x_regmap_read_clear(struct regmap *map, unsigned int reg,
 		return ret;
 
 	if (*val)
-		return regmap_write(map, reg, *val);
+		return regmap_write(map, reg, 0);
 
 	return 0;
 }

base-commit: 861c0981648f5b64c86fd028ee622096eb7af05a
-- 
2.42.0


