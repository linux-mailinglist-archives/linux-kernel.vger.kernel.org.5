Return-Path: <linux-kernel+bounces-96313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2332875A10
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 105C11C2166D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED72613DBB1;
	Thu,  7 Mar 2024 22:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UwMom9Lq"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6A220B38
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 22:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709849721; cv=none; b=SYazOWX9dJRPtvLjB+bqKwS6RRkzS1dtuiLH4HBnH+HIXv7gQTMh7lt62VNb5y8eL91+CTDGTi6Sbf8ipGZf88qFM23ltgUGAgT5YDIrCyA9tE/bwvf57qHbbV4oa81f0EI8TPDxVn4iJVfB56r7+UZd4Kwe7ru/n1l9yLxxQr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709849721; c=relaxed/simple;
	bh=xVjIxnXRza5ADO9nsi2doRpx+VjRsnIoZFjRiWHbyv0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lYyJi00LTOh/Q8RfBfKHWMlaCce2PknRvTT1exFJnCpnhUBXRUYww8mRxdxi3HAyEZRHV5ES6TQz5yVyi6wCkpeQ8raz+OKaL/TBYTEUXh4nR598+HCdFSwJLDswAXRNjbo7RkU0urS99Y4P2vYPgy7AK5K2yJI8iqicelqHi7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UwMom9Lq; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc0bcf9256so443626276.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 14:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709849719; x=1710454519; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7rzXLo7Z+/Q65u61DPW0fyUPb4sISQSDV3DIjd2co7U=;
        b=UwMom9Lq1cqR3pgDPmodAv2Rc7VGpxHs+TSyzNqc4ROfUo6qLZJkf62U31VkQofGes
         nBXSh8DpP9kTllBOGdc/qNLfkzZfUDURKLM3W1PAx3w9nesvfObZul8ZnA8vH5ZqRNgG
         SBwxb0xb4U9EB8Q+WuzOvkyAWQ1ZCSbfxJQHDFl5HlJFtp0XuHfqfQ2u/jnwbr8w+R6u
         GAPLk4xkkhlCK2PjKvkyUIN59ri7H0c/vSe3LIsl7TTB0sIXS9Fc65ylV75C4NaC4nRj
         lpSBVOw2nDyL+bK1fucDKv/GqbjKIj4iJQJy0RmnDcBLx024qFzfxE+G/BWnrB6WCK5J
         f1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709849719; x=1710454519;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7rzXLo7Z+/Q65u61DPW0fyUPb4sISQSDV3DIjd2co7U=;
        b=ralGhA4l9PUXBggHVuz60+24kFIzwEoxB85Pp3B3Xy+gMQJsHc7m7FHwlchrAJ0BCs
         ZLtWa+e1LAIK9REAzgeHeyjnHZAXgi81HySJjxPKvT+qIt2OIrxSRCMhRlxKrjxsdT1o
         UDtCeHQsN5GvHgQMvPG4dQhS+mzkZSO+lut5vnTZkzdvqF94Hab/oaG3dzhk45e3qPwv
         nmJNctl1qSDrbZKGizfhKJcnv/83xGaquOmCOAu9Ni8K63spgPh1hDYRmkcLms3cREGg
         SjKgUqjtQYk8ahKMXyYfLOgFs9BYPOscOAbIlLvn4Vbi+BKsvexAoPv7wEmQwvQnqTc3
         9t3A==
X-Gm-Message-State: AOJu0YzuYvSI6FmVzzH0aTXhhdF0RBIjJUaR62qUUfsYHDtR/lD6/fW9
	BL53yTxP2/kEDvNwKcSNR84F0g14RC1KzVGjsRBiYRb7yq1Sehufmxjn7nXt2qRPSsV5MqIeOZE
	AQ4kQSHeZxA==
X-Google-Smtp-Source: AGHT+IFkodcTmH2WhRKL5Guisq0dPblEAN2TuWVozqfDHwHkLazh4no4AcU34X9Cih1C+kj0HL3o1UyNSDUdjA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6902:1201:b0:dbe:30cd:8fcb with SMTP
 id s1-20020a056902120100b00dbe30cd8fcbmr663708ybu.0.1709849718793; Thu, 07
 Mar 2024 14:15:18 -0800 (PST)
Date: Thu,  7 Mar 2024 22:15:05 +0000
In-Reply-To: <2024030733-granny-octagon-7cfc@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024030733-granny-octagon-7cfc@gregkh>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307221505.101431-1-cmllamas@google.com>
Subject: [PATCH v3] binder: remove redundant variable page_addr
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Colin Ian King <colin.i.king@intel.com>, kernel test robot <lkp@intel.com>, 
	Carlos Llamas <cmllamas@google.com>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alice Ryhl <aliceryhl@google.com>
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
    v3: rebased, fixed conflicts with 0a97c01cd20b

 drivers/android/binder_alloc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index e0e4dc38b692..2e1f261ec5c8 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -925,7 +925,6 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 		int i;
 
 		for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
-			unsigned long page_addr;
 			bool on_lru;
 
 			if (!alloc->pages[i].page_ptr)
@@ -933,7 +932,6 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 
 			on_lru = list_lru_del_obj(&binder_freelist,
 						  &alloc->pages[i].lru);
-			page_addr = alloc->buffer + i * PAGE_SIZE;
 			binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
 				     "%s: %d: page %d %s\n",
 				     __func__, alloc->pid, i,
-- 
2.44.0.278.ge034bb2e1d-goog


