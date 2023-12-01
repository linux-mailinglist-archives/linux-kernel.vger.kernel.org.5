Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B5C800700
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378199AbjLAJ35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378189AbjLAJ3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:29:37 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799C92721
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:27:48 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6DAD621C3E;
        Fri,  1 Dec 2023 09:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1701422866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=WOtDxc+0CUVH1bgxuNgGLc6i5JbaWlWpPk+72gmy0nQ=;
        b=dSU/z05URucCogX6a95hB/5PICcSlu/D5r7y6UaiH2YwO58AHna24Prpx3p5oocfr4QqZ8
        542O2gKNAL+2j3mj+41WSJCtXixNydmHuxP8Al7rHOILSH6L8wHXDmXG2Otd2fG+S1+NLH
        6eRItJGUob9JyIQ8RMOvvzUY/hu/Vt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1701422866;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=WOtDxc+0CUVH1bgxuNgGLc6i5JbaWlWpPk+72gmy0nQ=;
        b=FlIzCByVIt2Es8zV7fh8DvnbmGHKBD5ByyJ3yAP0J+DGex8F+DNxhlDxKuzPULKrVxmiim
        133dIuUe826VGhBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C41013928;
        Fri,  1 Dec 2023 09:27:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id Uh0XFRKnaWULZgAAn2gu4w
        (envelope-from <dwagner@suse.de>); Fri, 01 Dec 2023 09:27:46 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [RFC v2 0/3] nvme: add csi, ms and nuse to sysfs
Date:   Fri,  1 Dec 2023 10:27:32 +0100
Message-ID: <20231201092735.28592-1-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Score: 3.90
X-Spamd-Result: default: False [3.90 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         RCPT_COUNT_SEVEN(0.00)[7];
         MID_CONTAINS_FROM(1.00)[];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.00)[12.67%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've moved all ns id info to nvms_ns_head in this version as we discussed in v1
(hope I understood it right). The change was pretty much straightforward except for 

  nvme_mpath_clear_current_path
  nvme_mpath_revalidate_paths
  nvme_failover_req

where there is need to access a nvme_ns pointer again. I've tested this change
with the nvme-pci and nvme-tcp transport so far.

Thanks,
Daniel

libnvme changes:
  https://github.com/igaw/libnvme/tree/tree-no-cmd
  
changes:

v2:
 - moved ns id data to nvme_ns_head
 - dropped ds, nsze

v1:
 - initial version
 - https://lore.kernel.org/linux-nvme/20231127103208.25748-1-dwagner@suse.de/

Daniel Wagner (3):
  nvme: lookup ctrl from request instead from namespace
  nvme: move ns id info to struct nvme_ns_head
  nvme: add csi, ms and nuse to sysfs

 drivers/nvme/host/apple.c      |   4 +-
 drivers/nvme/host/core.c       | 191 +++++++++++++++++----------------
 drivers/nvme/host/fc.c         |   4 +-
 drivers/nvme/host/ioctl.c      |  20 ++--
 drivers/nvme/host/multipath.c  |  40 +++----
 drivers/nvme/host/nvme.h       |  57 +++++-----
 drivers/nvme/host/rdma.c       |  10 +-
 drivers/nvme/host/sysfs.c      |  24 +++++
 drivers/nvme/host/tcp.c        |   8 +-
 drivers/nvme/host/zns.c        |  30 +++---
 drivers/nvme/target/loop.c     |   4 +-
 drivers/nvme/target/passthru.c |   8 +-
 12 files changed, 216 insertions(+), 184 deletions(-)

-- 
2.43.0

