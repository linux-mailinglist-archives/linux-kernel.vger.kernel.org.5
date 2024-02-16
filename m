Return-Path: <linux-kernel+bounces-69480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFA4858A22
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63C692894AE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC88B1487F0;
	Fri, 16 Feb 2024 23:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KdzknjbO"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B1F14831A
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 23:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708126148; cv=none; b=mFRHu45fyUi/cjf0TWmCH0HHGoSyXC9E7ebrGVwOEXaTuzEvW4Pyq9ok2LP9h6XYcn1EG5ucAkLDQrQsWpEUGtnX0ravqn8e7+LiyQcZkKEWa3Nxy0r6nAYxyVbmuPJe9C8BCh4iP4J0oVLZDGN8KwcxuoTTlmughuq/965SIxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708126148; c=relaxed/simple;
	bh=XoZLsDGAjROcmQDGkI0Vj+qpzKjS9550xNB4tcENbIM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BMqGzDG5FaTeI1nn7/Af/mIUOuw7w51mkghhFGuVMzF4wTT7a9imsNf5gLTQF+VWXKdsGnHPi6W+48EgQX2cMPqMweUX0SGLh2LFwUdUGAzYkn0RwfGZ1gxjbxXG1sdNSKJYAoiCrct5+PqnqgWQ5XF9MvXGv+koojdPZhSnAZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KdzknjbO; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5986d902ae6so1338881eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 15:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708126145; x=1708730945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YuVuB9WNnp6RhLhxcgBuf0qoep6pw4i+nNUSVjYdbec=;
        b=KdzknjbOeBWcPXDR9DRSwNedh4bnMhiww1IXTmC2AGa/MBHcq+Ffz66A8VOrzcmuTl
         74CaflRqwEDpv+MOsjBC8pJZTTy1nt44QmFgBk7OuduiFHQpLpV1tPrbHWnzQhXJopcR
         QBwSSBkKHbyS1ND4Xa6JSleactM17nX89qUzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708126145; x=1708730945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YuVuB9WNnp6RhLhxcgBuf0qoep6pw4i+nNUSVjYdbec=;
        b=oHI3OHew91pd3dm78sqAxGaAsL/dvvWbxmO1ICMAb7/Ls/ai6zZ3E3Fd/JOu6Dv/CB
         yDrNSGDDBpceX2AEX467ikgxF/EstDc6C7ixWVqnYkBzznKxYkORytRaJj4/RE6f9VPv
         ZSbj/rWEs9LCgGu6bdxb1XFO7xCvL/WuDMWRdbteFEkbQI9YBKfTA3NEpyzvMPYEkHXe
         54YuP+mmQBvVWP28vMbnIOYhPHevGNvAAQbVGw3fy6c4QUQfMNLouiy+yQaHDF6YvUqQ
         GJvoqMYLYxMffE5K0Dm6+a9sqvCHkq5yLdmxnY2DmgG6J9ODIXgVWzp0DIQtJUk4qgcX
         9jaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcPtgT1ioSj1DWQbk6kAnBoNzHPUxe4DR/EPg9y0ltnV2nCWAqZUkBuxApO9tmc5C9joRMeo60xTGC5EAD+UmTnLPrcdXbnClMDUfC
X-Gm-Message-State: AOJu0YxqfplNt/w3V9wpV1tPuiEsM5CpiLi5UgAxUFxxRii2zhOwhdXH
	Hp0tZfkMN1lx8GOjwc5wBlUMdIfNDRePmowUeSblm6QzaEIhD1QA6M9/tO6MGtdx/Y+PX3VuYr0
	=
X-Google-Smtp-Source: AGHT+IGkx/wYeGB3apgkwZolHTbHJV8+GpGlOZauTNmV+D51H1hWH34YB29ByFJkKMJCQpKS6k+1ng==
X-Received: by 2002:a05:6358:841c:b0:176:5a5e:4d85 with SMTP id b28-20020a056358841c00b001765a5e4d85mr7330542rwk.4.1708126145722;
        Fri, 16 Feb 2024 15:29:05 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d24-20020aa78158000000b006e053e98e1csm473041pfn.136.2024.02.16.15.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 15:29:05 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Anton Altaparmakov <anton@tuxera.com>
Cc: Kees Cook <keescook@chromium.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-ntfs-dev@lists.sourceforge.net,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ntfs: Replace struct ntfs_name 0-sized array with flexible array
Date: Fri, 16 Feb 2024 15:29:03 -0800
Message-Id: <20240216232903.work.643-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=951; i=keescook@chromium.org;
 h=from:subject:message-id; bh=XoZLsDGAjROcmQDGkI0Vj+qpzKjS9550xNB4tcENbIM=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlz++/M3Z7FKya3D8spCK/vdNEKLfnB2KXTxTqC
 SK8XCWyI3SJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZc/vvwAKCRCJcvTf3G3A
 JkVID/0VZ3h7rQqA3mm5DgQ6ZDY16VEAqoU7h4tLtJLNTiCbPXGl44TkjjFg4Y0w8FfTfiDJHRR
 UKLFCkHvfM/szUWwDwmTIZb9K6g+4RO2lYvrKn+Sn8+pmOh6x/9WXFyrivXGfil3GMfsXz0nZzi
 QrUx36umTDyUBYU6Wy/UA+TEFYjpexSssGUq1qysuoTXK0KGiSGIwlSh33uHy7kjQ9JfQCjBJa1
 9NOnFz1yvqHyqbyabOaW4ZFMeewmyTetaHnqcnoLdjVKpClzrgLnraxdBpALu+LKkhqTgCIp2UW
 CHlYTZnb/6OBF9vvvVahO5bS9L5SkxSY4bW7PN7RVcajpwvkd0SGbJDETzzyXqNfNNrpCT8LXCM
 3N8kPwfG/mDrcH4Kt6pbAEI5ZJ0OfEhzDxhQ8T8ci0MVRR3dGNHqPDbHot+MhCrN2gNv4IhRMZG
 peqEQ+SZgzkO0gyuECwzZg1RF8SKWX6C/O9FuTMcR1ABEEpjpuryLfgZ/bAvqJM5v1OMZ/YG7SL
 Bunodbfu6AGfumyUSn2/jENcXF+maPiY3k5r3bMQSeKPprtQSdpNeMMK+IUg/60jFbWG70QLlIo
 /8KYW4bkTNM62i/VgBRq8iAvlIpsHUaJDxClhZeLKnbZkQpox8xv4W/fX6wZxHg8JT48dY7oOEv
 iGoVWH8w hEHSQTg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

ntfs_name::name is used as a destination in memcpy(), so it cannot be a
0-sized array any more. Convert it to a flexible array and annotated
with __counted_by, which matches the allocations.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-ntfs-dev@lists.sourceforge.net
Cc: linux-hardening@vger.kernel.org
---
 fs/ntfs/dir.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/dir.h b/fs/ntfs/dir.h
index 0e326753df40..cafcd339094c 100644
--- a/fs/ntfs/dir.h
+++ b/fs/ntfs/dir.h
@@ -22,7 +22,7 @@ typedef struct {
 	MFT_REF mref;
 	FILE_NAME_TYPE_FLAGS type;
 	u8 len;
-	ntfschar name[0];
+	ntfschar name[] __counted_by(len);
 } __attribute__ ((__packed__)) ntfs_name;
 
 /* The little endian Unicode string $I30 as a global constant. */
-- 
2.34.1


