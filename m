Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6610776E3B1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbjHCIzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjHCIzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:55:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFD8E43
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691052898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=a0Qb1ZCjTg5X2iHgPbuPkClilFu2mrOZGxq+uAuigRM=;
        b=dvIbW6H9vc/JJQf0RRHFY7OusS9w4Ou7wLSb9EXp+PSO5KanYdgxOPCyVjnEMnbYwVj5NF
        mq/6leymBEOnXEvE0Y8x84/x15QTHfImT2sjSyL2XS1q2+pa2iiDzxur1WBjp3Sbxr6w3G
        KsFlt6V2W8f4O9D3BbtpvUotqCEJ+PU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-2I-C1BrJO5yV8qekwrRrWQ-1; Thu, 03 Aug 2023 04:54:57 -0400
X-MC-Unique: 2I-C1BrJO5yV8qekwrRrWQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94a34d3e5ebso47231266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 01:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691052896; x=1691657696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a0Qb1ZCjTg5X2iHgPbuPkClilFu2mrOZGxq+uAuigRM=;
        b=CJYSFYOZZDOPJvn5DveeN5VV80WVKnKrBdkKAoTGpQ4kJUKrXnPMWjWHKHOOXtu7D1
         12og8QSlmn+Y00e3RxHweDOOyr1EVxQ5eO2wT9xT0+HMDL48nfm5xL9SBEmlZdn8YX5T
         swwYBPzqT++T0eLKOOKMgsretPaBBbr6C0dZfD67JGrAGZz++cIvOx3EFOnL4u5qi5PG
         9aqorW/xpH3jcIUFtI3ok5UwZep6UsIFsyLlXXYU6zIYXJgGJq4My8cCk/McaQGGMtTf
         1snbx0hwuDyOJJet3YF0UwOS19ESk5Dt8XZ8MdgLxdUXGWj4nP8+uGkFO4+eMnu4nl4h
         y+AQ==
X-Gm-Message-State: ABy/qLYIp7SCm+7sO6G/q9y5F3XxORNKi+fr47EnsJYdNbS5myjc5/TS
        JqyYvW3gsdA1p0CMit+cq5/tp0TVgJfgCvmCbgl1hgNVpTsAXBVXZU4fZiAZhldCH9joZon7Xx7
        ouNoYwZKX5aNdZ4qTjzXO3jUS
X-Received: by 2002:a17:906:519e:b0:993:fb68:ed67 with SMTP id y30-20020a170906519e00b00993fb68ed67mr7034890ejk.24.1691052896530;
        Thu, 03 Aug 2023 01:54:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHVe0KJwC7fd5aUom3TJxYmpf5W0xCgiDOUhdnqgr4ZWF5nCbowtI5xFne903dpuVY/rWA+AQ==
X-Received: by 2002:a17:906:519e:b0:993:fb68:ed67 with SMTP id y30-20020a170906519e00b00993fb68ed67mr7034877ejk.24.1691052896280;
        Thu, 03 Aug 2023 01:54:56 -0700 (PDT)
Received: from step1.home (host-82-57-51-214.retail.telecomitalia.it. [82.57.51.214])
        by smtp.gmail.com with ESMTPSA id u17-20020a1709060b1100b0099bcf563fe6sm10239984ejg.223.2023.08.03.01.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 01:54:55 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH net] test/vsock: remove vsock_perf executable on `make clean`
Date:   Thu,  3 Aug 2023 10:54:54 +0200
Message-ID: <20230803085454.30897-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-type: text/plain
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

We forgot to add vsock_perf to the rm command in the `clean`
target, so now we have a left over after `make clean` in
tools/testing/vsock.

Fixes: 8abbffd27ced ("test/vsock: vsock_perf utility")
Cc: AVKrasnov@sberdevices.ru
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/vsock/Makefile b/tools/testing/vsock/Makefile
index 43a254f0e14d..21a98ba565ab 100644
--- a/tools/testing/vsock/Makefile
+++ b/tools/testing/vsock/Makefile
@@ -8,5 +8,5 @@ vsock_perf: vsock_perf.o
 CFLAGS += -g -O2 -Werror -Wall -I. -I../../include -I../../../usr/include -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -D_GNU_SOURCE
 .PHONY: all test clean
 clean:
-	${RM} *.o *.d vsock_test vsock_diag_test
+	${RM} *.o *.d vsock_test vsock_diag_test vsock_perf
 -include *.d
-- 
2.41.0

