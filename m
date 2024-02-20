Return-Path: <linux-kernel+bounces-73012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85D885BC18
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30852B21574
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C4C69310;
	Tue, 20 Feb 2024 12:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmnFB2hD"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB52965BDF
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708432100; cv=none; b=I6bSzrf0IFttvhkoXyyQabebk3wd0lCi9K9+Y8f2AfHOp278kZS49/vre8Ot4/86yMzFt27lHSDCXjbYI3VAjAom/Yil9e8EDoqFBK0PEKXVvcKBmgUxAxWevwULdkMG4X9pupo9FpL4fS8zSCMseeFWBhXTa4QqB7CNGL7geOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708432100; c=relaxed/simple;
	bh=wPnG6nFFhE1KXRQew0WPOM+BFz12P1OHBgjn5zkIuBc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CuCerM6njBMtVNVEiAI0w8eAimZcCOBhdb4PiWw+xznwN8lEdlin7gd7ifFGtniR/QCLwMnb+Yqf5kxFYBHwjIPHuxDN9f58nRkoz+fNWQRb9oRy88qXDsgvRlJDKJBdLY2ppJm11dAnWtdNKehiiK8ISoCOs4cgtQFUINz7uZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmnFB2hD; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33ce8cbf465so2616004f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 04:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708432097; x=1709036897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V9qG4b6c5lyMFAiTHXW/5OlVUvW7PY3GsXWkR2Bvbu8=;
        b=WmnFB2hDCEzzxU7yaU0XUigE3oeH4SKRxoR935w4thtKtl0Ui351bpgeuRhA77vlwe
         FY+1JsZj5APoVRMbgKz5DjxU8+chzXN4qT91orsVOdxNh0uNrIZwy/h/+2+FCCOz4Mdu
         2O+XPuYhv+q4hT3HDPWONpthF+eBHFqNZWo/vFt+tVvJvFqsN+X6nKl5xSlWl8OpzOxT
         SuFsM2uKY63xIlagYrm86AVtaFRgnJNOpLWwCZuEQuwU8WN4+FeBd7od3C5n91pGF57s
         gtOb5tr5fknXiM+ty4BTz2GyCkd4Gk1TbUWXB3gkbr3OBQjcJ0CP5G4LMP7OYEmObuiO
         wd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708432097; x=1709036897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V9qG4b6c5lyMFAiTHXW/5OlVUvW7PY3GsXWkR2Bvbu8=;
        b=AgZcSyeCBgZ+ImT+0T1xTcusEO3vWhffwBlzKe6EW2+Tt9k2lPbkg4VmjWrUELKQsU
         MRPCxQCuSF/nJWr2YkAb8qV1Ax8ZCahtYOZyuKK0Vc59g4hwuakDShsgsz4qXhAZuqr/
         yV97vwEjYWL474qKlJTRd5cUHEuh5R57p+LcfBgUIyN8M1bB0YziFqWcveekvswgm8Jg
         XZcmkqj7iAHj4yoZ9iveyYoeayLbstjKOw/RavrRuZx8QJ4aX+ImuQn+/pwRcvM+40pu
         0orhjj/B8Uj5K/0WQJKfRA+7Hs4d+UY89BhmMuA9v14nceCaWp42ZfIRrtLb8ptJEm6D
         Dh3A==
X-Forwarded-Encrypted: i=1; AJvYcCXP8OT/y+0uQBWItXTQCd5UYpEL1gWt19i8/+EH8cEBq16wYGx7i2Oufei8Ib9s+rqerdkEM0MU9UeLet3h+aRrBLm9JY+ZoG2cIRFV
X-Gm-Message-State: AOJu0YzIJmqKv3SP6sOXcnGMAZtB65sEzCsNMCTs9rF2LXsW+w/fV9br
	zgJaNYKpSXcoMi9MAw3kdOycSSfdJ3uwahhMLDqCIrsQHzrpOF82
X-Google-Smtp-Source: AGHT+IG4fgfE9ye3xhSDlApiASY7j0fNVeto1j+SruihzZ4Wnz1CKMuEevC3Y9CnNE4hym+oxXP+hA==
X-Received: by 2002:a05:6000:1143:b0:33d:2071:9b85 with SMTP id d3-20020a056000114300b0033d20719b85mr7553222wrx.19.1708432096738;
        Tue, 20 Feb 2024 04:28:16 -0800 (PST)
Received: from Ubuntu22.myguest.virtualbox.org ([46.121.140.152])
        by smtp.gmail.com with ESMTPSA id co18-20020a0560000a1200b0033d4c3b0beesm7346720wrb.19.2024.02.20.04.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 04:28:16 -0800 (PST)
Received: by Ubuntu22.myguest.virtualbox.org (sSMTP sendmail emulation); Tue, 20 Feb 2024 14:28:13 +0200
From: Meir Elisha <meir6264@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ruan Jinjie <ruanjinjie@huawei.com>,
	Yang Yingliang <yangyingliang@huawei.com>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Meir Elisha <meir6264@gmail.com>
Subject: [PATCH v3] Staging: rtl8723bs: Remove unnecessary braces in rtw_update_ht_cap
Date: Tue, 20 Feb 2024 14:28:02 +0200
Message-Id: <20240220122802.12561-1-meir6264@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove braces from single statement blocks to improve coding style.

Signed-off-by: Meir Elisha <meir6264@gmail.com>
---
Changes in v3: subject and description changed
Changes in v2: none

 drivers/staging/rtl8723bs/core/rtw_mlme.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index b221913733fb..5568215b35bd 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1548,9 +1548,9 @@ void _rtw_join_timeout_handler(struct timer_list *t)
 				int do_join_r;
 
 				do_join_r = rtw_do_join(adapter);
-				if (do_join_r != _SUCCESS) {
+				if (do_join_r != _SUCCESS)
 					continue;
-				}
+
 				break;
 			} else {
 				rtw_indicate_disconnect(adapter);
@@ -2432,9 +2432,8 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
 		return;
 
 	/* maybe needs check if ap supports rx ampdu. */
-	if (!(phtpriv->ampdu_enable) && pregistrypriv->ampdu_enable == 1) {
+	if (!(phtpriv->ampdu_enable) && pregistrypriv->ampdu_enable == 1)
 		phtpriv->ampdu_enable = true;
-	}
 
 	/* check Max Rx A-MPDU Size */
 	len = 0;
-- 
2.34.1


