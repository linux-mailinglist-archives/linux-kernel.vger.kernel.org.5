Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5558087E9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjLGMg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjLGMgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:36:25 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1780C10C8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 04:36:31 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B418E1FB4F;
        Thu,  7 Dec 2023 12:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1701952589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=y0U8KZeCA6s4bpvZ3Ttl3mLxygRB+RMYkcn6DEWuK94=;
        b=f5FwqGfDBOy9U8Z5u646KUAOKbJKexPpijr70f5wK+g9ldn1oY2LYDIdyu/mKe6EA5YoHr
        h+CjFjdCEjFIi3D+urRsKN71SbYI8hVlzREiQCd8e3m82mzsQ4chMlJFc1jYZ1K204oTWB
        2Y3wSHWD29i0ZbQ+HMnJ5E+ri2XNIQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1701952589;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=y0U8KZeCA6s4bpvZ3Ttl3mLxygRB+RMYkcn6DEWuK94=;
        b=Awk6IWJEr42CiZbc7ZAQBL5MvV3Do3xHG8iHwDiENL7OK+O7wOqa/+jl27vwI/cI5xcAYN
        cfCZZEyqIGoDCqBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A09C9139E3;
        Thu,  7 Dec 2023 12:36:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id dZXCJU28cWXzAgAAn2gu4w
        (envelope-from <dwagner@suse.de>); Thu, 07 Dec 2023 12:36:29 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4 0/4] nvme: add csi, ms and nuse to sysfs
Date:   Thu,  7 Dec 2023 13:36:20 +0100
Message-ID: <20231207123624.29959-1-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Score: 2.44
X-Spamd-Result: default: False [2.44 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCVD_COUNT_THREE(0.00)[3];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[7];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         BAYES_HAM(-1.26)[89.74%];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         MID_CONTAINS_FROM(1.00)[];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         RCVD_TLS_ALL(0.00)[]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As already reported in v3, the nvme_ns_head change was not gaining us anything.
Instead a simple repacking of nvme_ns gives better performance. Thus these
patches are gone. 

Thanks,
Daniel

libnvme changes:
  https://github.com/igaw/libnvme/tree/tree-no-cmd
  
changes:
v4:
 - drop 'use nvme_ns_head instead nvme_ns' patches
 - ratelimit nuse update per namespace not globally
 - rename ns attribute group
 - added non-multipath nuse update logic
 - added cacheline optimization

v3:
 - cut overlong lines shorter
 - fixed disk (queuedata) initialization order
 - more testing with blktest
 - added nuse ratelimit
 - added reviewed tags
 - https://lore.kernel.org/linux-nvme/20231206081244.32733-1-dwagner@suse.de/

v2:
 - moved ns id data to nvme_ns_head
 - dropped ds, nsze
 - https://lore.kernel.org/linux-nvme/20231201092735.28592-1-dwagner@suse.de/

v1:
 - initial version
 - https://lore.kernel.org/linux-nvme/20231127103208.25748-1-dwagner@suse.de/

Daniel Wagner (4):
  nvme: move ns id info to struct nvme_ns_head
  nvme: rename ns attribute group
  nvme: add csi, ms and nuse to sysfs
  nvme: repack struct nvme_ns_head

 drivers/nvme/host/core.c      |  87 ++++++++++++++--------------
 drivers/nvme/host/ioctl.c     |   8 +--
 drivers/nvme/host/multipath.c |   2 +-
 drivers/nvme/host/nvme.h      |  38 +++++++------
 drivers/nvme/host/rdma.c      |   2 +-
 drivers/nvme/host/sysfs.c     | 103 +++++++++++++++++++++++++++++++---
 drivers/nvme/host/zns.c       |  17 +++---
 7 files changed, 179 insertions(+), 78 deletions(-)

-- 
2.43.0

