Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A737D1376
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377864AbjJTQBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377871AbjJTQBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:01:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2094C124
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 09:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697817651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NcvcHF6syyTnw+TlLVd2nH8ZMZCU48+hIK7XQq6iEm0=;
        b=VSit08nNsXovdnumtAHWn93pDIK5n3IuS5QJEFgzATGDoz0qy8UT19R9Eov/R5O9JlRzs4
        EuYpbVsUlpxU2KfTQ/kQAGwKTdLFGBhMVHNAuXjbBmsGE//EKcbAbexm4Bh3/pHp3qwRJP
        4xgYzeTsfW0FNhBpMq1lEU2cSfY2BLQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-FYn6_4HoM46po6gwZ1h0Hg-1; Fri, 20 Oct 2023 12:00:45 -0400
X-MC-Unique: FYn6_4HoM46po6gwZ1h0Hg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C811F3C025C8;
        Fri, 20 Oct 2023 16:00:44 +0000 (UTC)
Received: from kalibr.redhat.com (unknown [10.47.238.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D9B32026D4C;
        Fri, 20 Oct 2023 16:00:43 +0000 (UTC)
From:   Maurizio Lombardi <mlombard@redhat.com>
To:     gregkh@linuxfoundation.org
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] driver core: class:  remove boilerplate code
Date:   Fri, 20 Oct 2023 18:00:42 +0200
Message-Id: <20231020160042.759439-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jump to err_out to avoid duplicating the code.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/base/class.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index 05d9df90f621..7e78aee0fd6c 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -193,10 +193,8 @@ int class_register(const struct class *cls)
 	lockdep_register_key(key);
 	__mutex_init(&cp->mutex, "subsys mutex", key);
 	error = kobject_set_name(&cp->subsys.kobj, "%s", cls->name);
-	if (error) {
-		kfree(cp);
-		return error;
-	}
+	if (error)
+		goto err_out;
 
 	cp->subsys.kobj.kset = class_kset;
 	cp->subsys.kobj.ktype = &class_ktype;
-- 
2.39.3

