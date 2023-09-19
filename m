Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B3C7A6B15
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbjISTCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbjISTCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:02:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A974B3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:02:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d8141d6fbe3so6614023276.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695150137; x=1695754937; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x6ui7w7cp8TYbfd07TcF3y+H8C9qnaw+znngkakEYjM=;
        b=LcscbQOX3ImqVLH+5kec+ofiycAZm4qAuxza/IugfiRNp3zXc+GMQm+POfpFCPEeA+
         5lTTbanDD9Po9U/OHM6kYeaK9UKFVaj+CJPjwyfROJcdBXnmIHrShKZxCV8SuXBgvVBg
         UES1b6xTUdQZsGckZk+azzRakl5HCQYatGRqrDRPqetyEOrF4ARqjNgIr3Ppw8QL6lR4
         RHjnz87lUQ7kE0cFJJfhGatk7AGkyeYXPh0LqIriz1pALWbB1JPkQn0Cz/IMDhAPM5fa
         YXkIlmKEm4AmLQIU7wOU5hVxLXPUTK9OziWtaeGheuhn+tJVeKBd/zZMlCpqxP5hF+ae
         JUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695150137; x=1695754937;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x6ui7w7cp8TYbfd07TcF3y+H8C9qnaw+znngkakEYjM=;
        b=Lz+Z1NjYwI8cofXe870KzDGjaol/KuTEdGuojwUudfApL4pvz69MWmp2FVFTt47TX1
         QGY2NwReCtM1y1gEuFh/TF0gE6DLfey3wxdLU7VjzsL+FgtfkcrYv3l8joOSX7fxiOKl
         LS1nnpkkJueid+gT+eY/fa5z9OcPV1wpwhLW+S2qCpsmCRwAp/+tOzWQEzRTbzw0Ph17
         Zv+D52tEFSotr1zDiIOtNe3OyOJpK8xnXvEbfdk9Kw4eGHjR65j0ah4+N/AYX/MzUFGl
         9vowQMOv+4+qBm9dt/Rg6TUSs0MeMy7hSn9tqMCTiNM7XPfv9GWDV787b02wyz4RIXay
         KozQ==
X-Gm-Message-State: AOJu0YwNUsYlRKGakid8sSvKU6EvOQoQEQ763SEma/Z3YUpveGlUL27d
        2WWzmijpSj0FsGBlFbMI5MhhDRiZ6eZly+u7LJTJ
X-Google-Smtp-Source: AGHT+IF7EWSh/N5MMPZLdhCjlunDyn3WMMhW7XdriIWLhkImYiN4zAjIc9dNexk394B25SiyeJMGHk+g/2e7wceTI23w
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:8f5a:6a6a:cafc:a3ad])
 (user=axelrasmussen job=sendgmr) by 2002:a25:8b0c:0:b0:cf9:3564:33cc with
 SMTP id i12-20020a258b0c000000b00cf9356433ccmr8307ybl.13.1695150137798; Tue,
 19 Sep 2023 12:02:17 -0700 (PDT)
Date:   Tue, 19 Sep 2023 12:01:58 -0700
In-Reply-To: <20230919190206.388896-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20230919190206.388896-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230919190206.388896-3-axelrasmussen@google.com>
Subject: [PATCH 02/10] userfaultfd.2: reword to account for new fault
 resolution ioctls
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alejandro Colomar <alx@kernel.org>, Peter Xu <peterx@redhat.com>
Cc:     linux-man@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Basically, reword the sentence to clarify that this isn't a complete
list. I don't believe it's worth maintaining a fully complete list here,
instead ioctl_userfaultfd.2 is the place to do that. Let this just be an
example.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 man2/userfaultfd.2 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/man2/userfaultfd.2 b/man2/userfaultfd.2
index 1b2af22f9..00d94e514 100644
--- a/man2/userfaultfd.2
+++ b/man2/userfaultfd.2
@@ -222,11 +222,12 @@ operation,
 a page fault occurring in the requested memory range, and satisfying
 the mode defined at the registration time, will be forwarded by the kernel to
 the user-space application.
-The application can then use the
+The application can then use various (e.g.
 .B UFFDIO_COPY ,
 .B UFFDIO_ZEROPAGE ,
 or
 .B UFFDIO_CONTINUE
+)
 .BR ioctl (2)
 operations to resolve the page fault.
 .PP
-- 
2.42.0.459.ge4e396fd5e-goog

