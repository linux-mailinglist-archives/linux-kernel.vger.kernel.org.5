Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A76B811116
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbjLMM0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjLMM0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:26:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E93993
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 04:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702470402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=M9d6ePRTzZiLNbRSrhKettsNPoTADGTq2uEKllllxdk=;
        b=EkbBsX7jFojUq5bRHipRefb/scnxvE60F1c3U5O+Op4Vl0dsp/9MfSdF+oy8A5jaGj0nnI
        AQWArJivdWFNupeEG4lmUMPEcLQ8vb6GhipVZp+tC+dRHT+1FLwUlnnZlFMRuk9IFPObhD
        JP3/BGvuD6hEK33dxR2KKKSaiJ5O3eo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-MO3X27X-Pbiyo8pFu38rng-1; Wed, 13 Dec 2023 07:26:38 -0500
X-MC-Unique: MO3X27X-Pbiyo8pFu38rng-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A54121011630;
        Wed, 13 Dec 2023 12:26:37 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D0A6492C30;
        Wed, 13 Dec 2023 12:26:37 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] KVM: selftests: Fix dynamic generation of configuration names
Date:   Wed, 13 Dec 2023 07:26:36 -0500
Message-Id: <20231213122636.2684144-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we dynamically generate a name for a configuration in get-reg-list
we use strcat() to append to a buffer allocated using malloc() but we
never initialise that buffer. Since malloc() offers no guarantees
regarding the contents of the memory it returns this can lead to us
corrupting, and likely overflowing, the buffer:

  vregs: PASS
  vregs+pmu: PASS
  sve: PASS
  sve+pmu: PASS
  vregs+pauth_address+pauth_generic: PASS
  X?vr+gspauth_addre+spauth_generi+pmu: PASS

The bug is that strcat() should have been strcpy(), and that replacement
would be enough to fix it, but there are other things in the function
that leave something to be desired.  In particular, an (incorrectly)
empty config would cause an out of bounds access to c->name[-1].
Since the strcpy() call relies on c->name[0..len-1] being initialized,
enforce that invariant throughout the function.

Fixes: 2f9ace5d4557 ("KVM: arm64: selftests: get-reg-list: Introduce vcpu configs")
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Co-developed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Message-Id: <20231211-kvm-get-reg-list-str-init-v3-1-6554c71c77b1@kernel.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/kvm/get-reg-list.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/testing/selftests/kvm/get-reg-list.c
index be7bf5224434..8274ef04301f 100644
--- a/tools/testing/selftests/kvm/get-reg-list.c
+++ b/tools/testing/selftests/kvm/get-reg-list.c
@@ -71,11 +71,12 @@ static const char *config_name(struct vcpu_reg_list *c)
 	for_each_sublist(c, s) {
 		if (!strcmp(s->name, "base"))
 			continue;
-		strcat(c->name + len, s->name);
-		len += strlen(s->name) + 1;
-		c->name[len - 1] = '+';
+		if (len)
+			c->name[len++] = '+';
+		strcpy(c->name + len, s->name);
+		len += strlen(s->name);
 	}
-	c->name[len - 1] = '\0';
+	c->name[len] = '\0';
 
 	return c->name;
 }
-- 
2.39.1

