Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7184779E6FA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240388AbjIMLih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237669AbjIMLig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:38:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A9D19AF;
        Wed, 13 Sep 2023 04:38:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B28341F385;
        Wed, 13 Sep 2023 11:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694605110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=uJxCMUIT09a7qNSpE55xAHMI/oO/Stvr6RHMZiPfub0=;
        b=sUXrGqZZOoVIQv+OGxhDBecrjHjH49ZzQmiR8HgriyCUNOyvY51cp4MNfw9H1W6dCN5PWU
        nlskKpBvJv3CbZBLqFWxt7NaFEeKD7XRZUMlyWluXouJQXkXs4bbOOzvEQlLkhJAKeb+KB
        zwEY9BZ/BObVZJyxnDHCZXPPTtSlHnI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36BE613582;
        Wed, 13 Sep 2023 11:38:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id L4D9CzafAWVVCwAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 13 Sep 2023 11:38:30 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-trace-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org, Ajay Kaher <akaher@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 0/3] xen: cleanup and fix lazy mode handling
Date:   Wed, 13 Sep 2023 13:38:25 +0200
Message-Id: <20230913113828.18421-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small series is cleaning up Xen lazy mode handling by removing
unused stuff and moving purely Xen-specific code away from general
kernel code.

The last patch is fixing a regression which was introduced in the
6.6 merge window.

Juergen Gross (3):
  arm/xen: remove lazy mode related definitions
  x86/xen: move paravirt lazy code
  x86/xen: allow nesting of same lazy mode

 arch/x86/include/asm/paravirt_types.h | 15 ------
 arch/x86/include/asm/xen/hypervisor.h | 37 +++++++++++++++
 arch/x86/kernel/paravirt.c            | 67 ---------------------------
 arch/x86/xen/enlighten_pv.c           | 40 +++++++++++++---
 arch/x86/xen/mmu_pv.c                 | 55 ++++++++++++++--------
 arch/x86/xen/multicalls.h             |  4 +-
 include/trace/events/xen.h            | 12 ++---
 include/xen/arm/hypervisor.h          | 12 -----
 8 files changed, 114 insertions(+), 128 deletions(-)

-- 
2.35.3

