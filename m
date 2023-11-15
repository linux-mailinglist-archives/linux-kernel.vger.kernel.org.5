Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535DB7EC9E0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjKORsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjKORsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:48:39 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BC418E;
        Wed, 15 Nov 2023 09:48:36 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F1CBC1F8BA;
        Wed, 15 Nov 2023 17:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1700070515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dVirFhaoEoAX1LEzb5mRTEwNjUcyu3xWdfuMee0UoV8=;
        b=lfPWiR9Atyz7OYGBbcWnddpsjMxEIsMt7yvvR42DgCwhHU87lj5wxD+Y/b3fDEhXpGzr3f
        /HwtCDqYciAHIIjoBtY5k2/ou+/RbpfBcm8QSgWrR/uJyejRJU2n2Ci2jvgqAYPICvpt+6
        1T7OCddHZL7liBBtsPAqY2vRO+4Z3kY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1700070515;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dVirFhaoEoAX1LEzb5mRTEwNjUcyu3xWdfuMee0UoV8=;
        b=tD38coEFHSEmEaDCjSnTkj9DKJrzJCISkjbbAXifYGSgZqY4Gztn4feNszGD5NqnQbHmqS
        qJKrGhfGyWPfzNBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A21013587;
        Wed, 15 Nov 2023 17:48:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6rL2InIEVWWzVQAAMHmgww
        (envelope-from <clopez@suse.de>); Wed, 15 Nov 2023 17:48:34 +0000
From:   =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] KVM: X86: improve documentation for KVM_CAP_X86_BUS_LOCK_EXIT
Date:   Wed, 15 Nov 2023 18:47:04 +0100
Message-Id: <20231115174703.1996-1-clopez@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Score: 1.46
X-Spamd-Result: default: False [1.46 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         MID_CONTAINS_FROM(1.00)[];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         R_MIXED_CHARSET(0.56)[subject];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the description for the KVM_CAP_X86_BUS_LOCK_EXIT capability,
fixing a few typos and improving grammar for overall clarity.

Signed-off-by: Carlos López <clopez@suse.de>
---
 Documentation/virt/kvm/api.rst | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 7025b3751027..4be0a53d82a7 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7582,20 +7582,20 @@ KVM_BUS_LOCK_DETECTION_OFF and KVM_BUS_LOCK_DETECTION_EXIT are supported
 currently and mutually exclusive with each other. More bits can be added in
 the future.
 
-With KVM_BUS_LOCK_DETECTION_OFF set, bus locks in guest will not cause vm exits
+With KVM_BUS_LOCK_DETECTION_OFF set, bus locks in guest will not cause VM exits
 so that no additional actions are needed. This is the default mode.
 
-With KVM_BUS_LOCK_DETECTION_EXIT set, vm exits happen when bus lock detected
-in VM. KVM just exits to userspace when handling them. Userspace can enforce
-its own throttling or other policy based mitigations.
-
-This capability is aimed to address the thread that VM can exploit bus locks to
-degree the performance of the whole system. Once the userspace enable this
-capability and select the KVM_BUS_LOCK_DETECTION_EXIT mode, KVM will set the
-KVM_RUN_BUS_LOCK flag in vcpu-run->flags field and exit to userspace. Concerning
-the bus lock vm exit can be preempted by a higher priority VM exit, the exit
-notifications to userspace can be KVM_EXIT_BUS_LOCK or other reasons.
-KVM_RUN_BUS_LOCK flag is used to distinguish between them.
+With KVM_BUS_LOCK_DETECTION_EXIT set, VM exits happen when a bus lock is
+detected in VM. KVM just exits to userspace when handling them. Userspace can
+enforce its own throttling or other policy based mitigations.
+
+This capability is aimed to address the fact that a VM can exploit bus locks to
+impact the performance of the whole system. Once userspace enables this
+capability and selects the KVM_BUS_LOCK_DETECTION_EXIT mode, KVM will set the
+KVM_RUN_BUS_LOCK flag in the vcpu->run->flags field and exit to userspace.
+Concerning the bus lock, a VM exit can be preempted by a higher priority VM
+exit, so the exit notification to userspace can be KVM_EXIT_BUS_LOCK or another
+reason. KVM_RUN_BUS_LOCK flag is used to distinguish between them.
 
 7.23 KVM_CAP_PPC_DAWR1
 ----------------------
-- 
2.35.3

