Return-Path: <linux-kernel+bounces-18682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB46B8260F0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 18:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FACBB21F1A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 17:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A5DC8F1;
	Sat,  6 Jan 2024 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFRQNNBv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B525C8C2;
	Sat,  6 Jan 2024 17:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-783148737d5so45395485a.2;
        Sat, 06 Jan 2024 09:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704563378; x=1705168178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VZSWVN0PX0qipG2eeREqz27T7a+T8ixFO0e0uD2k7ds=;
        b=LFRQNNBv3yKsM+vQiwKJLwgLrvpjsYRzV8b5LnXQFDsmumDVk+O6bo0HkEPKaa93Er
         ZJWBs5TkNs0pmFeG0nvyR0mjCAfiGEMu+NS7bSCsTsxteU1GbX/6lgjTtQzum1noCVNY
         OPchu49zYVEia15c6jYtXz2v7S9ItRaJvdLf/l/o6xkxp3FAGXwtEh5WdJH2uH9mIp74
         qEacWJi5DQr9R4CcQQH19BZ70oHtxy/6AeNpF+n5TWFytmUa0iMAIOEFzsrqLdqapjHk
         lvSVNAm19WgDk95V4fH1aS34Q3wU/EMmAdvmDYuagza9/zCpNiEuLJqEDqAscyy0R+bj
         73AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704563378; x=1705168178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZSWVN0PX0qipG2eeREqz27T7a+T8ixFO0e0uD2k7ds=;
        b=ImgOrHNHbGYBhaWtN7FV3Cc28fwRhi7iHW66tTrcHW0bRuKEjV8GtoUQ8gsTnMZMau
         hfy3C4A8e88S5NUx8jhfLrS/xdC7ePUwj3eErCy/2LLLDB6Mmtc3eDEWU6EJyrigyQ9P
         ApvH6hxrHhJP0LCDaPvv/NBmcJjmMSLrcPqMnjqeWPgBteeljZveJLBHJMN7mjfjLQju
         JUCk1+SCBvxT2699ovOwjC5GklOzgO1OG7uX9AB15JJKKs0kPDi91nHlOPfmlkZ4n/4o
         eaQam8i4ya3zvBsJK3ma5LkskCRhIFn2e0bv/HeWyewsaEvp3Xbtv9+W0eUzIZtNbOLl
         I8Zg==
X-Gm-Message-State: AOJu0YyS26WL3gOAK7+Hr/0VXTEOShjgmEfhRrrM+VwCwO32s4CFjjDN
	v1Jsib+v1ixRu59aSSuqywk=
X-Google-Smtp-Source: AGHT+IFZYT+nBzHpJnIS8y+SKJAUcvpWotPQbuKdyZKbNGqcUMJugMO3mMse0WpiuoWwba1Fv0zMXQ==
X-Received: by 2002:a05:620a:1207:b0:783:12e4:2c1c with SMTP id u7-20020a05620a120700b0078312e42c1cmr1135156qkj.72.1704563378282;
        Sat, 06 Jan 2024 09:49:38 -0800 (PST)
Received: from system76-pc.lan (pool-108-53-73-136.nwrknj.fios.verizon.net. [108.53.73.136])
        by smtp.gmail.com with ESMTPSA id t7-20020a05620a450700b00781b8f4c89asm1453328qkp.43.2024.01.06.09.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 09:49:38 -0800 (PST)
From: Mohammed Billoo <mab.kernel@gmail.com>
To: mab.kernel@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Marek Vasut <marex@denx.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: ti-ads1015: Use correct pga upper bound
Date: Sat,  6 Jan 2024 12:48:35 -0500
Message-Id: <20240106174836.1086714-1-mab.kernel@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The devicetree binding and datasheets (for both the ADS1015 and
ADS1115) show that the PGA index should have a maximum value of 5,
and not 6.

Signed-off-by: Mohammed Billoo <mab.kernel@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 6799ea49dbc7..6ae967e4d8fa 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -925,7 +925,7 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
 
 		if (!fwnode_property_read_u32(node, "ti,gain", &pval)) {
 			pga = pval;
-			if (pga > 6) {
+			if (pga > 5) {
 				dev_err(dev, "invalid gain on %pfw\n", node);
 				fwnode_handle_put(node);
 				return -EINVAL;
-- 
2.34.1


