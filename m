Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10489763742
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 15:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbjGZNOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 09:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbjGZNOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:14:18 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F962269A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 06:14:15 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3365968AFE; Wed, 26 Jul 2023 15:14:09 +0200 (CEST)
Date:   Wed, 26 Jul 2023 15:14:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Keith Busch <kbusch@kernel.org>,
        Pratyush Yadav <ptyadav@amazon.de>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: do not set the NUMA node of device if it has
 none
Message-ID: <20230726131408.GA15909@lst.de>
References: <20230725110622.129361-1-ptyadav@amazon.de> <ZL/dphk/MJMRskX8@kbusch-mbp.dhcp.thefacebook.com> <50a125da-95c8-3b9b-543a-016c165c745d@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50a125da-95c8-3b9b-543a-016c165c745d@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 10:58:36AM +0300, Sagi Grimberg wrote:
>>> For example, AWS EC2's i3.16xlarge instance does not expose NUMA
>>> information for the NVMe devices. This means all NVMe devices have
>>> NUMA_NO_NODE by default. Without this patch, random 4k read performance
>>> measured via fio on CPUs from node 1 (around 165k IOPS) is almost 50%
>>> less than CPUs from node 0 (around 315k IOPS). With this patch, CPUs on
>>> both nodes get similar performance (around 315k IOPS).
>>
>> irqbalance doesn't work with this driver though: the interrupts are
>> managed by the kernel. Is there some other reason to explain the perf
>> difference?
>
> Maybe its because the numa_node goes to the tagset which allocates
> stuff based on that numa-node ?

Yeah, the only explanation I could come up with is that without this
the allocations gets spread, and that somehow helps.  All of this
is a little obscure, but so is the NVMe practice of setting the node id
to first_memory_node, which no other driver does.  I'd really like to
understand what's going on here first.  After that this patch probably
is the right thing, I'd just like to understand why.
