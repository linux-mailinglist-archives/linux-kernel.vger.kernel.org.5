Return-Path: <linux-kernel+bounces-44356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1298420B6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88BAA1F2484F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D5060DE0;
	Tue, 30 Jan 2024 10:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BDw/P96U"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F68605DD
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706609245; cv=none; b=mZ1Ec6pNEgn8ltNAkZONRTzt+CJ5wbidiVDX/PpE3cV/gITF9bLPYmfT5Dlxhb2jlh3NG2DAQ0hSDYUAk6HXXi5cX0H4PGYxHn/SzCEdkfQBSbulr+ea1CmVa059CFlH0f6YhrL+c7kWSOc+tOx1C2JTGvBaByvgug+MR84rjqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706609245; c=relaxed/simple;
	bh=yW2DfKHcd6p0j7CmX5W50A9F1EGo3MnKGa/8aarOrQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TJuvssfOzcwYI5PUpGe5F9qgEhq5WqD7HwjCSBQzhX4t9EU9bAv6ati+AIPgesOTpfvD90ykNfTII4j+w3h7iKL7iT4XWmmxWkR7mhw9/7WMox7mIfO3kyvBjFLlysSiJspN6exC5JaE09HGKHY5quGs4y1dFw2LDn2fq1tMfec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BDw/P96U; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a26f73732c5so441820766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 02:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706609239; x=1707214039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MnF8BfQSshY6sgQTgD/NJK8RS69lJg5dZ3KoCaXsRxI=;
        b=BDw/P96UmJrHVBwktsDwNDMH/jLqwSd+4gejoSn0U+rruoyxM4985uyApl0xa/rhCW
         TqPQ2yHHPwDYV7wE56TEj8lamenVWlVfkgZsLGSKfN8yPN3uXv76njSmIt5SzKmhx+1c
         g0fTVsIlsbEXVutSulKeT/7Q8F2yaIxP1S6zPCoLEXVkj9d2yQpRdJPNB5tTzmCr5fYc
         i9KgaYMy7FOD2Og1WGw9dPJchKKW7tRSeWn8BOAMNbOvtvmBxjXd+xQFPamXJUTJcqrq
         9BikuoxwH/hhDSATthSpIsYWH8rJrQcibUDpWXE/OR22taTu5+Jh5fClhqVV1j4sb3J0
         R7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706609239; x=1707214039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MnF8BfQSshY6sgQTgD/NJK8RS69lJg5dZ3KoCaXsRxI=;
        b=cS6EhA5RPZjgyU8tPHrRvzq2CW9Ge3Yf65s6RfcMoyZNX5N7YKQcpI5kqfxT0kNWmk
         CteNZXmfj1MACPz8Ahn0oMF1Vb8I00DgyYiKIO5n5Rt3OY+OcSrG8wnnt0njdJsDoFC/
         hvnRMlyQfBcJQ6JZhdE7XyYeEfz9atJ5OAebIOcICnwbQXeRkHWGPt02YS5GM11xg50G
         y6sjEv/+PZNWXYs6zyxGDHSlezkgmfdf4yxZUlvdv92AcvVCiA+n5HQwiavyFGV3rsLF
         sCep+XQtWojgYut1A94NR2Rvo4lIkHQ0RDB/ZTetbNXQ6eOxTZLGvy2RPunZeBON38gt
         d1kQ==
X-Gm-Message-State: AOJu0YxtnuSq+7JKV6WcTFjFtqCpNA5qJPpE5Nguo2LOh8vyp9+1hpi+
	fvvRhMJ1xwI2a1EBI82nmFgk/SZyVDknPXGlEOlhKyuzlv0WQ130cDS7xOfTSTc=
X-Google-Smtp-Source: AGHT+IGjGHy24m6tONwwrlGCqydGJRVO1w8RsgncAjff3x2AK+xaesgjMgA3AlxAlZ9i9An9ekgAUQ==
X-Received: by 2002:a17:906:5953:b0:a35:7c25:b7c6 with SMTP id g19-20020a170906595300b00a357c25b7c6mr4842806ejr.72.1706609239278;
        Tue, 30 Jan 2024 02:07:19 -0800 (PST)
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906354f00b00a3186c2c254sm4917328eja.213.2024.01.30.02.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 02:07:18 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Michael Walle <michael@walle.cc>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	linux-kernel@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH] nvmem: core: Print error on wrong bits DT property
Date: Tue, 30 Jan 2024 11:07:14 +0100
Message-ID: <20240130100714.223468-1-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The algorithms in nvmem core are built with the constraint that
bit_offset < 8. If bit_offset is greater the results are wrong. Print an
error if the devicetree 'bits' property is outside of the valid range
and abort parsing.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/nvmem/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 980123fb4dde..a9832b5a608e 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -806,6 +806,11 @@ static int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct device_nod
 		if (addr && len == (2 * sizeof(u32))) {
 			info.bit_offset = be32_to_cpup(addr++);
 			info.nbits = be32_to_cpup(addr);
+			if (info.bit_offset >= BITS_PER_BYTE || info.nbits < 1) {
+				dev_err(dev, "nvmem: invalid bits on %pOF\n", child);
+				of_node_put(child);
+				return -EINVAL;
+			}
 		}
 
 		info.np = of_node_get(child);
-- 
2.43.0


