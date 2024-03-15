Return-Path: <linux-kernel+bounces-104354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A076887CC84
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0814CB22A15
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE5924215;
	Fri, 15 Mar 2024 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="m+EyuCEe"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59811C692;
	Fri, 15 Mar 2024 11:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710502745; cv=none; b=lhIN4Or1KuKN4RKS/+L4E2I8RzQwzLzMLYZPh1O7YjB7SJe0x+2Pg4eMxUbPdiGjzDkEracPC/u/aeAWhGxWyOhSWaYxkPfL77WDuWfMD1siKA3+zzU8NC6mn4MEZMqSMrYRJoTA2ab6WCmtAAjXYcVEO/O/waG4DJI1j7kiB08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710502745; c=relaxed/simple;
	bh=e1y/a3hAt3iIY1eG/bhFWCCip3ImzDp68z3R3ZufW3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xwzu25MZ2ZjUIli76vBHaHNkUeXa7oMbHKbxFd8ku3r0kSdrLLp+D/l3HiJ16RWg3dkrLFgYwhK4RqoXAlDWyobuhO+rf9RIuCj8WJWooAgx8PAf5BiPeoS5FxJmNS2rM1MBg/66HaZicNuPpi1moaR3AV8j1Bylf+64+M2PYEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=m+EyuCEe; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so562203166b.0;
        Fri, 15 Mar 2024 04:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710502742; x=1711107542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajSGsc6A/F/qkby1cV3DFijz3ujuoh7yFblhBSAWTk4=;
        b=m+EyuCEesIsDuGQ6AVn09GFl/Sc9Nd1IwniLlBRMSQlyFvpRQe/06nj77PnnEloORY
         ZSUZVXKOoAejW0/VB00UtZf6ZSbeD7uZzmqOzZV1T/1uIM3sB/aIuDjGDvyE6YnP4Fmr
         CBsKffMJAUEBZHNoPqPBsq+8XqN0JvTmBZrvp3biKpN+F9AxuvgpmCAIYK6+4pLBnXPH
         gpWTMbfeiTGUUiKu/sTJij2ePn5wtuqpfISjV/bRnlHOXgMKEpJV+Yj9eWkSExR6gmr8
         Wqu6i3pvXzzEfNsZ1cHXYDlN7u55voEv/tYewWcx49jKZgN4M7rurZB9+xf8KufXt1di
         dkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710502742; x=1711107542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajSGsc6A/F/qkby1cV3DFijz3ujuoh7yFblhBSAWTk4=;
        b=m2i20SLJ95nNtHMNV1/ybL3sZmOpq+j7FDhPe2un2YG1+HKFT1hsqT/k2KGh1cx92t
         FKeVy+mv3Tf/KT1bGmI2nKVZrmeXWV9mgnD+gobrHBNY8ieS1nM3Xg7f7hwakku6kuL9
         g7gKPZOUG874dQJxz/RW0FKLmCiQffDPgphsY2upx1/0KzxiGr4qin4Y8ZNDuwIGoXCZ
         pCYAUkAJn2YXS2OBCmWyEHG2H1DOnqF35AAGf4OJJTHDcyLMMzjaIWEiZJFoJrallF8E
         /062jBqZ+bYLQYlg8jrWjBQS5XV1rXeT/F7a/d3UCYLzObCK9k6gN6Vc7IEh9HNzssaz
         Gtlg==
X-Forwarded-Encrypted: i=1; AJvYcCU/u5xN97DqJsbxo/nBXCIhGdoK1TTMq11OvhNMcT1+NhREQal9tXbhUtGsp2her+EIccgs8RFBhbeC7GtuongHLOcx5VYALuN7NUcqQLRecxRzPQDKlPQfqSfGfeFnE6x2+PlfUdhG3HwCDYZlOOwXgaCbDVGBCHqdBweNDkt6W2x6UYEh7yu9A6Np9B89NwftCbbMeQ==
X-Gm-Message-State: AOJu0Yw30OxrMnn6dC7TIntAxALHSWajHgjtbL/snVeqf7ro73gHFDHq
	GuNDRrxxrDXLGjw5jSxqmoqawMJu3NzGbP2jMebzidmV1w336KcmuI0DRKaVjvUlcQ==
X-Google-Smtp-Source: AGHT+IHJJjdK95FxiFWtuKqFb5okKLCX+Xl17xr9ZeV/oMTb5MlWFKMC//tYf9kBKFRK8DaZbTEwfQ==
X-Received: by 2002:a17:906:1501:b0:a45:d7fb:8423 with SMTP id b1-20020a170906150100b00a45d7fb8423mr7825935ejd.9.1710502741739;
        Fri, 15 Mar 2024 04:39:01 -0700 (PDT)
Received: from ddev.DebianHome (dynamic-095-119-217-226.95.119.pool.telefonica.de. [95.119.217.226])
        by smtp.gmail.com with ESMTPSA id fg3-20020a056402548300b005682f47aea7sm1610024edb.94.2024.03.15.04.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 04:39:01 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: linux-security-module@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Haberland <sth@linux.ibm.com>,
	Jan Hoeppner <hoeppner@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 05/10] drivers: use new capable_any functionality
Date: Fri, 15 Mar 2024 12:37:26 +0100
Message-ID: <20240315113828.258005-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315113828.258005-1-cgzones@googlemail.com>
References: <20240315113828.258005-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use the new added capable_any function in appropriate cases, where a
task is required to have any of two capabilities.

Reorder CAP_SYS_ADMIN last.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Acked-by: Alexander Gordeev <agordeev@linux.ibm.com> (s390 portion)
---
v4:
   Additional usage in kfd_ioctl()
v3:
   rename to capable_any()
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 3 +--
 drivers/net/caif/caif_serial.c           | 2 +-
 drivers/s390/block/dasd_eckd.c           | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index dfa8c69532d4..8c7ebca01c17 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3290,8 +3290,7 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	 * more priviledged access.
 	 */
 	if (unlikely(ioctl->flags & KFD_IOC_FLAG_CHECKPOINT_RESTORE)) {
-		if (!capable(CAP_CHECKPOINT_RESTORE) &&
-						!capable(CAP_SYS_ADMIN)) {
+		if (!capable_any(CAP_CHECKPOINT_RESTORE, CAP_SYS_ADMIN)) {
 			retcode = -EACCES;
 			goto err_i1;
 		}
diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
index ed3a589def6b..e908b9ce57dc 100644
--- a/drivers/net/caif/caif_serial.c
+++ b/drivers/net/caif/caif_serial.c
@@ -326,7 +326,7 @@ static int ldisc_open(struct tty_struct *tty)
 	/* No write no play */
 	if (tty->ops->write == NULL)
 		return -EOPNOTSUPP;
-	if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_TTY_CONFIG))
+	if (!capable_any(CAP_SYS_TTY_CONFIG, CAP_SYS_ADMIN))
 		return -EPERM;
 
 	/* release devices to avoid name collision */
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 373c1a86c33e..8f9a5136306a 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -5384,7 +5384,7 @@ static int dasd_symm_io(struct dasd_device *device, void __user *argp)
 	char psf0, psf1;
 	int rc;
 
-	if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_RAWIO))
+	if (!capable_any(CAP_SYS_RAWIO, CAP_SYS_ADMIN))
 		return -EACCES;
 	psf0 = psf1 = 0;
 
-- 
2.43.0


