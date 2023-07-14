Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A28754474
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 23:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjGNVwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 17:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGNVwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 17:52:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A9235A6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 14:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689371478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8Hxo+RkWpN14XLiWcgexFQoX59W2A8cV2w6hOlqdXYc=;
        b=VNfjDqnfrBrNxOPVNlhYQ/vf+n6J7yYF0K3x74avT6yvpyjf7GI0qxae3PZskDldFJvzSC
        XkCdCNaqCIjTj4CecIB0jbGSWEICUaYEEdtdv0PzrVhxFZRr7UW+mT45vrxW3ZGNILCgU3
        fOtWsFfblAWGmLMzLdBTvSnYNAzSzFc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-UsYhiLZYOeqe-HaEq60pkA-1; Fri, 14 Jul 2023 17:51:16 -0400
X-MC-Unique: UsYhiLZYOeqe-HaEq60pkA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-635325b87c9so23806966d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 14:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689371476; x=1691963476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Hxo+RkWpN14XLiWcgexFQoX59W2A8cV2w6hOlqdXYc=;
        b=LDEL9bUPpez6FUy3MxnE2PZWJMhTPBbUKUezG6pdwxXDHctpSjRfMiRMeexJtuq0qX
         sFNJYHpZtvxrj+OU6Lr6A9+Ayeik2aq2+bPwbFRZxY9AcYzREONTjpHqWr90D5YEjI+b
         t2ROGRcKw0JrhSWipVWl03xLM2haWeqpVia8Na3kF6QXpM9aYIVpNgrLiU1uS6pbyf7c
         e4YAnnwaCyyR1tYgofOJXWMh8J+wB9zfmMpm4TlJhJNcjGa8sHZSUAkIyInFAE/IzwoA
         aidvriF9d8wDpU7+vFD1BEmJ2gQeZu7CH6ppVzA/dnT2oKizCjH2ac1dE7x2AfSy+vFp
         5pwA==
X-Gm-Message-State: ABy/qLYH1BeMu1N2Yj/lHs1W0FUJw10lXGwLX+S68Rzck2rha0uzya4a
        2nFob+riWAVhLRcHRSh+bWTBUAETBZCn109sakBHc7uf63cH1LGwQ0LYrpQa9rjNJVXgaqTPZH/
        wPxTWyrJ/hx1PfWVaFRvfIbcO+peUctKI
X-Received: by 2002:a0c:f452:0:b0:635:e209:178c with SMTP id h18-20020a0cf452000000b00635e209178cmr5074117qvm.10.1689371476121;
        Fri, 14 Jul 2023 14:51:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlECeKhR/HE5D/xADqgqYjum7rx4dSsBrkvBGCkPPWkWzdk7JOvc6oRDSx7upiK11VtkOw7Wtg==
X-Received: by 2002:a0c:f452:0:b0:635:e209:178c with SMTP id h18-20020a0cf452000000b00635e209178cmr5074111qvm.10.1689371475858;
        Fri, 14 Jul 2023 14:51:15 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id t10-20020a0c8d8a000000b00626362f1bf1sm4276508qvb.63.2023.07.14.14.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 14:51:15 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] shmem: set variable shmem_mark_dquot_dirty and shmem_dquot_write_info storage-class-specifier to static
Date:   Fri, 14 Jul 2023 17:51:13 -0400
Message-Id: <20230714215113.3919026-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports
mm/shmem_quota.c:318:5: warning: symbol 'shmem_mark_dquot_dirty'
  was not declared. Should it be static?
mm/shmem_quota.c:323:5: warning: symbol 'shmem_dquot_write_info'
  was not declared. Should it be static?

These variables are only used in their defining file, so it should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 mm/shmem_quota.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/shmem_quota.c b/mm/shmem_quota.c
index e349c0901bce..062d1c1097ae 100644
--- a/mm/shmem_quota.c
+++ b/mm/shmem_quota.c
@@ -315,12 +315,12 @@ static int shmem_release_dquot(struct dquot *dquot)
 	return 0;
 }
 
-int shmem_mark_dquot_dirty(struct dquot *dquot)
+static int shmem_mark_dquot_dirty(struct dquot *dquot)
 {
 	return 0;
 }
 
-int shmem_dquot_write_info(struct super_block *sb, int type)
+static int shmem_dquot_write_info(struct super_block *sb, int type)
 {
 	return 0;
 }
-- 
2.27.0

