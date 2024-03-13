Return-Path: <linux-kernel+bounces-102349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2121787B10D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBB7A2937DF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D5960EC8;
	Wed, 13 Mar 2024 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="SecEYsio"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD1360DED
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710353993; cv=none; b=mg7virp1X6Y2EP5d+aEPdkkw7FwuN+ok50Bu16FbWN/sko1fOkFUnQvJjL1JcIDy/hOaNVc7x1oPWUBL/bEE5+GCfeu3aapCd68S3m8HDOCHf3rxjsxVZcI5arUNvF6MthRCIIZNFRjMPLFxWXapUOYKm1m7wP9zb6JNJCqbJ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710353993; c=relaxed/simple;
	bh=i7kOt8c8LpYV3x34x7AxgcypS59Vl+cqgeoPtfOs/7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=ZglsK0MEnrTMpawapkw45Gcbk9F1ZRl6u46768gjz1JHqM2uJPIfIDnsknBIm9yYRiRwICznRXvrwU6Nd+X3mEeMchXF5EGeq8WqrHbC2Uq2ViwShBj5tL0dk7xRG1OiXwXFwUt2b3q2wmYp9+pB6qWYd2bU627/O1pgsRj647w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=SecEYsio; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1710353981;
	bh=i7kOt8c8LpYV3x34x7AxgcypS59Vl+cqgeoPtfOs/7I=;
	h=From:Date:Subject:References:In-Reply-To:To:From;
	b=SecEYsioM6Wb4/4J7jfRnmsaKS5bUD4C1UazeQWwkbczrwj1z6FXAVl86AmQr4cUS
	 izWFue0QtZFQGaptH7mEC3htXP8IdTqMHc5rMp5cyXPw5MsRyOW4aqCvX7mVW2U50j
	 O9Cxk7KM7iNtV4R26HCQXWZUK1z7rUvEwHfBJrIQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 13 Mar 2024 19:19:31 +0100
Subject: [PATCH 2/2] misc/pvpanic: add shutdown event definition
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240313-pvpanic-shutdown-header-v1-2-7f1970d66366@weissschuh.net>
References: <20240313-pvpanic-shutdown-header-v1-0-7f1970d66366@weissschuh.net>
In-Reply-To: <20240313-pvpanic-shutdown-header-v1-0-7f1970d66366@weissschuh.net>
To: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710353980; l=864;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=i7kOt8c8LpYV3x34x7AxgcypS59Vl+cqgeoPtfOs/7I=;
 b=Ka2KB3sIKOuE2KN34edSJzQYgJkwt/7L+sJL364wy+4M7EMmb573aNzLYTgrlB2hJRXwIg1+x
 v/IMP7Sc/8oDTgvh12UFHq6woEMDfuXjbD5xj+3B3gnz7jH6PJOCST7
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Shutdown requests are normally hardware dependent.
By extending pvpanic to also handle shutdown requests, guests can
submit such requests with an easily implementable and cross-platform
mechanism.

The event was added to the specification in qemu commit
73279cecca03 ("docs/specs/pvpanic: document shutdown event").

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/misc/pvpanic.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/misc/pvpanic.h b/include/uapi/misc/pvpanic.h
index 9ea6a965ca7a..3f1745cd1b52 100644
--- a/include/uapi/misc/pvpanic.h
+++ b/include/uapi/misc/pvpanic.h
@@ -7,5 +7,6 @@
 
 #define PVPANIC_PANICKED	_BITUL(0)
 #define PVPANIC_CRASH_LOADED	_BITUL(1)
+#define PVPANIC_SHUTDOWN	_BITUL(2)
 
 #endif /* __PVPANIC_H__ */

-- 
2.44.0


