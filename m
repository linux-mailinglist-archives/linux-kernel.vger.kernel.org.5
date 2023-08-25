Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FB97888CA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237813AbjHYNiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjHYNh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:37:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81CF2133
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 06:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692970583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=adBV5QdoIxMd11EUvCs5qDeDIAAmKS8CbHIBdJKT2cc=;
        b=GgzhEudvwkwUISR+ZdSFn6DaeL5nf6d4URfY3mdof6YCrmtPs3tUkV8z/LYlOB4snLVv/S
        k4T5sLgnHFB4YjgYEvKFZY0bCvqI41hN+MZ4HaEPjBe7vuIPhfcDS1TU2uPLI9fwTvYPAS
        gYX+7Hsibqv5koaN30oN+OURwed0i+k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-4k7Nr5hVNvus7wmomvHpog-1; Fri, 25 Aug 2023 09:36:21 -0400
X-MC-Unique: 4k7Nr5hVNvus7wmomvHpog-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-31c554c8867so652551f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 06:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692970580; x=1693575380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=adBV5QdoIxMd11EUvCs5qDeDIAAmKS8CbHIBdJKT2cc=;
        b=MnSLFgTet6AfVK4sAfoCs8JyS4O/Sp1dTP/ulbw/8AT0C27lWFvmCbm0G5nOAMmjpq
         AWtQmk4rO9LhURJB3Cyo8c6QtE1K7qsNdE72mwg5wzTLQ6N6xGcmxKknf+bHjF5CbIUT
         tCy2WQp24DhCALzDJcQ9f2lnklR/5c84MZBCiLOvbDHM/GcbSTpcaqGInJiAPVcXskxF
         0A+yXefbA71XDZryqFYO20LdSqW4SL9N/5yxBa8vy2U7A3I3Lg6UsO4lfwcoZLYdbkQt
         AuixwBvQMjMHGVSr++pzmpQ7x2pWASBFkvT0MCpQGyJZOj0XPo9UWPqUpbc5fNPqeWh9
         8rWA==
X-Gm-Message-State: AOJu0YzjuObja7qZf/d22choOPpfJxJsWaIu9tZaI6FZIabvBWpk8JPO
        emK+fPwEyo805or+5sLNuGzd/x9bcIxAvzxfh18TtVhvY22nMBllrd9clCxnbxd9Z3rEEONiRBW
        413h2WNRLvTs5iIH6HOFUAxk=
X-Received: by 2002:a5d:4211:0:b0:31c:769d:287c with SMTP id n17-20020a5d4211000000b0031c769d287cmr3990212wrq.50.1692970580506;
        Fri, 25 Aug 2023 06:36:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESApNQupeVzOoGH4xg/snp9WaQNwtnffnKK9WmFU7GZsNrMOGWLSfcHEOPViwtO0QwkRmx6A==
X-Received: by 2002:a5d:4211:0:b0:31c:769d:287c with SMTP id n17-20020a5d4211000000b0031c769d287cmr3990199wrq.50.1692970580113;
        Fri, 25 Aug 2023 06:36:20 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-31-124.cust.vodafonedsl.it. [2.34.31.124])
        by smtp.gmail.com with ESMTPSA id e11-20020adffd0b000000b0031b2c01f342sm2253915wrr.87.2023.08.25.06.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 06:36:19 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Jerome Glisse <jglisse@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Marco Pagani <marpagan@redhat.com>,
        Mika Penttila <mpenttil@redhat.com>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs/mm: remove references to hmm_mirror ops and clean typos
Date:   Fri, 25 Aug 2023 15:35:46 +0200
Message-ID: <20230825133546.249683-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean typos and remove the reference to the sync_cpu_device_pagetables()
callback since all hmm_mirror ops have been removed.

Fixes: a22dd506400d ("mm/hmm: remove hmm_mirror and related")
Signed-off-by: Marco Pagani <marpagan@redhat.com>
Reviewed-by: Mika Penttilä <mpenttil@redhat.com>
---
 Documentation/mm/hmm.rst | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/Documentation/mm/hmm.rst b/Documentation/mm/hmm.rst
index 9aa512c3a12c..1e0f2b2f58fb 100644
--- a/Documentation/mm/hmm.rst
+++ b/Documentation/mm/hmm.rst
@@ -163,16 +163,7 @@ use::
 
 It will trigger a page fault on missing or read-only entries if write access is
 requested (see below). Page faults use the generic mm page fault code path just
-like a CPU page fault.
-
-Both functions copy CPU page table entries into their pfns array argument. Each
-entry in that array corresponds to an address in the virtual range. HMM
-provides a set of flags to help the driver identify special CPU page table
-entries.
-
-Locking within the sync_cpu_device_pagetables() callback is the most important
-aspect the driver must respect in order to keep things properly synchronized.
-The usage pattern is::
+like a CPU page fault. The usage pattern is::
 
  int driver_populate_range(...)
  {
-- 
2.41.0

