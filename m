Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6FE80692F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjLFIMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjLFIMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:12:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDA4D3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 00:12:50 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 069232206B;
        Wed,  6 Dec 2023 08:12:49 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E5D57133DD;
        Wed,  6 Dec 2023 08:12:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id TNGhNgAtcGUPHgAAn2gu4w
        (envelope-from <dwagner@suse.de>); Wed, 06 Dec 2023 08:12:48 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3 0/4] nvme: add csi, ms and nuse to sysfs
Date:   Wed,  6 Dec 2023 09:12:40 +0100
Message-ID: <20231206081244.32733-1-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 4.21
X-Spamd-Result: default: False [4.21 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_SPAM_SHORT(2.22)[0.738];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.00)[~all:c];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         RCPT_COUNT_SEVEN(0.00)[7];
         MID_CONTAINS_FROM(1.00)[];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spamd-Bar: ++++
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none);
        spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dwagner@suse.de) smtp.mailfrom=dwagner@suse.de
X-Rspamd-Queue-Id: 069232206B
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'v dropped the RFC status and tested it lot more which found an obvious bug.
When initializating the disk in nvme_alloc_ns, the ns->head pointer was still
NULL. This is why I added the 'nvme: initialize head before namespace' patch.

I can't really explain why my testing didn't catch this earlier. Anyway, I
rebuild my test setup completely to make sure I got the most obvious things
tested. The blktests with loop and nvme-tcp pass, nvme-rdma breaks but so does
the base line test. So not a regression by this series.

Thanks,
Daniel

libnvme changes:
  https://github.com/igaw/libnvme/tree/tree-no-cmd
  
changes:
v3:
 - cut overlong lines shorter
 - fixed disk (queuedata) initialization order
 - more testing with blktest
 - added nuse ratelimit
 - added reviewed tags

v2:
 - moved ns id data to nvme_ns_head
 - dropped ds, nsze
 - https://lore.kernel.org/linux-nvme/20231201092735.28592-1-dwagner@suse.de/

v1:
 - initial version
 - https://lore.kernel.org/linux-nvme/20231127103208.25748-1-dwagner@suse.de/

Daniel Wagner (4):
  nvme: lookup ctrl from request instead from namespace
  nvme: initialize head before namespace
  nvme: move ns id info to struct nvme_ns_head
  nvme: add csi, ms and nuse to sysfs

 drivers/nvme/host/apple.c      |   4 +-
 drivers/nvme/host/core.c       | 279 +++++++++++++++++++--------------
 drivers/nvme/host/fc.c         |   4 +-
 drivers/nvme/host/ioctl.c      |  20 +--
 drivers/nvme/host/multipath.c  |  31 ++--
 drivers/nvme/host/nvme.h       |  62 ++++----
 drivers/nvme/host/rdma.c       |  10 +-
 drivers/nvme/host/sysfs.c      |  31 ++++
 drivers/nvme/host/tcp.c        |   8 +-
 drivers/nvme/host/zns.c        |  34 ++--
 drivers/nvme/target/loop.c     |   4 +-
 drivers/nvme/target/passthru.c |   8 +-
 12 files changed, 291 insertions(+), 204 deletions(-)

-- 
2.43.0

