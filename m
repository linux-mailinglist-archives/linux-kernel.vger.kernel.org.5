Return-Path: <linux-kernel+bounces-125393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F0C89254C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61AD61F23458
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A607933CC2;
	Fri, 29 Mar 2024 20:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aykzkv5m"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A073E1755B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 20:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711744401; cv=none; b=LMfXCVjOARREdPh59SeagJj80xlOw0dTUCM4q20h410Y6v4CmiQz2Me4sL9de4b33Gcn2UBduAp3ZWzu5rIastXXmqiqJV+xj6RG3RZjIeUyEEEuID0+uBzcdCfHEuCZLcYWJ7UrjnUpcj3GGTqKipnf5yxZ1ocI0l8vi0ndyq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711744401; c=relaxed/simple;
	bh=MmKPUNxZ+susb4kr/ZOyBooFet2Ni9V6EkAgfthmPGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eM7AR9T7dpbyRK6baVBAbGwCRx5D2EY395moEytKOwQ3qdDU1InM+3PyEOamXUzrf/6Pl+xycJVTi/JlLi4GdQisKwAkDB7Lt1f0ueQZus3CMYc4p8c0UZZSKRt/Q65TGEuVAlK7+5oyb5e/5cG9KbdyCqGElCCa7PbarJk39/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aykzkv5m; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5e42b4bbfa4so1393659a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 13:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711744399; x=1712349199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9y/dxoUHYnuLJXM/FbNFKWazEIf0YDN2gZikUVSS61Y=;
        b=Aykzkv5mDRd/lxI3VDy59EQ9qPOOG6nKG1MM8biF7qFLX0I11mEhe3oHndMtx9BNnD
         7fkqg29CCeK+vp+a4vt8yUK2PDSIWmdXHS28EK3ynJc1kCZCu8YIu4SYF7D365KbqL87
         3sdkvxybrySS9K9v4RoE3s9uTHD/szwnH3odJWFbguw+Jb02zQ1I1nWcwRjCvlOXt2tp
         r8g4dO9H70P4CaPIU5dD0mu6V+kd2E1Ds9/5j3mGHi/iYBccNhhY6rsJW17AHJdSUM5j
         CG6FntBF8Vpb2ufYvduBn4EM3OntJUk/r0xR4g91QwMKLVLyLuqDeGHDk2GJ2ipnVnJ3
         +aWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711744399; x=1712349199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9y/dxoUHYnuLJXM/FbNFKWazEIf0YDN2gZikUVSS61Y=;
        b=hhMXzo2cPp1qMHmbJf8ndUV9OLFKR3+CPkx1hFGqYJUTeLu/WKqlDymOhWyP6pI7gH
         f0qAZEcqto4/9plR5FIq4VesU2VsimUifj6U4C/vs70ZoV44HZhjqsu6XJjTpsZQtd4E
         OBTX/K7yAJvnsCLKNMGMf/pBsDLCshC/2KDvV+0EUMOfUHtsNwlYveBdFt8RRDYlSaRw
         WNocbOs53AsEursNUdvBJpwT+nuuFgwRFzjvMmhEoU8YN2gyFJp1+aBBBLIA7VYaF00s
         fl3WV3xtrtJ+f80fE3A4rOfCtWGqN5U7jGzRc2vrPOQTwCpjNSD1byqI8NQShASpOypQ
         rE7g==
X-Forwarded-Encrypted: i=1; AJvYcCXRzpcFib2bdOq9gQnhZtMnV3KPXK0MIX4forYdOrEC1l7u0AWAKKTTOt2aoYlLn+f+GJ+Z1d2ogD/MvNyKdfOPgG2oGFmQGvVZ18D0
X-Gm-Message-State: AOJu0Yw/XhnP12JRZosFEXpriPPGSQCkxpOEbzXaNn+yKDw3OHU0ii6b
	gMKsNuWBQKPg+G1Zaw5Lzl5Kha20mu+VlCVNioELFcc+WEgPq7Lj
X-Google-Smtp-Source: AGHT+IENv1wF/FlhJUBdDw7gbHcuc9C7OqOL6VgCxshez/VMiYYzHneKoAE1DtcwhSriDloEUjcrhg==
X-Received: by 2002:a05:6a20:3d07:b0:1a7:1c5:4746 with SMTP id y7-20020a056a203d0700b001a701c54746mr1717945pzi.1.1711744398901;
        Fri, 29 Mar 2024 13:33:18 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.128])
        by smtp.gmail.com with ESMTPSA id w26-20020a62c71a000000b006e635740126sm3524177pfg.112.2024.03.29.13.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 13:33:18 -0700 (PDT)
From: Shresth Prasad <shresthprasad7@gmail.com>
To: gregkh@linuxfoundation.org,
	hverkuil-cisco@xs4all.nl,
	christophe.jaillet@wanadoo.fr,
	prathubaronia2011@gmail.com,
	luca.ceresoli@bootlin.com,
	robh@kernel.org,
	u.kleine-koenig@pengutronix.de,
	frank.li@vivo.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	Shresth Prasad <shresthprasad7@gmail.com>
Subject: [PATCH] staging: axis-fifo: align arguments to open parenthesis in axis-fifo.c
Date: Sat, 30 Mar 2024 02:02:24 +0530
Message-ID: <20240329203222.12889-3-shresthprasad7@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Align some function arguments to the opening parenthesis of the
function as reported by checkpatch:

CHECK: Alignment should match open parenthesis

Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index c51818c56dd2..a70af76be7fb 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -376,8 +376,8 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 		 */
 		mutex_lock(&fifo->read_lock);
 		ret = wait_event_interruptible_timeout(fifo->read_queue,
-			ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
-			read_timeout);
+						       ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
+						       read_timeout);
 
 		if (ret <= 0) {
 			if (ret == 0) {
@@ -517,9 +517,9 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 		 */
 		mutex_lock(&fifo->write_lock);
 		ret = wait_event_interruptible_timeout(fifo->write_queue,
-			ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
-				 >= words_to_write,
-			write_timeout);
+						       ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
+						       >= words_to_write,
+						       write_timeout);
 
 		if (ret <= 0) {
 			if (ret == 0) {
-- 
2.44.0


