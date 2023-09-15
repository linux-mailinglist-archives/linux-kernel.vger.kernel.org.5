Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2E17A1AD6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbjIOJks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbjIOJkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:40:47 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6997E30DB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:Reply-To:MIME-Version;
        bh=Ox4t8vsBfHdHBvmrp8jZiGllqFgu3g66e8FODoz9bQg=; b=fJI6WlWmj1AOf
        yUIIbKxoEaBQajm2Nrgs7xcc2sqHbxlzU8FsNIYsF/HsIba4+2xI8XKlUFF7uIcr
        t7swTLsfB4v4PBInxim9tmi+hoKt76Id9c85frM5jIGKYWMY7gWY9TAcWeSmdd9e
        uWaaHTzaTowEUIdPzCzsGPr+EH6gIY=
Received: from localhost.localdomain (unknown [139.227.195.81])
        by zwqz-smtp-mta-g5-3 (Coremail) with SMTP id _____wD3vKUsJgRlL82KCA--.12438S2;
        Fri, 15 Sep 2023 17:38:54 +0800 (CST)
From:   Ping Gan <jacky_gam_2001@163.com>
To:     chaitanyak@nvidia.com
Cc:     ping_gan@dell.com, kbusch@kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        jacky_gam_2001@163.com
Subject: 
Date:   Fri, 15 Sep 2023 17:37:57 +0800
Message-Id: <20230915093758.31397-1-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <28949e52-7db7-4227-6bbd-cb8b627b390f@nvidia.com>
References: <28949e52-7db7-4227-6bbd-cb8b627b390f@nvidia.com>
Reply-To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3vKUsJgRlL82KCA--.12438S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw15JF4xtrWfZw18GF18uFg_yoW8WFy3pF
        WFq3ZxArW8tF4rAw1UAws2q34vqw1rC3WrXayrJrZ2kr98KryxWr15AFy3Xrs5WFykKr12
        vwn2v398Xw48trJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEzBTnUUUUU=
X-Originating-IP: [139.227.195.81]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiKBTrKV7WNENZmwAAsD
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 9/13/2023 1:34 AM, Ping Gan wrote:
> > Since nvme target currently does not support to submit bio to a
> > polling
> > queue, the bio's completion relies on system interrupt. But when there
> > is high workload in system and the competition is very high, so it
> > makes
> > sense to add polling queue task to submit bio to disk's polling queue
> > and poll the completion queue of disk.
> > 
> >
>
> I did some work in the past for nvmet polling and saw good
> performance improvement.
>
> Can you please share performance numbers for this series ?
> 
> -ck

hi,
I have verified this patch on two testbeds one for host and the other
for target. I used tcp as transport protocol, spdk perf as initiator. 
I do two group tests. The IO size of first is 4K, and the other is 2M. 
Both includ randrw, randwrite and randrw.  Both have same prerequisites.
At the initiator side I used 1 qp, 32 queue depth,and 1 spdk perf 
application, and for target side I bound tcp queue to 1 target core.
And I get below results.
iosize_4k        polling queue                        interrupt
randrw           NIC_rx:338M/s NIC_tx:335M/s      NIC_rx:260M/s
NIC_tx:258M/s
randwrite        NIC_rx:587M/s                    NIC_rx:431M/s
randread         NIC_tx:873M/s                    NIC_tx:654M/s

iosize_2M        polling queue                        interrupt
randrw           NIC_rx:738M/s NIC_tx:741M/s      NIC_rx:674M/s
NIC_tx:674M/s
randwrite        NIC_rx:1199M/s                   NIC_rx:1146M/s
randread         NIC_tx:2226M/s                   NIC_tx:2119M/s

For iosize 4k the NIC's bandwidth of poling queue is more than 30% than
bandwidth of interrupt. But for iosize 2M the improvement is not obvious,
the randrw of polling queue is about 9% more than interrupt; randwrite 
and randread of polling queue is about 5% more than interrupt.


Thanks,
Ping


