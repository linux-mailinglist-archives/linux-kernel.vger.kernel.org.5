Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBAF7B71FD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240984AbjJCTqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240985AbjJCTqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:46:04 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640249E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 12:46:01 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f8040b2ffso19700877b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 12:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696362360; x=1696967160; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nSwsPxGjU1Rb9Mh5qgmhu8siiN6wKhSBap+YrmkGvmo=;
        b=Pd9SK3SCC8XYtdvCkW9OWI3b/vojrwi3PAWRiKO3zZhpTS8aEFKNymTz+mUdWvW9Ua
         r3frU1La3/2MjnYK3/E7NCxEbv+gf6utCPmir5kKSFOb0AdvxWLviV1yBg0EdqeFZYyy
         V5LWYJ2FjpmdQghLZxeFlNIxIzan/BIJxg7kFcOTZKNiFlPvvS4YPi/ho65NEtLjV87i
         84GZygbITCqJcyiwIYxOODwu7ijuFGOEVwC09T1sn38VSk3wriZkQRqDyBXTLCEjeph8
         fQHNeY8b6nTwk9VvRXhg2++Z6xaJjAd470hbYnvgrr6EXpa7M5cBkhWPFYo3/s7cbfXW
         QtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696362360; x=1696967160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nSwsPxGjU1Rb9Mh5qgmhu8siiN6wKhSBap+YrmkGvmo=;
        b=ibbp/fNFOgOpnnSGflOZGzt10kJO5yCk88oXaDsPeaLym5ShFBSzUGqjDui2RJXYnT
         3t1yBUj6yeqfmhL0NEtpMRZUg+VxwPYYhlV4I8QbTVvnAgNuCgzJR2ggh+Xb68/38W78
         mB+5/mD1ZwrNoKlKIs1ZR/fM5SNlnzRrWBjaM4qdA7PCLt4FPPgGf7FdnmeOEqbWqv/q
         RMnxwUS++B78LruiN4xC0uwPOhbRTq/koe/zezsuMv3HIYrTD5W3sDPvtjpyfNKOUK45
         6kxPYS90Fzk4mX1zC34x7XDnf8A8xI7w9B4QVzbfn6cqbEbO2M9/nGjtURpAxvNScuDZ
         V3bA==
X-Gm-Message-State: AOJu0YywtWypXqlBhbVAE/IxevgKOisRTVxOrGQhwd0O+5vLy01QyoXO
        iwUr1niNZ6Nb+Ls+cfBUlIw8YtMVqNGZ+e0OEaLP
X-Google-Smtp-Source: AGHT+IG3ycgZ1ANRvhM0b8aR3O2JnbWKMJw5/2E7Y5Hu+lkyPvKs0PdaMQEwpxKlWPfeoGQhQE8730YP86ImtOIxI0CZ
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:6577:b8c1:dd2d:1c93])
 (user=axelrasmussen job=sendgmr) by 2002:a81:ae53:0:b0:59b:f138:c843 with
 SMTP id g19-20020a81ae53000000b0059bf138c843mr9811ywk.3.1696362360670; Tue,
 03 Oct 2023 12:46:00 -0700 (PDT)
Date:   Tue,  3 Oct 2023 12:45:45 -0700
In-Reply-To: <20231003194547.2237424-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20231003194547.2237424-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231003194547.2237424-4-axelrasmussen@google.com>
Subject: [PATCH v2 3/5] ioctl_userfaultfd.2: clarify the state of the
 uffdio_api structure on error
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alejandro Colomar <alx@kernel.org>, Peter Xu <peterx@redhat.com>
Cc:     linux-man@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old FIXME noted that the zeroing was done to differentiate the two
EINVAL cases. It's possible something like this was true historically,
but in current Linux we zero it in *both* EINVAL cases, so this is at
least no longer true.

After reading the code, I can't determine any clear reason why we zero
it in some cases but not in others. So, some simple advice we can give
userspace is: if an error occurs, treat the contents of the structure as
unspecified. Just re-initialize it before retrying UFFDIO_API again.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 man2/ioctl_userfaultfd.2 | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
index 28dd2fcdd..2ee6a0532 100644
--- a/man2/ioctl_userfaultfd.2
+++ b/man2/ioctl_userfaultfd.2
@@ -248,6 +248,14 @@ operation returns 0 on success.
 On error, \-1 is returned and
 .I errno
 is set to indicate the error.
+If an error occurs,
+the kernel may zero the provided
+.I uffdio_api
+structure.
+The caller should treat its contents as unspecified,
+and reinitialize it before re-attempting another
+.B UFFDIO_API
+call.
 Possible errors include:
 .TP
 .B EFAULT
@@ -281,14 +289,6 @@ feature was enabled,
 but the calling process doesn't have the
 .B CAP_SYS_PTRACE
 capability.
-.\" FIXME In the above error case, the returned 'uffdio_api' structure is
-.\" zeroed out. Why is this done? This should be explained in the manual page.
-.\"
-.\" Mike Rapoport:
-.\"     In my understanding the uffdio_api
-.\"     structure is zeroed to allow the caller
-.\"     to distinguish the reasons for -EINVAL.
-.\"
 .SS UFFDIO_REGISTER
 (Since Linux 4.3.)
 Register a memory address range with the userfaultfd object.
-- 
2.42.0.609.gbb76f46606-goog

