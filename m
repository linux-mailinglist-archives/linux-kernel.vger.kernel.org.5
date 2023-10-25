Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED03E7D6E58
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344545AbjJYOEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343648AbjJYODu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:03:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC6119B
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698242540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EC7RFMR3rA+1DRsmRuXrj1V+WaMGVpdP+bUvoE8xfhg=;
        b=HDECItOP9L2+uAH1MssFAO4S6q2z19xgzFF9BHpp9eSqTAO8hGMwTA7WU94CvfvF8SL7Cb
        lHjKer3/ZNKr7F+pOqpSlue2mNdXDVuPAhIKhVU2qOLvo5s+DUKgdEz/blT7IOzTR9VpMq
        lNt4GBx9vhwGWQctkU1x/m4GFSCUkVA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-L664L8RzP_uGPVc4RkbO_g-1; Wed, 25 Oct 2023 10:02:18 -0400
X-MC-Unique: L664L8RzP_uGPVc4RkbO_g-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9bd7c682b33so360640266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698242537; x=1698847337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EC7RFMR3rA+1DRsmRuXrj1V+WaMGVpdP+bUvoE8xfhg=;
        b=PMZXHKEuz2EYDNNZKw+6WwgqQvNJEUXUwC2+hSODWwmzS+Tx0rG/6m6AgdPmTUNDzJ
         fCbTZyCFG19nqkG08omuknB4huxBmeEI2zVe3EbmcNPBVPE7EFitNWHcnijlVlPLGDiK
         N2g7wsoVIw4hn/mfIqny5uZZCJrWvUrbxlmIRJuegJOxhqBKV6ZW6waQagWrvz7LbIk2
         IiM8vcBjZFLTK1nQzsXh336/LnGxP8eEK6oaM7fW8mRMv3R9ayHv5GYNXdIUjkgL0YDb
         O5/J5nGDbGGpT1W1v+gMNd9sX4BDBk3ItI6tb5f34xdGFs7ZdqZiWzWyoX5egPBcSMRO
         6gkQ==
X-Gm-Message-State: AOJu0YyfnGFqLd5uCiw0/23ztNN21uj5hJBTbRCmMSahGN9+nMSQ3CCn
        CxyIiHBwbua/Qa8SK5oE+wl2ZGqBMxwfLFkgAHmAbF+HN4xuWAWKbL1YKwtDOZKhR08amyS6Qmf
        rYBXFig6qQdxnCWQryWznAyRAb7L3Tv8f
X-Received: by 2002:a17:907:6093:b0:9ba:2f20:3d7b with SMTP id ht19-20020a170907609300b009ba2f203d7bmr13334952ejc.71.1698242537065;
        Wed, 25 Oct 2023 07:02:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjMjmoMNoYOpgsb76Zi6H4tYS6A+eLzcgNpATF2jXSDinHL2btMGhhvP35HJjX0s8ljGUJzA==
X-Received: by 2002:a17:907:6093:b0:9ba:2f20:3d7b with SMTP id ht19-20020a170907609300b009ba2f203d7bmr13334928ejc.71.1698242536775;
        Wed, 25 Oct 2023 07:02:16 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (92-249-235-200.pool.digikabel.hu. [92.249.235.200])
        by smtp.gmail.com with ESMTPSA id vl9-20020a170907b60900b00989828a42e8sm9857073ejc.154.2023.10.25.07.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 07:02:15 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 6/6] wire up syscalls for statmount/listmount
Date:   Wed, 25 Oct 2023 16:02:04 +0200
Message-ID: <20231025140205.3586473-7-mszeredi@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025140205.3586473-1-mszeredi@redhat.com>
References: <20231025140205.3586473-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up all archs.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 arch/alpha/kernel/syscalls/syscall.tbl      | 3 +++
 arch/arm/tools/syscall.tbl                  | 3 +++
 arch/arm64/include/asm/unistd32.h           | 4 ++++
 arch/ia64/kernel/syscalls/syscall.tbl       | 3 +++
 arch/m68k/kernel/syscalls/syscall.tbl       | 3 +++
 arch/microblaze/kernel/syscalls/syscall.tbl | 3 +++
 arch/mips/kernel/syscalls/syscall_n32.tbl   | 3 +++
 arch/mips/kernel/syscalls/syscall_n64.tbl   | 3 +++
 arch/mips/kernel/syscalls/syscall_o32.tbl   | 3 +++
 arch/parisc/kernel/syscalls/syscall.tbl     | 3 +++
 arch/powerpc/kernel/syscalls/syscall.tbl    | 3 +++
 arch/s390/kernel/syscalls/syscall.tbl       | 3 +++
 arch/sh/kernel/syscalls/syscall.tbl         | 3 +++
 arch/sparc/kernel/syscalls/syscall.tbl      | 3 +++
 arch/x86/entry/syscalls/syscall_32.tbl      | 3 +++
 arch/x86/entry/syscalls/syscall_64.tbl      | 2 ++
 arch/xtensa/kernel/syscalls/syscall.tbl     | 3 +++
 include/uapi/asm-generic/unistd.h           | 8 +++++++-
 18 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index ad37569d0507..6c23bf68eff0 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -492,3 +492,6 @@
 560	common	set_mempolicy_home_node		sys_ni_syscall
 561	common	cachestat			sys_cachestat
 562	common	fchmodat2			sys_fchmodat2
+# 563 reserved for map_shadow_stack
+564	common	statmount			sys_statmount
+565	common	listmount			sys_listmount
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index c572d6c3dee0..d110a832899b 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -466,3 +466,6 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+# 453 reserved for map_shadow_stack
+454	common	statmount			sys_statmount
+455	common	listmount			sys_listmount
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 78b68311ec81..b0a994c9ff3c 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -911,6 +911,10 @@ __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
 __SYSCALL(__NR_cachestat, sys_cachestat)
 #define __NR_fchmodat2 452
 __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
+#define __NR_statmount 454
+__SYSCALL(__NR_statmount, sys_statmount)
+#define __NR_listmount 455
+__SYSCALL(__NR_listmount, sys_listmount)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 83d8609aec03..c5f45a8fc834 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -373,3 +373,6 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+# 453 reserved for map_shadow_stack
+454	common	statmount			sys_statmount
+455	common	listmount			sys_listmount
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 259ceb125367..b9cabb746487 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -452,3 +452,6 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+# 453 reserved for map_shadow_stack
+454	common	statmount			sys_statmount
+455	common	listmount			sys_listmount
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index a3798c2637fd..89c4ed548ce8 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -458,3 +458,6 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+# 453 reserved for map_shadow_stack
+454	common	statmount			sys_statmount
+455	common	listmount			sys_listmount
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 152034b8e0a0..a9d561698fe2 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -391,3 +391,6 @@
 450	n32	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	n32	cachestat			sys_cachestat
 452	n32	fchmodat2			sys_fchmodat2
+# 453 reserved for map_shadow_stack
+454	n32	statmount			sys_statmount
+455	n32	listmount			sys_listmount
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index cb5e757f6621..80a056866da7 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -367,3 +367,6 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	n64	cachestat			sys_cachestat
 452	n64	fchmodat2			sys_fchmodat2
+# 453 reserved for map_shadow_stack
+454	n64	statmount			sys_statmount
+455	n64	listmount			sys_listmount
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 1a646813afdc..139ddc691176 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -440,3 +440,6 @@
 450	o32	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	o32	cachestat			sys_cachestat
 452	o32	fchmodat2			sys_fchmodat2
+# 453 reserved for map_shadow_stack
+454	o32	statmount			sys_statmount
+455	o32	listmount			sys_listmount
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index e97c175b56f9..46fa753f0d64 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -451,3 +451,6 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+# 453 reserved for map_shadow_stack
+454	common	statmount			sys_statmount
+455	common	listmount			sys_listmount
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 20e50586e8a2..106937744525 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -539,3 +539,6 @@
 450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+# 453 reserved for map_shadow_stack
+454	common	statmount			sys_statmount
+455	common	listmount			sys_listmount
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 0122cc156952..57dd9202f8d7 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -455,3 +455,6 @@
 450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
 451  common	cachestat		sys_cachestat			sys_cachestat
 452  common	fchmodat2		sys_fchmodat2			sys_fchmodat2
+# 453 reserved for map_shadow_stack
+454  common	statmount		sys_statmount			sys_statmount
+455  common	listmount		sys_listmount			sys_listmount
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index e90d585c4d3e..0c7407a0e32c 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -455,3 +455,6 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+# 453 reserved for map_shadow_stack
+454	common	statmount			sys_statmount
+455	common	listmount			sys_listmount
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 4ed06c71c43f..a0fd36469478 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -498,3 +498,6 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+# 453 reserved for map_shadow_stack
+454	common	statmount			sys_statmount
+455	common	listmount			sys_listmount
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 2d0b1bd866ea..4f41977bd4c1 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -457,3 +457,6 @@
 450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	i386	cachestat		sys_cachestat
 452	i386	fchmodat2		sys_fchmodat2
+# 563 reserved for map_shadow_stack
+454	i386	statmount		sys_statmount
+455	i386	listmount		sys_listmount
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 1d6eee30eceb..a1b3ce7d22cc 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -375,6 +375,8 @@
 451	common	cachestat		sys_cachestat
 452	common	fchmodat2		sys_fchmodat2
 453	64	map_shadow_stack	sys_map_shadow_stack
+454	common	statmount		sys_statmount
+455	common	listmount		sys_listmount
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index fc1a4f3c81d9..73378984702b 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -423,3 +423,6 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+# 453 reserved for map_shadow_stack
+454	common	statmount			sys_statmount
+455	common	listmount			sys_listmount
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index abe087c53b4b..8df6a747e21a 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -823,8 +823,14 @@ __SYSCALL(__NR_cachestat, sys_cachestat)
 #define __NR_fchmodat2 452
 __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
 
+#define __NR_statmount   454
+__SYSCALL(__NR_statmount, sys_statmount)
+
+#define __NR_listmount   455
+__SYSCALL(__NR_listmount, sys_listmount)
+
 #undef __NR_syscalls
-#define __NR_syscalls 453
+#define __NR_syscalls 456
 
 /*
  * 32 bit systems traditionally used different
-- 
2.41.0

