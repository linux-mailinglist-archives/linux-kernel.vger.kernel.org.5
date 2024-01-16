Return-Path: <linux-kernel+bounces-27756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A9C82F567
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04CDFB23AC2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BD91D52C;
	Tue, 16 Jan 2024 19:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DhrMKED5"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531401D521
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 19:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705433574; cv=none; b=g5Q+yaA5hi/6mWzH10E5ouKifioEEhy+xYQqdFjpgO19WBOAkAAg5y1B+3lUZP9BIVpZooNBM6aQuQJqB+slC9IKRAq6LpYqnz0RhLMCNw8y7uwfpRsiPUGcijWJ/8kQFLr5wCen/DhWkCMzIP/j1JCiiVzNLLiL8WUDAicxGqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705433574; c=relaxed/simple;
	bh=uztMAYweAeGONkWIxBSH0OIgUwqvadi5AoXFlyDjQvE=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:
	 From:To:Cc:Content-Type; b=i4Q4TZ268vliekda6AEooDlw7gzmc6kI1zfmHjlhc0cRF5BCezno157ty5+6qBeoZ7XixlBt+4QYkuBs8CG6UZrke7VJjqZlF5rzEyCsUUD/UHaLYOzxYmssoQAf6u32AXgwbzXlAbAWtQ/VYDgm5CpyuOeJw1NDJHP3msWhidA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DhrMKED5; arc=none smtp.client-ip=209.85.219.202
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc22f3426aeso758271276.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 11:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705433572; x=1706038372; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xYCBFPQRcQFQPD2haBQ2nJTVfjNvtLaSSb90X3QyQCw=;
        b=DhrMKED5QJVzwrS7YcuqQIRI6pUlJ/g90YUx/LJQw2YAN4/0Brr/8uIQuNDrlYG6Zg
         WudBa+c1mIDCD7Owl9Pvrx0KBowpGA4Bz5tqHtGJChvRaFrxnnYDtkR9YgEIVGGSP9eq
         ylM9mmzne1pqtGjsiwD5SvxCbrhaV+m2Yz2V8HEkR+FnkVIQgNysq8fb37F7vNAb3IR2
         uKqT2M/5nnGiugnNqYFWLimb59hWWX33KNFrNiQKaCe4BQcJrnVDGP1YnbB9RrQ1NQef
         PcPVAgXFFX5Ha6n35kvm4fxww7iSuYY5VYlE+tTwk1dcQGoVJ/4tUW3K/ZPNabMyqgRk
         H8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705433572; x=1706038372;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xYCBFPQRcQFQPD2haBQ2nJTVfjNvtLaSSb90X3QyQCw=;
        b=H1HamDPHFQcVhx6Szi3f3LWfakWoAQCGk+QNdHB0Xl4vuc83OPUzY2bYVu/CGPzq+B
         NWMjuhDEwmumLo81m2hPpYB96F8+GLLFtYgHcxO+XzYdAdDC3EInIdNfgbWn7Dx1MXCE
         TdDZUAGJPDdIuAZV1HAXrjD0nmReOzki+gN7m6DQf8HGruv6XOFH91KHoCA5vbh5W24f
         2uizzh9X9FIXWmlmfCNlRQZmofyX57+3kvUvbNr5jLLYY2bowLVF9pTLblVLGmknjB60
         hRFhTKw1FnSRM9jchMjKBH0En2pmBscERQeaLpQS2F3uFIIpHDnObYHDG223sOYf8B6o
         cjtw==
X-Gm-Message-State: AOJu0YyfiLwPu8JBFhDwKV4jHUidX9CExdANkRI3RGrtRWdzDiyDhzsH
	iFKWtt4CvdDWtthjnJXi4ewgmxrRmtss6dkXZMI3
X-Google-Smtp-Source: AGHT+IEt9/FUpzcDNvpy3XU/eiLKfjpxmLYextNhRGGEei8WedRc9F3SZCNtFswrXqd4fE4WU2k7Ewagm5ckzA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a25:aac7:0:b0:dc2:232b:5cf1 with SMTP id
 t65-20020a25aac7000000b00dc2232b5cf1mr595610ybi.1.1705433572369; Tue, 16 Jan
 2024 11:32:52 -0800 (PST)
Date: Tue, 16 Jan 2024 19:32:34 +0000
In-Reply-To: <https://lore.kernel.org/all/ZZl_-XGd-WJ0juz9@google.com/>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <https://lore.kernel.org/all/ZZl_-XGd-WJ0juz9@google.com/>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
Message-ID: <20240116193235.184666-1-cmllamas@google.com>
Subject: [PATCH v2] binder: remove redundant variable page_addr
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Alice Ryhl <aliceryhl@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Colin Ian King <colin.i.king@intel.com>, kernel test robot <lkp@intel.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Colin Ian King <colin.i.king@intel.com>

Variable page_addr is being assigned a value that is never read. The
variable is redundant and can be removed.

Cleans up clang scan build warning:
warning: Value stored to 'page_addr' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@intel.com>
Fixes: 162c79731448 ("binder: avoid user addresses in debug logs")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312060851.cudv98wG-lkp@intel.com/
Acked-by: Carlos Llamas <cmllamas@google.com>
---

Notes:
    v2: added tags, used char-misc-next as base

 drivers/android/binder_alloc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index a4a4dc87ba53..34d7a1494bc7 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -925,7 +925,6 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 		int i;
 
 		for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
-			unsigned long page_addr;
 			bool on_lru;
 
 			if (!alloc->pages[i].page_ptr)
@@ -933,7 +932,6 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 
 			on_lru = list_lru_del(&binder_freelist,
 					      &alloc->pages[i].lru);
-			page_addr = alloc->buffer + i * PAGE_SIZE;
 			binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
 				     "%s: %d: page %d %s\n",
 				     __func__, alloc->pid, i,

base-commit: 5850edccec30325707f953bc088497b3b9041231
-- 
2.43.0.275.g3460e3d667-goog


