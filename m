Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAF67B71F7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240971AbjJCTqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjJCTqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:46:00 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE990A1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 12:45:56 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d81ff714678so1611925276.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 12:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696362356; x=1696967156; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LZEL2BMjxz1i5idDbV1660WVS0O86XmSCyt1X5bcmDM=;
        b=Mq+RXsAdEu8Agt8QFclfS9ZJWQeyPjWgzORyR7dQ5ZrZPp2vHmiXbJ8Hq0EpBo7Bjm
         DYaSmQPC1pDTdIxAGyi+usEAYI7R/RqxhbshCoE/FO/i6WfTuEF/WukwvjRfHVN85UrN
         v4fae/nl9HnRZZnb5Mi3EijH5EH3/ntBGOSXkDECrLT7KvigehvgWLyP5bvP78N889rC
         OGsVX1N6VIlUQF5Y7NU1C5vUlAhG4YW77ueRx0S2I1zYYj5Qcv5vKOsDRiglJTFK7Z8p
         sfnQH9Tj3M8uHD3OHsapFSGsUwwvZeyCSw1l+DN30ac1rAIHut9N5EwZb3pL9nZWitjx
         A2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696362356; x=1696967156;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LZEL2BMjxz1i5idDbV1660WVS0O86XmSCyt1X5bcmDM=;
        b=YtdPZ5mg32s/covbxD7CDZewpebcO6SfcJZDiNswGVTR6I1So7/yCMbDWGhpeROF4A
         +s+kBGjjt95SGJxOoavZpp5HrX09SsUcWtHeU4b8rlIYLy99lTrU70VE/KRcEnxtDOjB
         qom/1779XDaEjRNOiCCt+HOMIY09lcfKOOoECx3fLRneSd4k6zxtCqhxwiz9DjvERfzE
         UVFLEI7+dK74E/0ZfEf7aKW/WenFw117vIRKzfO2ct/O6g6iyCZFTs4XYdS6uqs8ezNK
         4Hpp0Qx11AHy8fhsClC2niDF5GowVOx9bY2ZN8Oqnor13aYYnVgAUJ6dqu8KPrIRfib5
         mP4Q==
X-Gm-Message-State: AOJu0YwLQsBwSx820dSwZ5HANJpLkx9J+JYhOOyy+fv1NTUftODLfUhJ
        XLbmXBy3UREngV9Ur+cSJjGKJsElrIioLsP/rSAL
X-Google-Smtp-Source: AGHT+IGkq/Yho3MXhu4mjlOqZnh1sbMKJRwQFyyu29+TZYNFidmM+AVkw+octliNf2IRJpTmHxGFJHSGs+YhAb5n0ehq
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:6577:b8c1:dd2d:1c93])
 (user=axelrasmussen job=sendgmr) by 2002:a25:d816:0:b0:d7b:9fad:6b9e with
 SMTP id p22-20020a25d816000000b00d7b9fad6b9emr3353ybg.1.1696362356219; Tue,
 03 Oct 2023 12:45:56 -0700 (PDT)
Date:   Tue,  3 Oct 2023 12:45:43 -0700
In-Reply-To: <20231003194547.2237424-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20231003194547.2237424-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231003194547.2237424-2-axelrasmussen@google.com>
Subject: [PATCH v2 1/5] ioctl_userfaultfd.2: describe two-step feature handshake
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

Fully describe how UFFDIO_API can be used to perform a two-step feature
handshake, and also note the case where this isn't necessary (programs
which don't depend on any extra features).

This lets us clean up an old FIXME asking for this to be described.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 man2/ioctl_userfaultfd.2 | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
index b5281ec4c..ef352a69d 100644
--- a/man2/ioctl_userfaultfd.2
+++ b/man2/ioctl_userfaultfd.2
@@ -82,7 +82,6 @@ struct uffdio_api {
 The
 .I api
 field denotes the API version requested by the application.
-.PP
 The kernel verifies that it can support the requested API version,
 and sets the
 .I features
@@ -92,6 +91,25 @@ fields to bit masks representing all the available features and the generic
 .BR ioctl (2)
 operations available.
 .PP
+Since Linux 4.11,
+applications should use the
+.I features
+field to perform a two-step handshake.
+First,
+.BR UFFDIO_API
+is called with the
+.I features
+field set to zero.
+The kernel responsds by setting all supported feature bits.
+.PP
+Applications which do not require any specific features
+can begin using the userfaultfd immediately.
+Applications which do need specific features
+should call
+.BR UFFDIO_API
+again with a subset of the reported feature bits set
+to enable those features.
+.PP
 Before Linux 4.11, the
 .I features
 field must be initialized to zero before the call to
@@ -101,24 +119,11 @@ and zero (i.e., no feature bits) is placed in the
 field by the kernel upon return from
 .BR ioctl (2).
 .PP
-Starting from Linux 4.11, the
-.I features
-field can be used to ask whether particular features are supported
-and explicitly enable userfaultfd features that are disabled by default.
-The kernel always reports all the available features in the
-.I features
-field.
-.PP
-To enable userfaultfd features the application should set
-a bit corresponding to each feature it wants to enable in the
-.I features
-field.
-If the kernel supports all the requested features it will enable them.
-Otherwise it will zero out the returned
+If the application sets unsupported feature bits,
+the kernel will zero out the returned
 .I uffdio_api
 structure and return
 .BR EINVAL .
-.\" FIXME add more details about feature negotiation and enablement
 .PP
 The following feature bits may be set:
 .TP
-- 
2.42.0.609.gbb76f46606-goog

