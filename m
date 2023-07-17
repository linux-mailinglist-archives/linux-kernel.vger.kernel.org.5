Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D21E75674A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjGQPOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjGQPOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:14:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E3BE6;
        Mon, 17 Jul 2023 08:14:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BCA761FDB2;
        Mon, 17 Jul 2023 15:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689606869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=N6MW5aW5/tskhoIcmGl6SK2Dnqzk5QXBiM+B1KNWi+M=;
        b=HFN/G3NO2gGRJM0V2tN23lvvf+p8tEX7BxDFYshfltWNgK5bh5HzXMRSmxFALcdh1Zi7sh
        J2Y/7w91NF7TztNC0eW2dn3TC+4QOyIrbM6IH9sf5ofCljPKSQ7fVaypeBB04kINyIkJpn
        o2mrAdIWASJ1s+aP+WH90g+UfPUgiHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689606869;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=N6MW5aW5/tskhoIcmGl6SK2Dnqzk5QXBiM+B1KNWi+M=;
        b=6V3NV94KetzMZuh2uY0q2C5Z1CjV5Sz2KS4KKoAkMKKJY8AUWGArLTLVLlzQZugD4Gwu8X
        VmaXOHFG2cfcnYAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9453513276;
        Mon, 17 Jul 2023 15:14:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NSioItVatWTACAAAMHmgww
        (envelope-from <jdelvare@suse.de>); Mon, 17 Jul 2023 15:14:29 +0000
Date:   Mon, 17 Jul 2023 17:14:28 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] module: print module name on refcount error
Message-ID: <20230717171428.1b229215@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.34; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If module_put() triggers a refcount error, and the module data is
still readable, include the culprit module name in the warning
message, to easy further investigation of the issue.

If the module name can't be read, this means the module has already
been removed while references to it still exist. This is a
user-after-free situation, so report it as such.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Suggested-by: Michal Hocko <mhocko@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
---
Hi Luis, this is a different approach to my initial proposal. We no
longer assume that struct module is still available and instead check
that the expected module name string is a valid string before printing
it.

This is safer, and lets us print a better diagnostics message: include
the module name if struct module is still there (the most likely case
IMHO, as rmmod is a relatively rare operation) else explicitly report a
use after free.

The downside is that this requires more code, but I think it's worth
it. What do you think?

 kernel/module/main.c |   31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

--- linux-6.3.orig/kernel/module/main.c
+++ linux-6.3/kernel/module/main.c
@@ -55,6 +55,7 @@
 #include <linux/dynamic_debug.h>
 #include <linux/audit.h>
 #include <linux/cfi.h>
+#include <linux/ctype.h>
 #include <uapi/linux/module.h>
 #include "internal.h"
 
@@ -850,7 +851,35 @@ void module_put(struct module *module)
 	if (module) {
 		preempt_disable();
 		ret = atomic_dec_if_positive(&module->refcnt);
-		WARN_ON(ret < 0);	/* Failed to put refcount */
+		if (ret < 0) {
+			unsigned char modname_copy[MODULE_NAME_LEN];
+			unsigned char *p, *end;
+			bool sane;
+
+			/*
+			 * Report faulty module if name is still readable.
+			 * We must be careful here as the module may have
+			 * been already freed.
+			 */
+			memcpy(modname_copy, module->name, MODULE_NAME_LEN);
+			end = memchr(modname_copy, '\0', MODULE_NAME_LEN);
+			sane = end != NULL;
+			if (sane) {
+				for (p = modname_copy; p < end; p++)
+					if (!isgraph(*p)) {
+						sane = false;
+						break;
+					}
+			}
+
+			if (sane)
+				WARN(1,
+				     KERN_WARNING "Failed to put refcount for module %s\n",
+				     modname_copy);
+			else
+				WARN(1,
+				     KERN_WARNING "Failed to put refcount, use-after-free detected\n");
+		}
 		trace_module_put(module, _RET_IP_);
 		preempt_enable();
 	}


-- 
Jean Delvare
SUSE L3 Support
