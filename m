Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D72F79B953
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355412AbjIKV6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240441AbjIKOoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:44:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1879C12A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:44:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CD53721846;
        Mon, 11 Sep 2023 14:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694443450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xr4ibqDuzuUnxUV/l1cvdGlA8SZbcOuzfT1Mj/uprVU=;
        b=NfFY5JLCFkpg52Yo0SZyE7dtixYz5/S8ijG4dbkyXIrJtDbjBAx3d7DpjEqx1+4k+76K7a
        2OMYRCCWd5wuVDb8gQOv+SPIhqSMCLuBT+MU+vSMSw/xi5lUKG061M/hCmid4l16PxFOy4
        ETFJQnGXIOOwMmsQ4mw6n7hydMptImM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694443450;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xr4ibqDuzuUnxUV/l1cvdGlA8SZbcOuzfT1Mj/uprVU=;
        b=Etp/FImonl8DmzxPuqfZ7G2KQfkBQ5zcbFpd5hjLYjrn5qH/fp+XVjD6QKIR+hOuNQ/c4b
        7B1xLLPiXOxJ8iDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE607139CC;
        Mon, 11 Sep 2023 14:44:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9AtbLron/2TcUwAAMHmgww
        (envelope-from <dwagner@suse.de>); Mon, 11 Sep 2023 14:44:10 +0000
Date:   Mon, 11 Sep 2023 16:44:46 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [RFC v1 4/4] nvmet-discovery: do not use invalid port
Message-ID: <ebfmki7mifmo67x27wwrdpabdbiamalj7rsevxvabyi4sff4ck@4d5fyvrjggkw>
References: <20230829091350.16156-1-dwagner@suse.de>
 <20230829091350.16156-5-dwagner@suse.de>
 <20230905065032.GC19701@lst.de>
 <vml2mmhjurjaalzcmugnu2c4cm4okfkl43swbmudmaotew4gsy@o4q44el473to>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vml2mmhjurjaalzcmugnu2c4cm4okfkl43swbmudmaotew4gsy@o4q44el473to>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 12:40:25PM +0200, Daniel Wagner wrote:
> > But I'm still confused how we can get here without req->port
> > set.  Can you try to do a little more analysis as I suspect we have
> > a deeper problem somewhere.

The problem is that nvme/005 starts to cleanup all resources and there
is a race between the cleanup path and the host trying to figure out
what's going on (get log page).

We have 3 association:

 assoc 0: systemd/udev triggered 'nvme connect-all' discovery controller
 assoc 1: discovery controller from nvme/005
 assoc 2: i/o controller from nvme/005

nvme/005 issues a reset_controller but doesn't waiting or checking the
result. Instead we go directly into the resource cleanup part, nvme
disconnect which removes assoc 1 and assoc. Then the target cleanup
part starts. At this point, assoc 0 is still around.

 nvme nvme3: Removing ctrl: NQN "blktests-subsystem-1"
 block nvme3n1: no available path - failing I/O
 block nvme3n1: no available path - failing I/O
 Buffer I/O error on dev nvme3n1, logical block 89584, async page read
 (NULL device *): {0:2} Association deleted
 nvmet_fc: nvmet_fc_portentry_unbind: tgtport 000000004f5c9138 pe 00000000e2a2da84
 [321] nvmet: ctrl 2 stop keep-alive
 (NULL device *): {0:1} Association freed
 (NULL device *): Disconnect LS failed: No Association
 general protection fault, probably for non-canonical address 0xdffffc00000000a4: 0000 [#1] PREEMPT SMP KASAN NOPTI
 KASAN: null-ptr-deref in range [0x0000000000000520-0x0000000000000527]
 CPU: 1 PID: 250 Comm: kworker/1:4 Tainted: G        W          6.5.0-rc2+ #20 e82c2becb08b573f1fa41dfeddc70ac8f6838a63
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 2/2/2022
 Workqueue: nvmet-wq fcloop_fcp_recv_work [nvme_fcloop]
 RIP: 0010:nvmet_execute_disc_get_log_page+0x23f/0x8c0 [nvmet]

The target cleanup removes the port from the subsystem
(nvmet_fc_portentry_unbind) and does not check if there is still a
association around. Right after we have removed assoc 1 and 2 the host
sends a get log page command on assoc 0. Though we have remove the port
binding and thus the pointer when nvmet_execute_disc_get_log_page gets
executed.

I am still pondering how to fix this.
