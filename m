Return-Path: <linux-kernel+bounces-159411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E45F8B2E48
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38E81F22629
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 01:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D6315A8;
	Fri, 26 Apr 2024 01:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="qohgE+dZ"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82185184D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 01:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714094660; cv=none; b=AESuuyhmBCq7ZeppgT7z2mQkYzgSVyxaAm8eXsuRmn6WMFmuethZdgNXCtZuHG91N5sI6Fm2gqMDeCO/k+QGJamShtQuNYsfcAMxCxl/FqAxVQrZ5CkaCYeUxp7+POeG1HxhNAmEKkym5B1KmjQ/okJjgFenkLwwFIUhdHGEkxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714094660; c=relaxed/simple;
	bh=dZWiA2Ve5wwLdM4H6cElVHbi4Ey09vnby20FDRH/V9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g/twxDGe/6LgN+q0arFZyXxVAMH4VfWUQI1jy4XAgnIOsI0k/N2C26eI7pH09Qp4gyortNYPogV5wnlRJV8N4oNkRlakonmfF42p/dC0L4GhjJLnjlWSW+qZ//HCblwdr/Q8YH8xFoXIlzvLR8zmD0/clzc2e5dzcmr1qFCVlL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=qohgE+dZ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2a58209b159so1389502a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 18:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1714094658; x=1714699458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XTXjNi5Gsgixf7+CF9tdY9WwNZpzvpF4TetBpKpSXk=;
        b=qohgE+dZib+J2Ep8DN9oPtAfQhBcQXzNvvjNBVzNStQVRWm4gnZNqQZsRTGBO746sO
         DonPN0eDv07Pmx0HTQNz0FIKt2JQGXyfrwbY5J1iyw1bU8stnUcm0jZ5ZBO5s34UD0rW
         k6Lut9RWUOBuopKgUkSQ++X6yQAdJOOhoIGs1GL2XY9Z/n+nTk29kN+QMjxjpevE4SO7
         ha3UZOn9XcU9kQ1yzv63HeXa7DuykEkuKnCXcz2/gfxyx4TIWeppMDUy6aOgYc3HMgeu
         WD6jTNwvogcISZUBX5Qh2JbWhJRHCY9CElVLD4Uidq1JVwz4xeVHqE4GIhYd2dpbfxpA
         egCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714094658; x=1714699458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4XTXjNi5Gsgixf7+CF9tdY9WwNZpzvpF4TetBpKpSXk=;
        b=QUCrIpZnndUZC7uLyN4EJVU2jLFWunyBCt94balFzOB+W6mn2cXoBUJnQUUeclWGn0
         8vNEfVJkClEUQtCjqTpwO2oLSD5kJubgJNN2A/et/6fbrq5+ph1JzWRlU1dgebsfuw8m
         5Q9nHe/5GVoL9p77turduivWXMuSsynfycx4ONHgLCVthnpiW8PsLT3eDeAr9CVBuEL1
         0BEy+96AxDMpR85ZOpyd0XQuoVU6zhc5Gti8XeqJCQxj8SJSgi/pO9Ctg4Ka8MrPeIaS
         7MjeX4KePa8Aj4DoCA/HXVb6ODuKrmFEC/Hm6pg70m4o6U93YE8bOXTaIw9S36OAY3Xq
         qv8w==
X-Forwarded-Encrypted: i=1; AJvYcCUG8y/mNj/h1YbSOcmB69OcJH84MoyjscxNdofSeWhOky1VqlrbyCfR/fZd9QzrGCFOXpyv8NorhbFpCEJ1LiNRhmGez6SafS1kIqiq
X-Gm-Message-State: AOJu0YwFoD0NTjecfPH3SS8sgSdbF2qWD3QhLyYWUehTcEdXsS/Wh2jd
	yV+1xc+dTnv8wiyDKOvED+0QsXAssrHc9mmKc9+1JzA9oS062H9B0X8qEjnRtH0=
X-Google-Smtp-Source: AGHT+IH/brXLbpspcT58oxUEUY0gzcfLVnFrX2PcsjzI336kgn1k36NMQPQvvQoYXnnJkDlqar5k6w==
X-Received: by 2002:a17:90a:a50c:b0:2af:893a:4962 with SMTP id a12-20020a17090aa50c00b002af893a4962mr1313308pjq.10.1714094657911;
        Thu, 25 Apr 2024 18:24:17 -0700 (PDT)
Received: from ASUSLaptop-X513EAN.. ([2804:14c:81:903a:9968:e871:2529:9bcd])
        by smtp.gmail.com with ESMTPSA id p8-20020a17090a930800b002a513cc466esm15294305pjo.45.2024.04.25.18.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 18:24:17 -0700 (PDT)
From: Gustavo <ogustavo@usp.br>
X-Google-Original-From: Gustavo <gustavenrique01@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: Gustavo <gustavenrique01@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bruna Lopes <brunaafl@usp.br>
Subject: [PATCH 1/3] iio: adc: ad799x: change 'unsigned' to 'unsigned int' declaration
Date: Thu, 25 Apr 2024 22:23:11 -0300
Message-Id: <20240426012313.2295067-2-gustavenrique01@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426012313.2295067-1-gustavenrique01@gmail.com>
References: <20240426012313.2295067-1-gustavenrique01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prefer 'unsigned int' instead of bare use of 'unsigned' declarations to
to improve code readbility.

Co-developed-by: Bruna Lopes <brunaafl@usp.br>
Signed-off-by: Bruna Lopes <brunaafl@usp.br>
Signed-off-by: Gustavo <gustavenrique01@gmail.com>
---
 drivers/iio/adc/ad799x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index b757cc45c4de..3040575793a2 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -128,7 +128,7 @@ struct ad799x_state {
 	struct regulator		*vref;
 	/* lock to protect against multiple access to the device */
 	struct mutex			lock;
-	unsigned			id;
+	unsigned int			id;
 	u16				config;
 
 	u8				*rx_buf;
@@ -253,7 +253,7 @@ static int ad799x_update_scan_mode(struct iio_dev *indio_dev,
 	}
 }
 
-static int ad799x_scan_direct(struct ad799x_state *st, unsigned ch)
+static int ad799x_scan_direct(struct ad799x_state *st, unsigned int ch)
 {
 	u8 cmd;
 
-- 
2.34.1


