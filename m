Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9F779E6FD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240400AbjIMLin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240363AbjIMLil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:38:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AE7173E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:38:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 50BCD218E3;
        Wed, 13 Sep 2023 11:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694605116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dVPKyjPuFRiMX6H05C4yegFljVDNBdmN4FRlJrZXtC8=;
        b=DlBJopdppVqDlPo0820IN+B0NKE4azUrDiJXIdKEpL7OlV6MYr3nHi2QMsbkX4If5GTMSw
        NvGizRK0K/HmNwxhO3Ur6reeYkbMTx8gOR9zz1u+xaGJmgkuGNayQN6qLQvBTG8SUtXD26
        hVytxMzRpTNnAk+YIeojWOkv2IacXs8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 223A113582;
        Wed, 13 Sep 2023 11:38:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0PoHBzyfAWVoCwAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 13 Sep 2023 11:38:36 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org
Subject: [PATCH 1/3] arm/xen: remove lazy mode related definitions
Date:   Wed, 13 Sep 2023 13:38:26 +0200
Message-Id: <20230913113828.18421-2-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230913113828.18421-1-jgross@suse.com>
References: <20230913113828.18421-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

include/xen/arm/hypervisor.h contains definitions related to paravirt
lazy mode, which are used nowhere in the code.

All paravirt lazy mode related users are in x86 code, so remove the
definitions on Arm side.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 include/xen/arm/hypervisor.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/xen/arm/hypervisor.h b/include/xen/arm/hypervisor.h
index 43ef24dd030e..9995695204f5 100644
--- a/include/xen/arm/hypervisor.h
+++ b/include/xen/arm/hypervisor.h
@@ -7,18 +7,6 @@
 extern struct shared_info *HYPERVISOR_shared_info;
 extern struct start_info *xen_start_info;
 
-/* Lazy mode for batching updates / context switch */
-enum paravirt_lazy_mode {
-	PARAVIRT_LAZY_NONE,
-	PARAVIRT_LAZY_MMU,
-	PARAVIRT_LAZY_CPU,
-};
-
-static inline enum paravirt_lazy_mode paravirt_get_lazy_mode(void)
-{
-	return PARAVIRT_LAZY_NONE;
-}
-
 #ifdef CONFIG_XEN
 void __init xen_early_init(void);
 #else
-- 
2.35.3

