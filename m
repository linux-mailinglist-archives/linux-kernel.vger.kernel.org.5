Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06557A6B22
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbjISTDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbjISTCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:02:49 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34221A6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:02:32 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59e758d6236so36987027b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695150151; x=1695754951; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B/mBNxS046NndSUiuzLhVh8+as48kp1msWTNOB3shRo=;
        b=Ua8QGL2++mD9dEdg+sAx/FcJHqAsM5UhJQ3xLWs1T3+FEAbdPlQBBbZiTzJZPtRJcj
         zEo2awLPU7Rl3GJYMA/0fCdInO64l3hdcByzrVvS9DfW/6sZ41Ny/1Z2A2KCr5xGXn26
         sPcH9s9TSoeqDyh6IrLOhngvAGHRM9dC3yZ9VbblH0ueTgc4oUxhkNvOYZdwfBPUSaKL
         wqG3vLEVq+rqRbN+jo1/6jTBdkNAGXOr8XidYggPftdGrLmDdCXpTgn3G2GHZ+p7bSxW
         8mvRjrXS9Na7HQdrpOlKEyskvUrCScfa0mscy4cxzVDEcv3tsD0FfD/7b/ZNiUm6xKKY
         X6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695150151; x=1695754951;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B/mBNxS046NndSUiuzLhVh8+as48kp1msWTNOB3shRo=;
        b=gHiQwUwatWM8vANfFjCnulNze7UIeiRsMj8VlDbQkOBAF5sgAPJ0DmscQf8S1KAsk4
         J5tdH8xMvsKUUIpbv1PD4k/WYQvsx0qOusF0r9qtOehy8zL5h4THx6XM+MRzUltH220+
         bKYF/dFLeugaShNjBJkNGx1ROUs2LZSmdiBor6TTKa9bmwhIJyaWPmfMbD2HgfVzUEvH
         wFPHus2bRBdYEtaoJZG5WfOhQEXi5PcSwW8U8sBTApFN7u5rjonsvtgH+fkpL436wMKr
         6ZUwl199v1JCARexlYXcTQ6ZcrvF6/M/8jXs5JyIGj1Ct5QIbUS8rpTIi0ke7pXubqf2
         2wGg==
X-Gm-Message-State: AOJu0YwGwvgfBvH39+jpKrzLiySY7gpfswEe/DzSKUMF/PSlhcGp/K8h
        w/akMUWAl/oFc5We4OLDvH71lwqtkz7kercP4vU/
X-Google-Smtp-Source: AGHT+IH7a8feDFG+W7LkkHL8xBQ33JOSLVkr8l24lseUZrRLYRoJu9ErPhz702o9Ru0cy8y+86WKdCJVmDC1f0ZBz4hx
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:8f5a:6a6a:cafc:a3ad])
 (user=axelrasmussen job=sendgmr) by 2002:a81:ae07:0:b0:59b:ba8a:97d0 with
 SMTP id m7-20020a81ae07000000b0059bba8a97d0mr6086ywh.3.1695150151389; Tue, 19
 Sep 2023 12:02:31 -0700 (PDT)
Date:   Tue, 19 Sep 2023 12:02:05 -0700
In-Reply-To: <20230919190206.388896-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20230919190206.388896-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230919190206.388896-10-axelrasmussen@google.com>
Subject: [PATCH 09/10] ioctl_userfaultfd.2: fix / update UFFDIO_REGISTER error
 code list
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alejandro Colomar <alx@kernel.org>, Peter Xu <peterx@redhat.com>
Cc:     linux-man@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
index 29dca1f6b..afe3caffc 100644
--- a/man2/ioctl_userfaultfd.2
+++ b/man2/ioctl_userfaultfd.2
@@ -413,12 +413,6 @@ On error, \-1 is returned and
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
@@ -433,21 +427,32 @@ field; or the
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
2.42.0.459.ge4e396fd5e-goog

