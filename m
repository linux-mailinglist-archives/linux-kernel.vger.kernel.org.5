Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2587F84FF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 20:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbjKXT6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 14:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbjKXT6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 14:58:22 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E92172A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:58:28 -0800 (PST)
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 476CF1FE8F;
        Fri, 24 Nov 2023 19:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1700855907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:  in-reply-to:in-reply-to;
        bh=qGzEJ9/paLrY7yN9mHnVDrutfQTfMGd2dXLSP1MKgTo=;
        b=LQLyN4VFubhseBPaSDv3sIMpCKyboHj3200tSV7VZiT2UHjBEltrsuDHzL43nvNBiYZTTZ
        iwLzxf3sxhCN4ljw+PfEzCPGByK/j1R6NIZ3/KzzhiDFD60wm+UvbdJflOvhrQG3nb2UaD
        cCdbkHkYvxoS91LEfTeebcj0m6aE3mQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1700855907;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:  in-reply-to:in-reply-to;
        bh=qGzEJ9/paLrY7yN9mHnVDrutfQTfMGd2dXLSP1MKgTo=;
        b=6N1XaEBpIJeFMnj/coakTwo4OtVDr1qA17zfdgNfSB5diJTD0EwzWrvRhafTW9pU1Y0b7j
        HutLmei93GtJBKDw==
Received: from localhost (dwarf.suse.cz [10.100.12.32])
        by relay2.suse.de (Postfix) with ESMTP id 679982C145;
        Fri, 24 Nov 2023 19:58:25 +0000 (UTC)
Date:   Fri, 24 Nov 2023 20:58:25 +0100
From:   Jiri Bohac <jbohac@suse.cz>
To:     Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.cz
Subject: [PATCH 4/4] kdump, documentation: describe craskernel CMA reservation
Message-ID: <ZWEAYdO7VfT02EJz@dwarf.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz>
X-Spamd-Bar: +++++++++++++
X-Spam-Score: 13.49
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: 476CF1FE8F
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        dmarc=none;
        spf=pass (smtp-out2.suse.de: domain of jbohac@suse.cz designates 149.44.160.134 as permitted sender) smtp.mailfrom=jbohac@suse.cz
X-Spamd-Result: default: False [13.49 / 50.00];
         RDNS_NONE(1.00)[];
         SPAMHAUS_XBL(0.00)[149.44.160.134:from];
         TO_DN_SOME(0.00)[];
         R_SPF_ALLOW(-0.20)[+ip4:149.44.0.0/16:c];
         RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
         HFILTER_HELO_IP_A(1.00)[relay2.suse.de];
         HFILTER_HELO_NORES_A_OR_MX(0.30)[relay2.suse.de];
         RCPT_COUNT_FIVE(0.00)[6];
         MID_RHS_MATCH_FROMTLD(0.00)[];
         MX_GOOD(-0.01)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         RDNS_DNSFAIL(0.00)[];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         NEURAL_SPAM_SHORT(3.00)[1.000];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(1.20)[suse.cz];
         TO_MATCH_ENVRCPT_SOME(0.00)[];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_SPAM_LONG(3.50)[1.000];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         RCVD_COUNT_TWO(0.00)[2];
         HFILTER_HOSTNAME_UNKNOWN(2.50)[]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe the new crashkernel ",cma" suffix in Documentation/

---
 Documentation/admin-guide/kdump/kdump.rst       | 10 ++++++++++
 Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index 5762e7477a0c..4ec08e5843dc 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -317,6 +317,16 @@ crashkernel syntax
 
             crashkernel=0,low
 
+4) crashkernel=size,cma
+
+   Reserves additional memory from CMA. A standard crashkernel reservation, as
+   described above, is still needed, but can be just small enough to hold the
+   kernel and initrd. All the memory the crash kernel needs for its runtime and
+   for running the kdump userspace processes can be provided by this CMA
+   reservation, re-using memory available to the production system's userspace.
+   Because of this re-using, the CMA reservation should not be used if it's
+   intended to dump userspce memory.
+
 Boot into System Kernel
 -----------------------
 1) Update the boot loader (such as grub, yaboot, or lilo) configuration
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 65731b060e3f..ee9fc40a97fd 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -914,6 +914,13 @@
 			0: to disable low allocation.
 			It will be ignored when crashkernel=X,high is not used
 			or memory reserved is below 4G.
+	crashkernel=size[KMG],cma
+			[KNL, X86] Reserve additional crash kernel memory from CMA.
+			This reservation is usable by the 1st system's userspace,
+			so this should not be used if dumping of userspace 
+			memory is intended. A standard crashkernel reservation, 
+			as described above, is still needed to hold the crash 
+			kernel and initrd. 
 
 	cryptomgr.notests
 			[KNL] Disable crypto self-tests

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia

