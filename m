Return-Path: <linux-kernel+bounces-149109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBD48A8BE8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 030661F22D1B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6614624B33;
	Wed, 17 Apr 2024 19:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vyAyEgWh"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4821D36AE4
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 19:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713381296; cv=none; b=qDOZX/hIf92HOLqtTRCLU5PZSaTsynF9X0HQmNV+wEV44MyRTr+fZ7aKeXyQCv2JYvoYVfjJjzX3rFHqsaCdYv43uMrnjvVuGTEdiXwl7dFi1uB+0Y385e6JRWy/g+Mgqkv+e0wNXHlb0YcFuqOQvNXxxhdond2C2/KuzyejfEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713381296; c=relaxed/simple;
	bh=IKNpru5OPVki2SHKGA6nEmwCLM3XR3Z/O47OScdmKY0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iqc2gDZt7Fd/LrU/2dhS237tQKu0nuFn2scTnP46AsMJ7V8GqMIFkQZkvqJ4KR/29bvIVyCwVmZLC/kRE0r/FhsqAi10rzyE+LcIaTKoAeXfB23QYNtwxxmn4aeJUaT4N2VP5kLpaKFcXPoW8goLgsGfkhCNv0bxPanR8YPbCOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vyAyEgWh; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5e5022b34faso38081a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 12:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713381294; x=1713986094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PafBYw7ONOcmBuCbUCHZmMlU0Q7ADjoXpXWusviXFGE=;
        b=vyAyEgWh/9pt/YgiIDwf54idaHt1S1hYtWOkX823HBgyBMb1a2IyEfcQp/hISju0mg
         TgYwngD/KYgyUpvUIm7adsyg2GdCPaSTpI2VO9KsVYuorsnumqbRP0It336JE7pG6ASA
         idDBDDBhUdKOOSJGpJGzDN7juQW01qZ9ETtMSfHuJFMf/ri29ypM8CBcN6v6Nl+HgGzR
         kdWxU/5X0sZIMOMPit9uYCyAC1MhIPCCum1AdLlhsLyhqCLSIe/7vYX2nW7MFTCSX0lS
         gRfLCL7xRi0cBEBrgQUiL+eJGIIaQm8xWehNtVD1kBzOyqdyVhcwCyXyznsvVqJxXMAs
         7lyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713381294; x=1713986094;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PafBYw7ONOcmBuCbUCHZmMlU0Q7ADjoXpXWusviXFGE=;
        b=Pm7RrARFH3Vz3WlDfc3QA24Vg3fd2z0y3lSff+lhyRD2S62ZlRn1KqzAZ7Cxhqwu2E
         r2Qcs3kNFkT8jNIhIxLHbfLfabPlFyvs51DVsjRAvy/qgXd9kXNkPq1KGAfVYNMJ32PU
         4KB6OwVwDKT7qdO/MlL3gZIIQYxaKCKLhCdnGa3a1zT9jGpXUn6j/AdJaaHJZx8vUHgx
         hogFnappGDbSoB3TFKoSziGAAnuRqZH7wnq3iq1YgM9U8b/6cjuYKm3QbAGEbzH+YHYU
         QkvR7rczWtghvVjmT24Ue49weWAdEFia3HJGUlxWwib4QIBaErjHmn066qxo8NKzZ1U3
         DECA==
X-Gm-Message-State: AOJu0YyuRShQc9lLvXpAYjCfUFhAgDC6d+mTN0Yi00rtCULBOl5q1JGl
	jsfznNEN7NSRENOdpdWwtrSxfSx+XNaaMAEX6zRx31Vcd3DhvsNbFmh+ylj7rniUlb36aEC/Cwo
	OAXkZSbRmOQ==
X-Google-Smtp-Source: AGHT+IGtRoeqa9/s3PLrLUxy8CjokWV6b4MpFaVUxIoXCMqg3uRU+jsHFhwZ6hkIBayrQyka8srgIHmr/EALcQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:902:fa05:b0:1e7:b7c8:f79e with SMTP
 id la5-20020a170902fa0500b001e7b7c8f79emr6195plb.5.1713381294383; Wed, 17 Apr
 2024 12:14:54 -0700 (PDT)
Date: Wed, 17 Apr 2024 19:13:41 +0000
In-Reply-To: <20240417191418.1341988-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240417191418.1341988-1-cmllamas@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240417191418.1341988-2-cmllamas@google.com>
Subject: [PATCH 1/4] binder: introduce BINDER_SET_PROC_FLAGS ioctl
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Alice Ryhl <aliceryhl@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This new ioctl enables userspace to control the individual behavior of
the 'struct binder_proc' instance via flags. The driver validates and
returns the supported subset. Some existing ioctls are migrated to use
these flags in subsequent commits.

Suggested-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c            | 25 +++++++++++++++++++++++++
 drivers/android/binder_internal.h   |  4 +++-
 include/uapi/linux/android/binder.h |  6 ++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index bad28cf42010..e0d193bfb237 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5334,6 +5334,26 @@ static int binder_ioctl_get_extended_error(struct bi=
nder_thread *thread,
 	return 0;
 }
=20
+static int binder_ioctl_set_proc_flags(struct binder_proc *proc,
+				       u32 __user *user)
+{
+	u32 flags;
+
+	if (get_user(flags, user))
+		return -EFAULT;
+
+	binder_inner_proc_lock(proc);
+	flags &=3D PF_SUPPORTED_FLAGS_MASK;
+	proc->flags =3D flags;
+	binder_inner_proc_unlock(proc);
+
+	/* confirm supported flags with user */
+	if (put_user(flags, user))
+		return -EFAULT;
+
+	return 0;
+}
+
 static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned lon=
g arg)
 {
 	int ret;
@@ -5542,6 +5562,11 @@ static long binder_ioctl(struct file *filp, unsigned=
 int cmd, unsigned long arg)
 		if (ret < 0)
 			goto err;
 		break;
+	case BINDER_SET_PROC_FLAGS:
+		ret =3D binder_ioctl_set_proc_flags(proc, ubuf);
+		if (ret < 0)
+			goto err;
+		break;
 	default:
 		ret =3D -EINVAL;
 		goto err;
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_int=
ernal.h
index 7270d4d22207..a22e64cddbae 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -346,6 +346,8 @@ struct binder_ref {
  * @cred                  struct cred associated with the `struct file`
  *                        in binder_open()
  *                        (invariant after initialized)
+ * @flags:                enum proc_flags set via BINDER_SET_PROC_FLAGS.
+ *                        (protected by @inner_lock)
  * @deferred_work_node:   element for binder_deferred_list
  *                        (protected by binder_deferred_lock)
  * @deferred_work:        bitmap of deferred work to perform
@@ -409,6 +411,7 @@ struct binder_proc {
 	int pid;
 	struct task_struct *tsk;
 	const struct cred *cred;
+	u32 flags;
 	struct hlist_node deferred_work_node;
 	int deferred_work;
 	int outstanding_txns;
@@ -417,7 +420,6 @@ struct binder_proc {
 	bool sync_recv;
 	bool async_recv;
 	wait_queue_head_t freeze_wait;
-
 	struct list_head todo;
 	struct binder_stats stats;
 	struct list_head delivered_death;
diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/andro=
id/binder.h
index d44a8118b2ed..281a8e2e734e 100644
--- a/include/uapi/linux/android/binder.h
+++ b/include/uapi/linux/android/binder.h
@@ -251,6 +251,11 @@ struct binder_extended_error {
 	__s32	param;
 };
=20
+/* Used with BINDER_SET_PROC_FLAGS ioctl */
+enum proc_flags {
+	PF_SUPPORTED_FLAGS_MASK,
+};
+
 enum {
 	BINDER_WRITE_READ		=3D _IOWR('b', 1, struct binder_write_read),
 	BINDER_SET_IDLE_TIMEOUT		=3D _IOW('b', 3, __s64),
@@ -266,6 +271,7 @@ enum {
 	BINDER_GET_FROZEN_INFO		=3D _IOWR('b', 15, struct binder_frozen_status_in=
fo),
 	BINDER_ENABLE_ONEWAY_SPAM_DETECTION	=3D _IOW('b', 16, __u32),
 	BINDER_GET_EXTENDED_ERROR	=3D _IOWR('b', 17, struct binder_extended_error=
),
+	BINDER_SET_PROC_FLAGS		=3D _IOWR('b', 18, __u32),
 };
=20
 /*
--=20
2.44.0.683.g7961c838ac-goog


