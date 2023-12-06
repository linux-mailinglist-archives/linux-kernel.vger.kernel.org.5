Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2ABF806A2A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377079AbjLFIyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjLFIyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:54:37 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF59D087
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 00:54:40 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8E193227A8E; Wed,  6 Dec 2023 09:54:36 +0100 (CET)
Date:   Wed, 6 Dec 2023 09:54:36 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 3/4] nvme: move ns id info to struct nvme_ns_head
Message-ID: <20231206085436.GB24484@lst.de>
References: <20231206081244.32733-1-dwagner@suse.de> <20231206081244.32733-4-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206081244.32733-4-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 09:12:43AM +0100, Daniel Wagner wrote:
> Move the namesapce info to struct nvme_ns_head, because it's the same
> for all associated namespaces.
> 
> The head pointer is accessible from the ns pointer so we could just
> update all places with ns->x to ns->head->x. While this is okay for the
> slow path,

Do you have any data to show that it matters?  All the I/O command
setup functions already access the ns_head for ->ns_id, so looking
at more fields can't really make any difference.

If we have a good argument about reducing the pointer chasing I'm all
for it, but please as a separate, well-documented commit that also
explains the tradeoffs for the newly added lookups this adds in a few
places.
