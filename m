Return-Path: <linux-kernel+bounces-70259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E183E859559
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DBD928253D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91896107AA;
	Sun, 18 Feb 2024 07:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCzD9fao"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42565EAD5;
	Sun, 18 Feb 2024 07:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708243083; cv=none; b=Yp2kD3R3Ewgf2xb9yMd1KGOEEyTy/J++ahINlWeot/aMot1XrP4AntTh5QhRJHSTKiP6EjZnSESxF5wbTXgMQlu7SsREq4J60aVA9eqpjcHOdFsYVwTfMtKZ0t0DTkTeDv3IT+in0ylAQ23/7hJXKL6uhoAA+1XxV1xYvGmEyOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708243083; c=relaxed/simple;
	bh=12ZQEdtuynQ+RnIa2FV2uXf0/cwlIvakbZZS+qm0xB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qTWTxhEZ9OIa7963Ws6KBCTB5nhyEFHbIbZ46fAArz08vgpl3EToGw1PNK747vpwU002b5d6YQNJ8FsKn2BEEXezXtNn80cW+ITTko/R19Ddx5pgv29V/dh6XhZpscpMVrOd63jG4vlqali9+CutdViOhfZbV3Q/eSYXXVc1rI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCzD9fao; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-563c595f968so3585937a12.0;
        Sat, 17 Feb 2024 23:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708243080; x=1708847880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bU9yZws6bY4pAcFt+/tQW3bVoJ4iyCU+qUdZyENINWE=;
        b=fCzD9faozpixaf0WJsOBnwOk/MpjD9H+0GJteK6CMWYOt7hQ0iwEJ5MfTmUcOU9wf2
         C0yAORZgiY7AilQE/zRjtdr9snD+hkW57SEFdAQydoxttPtmL2KmForb6IJeHRyGyIYz
         b+CHB56pzmOs0YGlvProc0US2l8BLlnSizhS7PQQ/Mi09wVvlalGqJpBRAhsEVdPrc9I
         +3GHW7f8dBX9pLYf5eh1/hxDjF425KyHDB4r/DOMfSPVsOcp4oxJpt9le3Hk1Mnrmj4Y
         lZhfR1/Ig73NRTNB1wtMnMcQBkEVhYSKXyNUBca+3+/BCfJYbfdCntzEnpGodwbpGdNo
         VSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708243080; x=1708847880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bU9yZws6bY4pAcFt+/tQW3bVoJ4iyCU+qUdZyENINWE=;
        b=sKSkt4fVlzM9LhNYfRJ8OcPfpFUwmDOpliTG0KktnDxZHxr8NonnPVy7imrGWldcwn
         KHLc3gFxNUYx6yJY2rpwaZ3Ky3tkWNGPqOor2vSNUQZXC6jZ3VbSyNRZuQNgSZ8gqo0m
         LlQRFpQBpFkz2TCZFFKGy8SYOhfXP7aMx2aw+4a2Ht58Trjv6E7xJtY6yrWrLqgt4d6y
         jlKEsG98neAmUt8O2bstpGaevvczdjCwvb2ZHg4qMMmMe0OYJ4mnrWxvPp2tua5yNeHi
         FfDJgF+XSGbbI/F0+XVJKL72nAoYZWb/fbqb6RkjOC+JKoBXxwsE7Y961AUAj7G1lMid
         NDiA==
X-Forwarded-Encrypted: i=1; AJvYcCUPwpUNLNdTpEJhJHjEOfjb+ivEIg8D9eve/5FbMsFB/N6Q2E4rqaBmfY+OG8Vb+d0i8aRA0WrQWNoLaeVmQrEAV5rDlMssG+3m7ffgVJNKDdoHbDx66giIQlqGyumFkLf2E9PD
X-Gm-Message-State: AOJu0YyIvs9A7JLSSLaJoZBGqDW4CLbiL0sMQlZeWKqfBlk5bDVnck1K
	JvMwXfADbkf+IjwD7gXbmzLFJkw4luPDodMAWKhCyNzd0qAYvtpb
X-Google-Smtp-Source: AGHT+IGXHWdGOBEtbe2Q27KHCj3vWhkjd9YvBSUq5+h7VAsPByLk0kuEXYhvTqXB3cClDVqxOL/YmA==
X-Received: by 2002:a17:906:b0d9:b0:a38:63d4:2273 with SMTP id bk25-20020a170906b0d900b00a3863d42273mr6487403ejb.35.1708243080451;
        Sat, 17 Feb 2024 23:58:00 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id jj12-20020a170907984c00b00a3e64bcd2c1sm458732ejc.142.2024.02.17.23.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 23:57:59 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 net-next 01/14] net: phy: Add BaseT1 auto-negotiation constants
Date: Sun, 18 Feb 2024 08:57:38 +0100
Message-Id: <20240218075753.18067-2-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240218075753.18067-1-dima.fedrau@gmail.com>
References: <20240218075753.18067-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added constants for advertising 100BT1 and 1000BT1 in register BASE-T1
auto-negotiation advertisement register [31:16] (Register 7.515)

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 include/uapi/linux/mdio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index 3c9097502403..c0c8ec995b06 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -350,6 +350,8 @@
 
 /* BASE-T1 auto-negotiation advertisement register [31:16] */
 #define MDIO_AN_T1_ADV_M_B10L		0x4000	/* device is compatible with 10BASE-T1L */
+#define MDIO_AN_T1_ADV_M_1000BT1	0x0080	/* advertise 1000BASE-T1 */
+#define MDIO_AN_T1_ADV_M_100BT1		0x0020	/* advertise 100BASE-T1 */
 #define MDIO_AN_T1_ADV_M_MST		0x0010	/* advertise master preference */
 
 /* BASE-T1 auto-negotiation advertisement register [47:32] */
-- 
2.39.2


