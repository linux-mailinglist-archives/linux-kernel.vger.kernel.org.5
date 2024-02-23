Return-Path: <linux-kernel+bounces-78864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 603BD8619DC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA1228837A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5951C1420D8;
	Fri, 23 Feb 2024 17:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HxlLyd3w"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5B41420D5
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709384; cv=none; b=Tya8PYxpDk2XoWTW9d4ZqivsACsnhjMU1lXhvW+6jd5fzvVqB3D/XKIvw+mjNNQ5fIGQxjAkeQ/sNwlrW4RkFtD/qBDQRcvkt+UO+xQgqWzMxxV30Xg5Bw28IjhjU3kA7JPC2DAD0D5NfzgJGzkOOJCvlU5j8WpdD5YFAU4DtPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709384; c=relaxed/simple;
	bh=ZSQMrFcXK67EoYJFvWEtAVXpJz5HlNabiFfB2+DnMz4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DriPGSi2Otzj/VDsMFlmgs4i88AhNM6J+yez7sUBP4h94GYSH1W+7iD+5aEtuNypuqhg4ohlPVc3CTO2mrxhdIMh9yKPcN7JaZzi+sSphJLydB+Hd4tkoBRKWbzzj1jmFBv99SPxVmpYLqY5dCRquFzpBXqTcj3kxAVUk8JyWrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HxlLyd3w; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dc5d0162bcso9136195ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708709382; x=1709314182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bM3MPkF58+jFMGrw4OrogBOTmRr+QWSJaSYzjCyKYu4=;
        b=HxlLyd3wWp/ZtJmDGIhSVJrTQECsFgCM/77iCE2CRWD2fY2+jeyERBZOXlM8GtInHD
         deAVVscCHDZSs18oOHyqJVBYOflGvccJf+Zu2PfhXdm9MTT+JSBUU/jAchGUqDqy32rT
         /MMF1V59vC9RgcIEGFS4LUTz+RPKL+l+nsY+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708709382; x=1709314182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bM3MPkF58+jFMGrw4OrogBOTmRr+QWSJaSYzjCyKYu4=;
        b=pagTSQo8On44jq3udYHCc4D6t8GPoOa1yZ3wurPC93FFXS7SN33FMy/8ZE93FnFnbJ
         D4IHeRehpPFXoTWRnJeLOyEKoqJc65slZfuTDeL/kg9CQUub8K4sCth9VJ/szrzibKAi
         SqFSoTGJTpCoFpTRUVZaxnOfWjHQZ2Oftb7hAhRjNXZ2ZYCuYPfzea59iDUG+oQ5kYoL
         uk8mV1x+Sge0lVe/M1jzlXNzdQjioQ9k4N1ThYrEB8FAEI07d6GEJSl9/DZxKOa0lpNI
         /kiniMSuTWwz70ItmVMZ425bWZcM2t9OMZENwIniG+P73mVGSazN6Ep5ywVLlrlhS0JX
         JkWw==
X-Forwarded-Encrypted: i=1; AJvYcCU2KnLJptudHv34BuzduatWhWyhR+vm8lIqNJN9hyfBdFKfKiWynTwVK5FkjhvvcX0KEqQ1XbHIB1/B09BfTa9TNXDhI1jQwQEEEMYP
X-Gm-Message-State: AOJu0YxhFoo7zz4qLkzRTUsVVCbHY2ZiOdDVWXdphoUGCMTDe1sNBh9B
	9lML5XvnoEvMXiNNjC2hAYqAO9UDdzHt58BTrFJ4aJYvlolGmoamHi98lJbP6w==
X-Google-Smtp-Source: AGHT+IFzDY8go56+ptU8+F6xFCu+b2Z7ssHDmUg/9Vyz+3JhhD1xjzJWr9XeBbMxTH99G/AutAFy0g==
X-Received: by 2002:a17:902:c102:b0:1db:c536:803c with SMTP id 2-20020a170902c10200b001dbc536803cmr435891pli.33.1708709382389;
        Fri, 23 Feb 2024 09:29:42 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902b60200b001db604f41dcsm1778891pls.103.2024.02.23.09.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:29:42 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	"Lars-Peter Clausen" <lars@metafoo.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	"Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	"Nathan Chancellor" <nathan@kernel.org>,
	"Nick Desaulniers" <ndesaulniers@google.com>,
	"Bill Wendling" <morbo@google.com>,
	"Justin Stitt" <justinstitt@google.com>,
	llvm@lists.linux.dev,
	Tomislav Denis <tomislav.denis@avl.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] iio: pressure: dlhl60d: Initialize empty DLH bytes
Date: Fri, 23 Feb 2024 09:29:39 -0800
Message-Id: <20240223172936.it.875-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1937; i=keescook@chromium.org;
 h=from:subject:message-id; bh=ZSQMrFcXK67EoYJFvWEtAVXpJz5HlNabiFfB2+DnMz4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl2NYDdis920sydQS6ipBI49BtcHYYpvp5bOl50
 hx40NdinzyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZdjWAwAKCRCJcvTf3G3A
 JnTxD/wM4aMItMA1GlvtME+XbzHXS9RwkeN0sJ2am73tn22dB2vdV/htY/rmnPgBgjy46iuc62k
 Q3m4V2vmIRR7oin7Dp6MHFYVWNysZUrOrwO8uoINALTCyF30N3JPEUAlk4XA7j+U6DxerZ2IdL2
 jERDFaW6E+LGdZ3aQ6NsWuJxVvv1CRf2vcdwt8LL852yhg04L+MVtjejOhyu5dpy2wwFWU1qRGD
 cclqSl/4dB639iKcUgL3C9V9HKkPNtCYNINpITFMjIQFQzsNWTGonSvc/j3a5qgjb0gOMjlZ3+w
 cgF0DtlubTNlGX3Cpcq1K1B7qACqsit98xxDp561xm8fxD5LzuBoUfAlUZ3FhMj03iGsyMibDs8
 sk2GVwIANvPLWEriBJoqA83QqASX0TUC2BoszwezFgAriD0yMUS1O+j9zvO1SL8sNENlY7hzfIF
 Uo8fIy0Ey61dvD4BLNIY/5gQINuPOcGnpiw6PUIuUw1YywkubRbxs/Kajkeh2JjzESkcGpHXVO2
 zWqeB9B8/TO83C5O/BVx13LUq4OabuCRcOQA3anJYepO7RV5Nm2pUlZkx7gznkJtH68AMU9pmiu
 F3zxSeRPQ96CxmN+/baatYUN4AR1631D1oJIWyIM9SKfmCwzVUENT+QYOHbx0I0DhV0/52n0wAY
 wgn4Woo Gjwzea2g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

3 bytes were being read but 4 were being written. Explicitly initialize
the unused bytes to 0 and refactor the loop to use direct array
indexing, which appears to silence a Clang false positive warning[1].

Link: https://github.com/ClangBuiltLinux/linux/issues/2000 [1]
Fixes: ac78c6aa4a5d ("iio: pressure: Add driver for DLH pressure sensors")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: "Lars-Peter Clausen" <lars@metafoo.de>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: "Nuno Sá" <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org
Cc: "Nathan Chancellor" <nathan@kernel.org>
Cc: "Nick Desaulniers" <ndesaulniers@google.com>
Cc: "Bill Wendling" <morbo@google.com>
Cc: "Justin Stitt" <justinstitt@google.com>
Cc: llvm@lists.linux.dev
 v2: drop comments, array expansion, and WARN. refactor loop.
 v1: https://lore.kernel.org/linux-hardening/20240222222335.work.759-kees@kernel.org/
---
 drivers/iio/pressure/dlhl60d.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/dlhl60d.c b/drivers/iio/pressure/dlhl60d.c
index 28c8269ba65d..0bba4c5a8d40 100644
--- a/drivers/iio/pressure/dlhl60d.c
+++ b/drivers/iio/pressure/dlhl60d.c
@@ -250,18 +250,17 @@ static irqreturn_t dlh_trigger_handler(int irq, void *private)
 	struct dlh_state *st = iio_priv(indio_dev);
 	int ret;
 	unsigned int chn, i = 0;
-	__be32 tmp_buf[2];
+	__be32 tmp_buf[2] = { };
 
 	ret = dlh_start_capture_and_read(st);
 	if (ret)
 		goto out;
 
 	for_each_set_bit(chn, indio_dev->active_scan_mask,
-		indio_dev->masklength) {
-		memcpy(tmp_buf + i,
+			 indio_dev->masklength) {
+		memcpy(&tmp_buf[i++],
 			&st->rx_buf[1] + chn * DLH_NUM_DATA_BYTES,
 			DLH_NUM_DATA_BYTES);
-		i++;
 	}
 
 	iio_push_to_buffers(indio_dev, tmp_buf);
-- 
2.34.1


