Return-Path: <linux-kernel+bounces-141014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B283F8A1A52
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 337C1B2F0B1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192A417D036;
	Thu, 11 Apr 2024 15:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cBOCkMds"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B9C17D005
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849904; cv=none; b=NRRO6C6fjU0Er4hoxf9grgofNd155G92bwU4ppKpCe5MyfvL4Y2Y5aBl9nU0Leh3KWKCdVkesgjEr2nyVHEjvZj52HPuqjgATEv6IYyqV8JDwYQQdPtgDk3Y1G+PoOko/obKhIY0oDsApz18LqzHeMg1mFUwdwgndshGMDxZ7LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849904; c=relaxed/simple;
	bh=E2wx/0FL1TQR0BsAabiuUfktTaJ7onkJ24+tyDM+ewU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oW6Pxy9sNnAUO2zK0sIfjVSO4i0R6XDARDi4RAiMndvwQQf8BJDh+CrybZ/iH4+ZSTspyGuTP4XnFSSBeTvbsaKLCmN/IeBT6q2KqvpZm7ixqBMxqkZUZk4shAxafMDre3rd03drA2SLiO3Bw/5bBGlOSzB8nxNu+zkEVrluLzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cBOCkMds; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8991939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849902; x=1713454702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdXV8ZsMH7zUbt3+z3Z9fZuxmHYAX1pvA/Y9quQEfus=;
        b=cBOCkMdsBOAcYmA6bitrpRVwtKBPwqSIB6WBeekRnbtnRqZUqmjvct2ECwB7nQ3dv9
         4aUjWb2aQnqvds2IKjKw9Fhh2w7waSzgRO4SaIWjj+sKa4DoNQSa+lvO98kBOX45PuMB
         Em21HbW4/DULHz9Td9ZZZgZWUrq1jXKXWm9hd/JgQ+DaKEaBv633UZMN2ZiQ3hdx2y8Y
         tIbxSw5t/SiyVTUL9eI0lF61dac84RQBAY5oF3ulFlg7ahbqgBiiv7WGYpZFEMRPu721
         P9vuxzXA8sFcbTJ1XMFUQEPLIuaVkY93sjy88sty9lrNxk7eS6nch1QaXHB9sGiVlIMc
         TbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849902; x=1713454702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdXV8ZsMH7zUbt3+z3Z9fZuxmHYAX1pvA/Y9quQEfus=;
        b=c5fUEOP/d8pu01VHjZXty+uZsXlcqtZRq61VoMTD3+pRyVMIYfQVdgnAX57CyT8RWw
         Rx5dvFtqE2C4GVYXV3uQTiZ31VkO1GJ6MSQDBugulsl0F0rpZ7x0mOULJaMMyNL6qGvp
         l8X50+s4fqous7OFw0kXfqo/0olXcIOKnAr3QkFTVynphuHF3mlVgB2HyVCl31K8zeBD
         WYO9U3JL778SxzAd04hfTIA0U2s0Yxlt2v8lgbBKQTzy1DaWu7znl1767Ak1S1CLgSJe
         IUB9cdHAM9ljuovpXile3H76/sVFOb2Vz8BKcbre2v0mdQCpnVdA1TB1cUj2seiglznn
         pNXA==
X-Gm-Message-State: AOJu0YydmK6trUVDvQxpDYkA8sF+0ddwZfkfRVBY+3AtxlCPudpa/Efu
	hcJcvgIA4B0sF1krg7feGsR+l4xNWztW7KnTtZ8zuVv64JuIPu+SS3KAs9BM2G/WTFNbOgbGLiI
	j
X-Google-Smtp-Source: AGHT+IHZFZfM0kIu9pfljFzZLFycWuKGa7YxO9qmmY+N0Y1NVNfICo8J+2Ib/cobvcwvH2ZU+Xsj2A==
X-Received: by 2002:a92:2912:0:b0:36a:f9aa:5757 with SMTP id l18-20020a922912000000b0036af9aa5757mr3588463ilg.2.1712849900494;
        Thu, 11 Apr 2024 08:38:20 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:19 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 240/437] watchdog: geodewdt: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:20 -0600
Message-ID: <20240411153126.16201-241-axboe@kernel.dk>
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
 drivers/watchdog/geodewdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/geodewdt.c b/drivers/watchdog/geodewdt.c
index 5186c37ad451..2a0c904536d9 100644
--- a/drivers/watchdog/geodewdt.c
+++ b/drivers/watchdog/geodewdt.c
@@ -108,9 +108,9 @@ static int geodewdt_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t geodewdt_write(struct file *file, const char __user *data,
-				size_t len, loff_t *ppos)
+static ssize_t geodewdt_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t len = iov_iter_count(from);
 	if (len) {
 		if (!nowayout) {
 			size_t i;
@@ -119,7 +119,7 @@ static ssize_t geodewdt_write(struct file *file, const char __user *data,
 			for (i = 0; i != len; i++) {
 				char c;
 
-				if (get_user(c, data + i))
+				if (get_iter(c, from))
 					return -EFAULT;
 
 				if (c == 'V')
@@ -197,7 +197,7 @@ static long geodewdt_ioctl(struct file *file, unsigned int cmd,
 static const struct file_operations geodewdt_fops = {
 	.owner          = THIS_MODULE,
 	.llseek         = no_llseek,
-	.write          = geodewdt_write,
+	.write_iter     = geodewdt_write,
 	.unlocked_ioctl = geodewdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open           = geodewdt_open,
-- 
2.43.0


