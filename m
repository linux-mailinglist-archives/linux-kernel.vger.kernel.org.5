Return-Path: <linux-kernel+bounces-82697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B8E868857
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19C7E28709F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2375465B;
	Tue, 27 Feb 2024 04:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="bmU5wcGR"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A474D5646C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709008941; cv=none; b=AnD+r4C4TNf0MGkm1wHo0+lteO4EFhr7uFLrwSPCAezjFx2aJIPJlKGOMpHhqzJUNZYVR5s7eWQB20b1U/9BUx5PWOLi1t+kKtTfHVBThCB4kStisqlfSc/QIqN+6Ltk/y1rlVeADZoC1wdk0UnaSfw8VZ8Ne8SpJJzjOq6PfB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709008941; c=relaxed/simple;
	bh=2GdfiNtXfqkf0sPRRn4zSuegaebDi7tmfMKdY890X6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MURE0szOVljfN8Dw7YfJDzrkQprkuZJxDI0r2J8yNBThbJ3TFin/90FClZOzaJAsm5OwO37UniWMqs2J98EGT5d3gnkA5WOYeLmtEJh0tA2ccdFs0BXEmgr2wIcXKFYIuEsabGiAmzcoc9bujESQBDrK8rUURzzcEDiZvGbJlW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=bmU5wcGR; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c19937913fso2034091b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 20:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1709008939; x=1709613739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQ70orEx9Z7FVR/JUHIaH19uQdZyExB+1mSBQCRAEpQ=;
        b=bmU5wcGRsFtMWU5pDOgUMw+OBjzIH9kA1aw3/VIfBSKgjFBL8HyWMywt8+CiWlJ2Ap
         UZizBklcXW4KhVoCmZyDhLTKncC85ICsURje18b2pNnygk8IanVod5NnvfRgDjGNFDc2
         tsvgYsBptjzhaX1VC52cLJmA3JmoA/LWufJjVyY0CxTAiJRUXRMyYaLtkqtSO38a+Nzl
         qJPdZyXFlYmcs8k+w621D2VljUUDeXPXXYeoaaAXiT2OPsyoEuYlXwrfaPTJlcKOd+66
         COftvnOygXWFRusW578Fwfal9RxpueC4gGsQsAukfsKS5sUjKxkylIUjtWtYmSPzjGLY
         VqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709008939; x=1709613739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQ70orEx9Z7FVR/JUHIaH19uQdZyExB+1mSBQCRAEpQ=;
        b=qHFCNrs2v0eUv7CtfhxuCAQdb1iNUd5Hr4hvoALL0BvS9hY/qWoBaD7KlGKo0ia13X
         em39PkubYXT/qcGOdnzqjWEh01WytaKysiqdoQc9Eo7lMHeEU4gCwWxdmTJEwfg71ApJ
         R8gLxvPtzSwPpqKkNdBiF+43dwJZKGplLP/wK9klFfOSQEuKcT2HeTxg5ksQgs1JgGIj
         f4RGHa/D1L7U5e0DaJ6DZAjAEYUeetDXaiW4UggM8zzgulgOK+ExTmj/wsxe2r8huL/A
         8PxM9KUDHQVRm6HeDkntQHZmfRkRxbvleuEWK0u4UD1OoX6TzFy+jPQGJ5zQHdDZ122p
         XbkA==
X-Forwarded-Encrypted: i=1; AJvYcCVRm8e0so4B2O4c/QZQeTN1wckIzEeoWdJ0hF3CWQdV1n39HqSXE/UMsaArj9rF/T/DlOC2WMdynbVHTiSWSCGjwykLe7G01eYSUrmj
X-Gm-Message-State: AOJu0YyUAGdtZSZexCHjiQ5HrdKVy0GWqiNwm4CN4eD+v8zggmXN3WRi
	uBPQKKANuUU2ZYJY6mlVY0HZM3GDpUqmYUUyJghaYpIbLQFqOqzqDpgsrXPoEWw=
X-Google-Smtp-Source: AGHT+IFiTQnqSujC0nm1N1BTmJRntQKj0QrjE/2oRoJ+l6JCNbiiWNAp3FMF1QNz4FzPJ4iLLIIH1w==
X-Received: by 2002:a05:6808:1508:b0:3c1:b099:d4d9 with SMTP id u8-20020a056808150800b003c1b099d4d9mr48040oiw.12.1709008938954;
        Mon, 26 Feb 2024 20:42:18 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id e30-20020aa798de000000b006e4ecc3e394sm4899782pfm.79.2024.02.26.20.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 20:42:18 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 15/20] Staging: rtl8192e: Rename variable CcxAironetBuf
Date: Mon, 26 Feb 2024 20:41:52 -0800
Message-Id: <20240227044157.407379-16-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227044157.407379-1-tdavies@darkphysics.net>
References: <20240227044157.407379-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable CcxAironetBuf to ccx_aironet_buf to fix checkpatch warning
Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: no changes
 drivers/staging/rtl8192e/rtllib_softmac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 0907bee45dbf..51fa9db7d73c 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -819,12 +819,12 @@ rtllib_association_req(struct rtllib_network *beacon,
 
 	if (beacon->ckip_supported) {
 		static const u8 aironet_ie_oui[] = {0x00, 0x01, 0x66};
-		u8	CcxAironetBuf[30];
+		u8	ccx_aironet_buf[30];
 		struct octet_string os_ccx_aironet_ie;
 
-		memset(CcxAironetBuf, 0, 30);
-		os_ccx_aironet_ie.octet = CcxAironetBuf;
-		os_ccx_aironet_ie.Length = sizeof(CcxAironetBuf);
+		memset(ccx_aironet_buf, 0, 30);
+		os_ccx_aironet_ie.octet = ccx_aironet_buf;
+		os_ccx_aironet_ie.Length = sizeof(ccx_aironet_buf);
 		memcpy(os_ccx_aironet_ie.octet, aironet_ie_oui,
 		       sizeof(aironet_ie_oui));
 
-- 
2.39.2


