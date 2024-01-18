Return-Path: <linux-kernel+bounces-30552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5383383205D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 21:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD7A9B22C20
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FC32E63B;
	Thu, 18 Jan 2024 20:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiybzz9/"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614F82E632
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 20:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705608920; cv=none; b=JnAe+kdKwaYolEKkhOkQowvUtEM7Z4CtWHSjjFKQDgISmnjhwXFSlKjhEdevoCwp8tfF5811YtHaHXmrWEDDu6Fe5RHUHeFplWipq2NFkTIxav3UEQrvB7O7borgY6Ts5t4VRo2uIyTT6cMVhxZ19hQ2wJPLzZcBxgQC9sTJQOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705608920; c=relaxed/simple;
	bh=Z0RrZRpUMuxLOuKWgTcTsxPh19ObDHoZHvMKJIVzBDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9QTN4deqH0yUKXXgGHNEPSaIbkI8/XeTTtYZq/o6T8r0xu/HHxc1VDHWFScXHBc0/X1tW6f+ZRA4ztdesTyicYdsQTG6O5f+LWsBDc8KcEbx1FhTq+OADamezkkOVo2M1C1mS/spX28rPAFqMe47Z1GvCfkAZPS444iEdxwvKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiybzz9/; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e913e3f03so311555e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 12:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705608917; x=1706213717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgoCqLAjtOLBlW0wqD1ukPvEv+zciz4buJkSmjcaGcQ=;
        b=aiybzz9/bSVOxoPbfv1fDaoqF2JZuTxsg8w269dwwODV/YAUAk4yMlKL9fopgUrpx0
         UZdPYaomTyb/bcPIVvq1GniJ1oRlh3pye81JOhTrAzoSc8YPnYomfA7Tic9Hp2NxRl6G
         NTlZJRN+arCGcPRlNQronvct4tQQqX2xcJvcOIqsR+hFNnq35R8oliGFyMgYP59vbX/K
         Ilhcn8rRcdbpIbq6rAtD9wrCcdLtQS95GwYuFjhjRD+pYT8sMbRcOnWc7oVt+rjMSU3H
         EL9Bi4kq4OmHtFwetwhIkonU+l5fRmhoRec7PNkftzIV9XiqAoNo7fQdUjnP7gssCCO5
         yeuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705608917; x=1706213717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vgoCqLAjtOLBlW0wqD1ukPvEv+zciz4buJkSmjcaGcQ=;
        b=UlVVSS34ajUaDJmE61CWxbiilhVrSlYEwupCWalW8enqQttePS9Ng+cR++GE7PpEL3
         MmgB0KKW/A3jH0uXfvLH4xQaR9nsniqIAWM6u9g9sQIYuyTc2eTHqFv1DqJzfPZF94yo
         Ho2GXI0i3yJlE1ZRZr3lO/K79ddqSiQBQyvp296ufvAwcnyAibpKuW/EXkXY3rCFSUsA
         YVWCgjxgYkExZv25ejw/Xb4zLvhiM/AJ3/xdBRZrS9jdc5QmDC2fWPBkUFZAK1ggXZ3K
         32ADxQ26ImInezvaUea0AsRS4naeQZGm/93scL5jZ705kY67Epw9l43V2xSNT1Wh4VnC
         FvGQ==
X-Gm-Message-State: AOJu0Yx43mdM+0vgSLYz76bweEmpKUQCjTQhN1bLYFIghbImB97t43JJ
	R9v+/diC/nj2a87R4rIQv2feLegseV9CsR9P5qHlxKRC/fOu0N0w
X-Google-Smtp-Source: AGHT+IHvzeyPaP0kWmjQPs7yrsnHe3htEFAD5GzhQCTK7mjNJrPW9weREVDa1PoUIlK9CVwek3lP0g==
X-Received: by 2002:a05:600c:21ca:b0:40e:69b0:6827 with SMTP id x10-20020a05600c21ca00b0040e69b06827mr932464wmj.132.1705608917322;
        Thu, 18 Jan 2024 12:15:17 -0800 (PST)
Received: from localhost.localdomain (host81-156-206-78.range81-156.btcentralplus.com. [81.156.206.78])
        by smtp.gmail.com with ESMTPSA id l6-20020a7bc346000000b0040d81ca11casm26112842wmj.28.2024.01.18.12.15.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Jan 2024 12:15:16 -0800 (PST)
From: Levi Yun <ppbuk5246@gmail.com>
To: james.morse@arm.com,
	pierre.gondois@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Levi Yun <ppbuk5246@gmail.com>
Subject: [PATCH v2] firmware/arm_sdei: Fix invalid argument to unregister private events.
Date: Thu, 18 Jan 2024 20:15:14 +0000
Message-ID: <20240118201514.81046-1-ppbuk5246@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <29a13c04-f669-a6c3-4693-af7e44469ad2@arm.com>
References: <29a13c04-f669-a6c3-4693-af7e44469ad2@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To unregister private events in device freeze, it should call
cpuhp_remove_state with sdei_hp_state not sdei_entry_point.
otherwise, it seems to fail on cpuhp_cb_check.

Fixes: d2c48b2387eb ("firmware: arm_sdei: Fix sleep from invalid context BUG")
Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
Reviewed-by: James Morse <james.morse@arm.com>
---
Changes:
    v1->v2: add fixes tag and resetting sdei_hp_state

 drivers/firmware/arm_sdei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 285fe7ad490d..3e8051fe8296 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -763,7 +763,7 @@ static int sdei_device_freeze(struct device *dev)
 	int err;

 	/* unregister private events */
-	cpuhp_remove_state(sdei_entry_point);
+	cpuhp_remove_state(sdei_hp_state);

 	err = sdei_unregister_shared();
 	if (err)
--
2.41.0

