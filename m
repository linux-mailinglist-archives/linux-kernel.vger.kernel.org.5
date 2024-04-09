Return-Path: <linux-kernel+bounces-137213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 219E689DEFF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF56C28B1D2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56641386D7;
	Tue,  9 Apr 2024 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2K3pEAIs"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD70C13667F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676285; cv=none; b=dJfpP9nsPoN99FVL9vP5ZzTJz3dQ+4plfGa3KECn3bLa9PlfsxIA7zsLkQlrxH7rG92SqJ8kJR4+Up5rjFJ2XA5b4HhBMJhbZAxrbfauUK9DdDbAeawZUVQl9YXNxG9V1TbKWspaOG+irkmRY4+kJD3xQF0BQS7Y+dsOSmiC8hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676285; c=relaxed/simple;
	bh=L8raPWqde16GsYWbCk+qHGSoPzx+xF25H0NtJJiUQrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQkLdwR5viqoGgAAjG8BdZFJ0eDrfljjaky50kfbavbyhVErx1+g+wLSgp/CfK0ycXxKxMgcnvToQKEcR90M5eiMHkIrjtVuEJt/AF+qbs5ljoqPPaQbsgJ8M9o6N7JnbLf3Yh58/4kcvUQCMcT1UE3lumkVJPtab001TKFnolE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2K3pEAIs; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ecf1d22d78so873914b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 08:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712676283; x=1713281083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PC3JAGAh91yPLCnyIgZ/a59FqxkcNwJUPV8ww2u3Dso=;
        b=2K3pEAIsxYV7P1KUpAbTcLksBO3dYv2g60jnUziJ4uEi3PJgwt9iro7wp9fV5iyou3
         2fXk1R26vMJuOUg7eT99FlMqYpOh1XrHzyM+ltdnWz70JuHKqPoEsD+pRXijXRHemAut
         m+hGofZDsjdYwczMVHrv1BGMZ1u2sWf273GN8PRN5bB8mCdOZJnRQVNLmumhyJQfSLYE
         2hwLxKSE0L7D0pMd9W8pHRQiN5viMNlVZEqb0CrAdNvQw4Rc3uJPnS4lLIjmzlTMc61C
         YFIPy033Th31tteShL1qqyl6W/5ICD/ERqQoxrzJrZMh1Qzp7jJIfnuAeDiMpePicBmk
         3qAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712676283; x=1713281083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PC3JAGAh91yPLCnyIgZ/a59FqxkcNwJUPV8ww2u3Dso=;
        b=qrqnlQCxZWJ4enXaer/kVAtULyM48WanR7V/XgMc72Y/8j97gCY/tL9EM6E+5fvCMC
         ZoyH4g5eriXSLhPtNbfHgw0/+cn5FnI6LO1VckyE2hxPLJvQFEajmiA+SS1x8tNYqnUt
         e/C3/Z61xkDAdc1VyPx+8bCy8HDhZn9XfIiaeO1jCthgxbIRP62K0dLkH+qbaLyUC07L
         K3jRAeNH1Qa4K0ttAIRtrwF9wXVXhoAE9NzR2kXCBq3+e3eTXZuiOpLf8SPYwiwA2kQT
         ao/vtHARRE1jY9iyBINd7hHASI4C03ScWJGmxx7BlgBo3HzLubdr2tN/3wRIsfG1CuMp
         8Ouw==
X-Forwarded-Encrypted: i=1; AJvYcCV/jhHHJrvypHUdlVHWuV1QQx9IaTSHQN7zNvuTF9QPnF61ZIS2RFRKZEtiTiU+bLvrbdP3DKwuijiak/QZAGN9fJ5V3pX7fjJHzqN1
X-Gm-Message-State: AOJu0Ywh+n+NkH2PWMSwwk9zcS5ceCDspf07DxGsvFe0DuMf60+isFvP
	4D7RxhSfneODHN8vDakcZDp0cMh7IroP1orb/DnBXIIZ/RwfSynuGKM67T8V7+I=
X-Google-Smtp-Source: AGHT+IEc52xWMZzZcrHpnjme9geYxqLp5964NukBO7ZeZNSHOZ1BD9wDx+9lDuJhAiqT69HuUCo3Xg==
X-Received: by 2002:a05:6a21:6d9d:b0:1a3:c621:da8d with SMTP id wl29-20020a056a216d9d00b001a3c621da8dmr171767pzb.1.1712676282899;
        Tue, 09 Apr 2024 08:24:42 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id ev6-20020a17090aeac600b002a513cc466esm3945558pjb.45.2024.04.09.08.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 08:24:41 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/4] iov_iter: add copy_to_iter_full()
Date: Tue,  9 Apr 2024 09:22:15 -0600
Message-ID: <20240409152438.77960-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240409152438.77960-1-axboe@kernel.dk>
References: <20240409152438.77960-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add variant of copy_to_iter() that either copies the full amount asked
for and return success, or ensures that the iov_iter is back to where
it started on failure and returns false.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/uio.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 00cebe2b70de..9e9510672b28 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -197,6 +197,16 @@ size_t copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 	return 0;
 }
 
+static __always_inline __must_check
+bool copy_to_iter_full(const void *addr, size_t bytes, struct iov_iter *i)
+{
+	size_t copied = copy_to_iter(addr, bytes, i);
+	if (likely(copied == bytes))
+		return true;
+	iov_iter_revert(i, copied);
+	return false;
+}
+
 static __always_inline __must_check
 size_t copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
 {
-- 
2.43.0


