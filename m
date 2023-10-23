Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDBD7D39ED
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjJWOoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbjJWOnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:43:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C601FCF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:42:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2E1112188D;
        Mon, 23 Oct 2023 14:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698072145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=RTYsroAWljaROpiVAPyNscGJ0JLNhWtas14NGofBG64=;
        b=G7aViXm79Su4cvNDxWqYhqYC+UISHnBFJqW32gY5/ALtclMStDPw4XdGDbh56qLoHOaAi3
        qCoARrOQDg5H9DMh5BEnGIJeOc8/fxbzF5DsUKGDzc/Xi1n+ZRMZQogEpFef06FKaAxRuw
        3YNIN/1FEp7FV+mgzOZen1xSBcpZJKI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 10F63139C2;
        Mon, 23 Oct 2023 14:42:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aADMAVGGNmW5dgAAMHmgww
        (envelope-from <aporta@suse.de>); Mon, 23 Oct 2023 14:42:25 +0000
From:   Andrea della Porta <andrea.porta@suse.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nik.borisov@suse.com, arnd@arndb.de, mark.rutland@arm.com,
        Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v2 0/4] arm64: Make Aarch32 compatibility enablement optional at boot
Date:   Mon, 23 Oct 2023 16:42:19 +0200
Message-ID: <cover.1698069331.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Score: 1.30
X-Spamd-Result: default: False [1.30 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[8];
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

This is the second attempt of the patch, reviewed as follows:

* Reworked subject and description to avoid the term 'emulation' and to
  address generically 'exceptions' instead of 'syscalls' (mark.rutland)

* Moved aarch32_enabled() check inside system_supports_32bit_el0()
  (mark.rutland)

* Renamed AARCH32_EMULATION_DEFAULT_DISABLED to AARCH32_SUPPORT_DEFAULT_DISABLED
  (mark.rutland)

* Fixed a compilation Warning about missing function prototype
  Closes: https://lore.kernel.org/oe-kbuild-all/202310230423.r2U4Lqr8-lkp@intel.com/

This is just for completeness since other possible solutions have been
proposed that could be better suited, see for example:
https://lkml.kernel.org/linux-fsdevel/20210916131816.8841-1-will@kernel.org/
and followups. So, this patchset is just for reference, may be useful in the
future if some kind of exploit is found to bypass the 32bit process
enablement check (letting a process call 32bit syscalls) and nothing better
has been proposed meanwhile.

Andrea della Porta (4):
  arm64: Introduce aarch32_enabled()
  arm64/process: Make loading of 32bit processes depend on
    aarch32_enabled()
  arm64/entry-common: Make Aarch32 exceptions' availability depend on
    aarch32_enabled()
  arm64: Make Aarch32 support boot time configurable

 .../admin-guide/kernel-parameters.txt         |  7 ++++
 arch/arm64/Kconfig                            |  9 +++++
 arch/arm64/include/asm/cpufeature.h           | 20 +++++++++--
 arch/arm64/include/asm/exception.h            |  7 ++++
 arch/arm64/kernel/entry-common.c              | 33 +++++++++++++++++--
 5 files changed, 71 insertions(+), 5 deletions(-)

-- 
2.35.3

