Return-Path: <linux-kernel+bounces-47214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F958844A99
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C951C23973
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3184539AC7;
	Wed, 31 Jan 2024 21:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ts7Dp+dE"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146D839AF0
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 21:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706738034; cv=none; b=Ka6IQPFboOPCMQ4cqdy9kLsC037yZLGCLEX6zenU6X1UZgTMU9RqGpc7BscnjCRztnB3HqTFb0N5ee/XDWvDHnIJVbN4WFPCwNVnEZ0ADn2hBUWutbuJsomILVvA99q2xJsURZ4eAO9YD+ZecnIgrJZJdkaMOTvi2LTDCCalOnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706738034; c=relaxed/simple;
	bh=4xLkjEkNsl/vSzQQL56AarzQ/fTqiFXmSV0hiQdMmlk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=St6Mtq1yusDQ7PU7+ZYiCBVsplk6Al1OFaZmkkikcJSgDv+vB58DH8MjotfXD9G9M42e7aTZ5Ua8bjHzCRxQXrYLZcwiYvpzeV7Rd5aoDhj0h8aO8dc92bRYFh4r/fQ3ZbOnIFkVqU6RM8SL7azWgYex2cj0Ck7xg61HCkbZUpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ts7Dp+dE; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5cec090b2bdso284537a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706738032; x=1707342832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AnAFDV1t3aX3RqRk7DxFRUBw8cn5gMxBfRf2X8ihrDQ=;
        b=ts7Dp+dEbWqxSHWt3fm+nmu7jkU4nnsqztFMCRfiJ1+VDtrh1TGu/9f4BAt+BTuJfR
         tfdarsz1Gr2RZ4bbH8yoRSNoxKLOqz0XzwEmpALjOHHg6lhDR/HMR1w9q9bphBFdWdFO
         H+AuEdPA0ZWdVEVTNUN4LwFNDBlOTH+jpfmMFxDd38rNsFkq0tEWl4kKDoCIXJHETA+Q
         axfBK+z7jhOIp/QBKGcumzrkxGPadja3c9+xI11Shf279v60pkNcmwyi4UbM3BEorqhD
         +kxgCst6bTAvbOi2pcY52txZN4qGOpCvl2CBZGmdhXGhUFek2VIPNC+d7CGR8jY+JTiG
         ZKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706738032; x=1707342832;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnAFDV1t3aX3RqRk7DxFRUBw8cn5gMxBfRf2X8ihrDQ=;
        b=heMhG9XTHgU2IRajVEc32oeviCdxxkiksavmkNnjft0Q/hdQNGWJWbkapDvi8WJlps
         4nXd1ff3I6am2W5r9/s3mNWP946dSYryVVcHFJ+Ri7gRt3u3IiJ9w+XDMnh5fwtY5Xns
         S1CEAX15klRlN7gA1PjChSVpsvfWyUqTi5WXlUav4LM6C3a5CENyKvcJa0aSYSGzoi0N
         41szQJpoJT1zY/0HHSrPS8AnA8RRSVzi9X4IszZcvrRNY137vBo6DnLfLhgruloRTAjF
         JdcmOs3kXh6wBuwjfBFw/fqWnp+63xrOiIxpW5xWBijQnfEYMVMxvBKa/QfKVSPy9qRa
         xZVA==
X-Gm-Message-State: AOJu0YxMP29XsdAGbGoQ0S7eNxZ4G99ZS9K9QVY4kpLWoRLBrxsdxQ9r
	bLBhBqVf+PnNMXCfY4KhO4vq8ERLpRHKkFfeiMo5e7MCvif/3I/HAY+v6Y4l+TcbLDLExH5l086
	Na1rOiUtHZg==
X-Google-Smtp-Source: AGHT+IFw6WY4nDhnNbNIWITwqwDxfY1lJTf1DEXlQdSElsdLgqA96aMQvdRmrPsG2L2Y4tLmcXzdBHByoz4zCA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a65:68c5:0:b0:5d8:51e2:c8ca with SMTP id
 k5-20020a6568c5000000b005d851e2c8camr636pgt.2.1706738032095; Wed, 31 Jan 2024
 13:53:52 -0800 (PST)
Date: Wed, 31 Jan 2024 21:53:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240131215347.1808751-1-cmllamas@google.com>
Subject: [PATCH] binder: signal epoll threads of self-work
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Brian Swetland <swetland@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Alice Ryhl <aliceryhl@google.com>, Steven Moreland <smoreland@google.com>, stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In (e)poll mode, threads often depend on I/O events to determine when
data is ready for consumption. Within binder, a thread may initiate a
command via BINDER_WRITE_READ without a read buffer and then make use
of epoll_wait() or similar to consume any responses afterwards.

It is then crucial that epoll threads are signaled via wakeup when they
queue their own work. Otherwise, they risk waiting indefinitely for an
event leaving their work unhandled. What is worse, subsequent commands
won't trigger a wakeup either as the thread has pending work.

Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
Cc: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
Cc: Martijn Coenen <maco@android.com>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Steven Moreland <smoreland@google.com>
Cc: <stable@vger.kernel.org> # v4.19+
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 8dd23b19e997..eca24f41556d 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -478,6 +478,16 @@ binder_enqueue_thread_work_ilocked(struct binder_threa=
d *thread,
 {
 	WARN_ON(!list_empty(&thread->waiting_thread_node));
 	binder_enqueue_work_ilocked(work, &thread->todo);
+
+	/* (e)poll-based threads require an explicit wakeup signal when
+	 * queuing their own work; they rely on these events to consume
+	 * messages without I/O block. Without it, threads risk waiting
+	 * indefinitely without handling the work.
+	 */
+	if (thread->looper & BINDER_LOOPER_STATE_POLL &&
+	    thread->pid =3D=3D current->pid && !thread->process_todo)
+		wake_up_interruptible_sync(&thread->wait);
+
 	thread->process_todo =3D true;
 }
=20
--=20
2.43.0.594.gd9cf4e227d-goog


