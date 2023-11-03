Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF237E01EF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjKCLN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 07:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjKCLN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 07:13:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDA718E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 04:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699009961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EKotJyX83ZQaavHXcaSrvHRltZ/PTiWvZAqWNqbIC/E=;
        b=S2iwPnULjdmBI/Y4bOyBzkTJXuypqQnEL/LtlFehxzGbdYQ9KO5eUkY5KtaZYSsA4KJjgg
        k3YQkQzpHMbhMjzgVPPEA/Q+ACo1Wy3ZCD9kimWRgbeasQ08ZWd8vYfDT786ddN/j678kb
        0yTSnURfPD2Pu8lTos1d5PRBVwYN4cc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-dR8i8SPKO6iQk8MRPNIOtg-1; Fri, 03 Nov 2023 07:12:39 -0400
X-MC-Unique: dR8i8SPKO6iQk8MRPNIOtg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9c39f53775fso29748866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 04:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699009959; x=1699614759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EKotJyX83ZQaavHXcaSrvHRltZ/PTiWvZAqWNqbIC/E=;
        b=SM5IOGDm6dWhZ0bT6ZZP2PXiKiDw8xXB4F1PVsk8+Pmeb7uyqNNCR5JBr8EZlBj47K
         kHnOLuzWbskC2p1FNPJArjZKOiUKTBhAEN0OtppfVvRfm/z48RUHsX24hIXw8idiqkqp
         bsOqXnGfEss2bIZ/Me+KAhJH0WwyoMSo6q4jnWrYrr9LQMA6qLpMDP7BJyuUPkhI03hE
         wMY4TT0ZbtB2edv6L8B9tDdQJ+W2vMjzlCbDG8UtyCCXnxfeTmGWEammz2ZVwnU5/wjT
         dIQ6eYQbuCDWRgJk+ZcIVDV+NqAWlqbq2VVGoQ+NwKMRdnZb57xRuk84UoFv/TwL8Gb8
         q7aQ==
X-Gm-Message-State: AOJu0YydIYOzJWWUeFuyKsQLIUbbZ7XsT5ztykaNu2/fSFGXVPJktDOB
        xMxpEmZgtr1e+6hlx2CflmnhKwcqFCKottnaqUqW7inpTARxHzpebrhRJSmxONWsWzPh7u2SrA1
        4K/qP8nj3OuRqT3lkiVLpybUk
X-Received: by 2002:a17:907:1c92:b0:9be:8de2:a56c with SMTP id nb18-20020a1709071c9200b009be8de2a56cmr19512553ejc.0.1699009958709;
        Fri, 03 Nov 2023 04:12:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ97Ex9NOJxwu7cZf4ypToBcAvCkm8BR3IA1Z58ARKTni5k4nc2QCM9BdvMu0agZFpWc0fWA==
X-Received: by 2002:a17:907:1c92:b0:9be:8de2:a56c with SMTP id nb18-20020a1709071c9200b009be8de2a56cmr19512524ejc.0.1699009958376;
        Fri, 03 Nov 2023 04:12:38 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.fritz.box ([2001:9e8:32d1:5200:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id gw14-20020a170906f14e00b009ae3d711fd9sm786814ejb.69.2023.11.03.04.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 04:12:38 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Philipp Stanner <pstanner@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Tony Luck <tony.luck@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH v2] drivers/tty/vt: use standard array-copy-functions
Date:   Fri,  3 Nov 2023 12:12:08 +0100
Message-ID: <20231103111207.74621-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tty/vt currently uses memdup_user() and vmemdup_array_user() to copy
userspace arrays.

Whereas there is no danger of overflowing, the call to vmemdup_user()
currently utilizes array_size() to calculate the array size
nevertheless. This is not useful because array_size() would return
SIZE_MAX and pass it to vmemdup_user() in case of (the impossible)
overflow.

string.h from the core-API now provides the wrappers memdup_array_user()
and vmemdup_array_user() to copy userspace arrays in a standardized
manner. Additionally, they also perform generic overflow-checks.

Use these wrappers to make it more obvious and readable that arrays are
being copied.

As we are at it, remove two unnecessary empty lines.

Suggested-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
Changes in v2:
- Remove two empty lines from keyboard.c
- Rephrase the commit message completely to make it obvious that we're
  not actually fixing a really possible overflow here. Emphasize the
  commit being about unifying array-copying. (Al Viro)
---
 drivers/tty/vt/consolemap.c |  2 +-
 drivers/tty/vt/keyboard.c   | 10 ++++------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index f02d21e2a96e..313cef3322eb 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -644,7 +644,7 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 	if (!ct)
 		return 0;
 
-	unilist = vmemdup_user(list, array_size(sizeof(*unilist), ct));
+	unilist = vmemdup_array_user(list, ct, sizeof(*unilist));
 	if (IS_ERR(unilist))
 		return PTR_ERR(unilist);
 
diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 1fe6107b539b..96f19ef360b5 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1772,12 +1772,10 @@ int vt_do_diacrit(unsigned int cmd, void __user *udp, int perm)
 			return -EINVAL;
 
 		if (ct) {
-
-			dia = memdup_user(a->kbdiacr,
-					sizeof(struct kbdiacr) * ct);
+			dia = memdup_array_user(a->kbdiacr,
+						ct, sizeof(struct kbdiacr));
 			if (IS_ERR(dia))
 				return PTR_ERR(dia);
-
 		}
 
 		spin_lock_irqsave(&kbd_event_lock, flags);
@@ -1811,8 +1809,8 @@ int vt_do_diacrit(unsigned int cmd, void __user *udp, int perm)
 			return -EINVAL;
 
 		if (ct) {
-			buf = memdup_user(a->kbdiacruc,
-					  ct * sizeof(struct kbdiacruc));
+			buf = memdup_array_user(a->kbdiacruc,
+						ct, sizeof(struct kbdiacruc));
 			if (IS_ERR(buf))
 				return PTR_ERR(buf);
 		} 
-- 
2.41.0

