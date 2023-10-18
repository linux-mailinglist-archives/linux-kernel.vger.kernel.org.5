Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3FE7CDA0E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjJRLNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjJRLNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:13:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4530E112
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:13:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7E67E1F383;
        Wed, 18 Oct 2023 11:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697627606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=WWOeIhCQpfkoB9v4pU6ssMo6xZ7yBOXJ0schrwa2slA=;
        b=rqsvqGS0pplX1TMVXx3jtnoyflVVfjwHTHeEozpvg2BKUFgH/CbqvfwPoKYX6824ddK+7w
        RhX8j53M0c7g4pXZIkarww1+OSi2lNQGPVmL5awBufgdFZ1omg4JTUSkmRxCIhwP5QA+Tl
        zRLEwkbzK7cGaQvPPWalwslb1yVv73Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 61D9F13915;
        Wed, 18 Oct 2023 11:13:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BAJvFda9L2VDZwAAMHmgww
        (envelope-from <aporta@suse.de>); Wed, 18 Oct 2023 11:13:26 +0000
From:   Andrea della Porta <andrea.porta@suse.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nik.borisov@suse.com, Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH 0/4] arm64: Make Aarch32 compatibility enablement optional at boot
Date:   Wed, 18 Oct 2023 13:13:18 +0200
Message-ID: <cover.1697614386.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -1.70
X-Spamd-Result: default: False [-1.70 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_FIVE(0.00)[6];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FORGED_SENDER(0.30)[andrea.porta@suse.com,aporta@suse.de];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         FROM_NEQ_ENVFROM(0.10)[andrea.porta@suse.com,aporta@suse.de];
         RCVD_TLS_ALL(0.00)[]
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aarch32 compatibility mode is enabled at compile time through
CONFIG_COMPAT Kconfig option. This patchset lets 32-bit support
(for both processes and syscalls) be enabled at boot time using
a kernel parameter. Also, it provides a mean for distributions 
to set their own default without sacrificing compatibility support,
that is users can override default behaviour through the kernel
parameter.

*** Notes about syscall management ***
VBAR_EL1 register, which holds the exception table address,
is setup very early in the boot process, before parse_early_param().
This means that it's not possible to access boot parameter before
setting the register. Also, setting the aforementioned register
for secondary cpus is done later in the boot flow.
Several ways to work around this has been considered, among which:

* resetting VBAR_EL1 to point to one of two vector tables (the
  former with 32-bit exceptions handler enabled and the latter
  pointing to unhandled stub, just as if CONFIG_COMPAT is enabled)
  depending on the proposed boot parameter. This has the disadvantage
  to produce a somewhat messy patchset involving several lines,
  has higher cognitive load since there are at least three places
  where the register is getting changed (not near to each other),
  and have implications on other code segments (namely kpti, kvm
  and vdso), requiring special care.

* patching the vector table contents once the early param is available.
  This has most of the implications of the previous option
  (except maybe not impacting other code segments), plus it sounds
  a little 'hackish'.

The chosen approach involves conditional executing 32-bit syscalls
depending on the parameter value. This of course results in a
little performance loss, but has the following advantages:

* all the cons from previously explained alternatives are solved
* users of 32-bit apps on 64-bit kernel are already suffering from
  performance losses due to 32-bit apps not fully leveraging the 64-bit
  processor, so they are already aware of this
* users of 32-bit apps on 64-bit kernel are believed
  to be a minority and most of the time there are sources available
  to be recompiled for 64-bit as a workaround for better performance

It worth mentioning that users of 64-bit apps are, of course,
unaffected.

Based on the work from Nikolay Borisov, see:
Link: https://lkml.org/lkml/2023/6/23/387

Andrea della Porta (4):
  arm64: Introduce aarch32_enabled()
  arm64/process: Make loading of 32bit processes depend on
    aarch32_enabled()
  arm64/entry-common: Make Aarch32 syscalls' availability depend on
    aarch32_enabled()
  arm64: Make Aarch32 emulation boot time configurable

 .../admin-guide/kernel-parameters.txt         |  7 ++++
 arch/arm64/Kconfig                            |  9 +++++
 arch/arm64/include/asm/compat.h               | 12 +++++++
 arch/arm64/kernel/entry-common.c              | 33 +++++++++++++++++--
 arch/arm64/kernel/process.c                   |  2 +-
 5 files changed, 59 insertions(+), 4 deletions(-)

-- 
2.35.3

