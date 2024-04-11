Return-Path: <linux-kernel+bounces-140767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDAB8A18DB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC638286186
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6191F3E47B;
	Thu, 11 Apr 2024 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XDmIsfwf"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440173D0A9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849508; cv=none; b=gN/QsiqibN8n0ZMPIGHqVe4Km6pjvPSDkjuPxb+abOy/1bIvZg/fKf7CMzMiVYvzx32yZbATyzfIUDOM16cMMkjEQt5FvkxoUuzakm4M7uP2YHtA3SVj8teXyxHL3Z9kJqcks0U5rfhhAODRk23M2e1CJFz5IVBAbbNhNGHVE9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849508; c=relaxed/simple;
	bh=VBDJgnrPF2tVaWfyB6lISyxfNKzKEUryj7Q+6p+Wuww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVO+IAIgx7zDT0Grh6xfe/5B4g4bYi7fhZ3OKhxZ7s9ZoVw6hASU1yV3/e6GZplTaztMJ3Tf9wR5wP2tC01J2ZKK1pBxd04ZHY3893g7Z510Rp5s83bWLnTOGEsqbfbBa/kfl2R2da8wotW1usly137KjeWgB+FtJmOU5kCWyOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XDmIsfwf; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9690739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849506; x=1713454306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78h3OU/20E4GNiyf/egzrMDAZ6rqzVufo+cQ/mhUEoI=;
        b=XDmIsfwfuD7r8fRK2CuSOfE1GKdYQYZlJkMRdnLWkZuU0pKaeY5Iw1vlnwRqUFw345
         ZU5mqhWXzpkgnH9nUxBgnixtRTiOqN2FaPKvjj2AoS61qgDIo/MU73Sv8UqNVohp0gDv
         AN1QLQdZDkcz7rG8oWogT/smhocX4D5q1d2syOFHTvP2RcWMqMR7nU63L+1TyTAHQJ9o
         cnnUTRGOz1bj/TVfseFRccv7KrdQaGVTATUowS0yHFqGIS8VruW/eh8pvFguGpC6kG9u
         +rS4lmobsDl1POa/glulCuNOUtcfvRHGRP8M4DD6V3aJz72xa6hHs1MXAkPR0rFKNGi7
         +2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849506; x=1713454306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=78h3OU/20E4GNiyf/egzrMDAZ6rqzVufo+cQ/mhUEoI=;
        b=UFONqKAsPdDDOyG2ZGjFikr2AUSu2WSk4DXTC7i7cFlBNk7paR1usgVdrjqhO8QWxJ
         ds2WSyRJnbUg9sbm4QwyQOwolu9RbBAthEUkwAAyfpjATnMNqCuLxCNZNzINT8s6IjnR
         j0HTLlrLinZlkRaevyo3JTqW125/SR1w65HsMx8OdiuXkysBAt/bfmtE4BEClhIVSn5/
         vi6VHJs6EPCbNyKUtMKNEUso7xyGw+suhSYjfynY9F0lowv3mszk8PkI+Mw9Nvn4b2lW
         DFDR59XJk1yKZMZhlInDMZHkBp4JwhbbpTysMEpJA34bWJdZe/1iLOFXzxOrFnN5NjeI
         Ln5A==
X-Gm-Message-State: AOJu0YxfzxLjJ+Jz1S56HLvQNpUwmTrbkdT7ePtxF9r+TaSiayixj/rY
	k2Ah69QJqWo7DBdLrGSeWOj5wVFzJfhxRH7vXnnHCrxciQNS+S8sQYISkMM0Q53Gx10NTuWeQKq
	/
X-Google-Smtp-Source: AGHT+IGNSvD1OcD474lUWgvq3VCpVCwPEO0ef92nmToIhW7gKazt6rOVV/gKY1Z85lx9tzN0RRF4tA==
X-Received: by 2002:a92:2c10:0:b0:36a:2d25:3d82 with SMTP id t16-20020a922c10000000b0036a2d253d82mr6149003ile.0.1712849505872;
        Thu, 11 Apr 2024 08:31:45 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:31:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 010/437] lib/string_helpers: add parse_int_array_iter()
Date: Thu, 11 Apr 2024 09:12:30 -0600
Message-ID: <20240411153126.16201-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411153126.16201-1-axboe@kernel.dk>
References: <20240411153126.16201-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Works just like parse_int_array_user(), except it takes and iov_iter
instead of a ubuf + length.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/string_helpers.h |  2 ++
 lib/string_helpers.c           | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index e93fbb5b0c01..f38157114fc0 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -11,6 +11,7 @@
 struct device;
 struct file;
 struct task_struct;
+struct iov_iter;
 
 static inline bool string_is_terminated(const char *s, int len)
 {
@@ -32,6 +33,7 @@ int string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
 		    char *buf, int len);
 
 int parse_int_array_user(const char __user *from, size_t count, int **array);
+int parse_int_array_iter(struct iov_iter *from, int **array);
 
 #define UNESCAPE_SPACE		BIT(0)
 #define UNESCAPE_OCTAL		BIT(1)
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 77f942809556..ced4f77dc5e8 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -188,6 +188,25 @@ int parse_int_array_user(const char __user *from, size_t count, int **array)
 }
 EXPORT_SYMBOL(parse_int_array_user);
 
+/**
+ * parse_int_array_iter - Split string into a sequence of integers
+ * @from:	The iov_iter buffer to read from
+ * @array:	Returned pointer to sequence of integers
+ *
+ * See @parse_int_array_user, this is just the iov_iter variant.
+ */
+int parse_int_array_iter(struct iov_iter *from, int **array)
+{
+	char *buf;
+
+	buf = iterdup_nul(from, iov_iter_count(from));
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	return __parse_int_array(buf, array);
+}
+EXPORT_SYMBOL(parse_int_array_iter);
+
 static bool unescape_space(char **src, char **dst)
 {
 	char *p = *dst, *q = *src;
-- 
2.43.0


