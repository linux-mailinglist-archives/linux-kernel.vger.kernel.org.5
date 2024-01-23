Return-Path: <linux-kernel+bounces-34470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA03D837DD4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06CC0B24DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00ACD148307;
	Tue, 23 Jan 2024 00:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W9rZgYk6"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56BC1482E4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969719; cv=none; b=KWTUeRhWlYZ24NERpzfz7L/44d//EJv8KyClYWY6cVvxAmkz575C2eFne7mH85sQeYuTTIA/oY+uX1SPu7oKSkRUBWIvLB1Z+cNUXG39izXU2KQSd1zRGXk9wfRCOh0Lhl5jk5DYEy8tps7/8eqP8/rUNX6X/s3gMAt9UvpmEbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969719; c=relaxed/simple;
	bh=IJQ4VwF/XdURhwqKb20pArJOcqYtWwEP77l8CXMEO9A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KX5fs5DgKa1rEMf/sk/qopUd/7utzsfe2sQY5F396eIzcZRey8Ldce87C58sdM/GtSZQyuOJiGiGsaLwofykqouVKlg+oLyc0ZAEWiCdRz2CcU2V3dPY3J3AGgvRFcJUMyibVUMMJiu6vo0q1kmiyyErBrRvtNIYmEh6TWa5uuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W9rZgYk6; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d74dce86f7so12993065ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969717; x=1706574517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jDHEGsADozaBPzy87lyElMwpN6fXSBHhkt9/lWQvvg=;
        b=W9rZgYk61Iqfn9prLeNiSbTv3OpvaKxT39TUkP67jd/whB29kbf6LTakGVWTEt8Wkx
         hmAInx6f7SDsGMYO2OQsyHb8EGdPJc1dTJZZv+SyotYn+UuygCeOn3loeMhi9yy07XB0
         xX3alspmGSmPMhqlu96sub12KM3bBEnJIw5Tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969717; x=1706574517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+jDHEGsADozaBPzy87lyElMwpN6fXSBHhkt9/lWQvvg=;
        b=WEcmnyd5g/3dv7HcL+nAQ5r8tcOMp6YZPGKgIzEAXhOO5nPSXWOhdxtw3moAJ1baJA
         LICttD6MYpqxKLtCzsZbJy6IBGEXvTEq8KkLRnZEPm3MHYBf4BnTOmYrHP6ySHE+45wz
         D9kC+jf2J/VRKO8U1eYLSoZH0OorxoTe27UPpKLCgVw3jU63N/HOzy5U3SlPo50o3lyn
         N5Zca2IZbNNsM9tbKe5NLWmDNirRxeI5zPVE1w04XhjXTlfEIAMAwsYPUcEyun2jvkjl
         2m/zxpf7LrkmQIg58owCpRgM96BxV0nFyRjX8zC4R28zQMRl5QVpm+eUxecbZYKc9BSa
         p4Dg==
X-Gm-Message-State: AOJu0YwowosQDPL7hUlXs9eixp1DoK/3ut5lPUce1/+aggfHeCV3Er3r
	LVh8jXVzxOotciQ0gJXjSrn806FtwvNTHaP/b9yzkiHevqhF8uWyXFFZS+TvfQ==
X-Google-Smtp-Source: AGHT+IGVvNQqP/Yfcue1CS/oyv4ugKBq3YsZQeXsJR0yi4vRWYbdC01kdPUlI/QCPnGswiLzQN7ZOw==
X-Received: by 2002:a17:903:1ca:b0:1d7:6c58:a654 with SMTP id e10-20020a17090301ca00b001d76c58a654mr321507plh.8.1705969717309;
        Mon, 22 Jan 2024 16:28:37 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k12-20020a170902f28c00b001d7492d9890sm2786498plc.146.2024.01.22.16.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:28:25 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/82] overflow: Introduce add_wrap()
Date: Mon, 22 Jan 2024 16:26:38 -0800
Message-Id: <20240123002814.1396804-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1195; i=keescook@chromium.org;
 h=from:subject; bh=IJQ4VwF/XdURhwqKb20pArJOcqYtWwEP77l8CXMEO9A=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgEL8IucC9yEm2ouyrQ/hhMu5I3AUOX5/m7s
 cUy68MtvAaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBAAKCRCJcvTf3G3A
 JqGoD/0VbDA2K1vKkDXKw/XOmCvxckFsH1aXG4eTErag/Fyu11F/Hz71EheSTm63LgoPWiI+vwG
 vQcb3gzwgcA6Kv3ftEEWygG29jA30KCJdCnU7BgqLDouuIqhIzzubmXcqF0DF60tOIZCgObUYdW
 LboXVdtqnGzTV+ndwblWK6xc9gvy4kCGEHtQHUiTzqvKF3r0hNkAtTt/gyaIR8alh306zuznEUP
 Hy+3HE3U2/gyMkH8zjIoL7izNomyRAG+jGnzSTAQ+Y3Io/mDd4oLPhoQiGYK2gpGGj7B4xzcwGX
 ZfJsp3Ttomp+rMXKh/zDeoOy98JKGcFTIPxSR6pHgFfju/51K7XIIbJrWUYTJFCI+xGqAZoPJMA
 Z4nx57/RJXITaO74IOTE6xsVnwdW1XCDqNK8HVJcV4jcck3dqbaWeKq8G2Wn4oaUCpafB750LRo
 nG6bJ2EEORG+XgubtrKSu9fKiX5jB3Nua4vUxTjs3cpbB4Nn3+z1HECkX8puf7At08mJW7iuB9v
 eOLUNEvuugFexNTyysxKT9/pAWH+g8QUNUqvcuIpc1aKa+M51P2ektI1qunbV70+gASTfmfDtst
 8iHp9HNo7JldQqTsDLxzi7M2oSYZTd1Xnlv809kXKLW7oMGoxgBsHwO20fGby1A7AynToyEh9vY K6n3JQaCLci7AWg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Provide a helper that will perform wrapping addition without tripping
the arithmetic wrap-around sanitizers.

Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/overflow.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index ac088f73e0fd..30779905a77a 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -124,6 +124,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 		check_add_overflow(a, b, &__result);\
 	}))
 
+/**
+ * add_wrap() - Intentionally perform a wrapping addition
+ * @a: first addend
+ * @b: second addend
+ *
+ * Return the potentially wrapped-around addition without
+ * tripping any overflow sanitizers that may be enabled.
+ */
+#define add_wrap(a, b)					\
+	({						\
+		typeof(a) __sum;			\
+		if (check_add_overflow(a, b, &__sum))	\
+			/* do nothing */;		\
+		__sum;					\
+	})
+
 /**
  * check_sub_overflow() - Calculate subtraction with overflow checking
  * @a: minuend; value to subtract from
-- 
2.34.1


