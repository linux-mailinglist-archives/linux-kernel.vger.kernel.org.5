Return-Path: <linux-kernel+bounces-58042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BA484E091
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCBCA28C38E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26D171B48;
	Thu,  8 Feb 2024 12:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbDu/bjn"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D316A029;
	Thu,  8 Feb 2024 12:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707394818; cv=none; b=u0IsJ0s84IRe9bS8fjpP0BKLuFeQfehpN64zhdxESZRigYNHzfnJHqmrQ/IQcYBSZPBgdgiYIsPEbggj7THSR8lBigvIj7pJQpHHzpkXptePnh1zNIj6iy3n9MiemwZfDqz9Xns2cGIMyqeNr6JKEPMjvbqOISH9JsiaH9OgT50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707394818; c=relaxed/simple;
	bh=1/jElOUkOjtycqTK7uBY+Fqg6b2L402KOEq/KFj5Lvw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NX0UUW3PftQp7FZPSIqlgj+XPotr44VpeSdiuanKtR6YIr3dK5aXHMAMVcZMSXf3MZuR1WJ84GdIK5fkTWnHeJfjkauLhLVNwgiIzEopJD3VT1OuiZHjJeKt6oJAjeP0HaLG04KM6PSDD2DSbcN5dxKzY3uQzyi3zQrDk26rIk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbDu/bjn; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-511717231bfso374250e87.2;
        Thu, 08 Feb 2024 04:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707394814; x=1707999614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=72psFLs8Gi+MNEJgx2lwnlswN63/mhrnZDzpSoNcpqc=;
        b=ZbDu/bjnHzI54pLS2rmiI/0zsGt4CAY9+SXrBjF1DAmMbQ+3tSsPlQf8svAmTvZkas
         UzM59oujXfX4pXI4meQUZHz37rHpB6P/BXG/2eecsumx+TsK85QwEn5kcGnhPEcBD0ef
         V6xI+q0sZ29tx4ZxKDVkqalZq05/lq6uvFnaEh/DAZGZFWxBzkSgyVpuP5DbUAci1vy5
         8eRtH2QZcwbqexZvxoAyMlbUE0ODh0oFVWK7fGq0pyDqwMD7dm3TfpObyUXvQaYEk9gS
         1uneRam1tmOsKSuQL2N1xsuu8U5guC3XZvNC/1bfn4CGO12vcIdCcuX0+PzJMpCuk0iF
         Ll8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707394814; x=1707999614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=72psFLs8Gi+MNEJgx2lwnlswN63/mhrnZDzpSoNcpqc=;
        b=L4wzViiKF8y7DQhBPCmJSV1igtgOcUOD9NDt807wMedeF9qxdIe+dddnv9CypDhykT
         dJYJSxLPxy121D1YwGtBAGQggu3XBPVMrURcTI+AH5GFestwHw48g3he3jZLtMSkyqEr
         M0rk412dIjuviecyQw1PeB2T6u09SxV8davDxZQrQcbE51J6P1029seYAQP4ZMWNp/YB
         XUD8Dm8NHU1lEeFaw0MVbfBnXOszTDBSKNyY+WJ8jGZHqY99yRzl8fM2vddZRFsK75HB
         FszBgSTmIqEFikc/2gQyXhk379DX0JiNgl6BMEbsGQbqSSimKVU0t+95km6xb5KoVspE
         ECGA==
X-Gm-Message-State: AOJu0YywJj6odoSqCIJMvQDIni3rcQlI0s+r7h8BuTtl3YO4uDtuRXld
	UDWyCjwfGxIXUEe8+1F04oQ20+eV5FmcpPvxibQhOTYvxfAHbipp
X-Google-Smtp-Source: AGHT+IGicXRwsRzgk7/Ac/cqOV3jVHrfpZad2G3PO9HaODZw8hrKFZ16lSB3JhLAjhZy5MzUc85kLg==
X-Received: by 2002:a05:6512:1ce:b0:511:6f52:9592 with SMTP id f14-20020a05651201ce00b005116f529592mr867243lfp.62.1707394814110;
        Thu, 08 Feb 2024 04:20:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUj10yafoWt1eIWzfE3DFvv66rQwqJhRT1Gjr9TL7+Pt4Uy3nGc0MnTLVQPVAxpcZUeYU95/mgzLBQ63zX9B7ozVyMhU3JsIEMUjm1Rss/BXuinS8M6wqgppfHkWh/gJL/1A6q406YOib8rhQ2X1yTAlECjRturQ5qYaDVI7D5vJGkWMlgt6QvbRtzJYXWR5+m4NBEVyWny0g8dXYVhG5iwczNIJuI1PMtt3+8NoIYtL66/++4lOBkJUPeDy1NMv2QPiR8f+HCoAGh+6bTk++CVeeRWwA3N7Jzyn+zOhAuPuhXfIJ1G2m0gY2J+7+YHR1Ku1HqfXwTdVgX6WCEG97UDvg4E4H0=
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c35d100b0040fdb17e66csm1489447wmq.4.2024.02.08.04.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 04:20:13 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Iyappan Subramanian <iyappan@os.amperecomputing.com>,
	Keyur Chudgar <keyur@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drivers: net: xgene: remove redundant assignment to variable offset
Date: Thu,  8 Feb 2024 12:20:12 +0000
Message-Id: <20240208122012.2597561-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable offset is being initialized with a value that is never
read, it is being re-assigned later on in either path of an if
statement before being used. The initialization is redundant and
can be removed.

Cleans up clang scan build warning:
drivers/net/ethernet/apm/xgene/xgene_enet_cle.c:736:2: warning: Value
stored to 'offset' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/ethernet/apm/xgene/xgene_enet_cle.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_cle.c b/drivers/net/ethernet/apm/xgene/xgene_enet_cle.c
index de5464322311..8f104642897b 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_cle.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_cle.c
@@ -733,7 +733,6 @@ static int xgene_cle_setup_rss(struct xgene_enet_pdata *pdata)
 	u32 offset, val = 0;
 	int i, ret = 0;
 
-	offset = CLE_PORT_OFFSET;
 	for (i = 0; i < cle->parsers; i++) {
 		if (cle->active_parser != PARSER_ALL)
 			offset = cle->active_parser * CLE_PORT_OFFSET;
-- 
2.39.2


