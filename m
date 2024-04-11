Return-Path: <linux-kernel+bounces-140771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1DC8A18E0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C397E1F22F8C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B41D446D6;
	Thu, 11 Apr 2024 15:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="q0a3Gw1b"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6214207D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849515; cv=none; b=Vf5ENib9AR+6gxVkKr7MLACvty3i9PWh5VdZd6WXPBpo5J7DKkLsTUzv2HV1eZZltH7xi3ProcAFAsuXnRBHWyXnfatTxICcZptEXQ+szPPsv8KwN+R6fe4muZ262off7z2j5czJHRWI3OQCeY2+ZmxXJASpLQdSimD5rhX9MZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849515; c=relaxed/simple;
	bh=J3ZRmS/kDm6SwyFvzMdRfKQv+UZSkFjqVo0zbnBiUNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gA4E74QGhcUTbuRt8dospmGi17okwZC5jH8pDbw0rpDK3O7reIZLxeTzzDoqkMdZTmA9G6ld5FHRQoup4pyktO/81FTohqs5zoqLzn97DsrlsqTY7W87KxLHsUi+8vp3ycTwI7imXYv54/F/rbaK7my5XA9boAuH0OjwNRpfAOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=q0a3Gw1b; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170414339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849513; x=1713454313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZL6EZ74fam3Jx/eLwHx98Jvd5reprRiIoAdDHUBvKk8=;
        b=q0a3Gw1bfOs70uXXnHc5phcrsGpX4JizkO2hECIFEeFc98aiGmESGKFPH8o9MXMQKB
         9hPjsV3SoRW/xeLhE019xgDeDYBpm+gGCFIaqeA/OFINJagX/drn2UZuSDd8ChzMNxgk
         IoVAoGUJB73pQT4noAqHTvfk4fogKl9dLYdTu7vyUtDMZiY5y0Ib8LQ7vmYubiOoT7fj
         NTzBpgXP0+Xzon0ZrhY9co5h1/8YEl0dUZxJ2o8+l0WticMU46nRC1FTrbLATCrCvRX2
         G1K3Akx9eaXkw2zem6AhckQQzGleUxFqVgt2L25CXbAsNfa3v5E0jDpR8yJb0TtCqXTk
         iRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849513; x=1713454313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZL6EZ74fam3Jx/eLwHx98Jvd5reprRiIoAdDHUBvKk8=;
        b=k9rtTAJ3/bm0UV3uNgddmDpwuodbrghSk2kK1vK65TCNS7SN+stLWK+ytoiKszUhDM
         N6VLxkC1aejefZYb7NRBmExuiKK9918NZddYyISLwiJhA3chj6w+QWvG6s6kxOGz/AW6
         qMtiSBRxK+EBfId2F9wC+07GrI2Ai9uY2HYpQKu1SKKXJcgNYe++8fk7PROYXRNpwdu1
         OWur78WUBmeMpS3sFOUpd6dj3iMAeajUZ0/l8vaEi/WHN2hWJ+5+pb+nOP8KPnnycF6D
         +JZhfzk4qwysvQQ7lDW3Qt2X+GEuaBPLZDfWOm3u8gpAQr+f24aLv7xCtBz41ozSOgHh
         8yyQ==
X-Gm-Message-State: AOJu0YzOoHhXjhJiTte/A9qDxxVSSRbRbPQBQ1N9Nwnwq49gQQo+D6jB
	HyA1fvsiHl24pUntxFmyotpnBg/dLfyEvn8UuIK7/SLehL6Mj/gHCBWd6bpvWCJxre2k1pdMP5a
	p
X-Google-Smtp-Source: AGHT+IEnXrUxK5hqmuMIbt1Slc0M5tsdshnceqv6keuouDTZDysIB0Q8chaIfFGDZ8qg+D0z55euCg==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr209645ioh.0.1712849513342;
        Thu, 11 Apr 2024 08:31:53 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:31:51 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 014/437] char/applicom: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:12:34 -0600
Message-ID: <20240411153126.16201-15-axboe@kernel.dk>
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
 drivers/char/applicom.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/char/applicom.c b/drivers/char/applicom.c
index 69314532f38c..9a1e5f7111b1 100644
--- a/drivers/char/applicom.c
+++ b/drivers/char/applicom.c
@@ -109,11 +109,14 @@ static ssize_t ac_write (struct file *, const char __user *, size_t, loff_t *);
 static long ac_ioctl(struct file *, unsigned int, unsigned long);
 static irqreturn_t ac_interrupt(int, void *);
 
+FOPS_READ_ITER_HELPER(ac_read);
+FOPS_WRITE_ITER_HELPER(ac_write);
+
 static const struct file_operations ac_fops = {
 	.owner = THIS_MODULE,
 	.llseek = no_llseek,
-	.read = ac_read,
-	.write = ac_write,
+	.read_iter = ac_read_iter,
+	.write_iter = ac_write_iter,
 	.unlocked_ioctl = ac_ioctl,
 };
 
-- 
2.43.0


