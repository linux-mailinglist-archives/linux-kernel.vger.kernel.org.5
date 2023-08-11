Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E826779074
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjHKNK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjHKNKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:10:54 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FF730CB;
        Fri, 11 Aug 2023 06:10:53 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4DD1867373; Fri, 11 Aug 2023 15:10:49 +0200 (CEST)
Date:   Fri, 11 Aug 2023 15:10:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Wen Xiong <wenxiong@linux.ibm.com>,
        Keith Busch <kbusch@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>,
        Pingfan Liu <piliu@redhat.com>
Subject: Re: [PATCH V3 01/14] blk-mq: add blk_mq_max_nr_hw_queues()
Message-ID: <20230811131049.GA20991@lst.de>
References: <20230808104239.146085-1-ming.lei@redhat.com> <20230808104239.146085-2-ming.lei@redhat.com> <20230809134401.GA31852@lst.de> <ZNQqt1C0pXspGl3d@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNQqt1C0pXspGl3d@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 08:09:27AM +0800, Ming Lei wrote:
> 1) some archs support 'nr_cpus=1' for kdump kernel, which is fine, since
> num_possible_cpus becomes 1.
> 
> 2) some archs do not support 'nr_cpus=1', and have to rely on
> 'max_cpus=1', so num_possible_cpus isn't changed, and kernel just boots
> with single online cpu. That causes trouble because blk-mq limits single
> queue.

And we need to fix case 2.  We need to drop the is_kdump support, and
if they want to force less cpus they need to make nr_cpus=1 work.

