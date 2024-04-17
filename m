Return-Path: <linux-kernel+bounces-149110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34ED88A8BEA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD5B1F22C3D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378F928DC1;
	Wed, 17 Apr 2024 19:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AwgLfEIC"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034A122F19
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 19:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713381309; cv=none; b=qYdRMrxKFCv9QJDvoCMoWFmNlNVWfrcxJwhO3BaGR0ULfeS08umCCoVFyGltMeFw85miYCz90YPkTul3z5cE73woj++ybIYLyZBuRgiZjJHaq4C+u5ZDO+kbWyhoUPa+HrYLKtemdNx6rpaml+2gZ+cNHwSFPqfu651AKKbDvS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713381309; c=relaxed/simple;
	bh=9m6EeZARuCquPm7RqgMRj/Y6+Pz9ykI3aeF46NyBRd8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EbTK6Afb5zuanFpqQXphy3mA+rn++K9Nlv+ShmldhPixjwNlnmW5akxHi1Tah0FfsCYukIDBviepIBLHJVKZwrM2XRBtMMs77+OvsFTV4YHh5Fr2ej7SYG1pEmVTkqa0aRL/gcmgQfeH6Jz4gM5h4wlBFFu016LIu9/1z0WZvX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AwgLfEIC; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc3645a6790so198845276.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 12:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713381307; x=1713986107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wtuC/jSL94p6uXVWmWyzEtwt8JX/bgW/Wy1kn2uTmbk=;
        b=AwgLfEICw6SectDDMYBA31zejC6ZTV59zOZQ4ohGXQ/YEi7ie6lZY0udXRjYsvwjFq
         MWXiOSQZVpKLYlsU6QMzGBo3BW/q7l2WokcGQrUKeHq6lDrBuZDKvqk2jvvX5CkBgPrA
         9nSzFwx9pHIXAWml7fg60gY8Fhl8allqiPxw0OUnUzjFgTK0Fkwj52AC6tTUi4M1bO/5
         l+OHJBesArUHUjTg+1YfH5Clf2bG/lT6Yz+pA2kl9ZjUSrzrzRDXix3Jkx2Itc2BaC+C
         rr5hwLUwjL15nLZtTG/IisHMyfK/KsYVBjHJhhgbE1WfXbHzgYORFFz74DatI9OHwY3q
         LqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713381307; x=1713986107;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wtuC/jSL94p6uXVWmWyzEtwt8JX/bgW/Wy1kn2uTmbk=;
        b=pWsSVk0KTk2YIvZYlzG8TzDZdHZxEnsgS5aFJ64TIyiflB2XS+vNoQ4jVm1CQGnbaz
         GRqLU3Rc5eXnLCBHz3BmJ16zQIfggeuPIKBuhSKcUTZ5yJxa2VkDO2409pYh6dxBq6co
         crXRcOjznU4P759vE7JgwSNn7xM82Pt9MWTdT+S9Uac7w3MgATKNXFhuk4zdd1DZ65gv
         efB4RFNzgJke48IXtTcqDfmx+NBrSzXL81d7q4bbvGDQ0MzLSXLiP/7tbCVxfR9qM1hj
         5+b5tsjIcOxaOnya45L7EhzxsP8QMNr63FGDnGpGJnB5bWtKUAEoJIMKXRb73DnM0S9O
         I5SA==
X-Gm-Message-State: AOJu0YzxCm1LxSQNSUHGJKESXdhHK2lMJFff1/tAkfzO2Z1f8onXiYA/
	9J+DbY/WMBQy71xAHVNeovwpqDqwNRSzatYGG3QE3He2OFVNdIjpp1SkiZfgqIU/IbnwAb0aPRJ
	cZGd3ARe+5A==
X-Google-Smtp-Source: AGHT+IFnAylSDwidRckCpHK4Ltu3c7DPl7aywbX7vV2VTuv7KcgZ6Ho/+Ds9VfyU9pjc6n/QTu+AecIFm+iJzA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6902:2b08:b0:dc6:d233:ffdd with SMTP
 id fi8-20020a0569022b0800b00dc6d233ffddmr80854ybb.0.1713381306966; Wed, 17
 Apr 2024 12:15:06 -0700 (PDT)
Date: Wed, 17 Apr 2024 19:13:42 +0000
In-Reply-To: <20240417191418.1341988-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240417191418.1341988-1-cmllamas@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240417191418.1341988-3-cmllamas@google.com>
Subject: [PATCH 2/4] binder: migrate ioctl to new PF_SPAM_DETECTION
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Alice Ryhl <aliceryhl@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Deprecate the BINDER_ENABLE_ONEWAY_SPAM_DETECTION ioctl in favor of the
new PF_SPAM_DETECTION flag. The ioctl can be lumped together with other
flags to avoid a separate system call. The driver still supports the old
ioctl for backwards compatibility.

Suggested-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c            | 7 ++++---
 drivers/android/binder_internal.h   | 1 -
 include/uapi/linux/android/binder.h | 8 ++++++--
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index e0d193bfb237..54d27dbf1de2 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4486,8 +4486,8 @@ static int binder_thread_read(struct binder_proc *pro=
c,
 		case BINDER_WORK_TRANSACTION_COMPLETE:
 		case BINDER_WORK_TRANSACTION_PENDING:
 		case BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT: {
-			if (proc->oneway_spam_detection_enabled &&
-				   w->type =3D=3D BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT)
+			if (proc->flags & PF_SPAM_DETECTION &&
+			    w->type =3D=3D BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT)
 				cmd =3D BR_ONEWAY_SPAM_SUSPECT;
 			else if (w->type =3D=3D BINDER_WORK_TRANSACTION_PENDING)
 				cmd =3D BR_TRANSACTION_PENDING_FROZEN;
@@ -5553,7 +5553,8 @@ static long binder_ioctl(struct file *filp, unsigned =
int cmd, unsigned long arg)
 			goto err;
 		}
 		binder_inner_proc_lock(proc);
-		proc->oneway_spam_detection_enabled =3D (bool)enable;
+		proc->flags &=3D ~PF_SPAM_DETECTION;
+		proc->flags |=3D enable & PF_SPAM_DETECTION;
 		binder_inner_proc_unlock(proc);
 		break;
 	}
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_int=
ernal.h
index a22e64cddbae..3312fe93a306 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -434,7 +434,6 @@ struct binder_proc {
 	spinlock_t inner_lock;
 	spinlock_t outer_lock;
 	struct dentry *binderfs_entry;
-	bool oneway_spam_detection_enabled;
 };
=20
 /**
diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/andro=
id/binder.h
index 281a8e2e734e..972f402415c2 100644
--- a/include/uapi/linux/android/binder.h
+++ b/include/uapi/linux/android/binder.h
@@ -253,7 +253,9 @@ struct binder_extended_error {
=20
 /* Used with BINDER_SET_PROC_FLAGS ioctl */
 enum proc_flags {
-	PF_SUPPORTED_FLAGS_MASK,
+	PF_SPAM_DETECTION	=3D (1 << 0), /* enable oneway spam detection */
+
+	PF_SUPPORTED_FLAGS_MASK =3D PF_SPAM_DETECTION,
 };
=20
 enum {
@@ -269,9 +271,11 @@ enum {
 	BINDER_SET_CONTEXT_MGR_EXT	=3D _IOW('b', 13, struct flat_binder_object),
 	BINDER_FREEZE			=3D _IOW('b', 14, struct binder_freeze_info),
 	BINDER_GET_FROZEN_INFO		=3D _IOWR('b', 15, struct binder_frozen_status_in=
fo),
-	BINDER_ENABLE_ONEWAY_SPAM_DETECTION	=3D _IOW('b', 16, __u32),
 	BINDER_GET_EXTENDED_ERROR	=3D _IOWR('b', 17, struct binder_extended_error=
),
 	BINDER_SET_PROC_FLAGS		=3D _IOWR('b', 18, __u32),
+
+	/* This is deprecated, use BINDER_SET_PROC_FLAGS instead. */
+	BINDER_ENABLE_ONEWAY_SPAM_DETECTION	=3D _IOW('b', 16, __u32),
 };
=20
 /*
--=20
2.44.0.683.g7961c838ac-goog


