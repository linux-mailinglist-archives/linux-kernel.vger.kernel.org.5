Return-Path: <linux-kernel+bounces-68736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEED857F31
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16F531F22CDA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2742C12D765;
	Fri, 16 Feb 2024 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnVHDil6"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06CB12CD9D;
	Fri, 16 Feb 2024 14:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708093344; cv=none; b=FstLRN13t1o6KxQTJl/zEsB8Jx1x/EGY7U916JKFXxZOT7RiJBDncjgDp5T169a8lZNlzz51kPozDaXHc/AlUr/n0iHny9hu0EcCcKhxsqcuH5wUyFEEe9l5kwOpxCg3OHg0J9WDnIAITpj33RuCtRqyDJ1tr73ZHTPkTfNgO7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708093344; c=relaxed/simple;
	bh=Jxj3rEgbRGxw92wdoI8uuWjtJV70UO5s7O6AnHrXyAI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=MvJm7oTfmnwXhAeewEAsZW01QZfDO7pR5WF7q8Z8EjjTHMKNeqXAqVTvEIzqGy1m2DqbrYAFtvdKkHhm08GznEwns6jo4V2ROjZFMquL/KgjBNmcyONrWSLdC7pRX2OCQaRoDsb0/3SujiV+tnBHgO4EpayJT0f/PP6SZMRcAyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnVHDil6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4124d8f9915so3440485e9.2;
        Fri, 16 Feb 2024 06:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708093341; x=1708698141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PkdihLM6sVisVEtGKLuR9LEB3QNDRr4gR8bv8gV+fJ8=;
        b=JnVHDil6RzrWjiTyd/CYgEkf6v5l/ESlEtVoW1VHN74mQIUtg4KxHW/f6LkicBLrFw
         q/Dz8pxtVYJFidByzWeph4fRxHIN9PiNXV423OB7opkRQ8lJ4RvSIqIw9HJKafb/NmA+
         n1jfldhB6V9ocf5+/OIaDrPORGE16gQ7Sd/0gjP18kEnevsLwaAT9pVDjtgDer5lDSpa
         oMfG/zt4dfDgcMeB/00VynKoNxn/1lhBnV+Y0Xrba76dkk/aQ7krkBT9QL12u6go82II
         +qhjQJ/GC5ADugWjIYC9S06QSlzzhLZU/dxowZdF2wvBciX4Cpo8eAMDKKgfZ3O/q6U8
         yu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708093341; x=1708698141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PkdihLM6sVisVEtGKLuR9LEB3QNDRr4gR8bv8gV+fJ8=;
        b=joUR5N7rPk7gQh+4tyY/KpmJUkYgcA3KCbww3WHVFEjYd9QCFKmVePvGgjVkCkfEWA
         u9B/en8HQqRJMgsNZwtH1xL4ZqFW4GhGuAXLRH7GSvM6pgbi9xVAlooiak2PYW3iQyvr
         5J6cb0gB7Drkcrkv2cQLe4JpX5qoWKxw7OM+Y+pS8guz+zffgngo35+Jlc5WHoTJNeC5
         w3VpC26NWtgRy8q4JkPJy59SHG2y2tSK9fflZ1KPbs+XxmRX8nNMoMdf2baOujq/WCaC
         lJ2PyYyUnllk7COys2sVaqStgfhcYGNqUK47UrtAq+j+79Jy5zkJ90w4iKzE3W4yLgXt
         sbmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk6+AR/27LWuDhvrxEbuPAx/uebBq29Lq1lVCAuFjVhiiqgIbSge7igpCvz0WeK2Q+Bq+2WROyw9WnaKgx/K45v+JpPErv4Faqz8ZFUSdO2DKnWcC44hBhGrdeS45Ao+iIeP0Z+4COOLc=
X-Gm-Message-State: AOJu0Yx4EI61zBNYfZkM2XH51/t1hBSLRkguQi3XgYYLAT8gsMp+I4Q8
	Vuyle6xlT8EoAIQ/MTYGt2ef98pIDtN74iGZNnZDyTQ/x1PEBlpf
X-Google-Smtp-Source: AGHT+IHOPnOdjbMecgSAGifiPTVWd6xucSnzV0OTR3oaD+sN5wb2N9fYMluVi1eXv8uJwOW1grT2vw==
X-Received: by 2002:a05:600c:1f81:b0:410:4a4:6cd0 with SMTP id je1-20020a05600c1f8100b0041004a46cd0mr3825241wmb.33.1708093340832;
        Fri, 16 Feb 2024 06:22:20 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id j11-20020adff54b000000b0033b43a5f53csm2312969wrp.103.2024.02.16.06.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 06:22:20 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: tas2781: Remove redundant initialization of pointer 'data'
Date: Fri, 16 Feb 2024 14:22:19 +0000
Message-Id: <20240216142219.2109050-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The pointer 'data' being initialized with a value that is never read, it
is being re-assigned inside a while-loop. The initialization is redundant
and can be removed.

Cleans up clang scan build warning
sound/soc/codecs/tas2781-fmwlib.c:1534:17: warning: Value stored to
'data' during its initialization is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/codecs/tas2781-fmwlib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2781-fmwlib.c b/sound/soc/codecs/tas2781-fmwlib.c
index 85e14ff61769..45760fe19523 100644
--- a/sound/soc/codecs/tas2781-fmwlib.c
+++ b/sound/soc/codecs/tas2781-fmwlib.c
@@ -1531,7 +1531,7 @@ static int tasdev_load_blk(struct tasdevice_priv *tas_priv,
 	unsigned int sleep_time;
 	unsigned int len;
 	unsigned int nr_cmds;
-	unsigned char *data = block->data;
+	unsigned char *data;
 	unsigned char crc_chksum = 0;
 	unsigned char offset;
 	unsigned char book;
-- 
2.39.2


