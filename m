Return-Path: <linux-kernel+bounces-110796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAE3886410
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73EDF1C2179A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6DF3BB29;
	Thu, 21 Mar 2024 23:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="VsCJse60"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3B91B263
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 23:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711064794; cv=none; b=W6bnKdUdVKu5G3VHX658/araEkTECLbymRk8NEqM2OaqXBCgYaxCdJ2aPni4T7WCxFCntSCzIg9EjEHL3SlUUcQOVma394G4CX2xNJiTR+wum2X8jNgH+XkBBNFCuQbKLtsCY7yCWeG5pE1wILGV2txRsPIP1yQ2etVxZlqq0K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711064794; c=relaxed/simple;
	bh=GBp117Rw9ou09bC9vlczg3WmwjqjNQ4BV42hmHgOAGM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Eud1qnJRLCPs4pUJvtotLk1FjWQBLe0coattIhbf9nYbHnXddd3bqOpTA7TLo1hJ/fdKYQRv6PpOaALmk3ZR1YUT84d1bg0x3orZUS9kkRbbHKw6Pi9B1YmeGe4NuHHOnudBM6o/P630FnWV6eIY6AVeNmJuBetsE7qKiVgqap4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VsCJse60; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26ce0bbso2997864276.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711064791; x=1711669591; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TKcHHCSWCqgul2AOMbuKphpbCV9drtQafSH0+0DTZms=;
        b=VsCJse60j86WLf2PNMFujVaQX/q9AyhsHXmv/C09+wPlP+I0eZpkWyVD2nuHIr3e2w
         NsGGQJV5cM/vpLFlHwltfelhumVPrZR13P5ANwKcFg82SeZY9ULvH/FytwRXQTwCrYOI
         q8sitGGwDRXrgrziLBI6tJGwsJe3E13S4xFCW1BPRfOrawWEkh95DkZ1fmFUelM0zJj9
         g9fjDuAjILXtG7hGSbDt0wodKzHspkM/8kb3Ic/wV0fvs4U5UozufWb/ndF9eyK0GbY8
         gckRVGUM09dqaPOSPeL9t1MJZ+Nu093QYtukD/aDnHaX+VfZjnKRwbzFKF3n5ZHfoj7d
         CxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711064791; x=1711669591;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TKcHHCSWCqgul2AOMbuKphpbCV9drtQafSH0+0DTZms=;
        b=i04DscAoWKQ8Rd/Z0I870NHGyX5U1ipsHrxMCwCxptk2XClFcja8jA3IRmHoglW4Tr
         x0qRQDfofYVjvi4KjxS070C+HCK7gxj9DqpwGEJd4Z2XSW3eg3sHR/+9sipbf94aGMHc
         M5BI9E0KBD98o+5CyCsK+i0d0brL65EPcOilvLlbd7hQyD2eO0YAiSLNNQ3gv7Imof5f
         qqQgSsTWWTt/xgjEuDgCylJGfE7GWxyEnMul4mwHg/EwgQpggmoAFC4JK/hdb7JJzAmd
         YHyb1Cnsyw/LIiwgtNiCfmjxKnkzW7T9pRvhz0kIyOBBK5b3DuSuYr4h6ReyJ7j6MM5S
         vC9w==
X-Forwarded-Encrypted: i=1; AJvYcCWRteGKE397Fqnf5TfHPnLbuLPndZ8tl7kwvCjrB4iEahbhaW+dbMxfDSpNv8EXWClAxbmIQjQdqVxiBhmpHXroAxUExXUFqw8PpMoz
X-Gm-Message-State: AOJu0Ywu8u969qnCRmA9WeT2njTCPSZHomjkAisw5YVcIlwh0nRZskR2
	eoAI9yxsbSIUpR0CpqoqZqhX4snkidUGP9123HiErKmASlrEeUlLzafIcCQvAbL/QbSwgIYOg3H
	T+44vEIZCfjy0NnE3MrxSQw==
X-Google-Smtp-Source: AGHT+IGslFJ7I58NprLlYtxvFu8RungPyoqKiB8iuMyQ7S0Xf45CcMjYFnGLqEJkvq/9SAAdc0Ta5veeJ5B3mcEUmw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:100a:b0:dc6:ff2b:7e1b with
 SMTP id w10-20020a056902100a00b00dc6ff2b7e1bmr196400ybt.4.1711064791522; Thu,
 21 Mar 2024 16:46:31 -0700 (PDT)
Date: Thu, 21 Mar 2024 23:46:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANLG/GUC/x3MwQqDMAwA0F+RnA1oLQr+ytjB1WQGpJakikP8d
 8uO7/IuMFIhg7G6QOkQky0WtHUFYZnil1DmYnCN803nWrSsMaQfsuHCltbd8JxyVgzo6cPUD+x DP0MJkhLL+c9f7/t+AA3Ex21sAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711064790; l=3560;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=GBp117Rw9ou09bC9vlczg3WmwjqjNQ4BV42hmHgOAGM=; b=7eliCTZlOhrbirCoWB7C+nw7yQJFi+JZPUgfpGG0LQzr9Zvxig7qUqczMOmzK471p6Oo4nxWE
 EZp5nx2evR3AhFnqMtbF8E/P5IbKnWIgUu8C3qx4/qaT1i9Z166dvrZ
X-Mailer: b4 0.12.3
Message-ID: <20240321-strncpy-fs-hfsplus-xattr-c-v1-1-0c6385a10251@google.com>
Subject: [PATCH] hfsplus: refactor copy_name to not use strncpy
From: Justin Stitt <justinstitt@google.com>
To: Kees Cook <keescook@chromium.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated with NUL-terminated destination strings [1].

The copy_name() method does a lot of manual buffer manipulation to
eventually arrive with its desired string. If we don't know the
namespace this attr has or belongs to we want to prepend "osx." to our
final string. Following this, we're copying xattr_name and doing a
bizarre manual NUL-byte assignment with a memset where n=1.

Really, we can use some more obvious string APIs to acomplish this,
improving readability and security. Following the same control flow as
before: if we don't know the namespace let's use scnprintf() to form our
prefix + xattr_name pairing (while NUL-terminating too!). Otherwise, use
strscpy() to return the number of bytes copied into our buffer.

Note that strscpy() _can_ return -E2BIG but this is already handled by
all callsites:

In both hfsplus_listxattr_finder_info() and hfsplus_listxattr(), ret is
already type ssize_t so we can change the return type of copy_name() to
match (understanding that scnprintf()'s return type is different yet
fully representable by ssize_t). Furthermore, listxattr() in fs/xattr.c
is well-equipped to handle a potential -E2BIG return result from
vfs_listxattr():
|	ssize_t error;
..
|	error = vfs_listxattr(d, klist, size);
|	if (error > 0) {
|		if (size && copy_to_user(list, klist, error))
|			error = -EFAULT;
|	} else if (error == -ERANGE && size >= XATTR_LIST_MAX) {
|		/* The file system tried to returned a list bigger
|			than XATTR_LIST_MAX bytes. Not possible. */
|		error = -E2BIG;
|	}
.. our error can potentially already be -E2BIG, skipping this else-if
and ending up at the same state as other errors.

This whole copy_name() function could really be a one-line with some
ternary statements embedded into a scnprintf() arg-list but I've opted
to maintain some semblance of readability.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
---
 fs/hfsplus/xattr.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 9c9ff6b8c6f7..00351f566e9f 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -400,22 +400,13 @@ static int name_len(const char *xattr_name, int xattr_name_len)
 	return len;
 }
 
-static int copy_name(char *buffer, const char *xattr_name, int name_len)
+static ssize_t copy_name(char *buffer, const char *xattr_name, int name_len)
 {
-	int len = name_len;
-	int offset = 0;
-
-	if (!is_known_namespace(xattr_name)) {
-		memcpy(buffer, XATTR_MAC_OSX_PREFIX, XATTR_MAC_OSX_PREFIX_LEN);
-		offset += XATTR_MAC_OSX_PREFIX_LEN;
-		len += XATTR_MAC_OSX_PREFIX_LEN;
-	}
-
-	strncpy(buffer + offset, xattr_name, name_len);
-	memset(buffer + offset + name_len, 0, 1);
-	len += 1;
+	if (!is_known_namespace(xattr_name))
+		return scnprintf(buffer, name_len + XATTR_MAC_OSX_PREFIX_LEN,
+				 "%s%s", XATTR_MAC_OSX_PREFIX, xattr_name);
 
-	return len;
+	return strscpy(buffer, xattr_name, name_len + 1);
 }
 
 int hfsplus_setxattr(struct inode *inode, const char *name,

---
base-commit: 241590e5a1d1b6219c8d3045c167f2fbcc076cbb
change-id: 20240321-strncpy-fs-hfsplus-xattr-c-4ebfe67f4c6d

Best regards,
--
Justin Stitt <justinstitt@google.com>


