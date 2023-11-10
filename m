Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07647E818D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345786AbjKJS3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346599AbjKJS1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:27:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF836431CD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 09:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699635992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q2KBpc9BasJQHEEaBScXMjepCNomXvpnM2lUSUMsHc4=;
        b=fEhtj1hrJBALyRX6FvjjBx/hESQ5dt7EXlk81Npxo7MJeaG+2FCcnPnlZRmJCCd0KPa7tc
        dRqokUUMZhG9zc13g/VW0U45frPWfAPChBTX0XfLZoS4+0rGivHllsL+nzZQSnKTLXtGAw
        lkOMT8e/weBvMnZPZiXYZL03doC/L/E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-l1dL7eoMPreuAzOZKJ4E3A-1; Fri, 10 Nov 2023 12:06:30 -0500
X-MC-Unique: l1dL7eoMPreuAzOZKJ4E3A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 168E6101A597;
        Fri, 10 Nov 2023 17:06:30 +0000 (UTC)
Received: from cmirabil.redhat.com (unknown [10.22.16.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D668E502C;
        Fri, 10 Nov 2023 17:06:29 +0000 (UTC)
From:   Charles Mirabile <cmirabil@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Charles Mirabile <cmirabil@redhat.com>
Subject: [PATCH v1 1/1] fs: Consider capabilities relative to namespace for linkat permission check
Date:   Fri, 10 Nov 2023 12:06:15 -0500
Message-Id: <20231110170615.2168372-2-cmirabil@redhat.com>
In-Reply-To: <20231110170615.2168372-1-cmirabil@redhat.com>
References: <20231110170615.2168372-1-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, the check for CAP_DAC_READ_SEARCH when trying to use
AT_EMPTY_PATH happened relative to the init process's namespace
rather than the namespace of the current process. This seems like
an oversight because it meant that processes in new namespaces
could not ever use AT_EMPTY_PATH with linkat even if they have
CAP_DAC_READ_SEARCH within their namespace.

Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 71c13b2990b4..0848aa563988 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4628,7 +4628,7 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 	 * This ensures that not everyone will be able to create
 	 * handlink using the passed filedescriptor.
 	 */
-	if (flags & AT_EMPTY_PATH && !capable(CAP_DAC_READ_SEARCH)) {
+	if (flags & AT_EMPTY_PATH && !ns_capable(current_user_ns(), CAP_DAC_READ_SEARCH)) {
 		error = -ENOENT;
 		goto out_putnames;
 	}
-- 
2.38.1

