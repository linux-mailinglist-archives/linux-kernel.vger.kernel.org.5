Return-Path: <linux-kernel+bounces-38768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C27D83C5B0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 049AB2993B4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387A2129A7A;
	Thu, 25 Jan 2024 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TmiF/IpX"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FEF86AD3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194232; cv=none; b=UPeZDQh8Tc7+kM+4UDCQVnyiDfv4Vbb1zTqMg5nbNq5vS9ezTY0yt8RqnfaiW1XR5lPSl40AJgW4BiNODom3GojCNOSfZNv24RgsDSSTJUN3TTCfXuVgv+5rhbYX2M03AQ8L0dyY4bQB3duGC0ZMUdPo44GccYnE92uh+pd0MvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194232; c=relaxed/simple;
	bh=ky++lUpjV2xM2yr5R8NgpgcPYQ2XfXR8n2IS4sf5ezM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvV2+o4f02D882icPa0xWt3ppPgNQEInJNdZJ/sqIR7Y4RkLYxJvAGsvk9v5GcIPmFD9IQM6P4J6kJCkC113H67PUerjTTXjXyCWLlaAvfCv1hOy0jMcrZrhpjcGdxU6ea+HjM8rw4iwjh5CxBK/5c0aEOGKCrsang3NJbjZXnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TmiF/IpX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40eb033c1b0so50900435e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 06:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706194227; x=1706799027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCsZDfh5Q5K/DwuAunrdWzuUCnvHISTW4ss32NHF9x0=;
        b=TmiF/IpX82/+fZtReS65al6nyoIPbF+9gOTJy/uf03WRKAwroyl+mHFPkd/bcZElIU
         vq1eurdLj7biNPfJyDPcFk0LkZjHSmDaQUOQdWqjx//IkDIkv7dHghniA5wI3XotMKpM
         SP/cOW6ABt91oyFYWYl/zABPiIHMvUEx4OAzT90oSz0QzZ+tSybNi25VtbG0vhBGUdT3
         KyDe7QDzHNdS13owh9M39+nRsY6EdsOQ0HnWaB+3gJDvxJ7T8GtjpIQXiv+9I9UoDmUC
         7gw20vQi2Z46I8a08zYcf2aR52zuFsUvaiBBNFfLPWJn81oKVbY+bIUIymjaJVDXI/1O
         YZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194227; x=1706799027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCsZDfh5Q5K/DwuAunrdWzuUCnvHISTW4ss32NHF9x0=;
        b=Oz6sv9U9HY0L3940FrXtCmPEW5L85xIfvxqAMieMwNsUp236FprKsyF7LGuVXaSCEU
         zSVu0rEzMKhZSewbmskP8sL+Pvjy3g5aqXe2F3MSZlrmcHFeG8uF/lNBysnp+ajsdfAv
         DTvEHKhveJZJGXZjMwDg/522c+AP0zNKYq/Uunzac4y3m32teI59JSzjbEGQHASFIjO2
         1XMUNV3hWieSElCVD/mpMEvpqlNKtsYIFTvFGTp7TzpMtwGiqsISn4vilp9T2iEu/zZV
         Oouk+UgZiwG+wyM2V/Tj4Op31cRhXpFU2SuD/nWG6ugbrF990tK4XOe7JdtXiEvD/2Ns
         aF9g==
X-Gm-Message-State: AOJu0YyAtU+gb3O++6kuDZesia3c8+ff3ct32Gq8EoQ8GseX68A5Gt51
	YJWgIRgF42OnKlWqog+KFLhoW0jzAxEpX7Cwj7tr41TD1FKpxkJkq91nr3KNx10=
X-Google-Smtp-Source: AGHT+IGh12BcHV/dAPX9rARaa3uM3thpkF0/DbdSBRI+KmJZrJjj10wwGpQaaYX5IgM25eGiIJcLTg==
X-Received: by 2002:a05:600c:418a:b0:40e:4ac1:8609 with SMTP id p10-20020a05600c418a00b0040e4ac18609mr575275wmh.86.1706194227540;
        Thu, 25 Jan 2024 06:50:27 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c471100b0040d91fa270fsm2875875wmo.36.2024.01.25.06.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:50:26 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	arnd@arndb.de
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 19/28] spi: s3c64xx: downgrade dev_warn to dev_dbg for optional dt props
Date: Thu, 25 Jan 2024 14:49:57 +0000
Message-ID: <20240125145007.748295-20-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240125145007.748295-1-tudor.ambarus@linaro.org>
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"samsung,spi-src-clk" and "num-cs" are optional dt properties. Downgrade
the message from warning to debug message.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 692ccb7828f8..fc5fffc019e0 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1071,14 +1071,14 @@ static struct s3c64xx_spi_info *s3c64xx_spi_parse_dt(struct device *dev)
 		return ERR_PTR(-ENOMEM);
 
 	if (of_property_read_u32(dev->of_node, "samsung,spi-src-clk", &temp)) {
-		dev_warn(dev, "spi bus clock parent not specified, using clock at index 0 as parent\n");
+		dev_dbg(dev, "spi bus clock parent not specified, using clock at index 0 as parent\n");
 		sci->src_clk_nr = 0;
 	} else {
 		sci->src_clk_nr = temp;
 	}
 
 	if (of_property_read_u32(dev->of_node, "num-cs", &temp)) {
-		dev_warn(dev, "number of chip select lines not specified, assuming 1 chip select line\n");
+		dev_dbg(dev, "number of chip select lines not specified, assuming 1 chip select line\n");
 		sci->num_cs = 1;
 	} else {
 		sci->num_cs = temp;
-- 
2.43.0.429.g432eaa2c6b-goog


