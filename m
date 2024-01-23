Return-Path: <linux-kernel+bounces-34540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88ACF837EBB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E67F290736
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306051272A6;
	Tue, 23 Jan 2024 00:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QsDkKLfB"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA09A61663
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970759; cv=none; b=i6tVGnoa+3eIjGW4Sjn5z7lJ4QxMwEOx2SqiSx0gvIKwkfyqMfiHv40Tjut31TlUCaEKFHL7y45yN2krkTzr0hc6d4iGM9wS/gsFcKBFtBRhrFT78QacTZdW6qUw0d8+8NQOmiwxIgdJ/8b3+V3STcg9ImVH4MgkCCbdMddZ49Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970759; c=relaxed/simple;
	bh=pqahPWCtiilVxi2Cwewikz7N45reJkQJ7UJUXEGvxo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QI90Pb7AZC3DejsWondnlvQKPa7mzz+yUFGqbTbMIdPvVYp7MeOnzogQpi0u+j9h2hAKk72/ysfHrw9MQkl0n7swUfi/DnkPqqSbzp6mCE2tqePl0VCRTFg5+BgZ4wQlRlhVUu99B3WQ658+Xi0YxEZ/V1iWZ5kXT7l86Zq1iLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QsDkKLfB; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2907748497dso1579347a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970757; x=1706575557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRtEgA24maRm+G5gcEke23eL30Vj6MIdNe5RQrjo/8E=;
        b=QsDkKLfBWO7BdvpXfam5uZ0BIQsXQUO1qqd6M4QpYpsO6sd9MIZZXJRrNzTO65Y+hQ
         VoqSbft5M1Ckz5+NXB7r1zvru8OJj2GpsyfbuQVY0xcJkP/hmvGl+woNudrUVbPI+/EG
         fK1awRwMQqC+OwibXTaOtxGj+3ZYu6pnwWa9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970757; x=1706575557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cRtEgA24maRm+G5gcEke23eL30Vj6MIdNe5RQrjo/8E=;
        b=j0WiKZBXEY3bC/CxtDUrvOkXucPRO9i34wKut1I3phO52N27U4ACTk1xQE5IQ8DS4z
         aHJWqBiEl8wQIFqwgrMMzBhLbaeSEYa8e6S3XwwVXf8T+PgC2O8AahHQsTDKBZDMAaQt
         x+0Rfy2PvVXh9Ik32mYHbQJxHdWOUYcTDCPqFEHuXGaqUyiPIZeZ5UYsIdTO1zm6wkQF
         KMlJrjjn/zqHyTGNUfF8dz3e9ekXyU5zuF9TJAHDRat51n+kv9GNuhVpOZlKD+6uhfel
         GFxm0q75jLfnUns7AWjmf4cKSAnMsUpsb3OcihdxSub5Ff+Ho+l5+0ksxB0aWubsUWMk
         Czhg==
X-Gm-Message-State: AOJu0YwbgVI/5ZD/ai/fDKgJLIeAxFSRXGPg8fvr69v8K356LUe4UZnO
	/CERuhRKRiDgx4dzS9x+Y9m0HVJn1RZfhjAizEcvs/zt4L/BEc2efH9Oki/3Qw==
X-Google-Smtp-Source: AGHT+IFciWHO78/a7euH6rqJvtMdI+gSwn5MfNBM1NW2JHf/Lhr+OJ/TN/dJXuWD57I9PPPQxJ44Rw==
X-Received: by 2002:a17:90a:3941:b0:290:caf7:7a16 with SMTP id n1-20020a17090a394100b00290caf77a16mr435126pjf.0.1705970757093;
        Mon, 22 Jan 2024 16:45:57 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id so18-20020a17090b1f9200b002909c6bf228sm3237373pjb.51.2024.01.22.16.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:45:55 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <lsahlber@redhat.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/82] smb: client: Refactor intentional wrap-around calculation
Date: Mon, 22 Jan 2024 16:26:49 -0800
Message-Id: <20240123002814.1396804-14-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2356; i=keescook@chromium.org;
 h=from:subject; bh=pqahPWCtiilVxi2Cwewikz7N45reJkQJ7UJUXEGvxo0=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgF+RrezY1R+vJeoB3MoQno65kcsaFJYE8T7
 TFT3XWlULSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBQAKCRCJcvTf3G3A
 JghND/9sxXRpGBChydX6oXKHlWt5zCT0j1qCewzIX5EZfL6bLAAMMvbrryh0Kxi9Sj4hqZGsIHg
 LtEJVktXPEirje72RefP1RpOxo01UzeUOLmDOWUHMoB4B0z+XubPvEaAaQ93LFS0A5Cf2GSblOc
 Hx+I37mBMNSY3YGAsN9F86amVO0lc8gZY8oppvXg0goQD2o031eriElKHB3uK26o2m9SokcDyZW
 Q4di9IdRGvGZ4IPTbQ0R5Uc/QqdPqSBZ/tJyncI0bhVLAYKfqLdKCWvKzpFkbsxSnLFey7WJTtL
 N6JxOZoVgb+cu14E6OubQIRM4a2MF6lWjK/TSXxKa741TuGCCZWHVWy8HfQg/nEehtsBojQR5Ke
 n4ZK0eZDc+TVrnTYX09u87bgIwCCnlVBad9RNxR6MYfbB5PCTvmdApJodAX+eamo/22YvttIlV2
 lHj7KOeoKn1Ybl67n+iX3eJgQ4EssmZnEZG7XmODkiw6AR1iDdWqIvIfoThRxBNs46UjYdzaIa/
 KZn9l3Z/958uJ9DYefApgztvC4i06O+FIGSIYVn45yV+CgRlLA9VZjRlrzzgLoEgZrklYDey13J
 IlbCxjn/tjXnvRrqNAWm/i7hglaOoYH5il7sEsia1iH8bIkOkbWmiSISrRcH/ojibVnpKp/vaxx ikviov4jRF0L/Hg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded pointer wrap-around addition test to use
check_add_overflow(), retaining the result for later usage (which removes
the redundant open-coded addition). This paves the way to enabling the
wrap-around sanitizer in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Steve French <sfrench@samba.org>
Cc: Paulo Alcantara <pc@manguebit.com>
Cc: Ronnie Sahlberg <lsahlber@redhat.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/smb/client/readdir.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
index 94255401b38d..7715297359ab 100644
--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -467,12 +467,13 @@ static char *nxt_dir_entry(char *old_entry, char *end_of_smb, int level)
 				pfData->FileNameLength;
 	} else {
 		u32 next_offset = le32_to_cpu(pDirInfo->NextEntryOffset);
+		char *sum;
 
-		if (old_entry + next_offset < old_entry) {
+		if (check_add_overflow(old_entry, next_offset, &sum)) {
 			cifs_dbg(VFS, "Invalid offset %u\n", next_offset);
 			return NULL;
 		}
-		new_entry = old_entry + next_offset;
+		new_entry = sum;
 	}
 	cifs_dbg(FYI, "new entry %p old entry %p\n", new_entry, old_entry);
 	/* validate that new_entry is not past end of SMB */
-- 
2.34.1


