Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B3F7A0457
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 14:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237943AbjINMu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 08:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbjINMuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 08:50:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 331B41FCC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 05:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694695776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zl4p8XLey0gy6USUzeltuD0UQ4OeCQFR0LvCVwJKbIU=;
        b=Cue/NwDz7swj9BTO4rd10lU5UfGApUqi6wm9Q6UAh7JSwFWXM9GVHPB3+5By/Nn/Ns1twy
        ThBR1GD4RWY0Bhsr+qn5Ims6pnJJtD2kLUNkegXDDj2ko6vcJlIeNB78VKuYT/5yy66tUT
        i/fBd44SyrcsM+mKSB0Sd4Un5NHr6zo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-n9Sb7Bo3NeGcWtIVt21FzA-1; Thu, 14 Sep 2023 08:49:32 -0400
X-MC-Unique: n9Sb7Bo3NeGcWtIVt21FzA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9DD1180A20F;
        Thu, 14 Sep 2023 12:49:31 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.43.17.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FC6D2156A27;
        Thu, 14 Sep 2023 12:49:30 +0000 (UTC)
From:   Artem Savkov <asavkov@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     vmalik@redhat.com, linux-kernel@vger.kernel.org,
        Artem Savkov <asavkov@redhat.com>
Subject: [PATCH bpf-next] selftests/bpf: skip module_fentry_shadow test when bpf_testmod is not available
Date:   Thu, 14 Sep 2023 14:49:28 +0200
Message-ID: <20230914124928.340701-1-asavkov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This test relies on bpf_testmod, so skip it if the module is not available.

Fixes: aa3d65de4b900 ("bpf/selftests: Test fentry attachment to shadowed functions")
Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 .../testing/selftests/bpf/prog_tests/module_fentry_shadow.c  | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/module_fentry_shadow.c b/tools/testing/selftests/bpf/prog_tests/module_fentry_shadow.c
index c7636e18b1ebd..cdd55e5340dec 100644
--- a/tools/testing/selftests/bpf/prog_tests/module_fentry_shadow.c
+++ b/tools/testing/selftests/bpf/prog_tests/module_fentry_shadow.c
@@ -61,6 +61,11 @@ void test_module_fentry_shadow(void)
 	int link_fd[2] = {};
 	__s32 btf_id[2] = {};
 
+        if (!env.has_testmod) {
+                test__skip();
+                return;
+        }
+
 	LIBBPF_OPTS(bpf_prog_load_opts, load_opts,
 		.expected_attach_type = BPF_TRACE_FENTRY,
 	);
-- 
2.41.0

