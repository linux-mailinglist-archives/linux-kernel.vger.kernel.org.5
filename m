Return-Path: <linux-kernel+bounces-104290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BAD87CBA9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33231C2200F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699FA1B7F4;
	Fri, 15 Mar 2024 10:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NSOlEfkO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C171B7EA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710500114; cv=none; b=sB9psUxIS4HiFhx4zvUCVgK2AZ55EFrdAqWcxXGSo12U3ZSzP+Dgzp8ji0A2tIalypNpI8pxPVLjyRHJLIJSKMLFxoaD1gxxXH6WkVX6j4jn+Q/ERazmrzmx2B3FwJkNZWZ9LZ8xueRkI0J6vM3EJ8Cei7B55It+5CSv3zDGDZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710500114; c=relaxed/simple;
	bh=egKFcFy18uI/dVjWoyZvuW3VcQWXWF1qul2r340oNl0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=T8ehgNyE8NgFd4YM7GQsYOW0p2sn16H9UBkynGw0zZXLRuq8Ka2gxtNNx9OPHxrPew1t9lVcdhJJ7hzqYgO1SJxgnmnRpGeGKenEJ6vCi0TH25wKAs+yM/npwncNPPDkUD/JM0ENBHMh7jbI1Md41qcnkUGBj414H6VX6IkSuPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NSOlEfkO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710500112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WKnajArjwdqkW9mul8mVcKUVfLxGaXnxMQu51jtLd0s=;
	b=NSOlEfkOJkWYSZFK4TXL6QW6bzIZNoTwaDmk2KihS0kRepk5MxLiq3SXE/u6oEheVUZdqS
	DjBSTC+1vNLrk8cdsqDskDZr4+CcFXGxXtKZvL82adGWPofLYrjJr7GejaygGMlY8ae9oS
	3UqwJWrnYXRvzRkAqgyKfwOMtRRqYRk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495--O4F-DR8Na-mU1jF5OHwsA-1; Fri, 15 Mar 2024 06:55:08 -0400
X-MC-Unique: -O4F-DR8Na-mU1jF5OHwsA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8513851780;
	Fri, 15 Mar 2024 10:55:07 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A8484492BD0;
	Fri, 15 Mar 2024 10:55:07 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] selftests: kvm: remove meaningless assignments in Makefiles
Date: Fri, 15 Mar 2024 06:55:07 -0400
Message-Id: <20240315105507.2519851-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

$(shell ...) expands to the output of the command. It expands to the
empty string when the command does not print anything to stdout.
Hence, $(shell mkdir ...) is sufficient and does not need any
variable assignment in front of it.

Commit c2bd08ba20a5 ("treewide: remove meaningless assignments in
Makefiles", 2024-02-23) did this to all of tools/ but ignored in-flight
changes to tools/testing/selftests/kvm/Makefile, so reapply the change.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/kvm/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 19f5710bb456..741c7dc16afc 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -277,7 +277,7 @@ TEST_DEP_FILES += $(patsubst %.o, %.d, $(LIBKVM_OBJS))
 TEST_DEP_FILES += $(patsubst %.o, %.d, $(SPLIT_TEST_GEN_OBJ))
 -include $(TEST_DEP_FILES)
 
-x := $(shell mkdir -p $(sort $(OUTPUT)/$(ARCH_DIR) $(dir $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ))))
+$(shell mkdir -p $(sort $(OUTPUT)/$(ARCH_DIR) $(dir $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ))))
 
 $(filter-out $(SPLIT_TEST_GEN_PROGS), $(TEST_GEN_PROGS)) \
 $(TEST_GEN_PROGS_EXTENDED): %: %.o
@@ -309,7 +309,7 @@ $(LIBKVM_S_OBJ): $(OUTPUT)/%.o: %.S $(GEN_HDRS)
 $(LIBKVM_STRING_OBJ): $(OUTPUT)/%.o: %.c
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c -ffreestanding $< -o $@
 
-x := $(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
+$(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
 $(SPLIT_TEST_GEN_OBJ): $(GEN_HDRS)
 $(TEST_GEN_PROGS): $(LIBKVM_OBJS)
 $(TEST_GEN_PROGS_EXTENDED): $(LIBKVM_OBJS)
-- 
2.39.1


