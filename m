Return-Path: <linux-kernel+bounces-125822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F97892CB1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65281F22B82
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 19:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33E53FBAD;
	Sat, 30 Mar 2024 19:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jupwujvK"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD637748E
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711825283; cv=none; b=nQMo2oOqcyc5YjiI+1GBETppTyz0ZApQCRAtyWXOnFoRJkjl1YknE9INJATH3BejcmLQiE563pnfzYAasyJjwRZsXlVSHC7zquzpahfOwqme9YGFvZOnIigly7hRme8XhdON5B1KrSeABQuutnVn13d+5u9N/FdmwaZjXGQ9Zg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711825283; c=relaxed/simple;
	bh=V2ie+7To0BYnGaA6Bg61VOEnzM566Eh9HqIPS/sPS+E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=L421+3UV7yZ8JV+FOcqzpbi+4H0+ZuLbT0LFqh98SCSI74GLVWgAEfwKXdU4ucZlB3cY5Ed1t9Jd+m60FKHMjlRN5gB3libmMnv91she4AyvT5SfOpE1zX5Oxfe+2igWt0xjKFKbVgMxnZWwGcx6Qi7cL0P/aNTAy1IdiZZyWtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jupwujvK; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-614984f5a4eso3916477b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 12:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711825281; x=1712430081; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EiiUPjGvLxIO9csQLAqCT44/6WzHuWbceesLPgGHvn4=;
        b=jupwujvKPnEVr2547uOoND5rz7a1jnBe4iYdLzn0DwDqqtOFav7gqR2ZbB+xUpXznc
         LvqmYp7LKm9Ep9L3WbzfHi5WWQ0xMPI4ZomJFZ9BWcbsbVGhxFAXrlJF9mK9zOativXl
         oeb5F8+RD9QNyokiyTZDDcJX9hvAdT28bUEZQd8gdZE0Br6F7EZJCGeETt1G8McB7V1V
         QxmIvA496wAQ+w6bk7q4TfU3vsUKAkmZcgBSv5oBjkJAlcEh/63OHXqrPCWfF3Spmmlv
         9Sq0crdhNlxIU/F/SVuqAAlPFuOAQTz+RdL0w/fEfnVyt5pSe4nZ2fzu+wuDIY1LAB2N
         BIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711825281; x=1712430081;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EiiUPjGvLxIO9csQLAqCT44/6WzHuWbceesLPgGHvn4=;
        b=qtKhPAZUKqr6ZbaOF5uTeHYN7E0DBPrdEXaGp+7HsTBSpSu50Bz8FiPAbBlWkJD8iQ
         6OG3FyK4jiN16pAqZXSMGcL8pRPoDS2OeALnYptASzUYdC5WOkWkg6H4AxL6g4TXIdEy
         FL2qLyjXhr5cvss+9xNn3uqGjXc13Edlu0vY4svGAAyrxayAxnxEIIThN0fIT7xbJylr
         MtZJPjGw27ApyKk2qtUEVie1ooaZZsZ4thQ4I5PnLCXU+rVQ4lKCtCr2iyIyebIP+j9l
         jkQlIkHFkg5ChaYapNBQ5RGVYaTvH0R5mUqSOtV74pyJ9e4h4q/Oeia/ZCbf253EGe91
         0i9w==
X-Gm-Message-State: AOJu0Yy0Zb03/5u9+PsphiYUC7cvJy1kUco3iM4ByfsTf/FFKt6WJ8/m
	w48CLJ2GK9IyXMQ9j5Z/6wDXk9BAvTLXUrlNz7UL9q5TyQnGvnwP9yLlxU91Wxe/baS6hTNPt8M
	CPcfDvGzAwg==
X-Google-Smtp-Source: AGHT+IGDyyYN8rAC95fI7H3o05Eg+AmVi+hqzqOIA1YgZfoKA1eomN3IPZFZ7c7IcDrwBZEVCwChOjjsodo2HQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6902:2309:b0:dbe:a0c2:df25 with SMTP
 id do9-20020a056902230900b00dbea0c2df25mr502653ybb.8.1711825280848; Sat, 30
 Mar 2024 12:01:20 -0700 (PDT)
Date: Sat, 30 Mar 2024 19:01:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240330190115.1877819-1-cmllamas@google.com>
Subject: [PATCH] binder: check offset alignment in binder_get_object()
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit 6d98eb95b450 ("binder: avoid potential data leakage when copying
txn") introduced changes to how binder objects are copied. In doing so,
it unintentionally removed an offset alignment check done through calls
to binder_alloc_copy_from_buffer() -> check_buffer().

These calls were replaced in binder_get_object() with copy_from_user(),
so now an explicit offset alignment check is needed here. This avoids
later complications when unwinding the objects gets harder.

It is worth noting this check existed prior to commit 7a67a39320df
("binder: add function to copy binder object from buffer"), likely
removed due to redundancy at the time.

Fixes: 6d98eb95b450 ("binder: avoid potential data leakage when copying txn")
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index bad28cf42010..dd6923d37931 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1708,8 +1708,10 @@ static size_t binder_get_object(struct binder_proc *proc,
 	size_t object_size = 0;
 
 	read_size = min_t(size_t, sizeof(*object), buffer->data_size - offset);
-	if (offset > buffer->data_size || read_size < sizeof(*hdr))
+	if (offset > buffer->data_size || read_size < sizeof(*hdr) ||
+	    !IS_ALIGNED(offset, sizeof(u32)))
 		return 0;
+
 	if (u) {
 		if (copy_from_user(object, u + offset, read_size))
 			return 0;
-- 
2.44.0.478.gd926399ef9-goog


