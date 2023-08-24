Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE741786D5B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238878AbjHXLDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240981AbjHXLCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:02:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7D91BFB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 04:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692874877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NmUHBo5LrPwdmQecLAx8MfYidtED1jQWxrZgmH5OLzg=;
        b=VWExLDLazuWQhOyY6TqmqPNQNQwS1RfN/I0l4Uh6vGUlexgaWg6uNaet8j7ZrlTka4mSCW
        exLVGFOaiB1eSaRelyrCW40jfH1dR13IYOVe/bsSXJO3pBTivboITMi1V3YKWll09db84m
        fu7Y7ls9KSrNxKitdcltSw3xUW1UvVM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-g3tRwQbEPGe6lb4D7lF3sg-1; Thu, 24 Aug 2023 07:01:16 -0400
X-MC-Unique: g3tRwQbEPGe6lb4D7lF3sg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-411f4a7ddbdso3361101cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 04:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692874875; x=1693479675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NmUHBo5LrPwdmQecLAx8MfYidtED1jQWxrZgmH5OLzg=;
        b=BoYUSaLYBz93cy50v9scBz/eFuAnNMujCs3uw3zlkKggBV6OMBqpYT7AZtVQSbEPCS
         Ldh6rG5J60XL2wMTOvXA+MYHcEaISR4u1QEaoLgSMJoLinIhrZRv6+ahh7KtQ1hMul7/
         OoCVSv4Q6vayQirdv+rkNY2JEMW40HyQglmeIjiMuT/Wf72h1Siu0MNM8E3Y2cR3CDCH
         uDNftgf63TeaJUUt7HXzISdEZpmWbZNDx+8z5NizRIgQtrre7M27LNXdTbGFWPKitmP8
         b5mPoABm/FRRM0kDLcCp/NgNTq8gy9cM50ShqsYMMtHkQn3xeHd9PLrRiB7jx8ZGX1L7
         zHXg==
X-Gm-Message-State: AOJu0YwRq1DlfeC58GmLShX2FRn7qnazG5Lf8bLXZSLwuY0of6WofGeZ
        jKsMoz9ZbEQj7dumyxn3czCy7SBccLJApXk5Vnmkj6qQSBV9FbDpgsWI3skkIrOA3v9d80epC0J
        JR22vnqy3+1H8w4F8/5xrK7Cz13OjS0ucm7U=
X-Received: by 2002:a05:622a:294:b0:411:f6a8:a0da with SMTP id z20-20020a05622a029400b00411f6a8a0damr4149096qtw.2.1692874875470;
        Thu, 24 Aug 2023 04:01:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERKsP7cGywJYsINrzua4Lmp4hKkGpExNSVHLq+6bmfDgtvoEcp1qnbje49JxvRC7MFmDtEZA==
X-Received: by 2002:a05:622a:294:b0:411:f6a8:a0da with SMTP id z20-20020a05622a029400b00411f6a8a0damr4149079qtw.2.1692874875242;
        Thu, 24 Aug 2023 04:01:15 -0700 (PDT)
Received: from fedorinator.redhat.com ([2001:9e8:32d4:a00:c8cc:8ab8:2b77:5655])
        by smtp.gmail.com with ESMTPSA id j16-20020ac806d0000000b00405502aaf76sm3501549qth.57.2023.08.24.04.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 04:01:14 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH] Docu: genericirq.rst: fix irq-example
Date:   Thu, 24 Aug 2023 13:01:09 +0200
Message-ID: <20230824110109.18844-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A code example was missing the pointer to dereference a variable.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 Documentation/core-api/genericirq.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/core-api/genericirq.rst b/Documentation/core-api/genericirq.rst
index f959c9b53f61..4a460639ab1c 100644
--- a/Documentation/core-api/genericirq.rst
+++ b/Documentation/core-api/genericirq.rst
@@ -264,7 +264,7 @@ The following control flow is implemented (simplified excerpt)::
             desc->irq_data.chip->irq_unmask();
         desc->status &= ~pending;
         handle_irq_event(desc->action);
-    } while (status & pending);
+    } while (desc->status & pending);
     desc->status &= ~running;
 
 
-- 
2.40.0

