Return-Path: <linux-kernel+bounces-40413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6385983DFC1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D874283601
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39EB225A5;
	Fri, 26 Jan 2024 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B2+25mnh"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BEE22338
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 17:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289366; cv=none; b=vE3wBlcTkNvyK+cJOByMzC77XxzAu2dBcfHkxHepIOdMOpk7PmdTQ3Vw4BTgQ3bVHJzchHf1KzMHOnXz0fqtZdhjSkH1uCxOgM02hXJkz22aENaSpthNv6JxZeduXGUS9phT7mld0hvI/UktmBhfyZWJuBdtu76/qRBHrAWWXJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289366; c=relaxed/simple;
	bh=6rOo14Bz2JZpKcqmwTvyP3kn0DgWf85cl4VWFDXDtLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlCuy+4WNjTN6ocpFw3kKbvjR446dGwAHUU+2iFYRd1brxjkN7AJm0sZWZEhALhXAIo4Nn2VymKIKS08T/915L2d+2veL+1SAjpFrsMERcCGTipKWU7BdQ23wCbTomGMLecnp3m+53hocxiv2VGg1o/7lhYaNCUAwtPTHMk6OXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B2+25mnh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e8fec0968so11079985e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706289361; x=1706894161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFdCZ+E7BFUbmZ2dzvoSTWD6D1fnBZ2RDi/MQ7bu2EU=;
        b=B2+25mnhwv7LvnXiDtp4U/HAV0Dt3LrvYKzqx+d+SKrCpWNP1PxINi/nopRPBfSeIz
         /MDGp7EZZ0+Fr/hfXV3v/2LVlTriaOj7Vjxkkj/ojXxPVyaI1QmtuI8dyNgsgDxVbHlt
         F0BTN83SRmDWbgDvcNJiYrHdrIKnisV4uwdSRBE091wjyJYNLyuFOQ/CBh2s/X6srAHE
         KggJs+eR7JdaPjN37WYp+lH3ildPhOtLFuh2cfwsNDbvQrLeZBK3RxLk94oLHicjBBkj
         mwEx5w2YlE58VTAi0u7h0/a0rr41XN7gpDFjIa+lg0zwLa3OS0VMvzIPBPuWRCTsYwTW
         B1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289361; x=1706894161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFdCZ+E7BFUbmZ2dzvoSTWD6D1fnBZ2RDi/MQ7bu2EU=;
        b=QElHP85HpO2FUrRtAltmlRpMMVwKXpe7nMlDmXzLV62v9OFDAN6Qajg3jsfHJkheSw
         vcdV38puFzqT1fFED6xohyemZcokeU+W+u3NESIXPkgpfLG8bQhyGYhMo4LiVniujLNy
         AkGFd6DE1uNUlFmH48T7r8ryY9nuQA8HsHZ42LN4MwdiUL17fNCvR78d89lzrYKG9uv4
         0oATB/FFIeRziA/UwGl6KTT93+AsY4B0QshGoaZz/PZxdPzFi/CCOAvyLMnQh/scSnOX
         Fmz0pCJBBF9U1r33S3gwrSKmFjRinNqiV8VRCmOADBAIcWFFo1OsXD2YjfV7QvJ7DcsO
         Tkdw==
X-Gm-Message-State: AOJu0YyVCGJfAjtEWKhTc5AnCTkljVZb4lHRjyJA/E3h0+DN+099WIZe
	p0ORtc9MUi3qNa59FS9Rz+ZY4sIYsYFvWig5sl6M+PDwHSwnB7gjjytfg+mzHbs=
X-Google-Smtp-Source: AGHT+IHAdoE7ZY9wf1qj3d+JD3BcLNSbHlFCODLChuw3+wfJAwKowp+5DxpzG8f1Cx3S5gdIKHCLrQ==
X-Received: by 2002:a05:600c:3ca7:b0:40e:62b1:58a5 with SMTP id bg39-20020a05600c3ca700b0040e62b158a5mr90288wmb.15.1706289361429;
        Fri, 26 Jan 2024 09:16:01 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id k10-20020a05600c1c8a00b0040e451fd602sm6287286wms.33.2024.01.26.09.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 09:16:00 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	jassi.brar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 10/17] spi: s3c64xx: propagate the dma_submit_error() error code
Date: Fri, 26 Jan 2024 17:15:38 +0000
Message-ID: <20240126171546.1233172-11-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
References: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DMA submit should just add the dma descriptor to a queue, without firing
it. EIO is misleading and hides what happens in DMA. Propagate the
dma_submit_error() error code, don't overwrite it.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 6268790bbcff..64daf944b245 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -321,7 +321,7 @@ static int prepare_dma(struct s3c64xx_spi_dma_data *dma,
 	ret = dma_submit_error(dma->cookie);
 	if (ret) {
 		dev_err(&sdd->pdev->dev, "DMA submission failed");
-		return -EIO;
+		return ret;
 	}
 
 	dma_async_issue_pending(dma->ch);
-- 
2.43.0.429.g432eaa2c6b-goog


