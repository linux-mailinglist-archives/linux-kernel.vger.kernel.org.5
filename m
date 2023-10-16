Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF04C7CB6B5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 00:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbjJPWuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 18:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbjJPWuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 18:50:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5EBEE
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697496543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pYRuDFtRQm/XEND8LuUsFc5Ssln/FFt05O1wZEMzWlU=;
        b=cM2HwvFiyKYE/fTNqqIOVy87fMAOQDAcZklj0k23odSGFJXH8q8yQqZfIuFQ2ZB5fks2LU
        d72MDJPUrz3Iya8vykX30hnTppgOMpXNi0fLXm7FDCPhyBqyddF7LfKgE+kk6tDbQpUtr4
        Dv3Lh+FS4B1h5nc1+8dfnT4ZiAiDJO4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-450-_ocvPLeEPPCEzcjLSzAh1Q-1; Mon, 16 Oct 2023 18:48:59 -0400
X-MC-Unique: _ocvPLeEPPCEzcjLSzAh1Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C9283C1E9C5;
        Mon, 16 Oct 2023 22:48:59 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4AAA025C9;
        Mon, 16 Oct 2023 22:48:59 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     kernel test robot <lkp@intel.com>
Subject: [PATCH] x86/cpu: amd: fix warning in W=1 build
Date:   Mon, 16 Oct 2023 18:48:58 -0400
Message-Id: <20231016224858.2829248-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with GCC 11.x results in the following warning:

arch/x86/kernel/cpu/microcode/amd.c: In function ‘find_blobs_in_containers’:
arch/x86/kernel/cpu/microcode/amd.c:504:58: error: ‘h.bin’ directive output may be truncated writing 5 bytes into a region of size between 1 and 7 [-Werror=format-truncation=]
arch/x86/kernel/cpu/microcode/amd.c:503:17: note: ‘snprintf’ output between 35 and 41 bytes into a destination of size 36

The issue is that GCC does not know that the family can only be a byte
(it ultimately comes from CPUID).  Suggest the right size to the compiler
by marking the argument as char-size ("hh").  While at it, instead of
using the slightly more obscure precision specifier use the width with
zero padding (over 23000 occurrences in kernel sources, vs 500 for
the idiom using the precision).

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308252255.2HPJ6x5Q-lkp@intel.com/
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kernel/cpu/microcode/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index bbd1dc38ea03..b4eea8a1f68a 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -501,7 +501,7 @@ static bool get_builtin_microcode(struct cpio_data *cp, unsigned int family)
 
 	if (family >= 0x15)
 		snprintf(fw_name, sizeof(fw_name),
-			 "amd-ucode/microcode_amd_fam%.2xh.bin", family);
+			 "amd-ucode/microcode_amd_fam%02hhxh.bin", family);
 
 	if (firmware_request_builtin(&fw, fw_name)) {
 		cp->size = fw.size;
-- 
2.39.1

