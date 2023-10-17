Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A747CD029
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 01:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344244AbjJQXB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 19:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbjJQXBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 19:01:22 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C92F1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 16:01:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a61f7aaf8so8189313276.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 16:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697583680; x=1698188480; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zhGJS9TSuAOI7ph8IS5R88r99qDdTpF/uHgtYeaRs+U=;
        b=wCjNKJx/ShdeEviPYVdOhSJW2e/90RTsvrh9/XLGcpzh+2tv8CroON8LkokJeAYpow
         5TYNMpptwb8DYPfxWJFM04xsSbBfE6eX/Bbdg1qat3hZ/HkjmG6L0msGMP3q+R+duuJK
         82AizqdTqc2XuvkGJzUDWHs4y8a58lLiaZR+IdCyn4ZImuOOPM/5gg1cNYwPvN/NkM5W
         b8DSqTP9ogRG6Lq+0OhcfQwoNc6E/qOp1RX3RWWr3H72jGO2P1oY9JY3mv0EBYs/tAMv
         vaw3jx3suGhmsqSKYHWYVa69R8XW0SK1UjV2R4QrjumNmS94ZSnsCdEs+MmgUcEydYge
         0KrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697583680; x=1698188480;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zhGJS9TSuAOI7ph8IS5R88r99qDdTpF/uHgtYeaRs+U=;
        b=nce5cLKLk0ygEWzTMpfHbHCBm4cldExH0PY0ZhTMXDf+CHr1urNi1lJK8EB5fDbmto
         RJqSzyvl7alNL1BO520zarsZ1WaqiP5Jio46oNTmOjmG9ZBsZs9lqw7LogGPpdDD8rDC
         NKEjR3d/URLEQqncotVcA6CUvTAbK0M/UCj4EGSyFaqakmi19g5xtAFRQGIgIdkUDf1C
         Rlx0GqsvDkAHuOkRrLSDFRHzXKmMKKVcdYVfRnT/gkYemgMjoDt/VIqTOzDpEIJT8LQP
         a+XfyRkte4LnomCojE9R4yrpyrrVA2uljCA49XSwvY/bGv5bdzUr/9Cyzt9hQIfNvyjV
         /zew==
X-Gm-Message-State: AOJu0Yx0RmgihkckAw4tRtFy6AQ5M+BiuzIqTqm32VQlx1h8AFtzUMmj
        ojeTheCkgrfiCGeYfHXqKAJ7VDjuSetFxw0wQbT3
X-Google-Smtp-Source: AGHT+IGUIIMYcfHcAX/EFWTsWCSWt3CWSp3wyfZIjOY21JWpjm5WYGNByO8zTW1z94HmtGuIWpM6167CUq/2ldotqPAL
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:cd04:35d6:a586:5c86])
 (user=axelrasmussen job=sendgmr) by 2002:a25:8c86:0:b0:d81:7617:a397 with
 SMTP id m6-20020a258c86000000b00d817617a397mr80370ybl.9.1697583680159; Tue,
 17 Oct 2023 16:01:20 -0700 (PDT)
Date:   Tue, 17 Oct 2023 16:01:09 -0700
In-Reply-To: <20231017230110.3170850-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20231017230110.3170850-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231017230110.3170850-3-axelrasmussen@google.com>
Subject: [PATCH v3 2/3] ioctl_userfaultfd.2: fix / update UFFDIO_REGISTER
 error code list
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alejandro Colomar <alx@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>
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
 man2/ioctl_userfaultfd.2 | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
index 82aee667c..40528001e 100644
--- a/man2/ioctl_userfaultfd.2
+++ b/man2/ioctl_userfaultfd.2
@@ -413,8 +413,6 @@ On error, \-1 is returned and
 .I errno
 is set to indicate the error.
 Possible errors include:
-.\" FIXME Is the following error list correct?
-.\"
 .TP
 .B EBUSY
 A mapping in the specified range is registered with another
@@ -433,21 +431,28 @@ field; or the
 field was zero.
 .TP
 .B EINVAL
-There is no mapping in the specified address range.
-.TP
-.B EINVAL
-.I range.start
+The specified address range was invalid.
+More specifically,
+no mapping exists in the given range,
+or the mapping that exists there is invalid
+(e.g. unsupported type of memory),
+or the range values
+.RI ( range.start
+or
+.IR range.len )
+are not multiples of the relevant page size,
 or
 .I range.len
-is not a multiple of the system page size; or,
-.I range.len
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
 .SS UFFDIO_UNREGISTER
 (Since Linux 4.3.)
 Unregister a memory address range from userfaultfd.
-- 
2.42.0.655.g421f12c284-goog

