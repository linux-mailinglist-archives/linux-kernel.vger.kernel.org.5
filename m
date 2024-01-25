Return-Path: <linux-kernel+bounces-39267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C883583CDCF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757DB2940FE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FB81386B4;
	Thu, 25 Jan 2024 20:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bCdgPMNE"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055CC135A5E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 20:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706216043; cv=none; b=W50sHat1BoEsujn6cCgN5fVzvYGF9mqfYprm36tAZDY81d2M9aG+Cv48ha1EhP0gmFlGzherNipJms7pVZTG82PdJFfhdqumL7nGztF6+KJJnK2SlowuSvQY/cLH1Y7BGPAjFlQO/dehbVodNdbOJNf3Y1wKNwqadLcGWkny8Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706216043; c=relaxed/simple;
	bh=qN97QgxcNwazBwy4m/qPZYRkk3uOCPeLawJl4nD8TjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ts7xIi9NTAHlkG76iM+cObjVnm9ROAjz0fWAS0JS7pI/GK25c+hYqdQiXu1YmMH+wDr+ujYP+/azCJOyc5Ipzikqnalp1PxD3pUO5Ap/TZJtH4LI9QUvvfb7FZFMtydTnw8XJR0Q4xoHhlg3yVRrYtY2tDdtpsZ/e0AhGl/+G9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bCdgPMNE; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6dc20b4595bso8105a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 12:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706216039; x=1706820839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lvIwTLoL5N7rudKIDRrhH6OrqM05O1qNoqG8wNNdO00=;
        b=bCdgPMNE+ZHihgKF5O8VhumWqQvzjCGvuqO5u4AfDY8b8cS4x3pNxiu+xelgwvBTBC
         ma7QWs59zYrb07bLkJBk1g/UPeQQpzW1vfJPTkOlAcAy7DnPVl5+fQOdQNXicfDecraK
         Zmk8WPih+dGPulkUY0Lcat/8xQQyJDxtEt46WLTkeulud2rEV6z4j/y5w9knC/frrLgc
         Y0UJY01WtPouGl7cO/U+aEf0F8cc6ve46KXHJB2pHzMwh2y7LWUQWMuLpIA7IrI1d6wD
         YkoCVfCyF3Tew2h2p0Gr3PrfLIab6pzfgvJWQ89L4pIKcls2j56yugFAyTz6EPCzhxLa
         FNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706216039; x=1706820839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lvIwTLoL5N7rudKIDRrhH6OrqM05O1qNoqG8wNNdO00=;
        b=MyV3NdNkIFnq9Zwsgke7tukAJ4gui7y8Ei0rlyztq7pAj8+kmThJ58ioFrUVCemFEK
         9RLKx1lMXh1bDfeRi+IdFiARw807/h6fOJuT1zNb36P2BmOswfSnH7cTADA/hL2WtWUM
         yz4k/Kp0WwFSMvTyt7VEE0Mr88kujTzp/LO+NadItrQVIVTosLrhvy7+cd4zzu8188V4
         +rJLCPPaSXqP7nHmgRPtN8A+mzCLSJLAFh1GcBJtFnTLD+VIr0s/8ZZclpowxO73X0NK
         6f/RdQWLMmaraGz2Ypyc2E/LUxO7DrP93RZl7qnltBklzI3LFBDe92n+c8kQo6V8AqVU
         +pPQ==
X-Gm-Message-State: AOJu0Yywix+2e8EBmFpLp1sPuP70ygmXaDWfJvu7j9pbKa/IkpSgg+pP
	QkFHN7XmYHpD+dwvpLqHS3FIyS94qYNDYwGzzY9j48qfRWG78q7eorFT8fbzRqlCpv/RuxszVjN
	o
X-Google-Smtp-Source: AGHT+IEX0ukIpcEnUJFhXkpQzCgy3jKD4w9AMVGiZ6cP2krtZCMzHGXYgOaFTVjh2qVssO1VsGWagQ==
X-Received: by 2002:a9d:7494:0:b0:6d9:d815:f399 with SMTP id t20-20020a9d7494000000b006d9d815f399mr446661otk.66.1706216039071;
        Thu, 25 Jan 2024 12:53:59 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id v2-20020a056830140200b006e0c65ba0b4sm3108968otp.13.2024.01.25.12.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 12:53:58 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	David Jander <david@protonic.nl>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: fix finalize message on error return
Date: Thu, 25 Jan 2024 14:53:09 -0600
Message-ID: <20240125205312.3458541-2-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In __spi_pump_transfer_message(), the message was not finalized in the
first error return as it is in the other error return paths. Not
finalizing the message could cause anything waiting on the message to
complete to hang forever.

This adds the missing call to spi_finalize_current_message().

Fixes: ae7d2346dc89 ("spi: Don't use the message queue if possible in spi_sync")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

Context:

I just noticed that this was missing while looking at the code, so I didn't
actually hit the error path here.

Also, technically the bug probably existed before the Fixes commit but that
change did some refactoring and moved that particular chunk of code, so that
is the oldest commit where this patch will apply cleanly.

 drivers/spi/spi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 7a70ef47cdf6..4dea33ca50b9 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1717,6 +1717,10 @@ static int __spi_pump_transfer_message(struct spi_controller *ctlr,
 			pm_runtime_put_noidle(ctlr->dev.parent);
 			dev_err(&ctlr->dev, "Failed to power device: %d\n",
 				ret);
+
+			msg->status = ret;
+			spi_finalize_current_message(ctlr);
+
 			return ret;
 		}
 	}
-- 
2.43.0


