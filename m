Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE907A6B1D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjISTCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjISTCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:02:35 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B48EB3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:02:26 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d81646fcf3eso6628378276.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695150146; x=1695754946; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NEXa90h/68GUsd6orjyORkWHy9a7mT47IoYQaYRrJqY=;
        b=4BGM7sKNay44Df+g1Nw7jE50VV4DWrA0nROlWCooGG1H1RemZ7SOImOL3JqwGUF5p2
         YG+SI8JO1m/4mD27dbBhBBEgNGOhzValgvOf7S8LqtniXOdj2CXynEgooHy6K1lfoQzI
         XXdbQmMQgUoVI6LGhPMudhzAvkbFtyWu6iL6RgVcAtrgAOcNArFcIEkO9z/HommLEkJK
         pEJ4zaP9tQbNq3F/AFP9sOHxPOJTMDEMps+2YVNSooWH+1bCNOQUcOmygMX/yv//z4H6
         ZutUQhgR9lK5EJlnZiwZOyrnW6Zsu0eMJhp2rT6WGWyPWekZ3IZThOAIRWqu+JLcLfJT
         8mBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695150146; x=1695754946;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NEXa90h/68GUsd6orjyORkWHy9a7mT47IoYQaYRrJqY=;
        b=d33S8FtDyVc2WQnjDUW8DGNx2CqCMW2WU/Tl76KbWEq/H5AQIBnaS2Eu9CVQq3oTN9
         CLA4W2AzAP5jQp2DcKyMRsS77pa4LjNiQ5nFEY6mZiwpe/NgYwrxMMAeYORXW/E0jwB5
         /na+rKVXKZlgPfbSuzQXHBY4mMGAjg/GVXgZCMzl44RLVkfoUooDYSnzTvZqK+5ftdBC
         0vmlAmwGvJ/OGzhDvVKlOg/ZPscumkt3CBGQqkbM1aUjm0Yps/XrqogpCTtR86vr9qFJ
         Ax38ihjuAsExWo/TY1W9T+i8oZ1PAHPXcFJVl38OsGrHsebSeXzQjlPRj4TWFwIbpEuy
         iCUA==
X-Gm-Message-State: AOJu0YwiKNSjzwVwBVmCcgyZgCmEQ2dou79aXhlmw0C4D2VS0BqN/VuS
        NP+T6DYpi31p/TK09IIAdfA4+mxSgIlDVwnZajr3
X-Google-Smtp-Source: AGHT+IFCWTBj+STf+JQII+aukLsaaJkmL6LUdqEggx41JkN/znYtNCrIQg6lN+ju+ooY+qcE8V78UIKtBAjD3/9uU5Cw
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:8f5a:6a6a:cafc:a3ad])
 (user=axelrasmussen job=sendgmr) by 2002:a25:6802:0:b0:d7b:3917:4606 with
 SMTP id d2-20020a256802000000b00d7b39174606mr6912ybc.11.1695150145976; Tue,
 19 Sep 2023 12:02:25 -0700 (PDT)
Date:   Tue, 19 Sep 2023 12:02:02 -0700
In-Reply-To: <20230919190206.388896-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20230919190206.388896-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230919190206.388896-7-axelrasmussen@google.com>
Subject: [PATCH 06/10] ioctl_userfaultfd.2: describe missing UFFDIO_API
 feature flags
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

Several new features have been added to the kernel recently, and the man
page wasn't updated to describe these new features. So, add in
descriptions of any missing features.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 man2/ioctl_userfaultfd.2 | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
index e91a1dfc8..53b1f473f 100644
--- a/man2/ioctl_userfaultfd.2
+++ b/man2/ioctl_userfaultfd.2
@@ -204,6 +204,13 @@ If this feature bit is set,
 .I uffd_msg.pagefault.feat.ptid
 will be set to the faulted thread ID for each page-fault message.
 .TP
+.BR UFFD_FEATURE_PAGEFAULT_FLAG_WP " (since Linux 5.10)"
+If this feature bit is set,
+userfaultfd supports write-protect faults
+for anonymous memory.
+(Note that shmem / hugetlbfs support
+is indicated by a separate feature.)
+.TP
 .BR UFFD_FEATURE_MINOR_HUGETLBFS " (since Linux 5.13)"
 If this feature bit is set,
 the kernel supports registering userfaultfd ranges
@@ -221,6 +228,22 @@ will be set to the exact page-fault address that was reported by the hardware,
 and will not mask the offset within the page.
 Note that old Linux versions might indicate the exact address as well,
 even though the feature bit is not set.
+.TP
+.BR UFFD_FEATURE_WP_HUGETLBFS_SHMEM " (since Linux 5.19)"
+If this feature bit is set,
+userfaultfd supports write-protect faults
+for hugetlbfs and shmem / tmpfs memory.
+.TP
+.BR UFFD_FEATURE_WP_UNPOPULATED " (since Linux 6.4)"
+If this feature bit is set,
+the kernel will handle anonymous memory the same way as file memory,
+by allowing the user to write-protect unpopulated ptes.
+.TP
+.BR UFFD_FEATURE_POISON " (since Linux 6.6)"
+If this feature bit is set,
+the kernel supports resolving faults with the
+.B UFFDIO_POISON
+ioctl.
 .PP
 The returned
 .I ioctls
-- 
2.42.0.459.ge4e396fd5e-goog

