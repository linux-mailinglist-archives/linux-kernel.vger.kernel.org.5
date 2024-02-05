Return-Path: <linux-kernel+bounces-53178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B33A84A1BE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EC9BB227B2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F278047A7B;
	Mon,  5 Feb 2024 18:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYOlBbpI"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A0E47F59;
	Mon,  5 Feb 2024 18:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707156281; cv=none; b=C9jLrfbNh9F1ePIfHAAavCPSz62TDvl0R6df4bvRnudJ26OGlUVbGl3e18RbHN8FK6h0H80rtnGrT8+KN9cXwGRNgNwyUV8kp3SZ0PMm2w6A9rkqtgTVInenWs37RAcpQnEbfi08etWGSjZdoHBIMBR3DVwU8stLS/2EhKoODnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707156281; c=relaxed/simple;
	bh=TMmz9ofcV3Qg3qVRtpdLWdMNQPaRCIuMqEqskELJsXM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=si7N0OdLF38cGoucKGXLamit8FrkoiCevTKNImNWDsgR1ZdxJPwA8DBnXToRk16DvPkBv8s9ma4Pi+OJmwi2Msyf++xJK8sryFUtdPKZwf4NXsopFrUYoNMceqaismsrSCTWMx6FVMSt3v93nLA4jPXB+qqyn/cLx25GHf25Jrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYOlBbpI; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40fb3b5893eso38703345e9.0;
        Mon, 05 Feb 2024 10:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707156278; x=1707761078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HQK/98G9XoX645/LAft2pPXCTjN+BMBYrQ0Nd3/J0IA=;
        b=GYOlBbpIKWSHCKPmAWC0T5QQI7v9ypjxDwjwBXXo3LtkEJKda6vIjva3QRHloDImhe
         suGtwligIbp71TNZUgj36jVOddSTtFTZcPLgO6NnKZm8uDOnWYfRmxTv75vwQEUaSwE7
         PADrZ8SLsJ5ym5uxFl1tUFm2OA99zmEcNFl/jIfkvz1irzQuv4y36zp1Vae5Pa7kEZ03
         HSAR9m6/RyYrm1TqdbX5F4en3fAsnD/xIKIi7vW9nF16Ahog47liJyuUGZhNCIN/THJJ
         VA23R/uK2lSTZPMcMLZllbTeENrPONVTMHL8gVAl33LNPWpbtrWqHrV63FvbpMVK1EmE
         s87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707156278; x=1707761078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HQK/98G9XoX645/LAft2pPXCTjN+BMBYrQ0Nd3/J0IA=;
        b=NIh9J9J0rUgS8XT/gqpQgS+c+HwVXT59guIltTKOgZoZwzp2fQp1zBqAhqZNTPysIW
         cqGEAsdp3jaL7l60S4OF6DDwz4M6Ui/UH1htrwpRNHwzYmqn+0uiDS5Qs/lzINKkobl+
         sXkA6bh0gfy3fMUxC17B+N9W3gU37C7agS2J11d3zlUChrh2Ss/pDjacvwMezjr42WXq
         lghbLkFxdXt9dFROOtATWsZq6fbMc/QZyKZ2q/TzcGsr6hnaZfIDWngYNUnIfoA5DwgQ
         oF02TO3sv5GEADW6XN6MsdDdXdQH6uuI9mDfdNEHtspwnAwfhFcSIQD55aEcBu+5LVLR
         wpig==
X-Gm-Message-State: AOJu0YyPIevo3m01jFvezX5dfk2NXARlfSxcHHP5UVkpeyaOBnx5NxY4
	jO+DvkiphEwCalP0S9Q8IHpwjJGddkyLEVCSQrotvG82qo03XyoTOIn8jAt3
X-Google-Smtp-Source: AGHT+IHUkqH15zC1Bm+thOKzFjaRy3hygMQRxs9HCocH2B2FpfgDEcW4liXDB57ayEwFyUWNqF56Ug==
X-Received: by 2002:a05:600c:3d08:b0:40f:e067:d67e with SMTP id bh8-20020a05600c3d0800b0040fe067d67emr133989wmb.3.1707156277764;
        Mon, 05 Feb 2024 10:04:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXO8zB4b/6jxR/B/RwwFZajC38o+8DiwDup2yUu/xCwFlxEsbK3IR8rE7DQYzHB2htR3WpfkEICsjdb2SKdPe/P0EwpFDGngsZr/qzGcmwnTHiE76fKuHfdcP4kPIV6zke88mlmMoKNDes5HkW06CqkFrGcfT3g+FR0X0ZQbX3mvnENBF8mpBA0+ePKArrETHfbpYegGmCu9GPJ9Y6Ucg==
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b0040e541ddcb1sm549411wms.33.2024.02.05.10.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 10:04:37 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] comedi: remove redundant assignment to variable range
Date: Mon,  5 Feb 2024 18:04:36 +0000
Message-Id: <20240205180436.1841706-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable range is being initialized with a value that is never
read, it is being re-assigned later on. The initialization is
redundant and can be removed.

Cleans up clang scan build warning:
drivers/comedi/drivers/das08.c:180:2: warning: Value stored
to 'range' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/comedi/drivers/das08.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/comedi/drivers/das08.c b/drivers/comedi/drivers/das08.c
index 5d5b9174f88a..49944ce1f813 100644
--- a/drivers/comedi/drivers/das08.c
+++ b/drivers/comedi/drivers/das08.c
@@ -177,7 +177,6 @@ static int das08_ai_insn_read(struct comedi_device *dev,
 	int ret;
 
 	chan = CR_CHAN(insn->chanspec);
-	range = CR_RANGE(insn->chanspec);
 
 	/* clear crap */
 	inb(dev->iobase + DAS08_AI_LSB_REG);
-- 
2.39.2


