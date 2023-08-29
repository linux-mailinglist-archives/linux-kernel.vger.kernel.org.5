Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A52978C10D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbjH2JOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbjH2JNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:13:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93ABD12F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:13:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4F2EB21863;
        Tue, 29 Aug 2023 09:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693300417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=jby3RLt4Cl7pfimcnYIo/yv1eOMTGSq77VEFESvTCik=;
        b=ElbfAXA4M7q/Wsy/ajvXromF6qw1Mm4xKNn2Tap2eCFTDjDWCPl/QiIwgTWq42Z+j1SjSI
        xwt10BPB62zJtdVeF89kb2S1i7IEVQfMB6NZt80pgN+M8B3v5WmaGX47Phwi1senTk+6c/
        qLoN5WwlwDvdrZmrzjanaknL+XIXak8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693300417;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=jby3RLt4Cl7pfimcnYIo/yv1eOMTGSq77VEFESvTCik=;
        b=luU0R0AnLAGQz8VB8ufnb9kSEtoN8VPLEI0163BUUwlcuVubjyOyRcCUhXBIujJoTMetWC
        kv8GzLa4YUTWjzBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4149013301;
        Tue, 29 Aug 2023 09:13:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aHTpD8G27WSnUwAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 29 Aug 2023 09:13:37 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>
Subject: [RFC v1 0/4] nvmet-fc blktests & autoconnect fixes
Date:   Tue, 29 Aug 2023 11:13:45 +0200
Message-ID: <20230829091350.16156-1-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, blktests will pass with the patches [1] and the revert of
[2]. This is possible because blktests is still disables the
nvmf-autoconnect auto connect service [3].

As I previously reported, blktests is able to trigger various kernel
panics with the system auto-connect running in the background. Let's try
to fix these problems.

The first two patches are fixing nvmet ftrace infrastructure. I think
they could go in right now.

The third patch changes the way the refcounting for association and
queues is done. There is a cycling dependency between these two objects
and this makes the shutdown path very complex and error prone. As the
life time of the queues is coupled to the association, I decided to drop
the refcounting of the queues and only rely on the refcounts of the
association. This made the code a bit simpler to follow and also allowed
to cleanup path to split into two halfs. The first one is to remove the
association from the association RCU list and wait for an grace period
so we know that now new I/Os will enter any queues. Then we drop the
refcounts and then actually remove any resources when the refcount drops
to 0 (all in-flight I/O has been processed). nvme/003 is particular good
in triggering crashes in this path.

nvme/005 is triggering crashes in get discovery log page. The req->port
pointer was never assign a valid pointer. This looks like there is way
to have no port entry binding (remember we have the external autoconnect
running in background).

Unfortunately, there are still some more fallouts, but I though I post
these patches now when my memory is fresh if there are any questions.

[1] https://lore.kernel.org/linux-nvme/sgoyzwj6ckrdrpq22u6fhtcemul5rqj6de4l5gw73vz77o3ils@vmv3jue4rom7/
[2] linux: ee6fdc5055e9 ("nvme-fc: fix race between error recovery and creating association")
[3] blktests: 0478dce70696 ("nvme/rc: Avoid triggering host nvme-cli autoconnect")

Daniel Wagner (4):
  nvmet-trace: avoid dereferencing pointer too early
  nvmet-trace: null terminate device name string correctly
  nvmet-fc: untangle cross refcounting objects
  nvmet-discovery: do not use invalid port

 drivers/nvme/target/discovery.c |  9 +++++
 drivers/nvme/target/fc.c        | 67 ++++++++++++++++-----------------
 drivers/nvme/target/trace.c     |  6 +--
 drivers/nvme/target/trace.h     | 28 +++++++-------
 4 files changed, 60 insertions(+), 50 deletions(-)

-- 
2.41.0

