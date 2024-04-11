Return-Path: <linux-kernel+bounces-141204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3928A1AF7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D7F282613
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99AF1FF2F0;
	Thu, 11 Apr 2024 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TyeXDBpv"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150461FEAA9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850205; cv=none; b=E20oQ5Si3KBVfnUvo7WLolNW6z/EmR2AcO46HxxZ7OXERB9Y3OOBwbi/H6HPS58QeCed7UE9HprWmgGzzcSx782GA35cRfVkwIaEZ2rfR7HoRG2hEIZMKIXOd+AdFgY5Oc28z8B7nQE8EpT7x4r7Uqi41W4ke6sICBSpNuCA4vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850205; c=relaxed/simple;
	bh=6PyeHO716hueoVFuzJY+iI0R2MEZaUTNJe1YRiCxNsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5etyFyzIW7nXxBW4ko86irAk34n6NEy/pZucQ2d1PXcxdjbnj8wPdF5wcSjCG1gCfbynixoI6McOPfHXbAdraO1buXABkqf2CME2tkp4rRLRMlbHfgYwVdMfwLgF+Jh0t/S6PQFSXMA/FQrIEqt0mBnTJJMfIoABgbDPg9oxa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TyeXDBpv; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69701139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850203; x=1713455003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Og13f4CdpNy3Hyhdd6hAlI8AZ3h44M1OT6Qc6k2flXU=;
        b=TyeXDBpvg++5kbrj1M4YGu/AkJgjqvTlwsoTpbSjO2FrXbUKkvlTj5H8EJPizZCY4y
         +7kZ0J91Z3xC620v+JXTCQcTyeQzf1TF6ft5Wo6tQlq6w/zb+xq3uuw7MgHzGE3/rWhy
         QsCPoAezvFnMFXmYyYQnF6OyD0WwmBuK4XbKpFHEhUuNVnNEYhPIOp1fKo8YCo95aOYY
         yA6NaawTFsjZFP/OteICLg3wtDh4/z8G+OVLbBUTCbV/4ElyFawGuK4UpsJ8pmuNA6n9
         9TtwtGJBGSxwzpGLkt5bVRyC/pUU+rZRpKAGSs3rUi4QmeteGnyOUbzZ3Tmx6O9MJgSB
         gHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850203; x=1713455003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Og13f4CdpNy3Hyhdd6hAlI8AZ3h44M1OT6Qc6k2flXU=;
        b=kp7qFsSRgqAbDPRPTeCP2q2HcRL2/fEj/okN88h/zxX9pskRKabbLmjW1XoxkehXhL
         CS3fbZNk/kpNFFqvZPxbbLxaz999UMyWEvLQZT7qGibwEFoJcAqp2kk2S5GAGKJxBZTA
         I1EaZmGRYW4yvt1JEqkZp1D5amSkKoQTft8BwrDmPftNg3cq+GVzvXIX9aRGi3yZCArF
         tt0kbALbDLaCy1hJf/Yk2Ah37xMArFlC/CiSVQboPHuEsnXrLPVp7SJUsxN02x7bCGvW
         1P9aPmMogKVJnR902OJPoDKOHlUP7ZnpCLVm6MlW27Uu0w7hTOpx0dykxIqcLEeWa5EJ
         2D+A==
X-Gm-Message-State: AOJu0YxSHbUCQg4MQfnLxNHT8sGjP9bn/YciGePySxNktba5GPXzF2Qk
	w18Tpx0wipUgx3QY5v6T7LiMG6HRSIctDanUTGtiFAWyexAIP3/yuyyHNKbEcMP4ipAk5+9FwK/
	5
X-Google-Smtp-Source: AGHT+IErTa3ZqJYUSxlSx4PPEoMH+aN6soqSEt+zSTTQ4B+tU0TT6nrlsX+BfeP5YpK1OM7C5SKzsA==
X-Received: by 2002:a05:6602:84:b0:7d6:9d75:6de2 with SMTP id h4-20020a056602008400b007d69d756de2mr57390iob.2.1712850202997;
        Thu, 11 Apr 2024 08:43:22 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:43:21 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 420/437] media: bt8xx: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:19:20 -0600
Message-ID: <20240411153126.16201-421-axboe@kernel.dk>
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

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/media/pci/bt8xx/dst_ca.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/pci/bt8xx/dst_ca.c b/drivers/media/pci/bt8xx/dst_ca.c
index a9cc6e7a57f9..3e0cbd71cd0f 100644
--- a/drivers/media/pci/bt8xx/dst_ca.c
+++ b/drivers/media/pci/bt8xx/dst_ca.c
@@ -622,14 +622,14 @@ static int dst_ca_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t dst_ca_read(struct file *file, char __user *buffer, size_t length, loff_t *offset)
+static ssize_t dst_ca_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	dprintk(verbose, DST_CA_DEBUG, 1, " Device read.");
 
 	return 0;
 }
 
-static ssize_t dst_ca_write(struct file *file, const char __user *buffer, size_t length, loff_t *offset)
+static ssize_t dst_ca_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	dprintk(verbose, DST_CA_DEBUG, 1, " Device write.");
 
@@ -641,8 +641,8 @@ static const struct file_operations dst_ca_fops = {
 	.unlocked_ioctl = dst_ca_ioctl,
 	.open = dst_ca_open,
 	.release = dst_ca_release,
-	.read = dst_ca_read,
-	.write = dst_ca_write,
+	.read_iter = dst_ca_read,
+	.write_iter = dst_ca_write,
 	.llseek = noop_llseek,
 };
 
-- 
2.43.0


