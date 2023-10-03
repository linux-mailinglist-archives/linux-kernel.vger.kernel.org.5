Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C9B7B7200
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241020AbjJCTqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241001AbjJCTqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:46:07 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8968ABF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 12:46:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d865f1447a2so1687926276.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 12:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696362363; x=1696967163; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KHojRgQcvHJlG3tNkbT5JYy4vaQ9RVgTVjOSA6AH+sQ=;
        b=XiqKhHZPLH4u07w/7Cv0397UGeq3riVtQ+6IopmmJTx1IBU7ENDtd36FIaIzzriX1l
         TRm4vEBzWPhJiMhlKZCS5fPNxbIwFPk36izfGFF8VsrnWr8CiTMLpiO1CkXo9T8C7JzS
         YopAEjxgCBeokfCuu3mE/nERXoSs67zRnWtwx5xqgSOhWXE07OW5BT6us0Hp7VFT8S4V
         qrQBpym+hI9XtEMnN4pgQmOINSxTQioD1xzrzsqODAuQa2vakzXLZPWIY7MHC5+Y8drV
         UYC52RHymY2pjv65CMfVikh8SYrTxNWNyAl08YDJdsLyL28b/bv9mQAjpRDRbyPz3dAe
         13vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696362363; x=1696967163;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KHojRgQcvHJlG3tNkbT5JYy4vaQ9RVgTVjOSA6AH+sQ=;
        b=eoBpoMgSZVjbxnY7ZeH1HiBDjH6nXGE2qOtqyoBWraK+K7w3Z7/dJ4tiirsb7AunuF
         6MItxV9u30XmL9CVEozEPRw9GC/MNJF8VWhtG73ckLU1z4N6yASy1tctQYTOXBA3Clth
         MRuC3Val3xfb2UpZIcUwxyYMIomDZGyj0Mk4+B3knFd3JsVae0Coss29JAvCS3/PFhq4
         /GO+RR6APf6lVEqQbwwN0kD1sH76OiJqrdizHFtxz1PvXI0arVYJ27tfcfB0No/eldoH
         3mcML7nQt/5qgHoepTd8T4hp/4dMnCEkZzNWNIQN40RvLW00e1AWXlC/C70M8G3MvTqz
         Pk/g==
X-Gm-Message-State: AOJu0Yx938LzaAgWtMOnikOEtDoth0cWo1/sK3uimRsVHv2RGRSlDYVF
        5EEK0PQB05Wg55tHBrYDVdJT5Doy8aiPe29HADXl
X-Google-Smtp-Source: AGHT+IEqhtFQcshbqUK4gTfwcaeBbR5gxWj6j2J6NdanzQb0K4203DhX5lB+56HhQWq3zs1Ah3+xDDFNYZ8+YYbf0JmL
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:6577:b8c1:dd2d:1c93])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6902:212:b0:d89:b072:d06f with
 SMTP id j18-20020a056902021200b00d89b072d06fmr3912ybs.7.1696362362806; Tue,
 03 Oct 2023 12:46:02 -0700 (PDT)
Date:   Tue,  3 Oct 2023 12:45:46 -0700
In-Reply-To: <20231003194547.2237424-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20231003194547.2237424-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231003194547.2237424-5-axelrasmussen@google.com>
Subject: [PATCH v2 4/5] ioctl_userfaultfd.2: fix / update UFFDIO_REGISTER
 error code list
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alejandro Colomar <alx@kernel.org>, Peter Xu <peterx@redhat.com>
Cc:     linux-man@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The list of error codes in the man page was out of date with respect to
the current state of the kernel. Some errors were partially /
incorrectly described.

Update the error code listing, so it matches the current state of the
kernel, and correctly describes all the errors.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 man2/ioctl_userfaultfd.2 | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
index 2ee6a0532..95d69f773 100644
--- a/man2/ioctl_userfaultfd.2
+++ b/man2/ioctl_userfaultfd.2
@@ -388,12 +388,6 @@ On error, \-1 is returned and
 .I errno
 is set to indicate the error.
 Possible errors include:
-.\" FIXME Is the following error list correct?
-.\"
-.TP
-.B EBUSY
-A mapping in the specified range is registered with another
-userfaultfd object.
 .TP
 .B EFAULT
 .I argp
@@ -408,21 +402,32 @@ field; or the
 field was zero.
 .TP
 .B EINVAL
-There is no mapping in the specified address range.
-.TP
-.B EINVAL
+The specified address range was invalid.
+More specifically,
+no mapping exists in the given range,
+or the mapping that exists there is invalid
+(e.g. unsupported type of memory),
+or the range values (
 .I range.start
 or
 .I range.len
-is not a multiple of the system page size; or,
+) are not multiples of the relevant page size,
+or
 .I range.len
-is zero; or these fields are otherwise invalid.
+is zero.
 .TP
-.B EINVAL
-There as an incompatible mapping in the specified address range.
-.\" Mike Rapoport:
-.\" ENOMEM if the process is exiting and the
-.\" mm_struct has gone by the time userfault grabs it.
+.B ENOMEM
+The process is exiting,
+and its address space has already been torn down
+when userfaultfd attempts to reference it.
+.TP
+.B EPERM
+The userfaultfd would allow writing to a file backing the mapping,
+but the calling process lacks such write permissions.
+.TP
+.B EBUSY
+A mapping in the specified range is registered with another
+userfaultfd object.
 .SS UFFDIO_UNREGISTER
 (Since Linux 4.3.)
 Unregister a memory address range from userfaultfd.
-- 
2.42.0.609.gbb76f46606-goog

