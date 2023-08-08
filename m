Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE220773748
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 05:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjHHDEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 23:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjHHDE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 23:04:26 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289A1C2;
        Mon,  7 Aug 2023 20:04:25 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-56ce156bd37so3215275eaf.3;
        Mon, 07 Aug 2023 20:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691463864; x=1692068664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lU9dy9acxPivAK9sAqV8O5YVQrlBKU/PVmJCwK+iI40=;
        b=j/IuvRWHR0mJZ3utT4ETYOM1KM7sGD4D6iWKBc2trPoxvnlwBsoMfnx9RWBa1z6e4Q
         zh+eICNT4DNpZQz/9VGiflvBuBBXTR9hcNTIP1Ow3nAaYXIQISn+2rtaXXj4mGHfCoRe
         U3UiwSZ0sb6z3uEQUkWgqiYituiD53v18EKtRQiSRqmF9qVCCjCmohtLSh0+tF/YU90z
         lcb4DDR5c5C2omHAhYF2c7OcYjx+EV+w/+DVkEMsaqwPlk2qdWuCcVGn66mbCa3gYc5B
         7/9ycVjVsgMGhM/0GJ7Ht3uobSj4qHwVbW5eN/73sM1CV6a0RqokIYWwr6WQcmfcbvBo
         D8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691463864; x=1692068664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lU9dy9acxPivAK9sAqV8O5YVQrlBKU/PVmJCwK+iI40=;
        b=bZDO8S9NZSnm2d0ai72TGQOFYx2IY6v/COm7x7QeAvuEZgQtfFY39/5iTjOUEwe0dN
         kU29+PvDm7gbPbmlTETzn4Qiviim90V0/dGXiCfHuZQsOE65GzqLy7yPrmYskk6jMorA
         1N5KGkOf/yadjQ1PQ9Fj61XcAm8zQdp3b3CzoSBtpU83AfFZlh2UZnzg4VNHnsgnKiQa
         fIdSarPgKrJ/fsDBB2f9RpmDWk9MnNZ9ltQ8p9yCIDxjJS3peBqAEwm8SxmZIWXhqbV4
         Il9OCnnlbrrAmE2+ZeV0H85L3Zg9jcpjdUiiFwxsVpssYfu7JeDobuoP1boDUa8c1tpM
         4Ahg==
X-Gm-Message-State: AOJu0YwTbf25gnanFvjr2tFQx3N/7UHL1WomGSYDQCtPeeufVLlm7oIj
        dP9+HrE1nAPoLlkfLOFgsUUruU87osMKUA==
X-Google-Smtp-Source: AGHT+IFywI2BuYDLZVDGsdFfFF6DvxQuyBA8SR3uuOj7it5jlV6PY2OX2KTP4ilZALeWIK9XjjALHQ==
X-Received: by 2002:aca:170d:0:b0:3a7:a34a:ea9 with SMTP id j13-20020aca170d000000b003a7a34a0ea9mr3018690oii.56.1691463863950;
        Mon, 07 Aug 2023 20:04:23 -0700 (PDT)
Received: from kir-rhat.lan (c-76-104-243-248.hsd1.wa.comcast.net. [76.104.243.248])
        by smtp.gmail.com with ESMTPSA id b2-20020a17090a010200b002636dfcc6f5sm7276425pjb.3.2023.08.07.20.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 20:04:23 -0700 (PDT)
From:   Kir Kolyshkin <kolyshkin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kir Kolyshkin <kolyshkin@gmail.com>, libc-alpha@sourceware.org,
        musl@lists.openwall.com, linux-api@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH] sched/headers: move struct sched_param out of uapi
Date:   Mon,  7 Aug 2023 20:03:57 -0700
Message-ID: <20230808030357.1213829-1-kolyshkin@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both glibc and musl define struct sched_param in sched.h, while kernel
has it in uapi/linux/sched/types.h, making it cumbersome to use
sched_getattr(2) or sched_setattr(2) from userspace.

For example, something like this:

	#include <sched.h>
	#include <linux/sched/types.h>

	struct sched_attr sa;

will result in "error: redefinition of ‘struct sched_param’" (note the
code doesn't need sched_param at all -- it needs struct sched_attr
plus some stuff from sched.h).

The situation is, glibc is not going to provide a wrapper for
sched_{get,set}attr, thus the need to include linux/sched_types.h
directly, which leads to the above problem.

Thus, the userspace is left with a few sub-par choices when it wants to
use e.g. sched_setattr(2), such as maintaining a copy of struct
sched_attr definition, or using some other ugly tricks.

OTOH, struct sched_param is well known, defined in POSIX, and it won't
be ever changed (as that would break backward compatibility).

So, while struct sched_param is indeed part of the kernel uapi,
exposing it the way it's done now creates an issue, and hiding it
(like this patch does) fixes that issue, hopefully without creating
another one: common userspace software rely on libc headers, and as
for "special" software (like libc), it looks like glibc and musl
do not rely on kernel headers for struct sched_param definition
(but let's Cc their mailing lists in case it's otherwise).

The alternative to this patch would be to move struct sched_attr to,
say, linux/sched.h, or linux/sched/attr.h (the new file).

Oh, and here is the previous attempt to fix the issue:
https://lore.kernel.org/all/20200528135552.GA87103@google.com/
While I support Linus arguments, the issue is still here
and needs to be fixed.

Cc: libc-alpha@sourceware.org
Cc: musl@lists.openwall.com
Cc: linux-api@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Christian Brauner <brauner@kernel.org>
Fixes: e2d1e2aec572 ("sched/headers: Move various ABI definitions to <uapi/linux/sched/types.h>")
Signed-off-by: Kir Kolyshkin <kolyshkin@gmail.com>
---
 include/linux/sched.h            | 5 ++++-
 include/uapi/linux/sched/types.h | 4 ----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 609bde814cb0..3167e97a6b04 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -63,7 +63,6 @@ struct robust_list_head;
 struct root_domain;
 struct rq;
 struct sched_attr;
-struct sched_param;
 struct seq_file;
 struct sighand_struct;
 struct signal_struct;
@@ -370,6 +369,10 @@ extern struct root_domain def_root_domain;
 extern struct mutex sched_domains_mutex;
 #endif
 
+struct sched_param {
+	int sched_priority;
+};
+
 struct sched_info {
 #ifdef CONFIG_SCHED_INFO
 	/* Cumulative counters: */
diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/types.h
index f2c4589d4dbf..90662385689b 100644
--- a/include/uapi/linux/sched/types.h
+++ b/include/uapi/linux/sched/types.h
@@ -4,10 +4,6 @@
 
 #include <linux/types.h>
 
-struct sched_param {
-	int sched_priority;
-};
-
 #define SCHED_ATTR_SIZE_VER0	48	/* sizeof first published struct */
 #define SCHED_ATTR_SIZE_VER1	56	/* add: util_{min,max} */
 
-- 
2.41.0

