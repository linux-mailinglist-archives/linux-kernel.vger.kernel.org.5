Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EAC79D0B4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbjILMHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbjILMH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:07:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4209F10D3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 05:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694520398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tX6yWckEp0zjVKcWR1lfoEzSymqYQ6Dx9WYErV4NIQ4=;
        b=day7dsfJO+7i8dK9Q7byY+2g70qqW4yjnzf3reiSvBqJDMLlFiKBnVmHhgybAIkonvadEg
        U5xIYdUkxtUfa542FZi/86M+Yta017IlX2dZbT+ZK1bq0D6XihkJa6e7sAmiHs4CjtL2q2
        cicC8GbZXULE+gc4yJjwKKZ/aAu0Hvg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-SxgM-UXoMPmCmZdOPiUJOQ-1; Tue, 12 Sep 2023 08:06:35 -0400
X-MC-Unique: SxgM-UXoMPmCmZdOPiUJOQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 952668D3BC3;
        Tue, 12 Sep 2023 12:06:34 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.43.17.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55D5710F1BE7;
        Tue, 12 Sep 2023 12:06:33 +0000 (UTC)
From:   Artem Savkov <asavkov@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Eduard Zingerman <eddyz87@gmail.com>, linux-kernel@vger.kernel.org,
        Artem Savkov <asavkov@redhat.com>
Subject: [PATCH bpf] selftests/bpf: fix unpriv_disabled check in test_verifier
Date:   Tue, 12 Sep 2023 14:06:31 +0200
Message-ID: <20230912120631.213139-1-asavkov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1d56ade032a49 changed the function get_unpriv_disabled() to
return its results as a bool instead of updating a global variable, but
test_verifier was not updated to keep in line with these changes. Thus
unpriv_disabled is always false in test_verifier and unprivileged tests
are not properly skipped on systems with unprivileged bpf disabled.

Fixes: 1d56ade032a49 ("selftests/bpf: Unprivileged tests for test_loader.c")
Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 tools/testing/selftests/bpf/test_verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 31f1c935cd07d..98107e0452d33 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -1880,7 +1880,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	get_unpriv_disabled();
+	unpriv_disabled = get_unpriv_disabled();
 	if (unpriv && unpriv_disabled) {
 		printf("Cannot run as unprivileged user with sysctl %s.\n",
 		       UNPRIV_SYSCTL);
-- 
2.41.0

