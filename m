Return-Path: <linux-kernel+bounces-117078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D240C88A6C3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 733A21F6177A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E0D12BF32;
	Mon, 25 Mar 2024 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lczeu3nz"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD17C12BF0B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711371548; cv=none; b=eFAwZ+CRHEXKZbWC5jXuR1tFwZXTWGor4NoVz9HnfZymmUigxT3c9KrcLJAztxKDbQbn8pYWIuUk6NTKP3a3EwNoHuoeI+SBN1ac5TmIClCbQHZks+5nKfBFZqpiom0JRL0pJGmf35dq6TRrfHZ4wYCwiMePKVD6BTB5NryXaA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711371548; c=relaxed/simple;
	bh=UGGmfelIzmGInaKcWXR5YJ4Klnquo7BW7//4FhAsvTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X7uG6rCQmm43GLZZhBZkXiOkt9zuE6Tp5QzuqsTDJwuBSdnYlBfpr1RPmdI+HmoMHIAyZKLFX61ZZVVC0b2GdgvwxzF7WoZCEeLQNdS/vbcywKiogdD33+145SemUwvqSPn0Zs/i/Spbf4wrMoYpE4GT5RXvKTVH09jz/YBsWKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Lczeu3nz; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5a485724ddaso2595446eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 05:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711371546; x=1711976346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JkyqpDMyqX41cyTaE28OnrvQwkG6qyxUUrve0FvXzho=;
        b=Lczeu3nz4lRBm/2IYw4BYNfW+0V/Q3L5O22z5VLu5uy5pB7EtGgCgbFtDian763eMy
         FhIS8/LjM9UhMCQHH/C0EYK2r7CrTDlir1sG3l5qFuxck2o30lWbD7QjuRf6aTrQgdJ/
         b7KZvohe0DhPmo/iSREFOQbtGla3OJcLQM9Wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711371546; x=1711976346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JkyqpDMyqX41cyTaE28OnrvQwkG6qyxUUrve0FvXzho=;
        b=p50jZzAqMmm1rMqnwA0jYYwU1IVD6uj1Rq4XABQ/Bzy2XzGt7IU85is+SzKJBPxYuv
         94tmF59ebBzCV5SDlnM6MYGrFImYxWBCrLUP/6vQeA1zqs0a/Svotf+biePLNBjHVuFz
         rWWQYfX/2WUoIy0caBCrGDDIO9B4Vs3zpeChWs0+uQcfz4guRJSinsrv5c6MYkQFl9VN
         uthkdvGm9QkQMvbLbQrFvTZRc0ahPMgc+lF1Lf4RTi29lSdp7LpGTNFk3EgrJYjvlgxd
         yIFLI+ueBxszqt9Q8UKWDeVrYnQcZc5dVv16iAuqnet5iAc5ozZAqxx8uLTWj2uSztnW
         33bw==
X-Gm-Message-State: AOJu0YzOFO3mCBQg1twukmxw9bGMxpHPTsLzAMys17fTNBKXhS2PXPZB
	FYVgbXIM0XN14V1EmZXOT2Z2wiRX914RSaXwb/W62ipqlmysnBaTe8Cmq0Axpklcx5rhuGvv/9U
	=
X-Google-Smtp-Source: AGHT+IG0ccGt9Jqagp19yq4VqEubSRZbWD0YyCNpyegF9W/d3KGhEe24YPFxiE9DLu6ni8Ngc5Qg9Q==
X-Received: by 2002:a05:6358:5242:b0:17e:53f9:697e with SMTP id c2-20020a056358524200b0017e53f9697emr7688607rwa.28.1711371545721;
        Mon, 25 Mar 2024 05:59:05 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:c95b:ef24:f1aa:2bcc])
        by smtp.gmail.com with ESMTPSA id i4-20020a63e904000000b005e2b0671987sm5723446pgh.51.2024.03.25.05.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 05:59:05 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: Douglas Anderson <dianders@chromium.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org,
	Hsin-Te Yuan <yuanhsinte@chromium.org>,
	dri-devel@lists.freedesktop.org,
	Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH] drm/panel-edp: Add AUO B120XAN01.0
Date: Mon, 25 Mar 2024 20:58:51 +0800
Message-ID: <20240325125901.2524752-1-treapking@chromium.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the AUO B120XAN01.0 panel.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index c4f851200aa2..1a4a1ffea2c1 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1989,6 +1989,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x639c, &delay_200_500_e50, "B140HAK02.7"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x723c, &delay_200_500_e50, "B140XTN07.2"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x8594, &delay_200_500_e50, "B133UAN01.0"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0xd497, &delay_200_500_e50, "B120XAN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0xf390, &delay_200_500_e50, "B140XTN07.7"),
 
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0607, &delay_200_500_e200, "Unknown"),
-- 
2.44.0.396.g6e790dbe36-goog


