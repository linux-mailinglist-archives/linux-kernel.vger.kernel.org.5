Return-Path: <linux-kernel+bounces-53803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 263BE84A6C7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB1A2B2A573
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF815102F;
	Mon,  5 Feb 2024 19:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4aZGsXu"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8942A51C21;
	Mon,  5 Feb 2024 19:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160396; cv=none; b=TTxocLO+tAytokR2cq7MEUNIyJYmpp0zOdyP4cg8Q403pLahXdlsYvkDZBL8DSOAdo4w0Gg1uBxXnSop4GaCLiiWbQjbQDKkyeZ/zIS6mIPWqiRnB+aWPrlPhzaJpzVfRMgIVraSDSU+HRepgJR2hTcjYrHifstXME6UAKwVgko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160396; c=relaxed/simple;
	bh=lU6gB73tIul6YmK9JZDPM8lDZd0vYWOPoQz8rPmFwPo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Csej/rtHoXbR58BbZfZa45SxOPR06pkl75+fjjRt4+4SWzFcylco6SVlf7kfAWNQSEJHsGQsqDelunl8TCFVxLo09l75Z5l1MoDZjmcjc+Oo4Jo6oMVsGUvIq9/ey+MYQQBYei3RUdWNKP7hBu2w94gHXruOtjxo1qX/iTFw6xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4aZGsXu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40f033c2e30so43285435e9.0;
        Mon, 05 Feb 2024 11:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707160392; x=1707765192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NRol/sNFwmfGsTVDpU7W1gqtEg6dz5qSdXDBnXM1i3E=;
        b=H4aZGsXuIeWoYcIC3zBE1IeFkyidWc0t8AapYRvnSXDY1wTpnDrHSHPLdxyk9AQGE1
         3UPeE1X/GlHqLF7vGDJV7FA1Dd0ZvnoLL96lEhJNXFdOZgCM3X/3yLmmBz/pEkMk3RP2
         dXWKhg7k30fL4Cpb6U9i506wxHkyU43vd+efTqNzl0V2h4UcgPkknR6neXk69Vj0vcsW
         Hrqylc052lFpc1x7bsD2n9clPdXOfN7V4qioLro+UKeMfI1ZPJMeDDZevoSBag7wvRbK
         jlvaEKk4W9oi+0oFdPsiRiJUtjy7gsgq+ghFrAQ6GO/SMhvqXZhTuMuFCNmR9UVaBb7P
         cw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707160392; x=1707765192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NRol/sNFwmfGsTVDpU7W1gqtEg6dz5qSdXDBnXM1i3E=;
        b=QJBpdmvfh2PTmV70f+oi5zRgWsqgj4miDV+seev9oyPq82/dLc6+eK9/jewVXZVAoX
         ebUIlSc7AfTttWuHXx2FbOwFLMCw43cuc7OpYz1cw/3YeDoc/OU42m612eLywXaQb9MT
         8DmSjdVgwSvIIz9fW8WLRoKYFFhLcvQ6weVZuAaup5/LnidK1C0V12IXwazFU1KfheIN
         9puCN661ZdJ1MShCJ1rh1Y5ajgEY2TCjdpPHEcvS4sMVq8l9bC1c+kOVmgEkjBJ3EejR
         2V/YGn5ZzD8LmaVcdRIPNCAnIqfUagnjz681T77OAR13k2mvArHrEgJIOMgesZU22P2z
         BTqQ==
X-Gm-Message-State: AOJu0YzCDhcfa0rLoSC0zklIheI80NSOhWJTlQFDsTThqbvsqNmGDKI4
	Cy020TLcG5QvZF6Mwa6UzsFXNxOpMKqKhxgj5eg+E19WY5ogdnRk
X-Google-Smtp-Source: AGHT+IEWU+P0OgANFuC5OMyILxKQHLwAI/asDetFjqiYPgT8HIxcHu9EBRPQ6ns0MI750TnEII4Ziw==
X-Received: by 2002:a05:600c:4f4e:b0:40f:d3b3:b6c2 with SMTP id m14-20020a05600c4f4e00b0040fd3b3b6c2mr479457wmq.36.1707160392491;
        Mon, 05 Feb 2024 11:13:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWsLBC5LGSyLGHsogO/vbduU2nyomv80c3b+pcrHq4IzVSoDPqs6W5AmEoJzH1oVfysaiGYib8aDTogydQktlkvyrEs5LEkwcEhPRz7dHn3NS0FfXTi1PpVT4Ef2IPzTHJfJBlH6XarZFZ1HRU6DyTEtU/8IvMdSDlIhZnwatLAp1m16Eu2UdNds1ZGDundDpYYrZI9cp5g
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id m41-20020a05600c3b2900b0040fa661ee82sm9575862wms.44.2024.02.05.11.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 11:13:12 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Pierre Ossman <pierre@ossman.eu>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: wbsd: remove redundant assignment to variable id
Date: Mon,  5 Feb 2024 19:13:10 +0000
Message-Id: <20240205191310.1848561-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable id is being initialized with a value that is never
read, it is being re-assigned later on. The initialization is
redundant and can be removed.

Cleans up clang scan build warning:
drivers/mmc/host/wbsd.c:1287:4: warning: Value stored to 'id'
is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/mmc/host/wbsd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
index 001a468bc149..f0562f712d98 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -1284,8 +1284,6 @@ static int wbsd_scan(struct wbsd_host *host)
 			continue;
 
 		for (j = 0; j < ARRAY_SIZE(unlock_codes); j++) {
-			id = 0xFFFF;
-
 			host->config = config_ports[i];
 			host->unlock_code = unlock_codes[j];
 
-- 
2.39.2


