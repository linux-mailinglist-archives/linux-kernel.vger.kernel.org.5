Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1D97A57E1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 05:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjISD2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 23:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjISD17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 23:27:59 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC928116
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 20:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:Reply-To:MIME-Version;
        bh=4Y6wt5SzgLMJ3PPOdqn79HesSoUYnREHVbZj8xkzF7U=; b=nprfgFIvNTj1o
        VWkPe6q8BH3x4TNASdJVcYGb88WEi546PbzqFdujpfdVZ89mQTh+TbiLURzBvraR
        re0EjqkUX7/CjqiETRC4CXICfbYUm3+Xaihj5Wj9ms8GNb8qNKJet1FOe/urVnj1
        jXNUtndWlb5WKMtfO9JzGDIhn2za7E=
Received: from localhost.localdomain (unknown [183.192.130.204])
        by zwqz-smtp-mta-g2-1 (Coremail) with SMTP id _____wB3Lij7FAllZePxCQ--.10947S2;
        Tue, 19 Sep 2023 11:26:52 +0800 (CST)
From:   Ping Gan <jacky_gam_2001@163.com>
To:     chaitanyak@nvidia.com
Cc:     ping_gan@dell.com, kbusch@kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        jacky_gam_2001@163.com
Subject: Re: [PATCH 0/4] nvmet: support polling queue task for bio
Date:   Tue, 19 Sep 2023 11:25:38 +0800
Message-Id: <20230919032539.71629-1-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <28949e52-7db7-4227-6bbd-cb8b627b390f@nvidia.com>
References: <28949e52-7db7-4227-6bbd-cb8b627b390f@nvidia.com>
Reply-To: chaitanyak@nvidia.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wB3Lij7FAllZePxCQ--.10947S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw15JF4kAFykWF1rZw1xGrg_yoW8WFW3pa
        yFq3ZxArWktF4rA3WUAw4vq34vq3WrC3WrXayrJrZ2krZ8KFyxWr15AFy3Xrs5WFykKr12
        vwn2v398Xw48trJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR0oG9UUUUU=
X-Originating-IP: [183.192.130.204]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/xtbBohPuKVaEJhdPpQABs+
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 9/13/2023 1:34 AM, Ping Gan wrote:
> > Since nvme target currently does not support to submit bio to a
> > polling
> > queue, the bio's completion relies on system interrupt. But when
> > there
> > is high workload in system and the competition is very high, so it
> > makes
> > sense to add polling queue task to submit bio to disk's polling
> > queue
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
I did two group tests. The IO size of first is 4K, and the other is 2M.
Both include randrw, randwrite and randrw. Both also have same prerequisites.
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
bandwidth of interrupt. But for iosize 2M the improvement is not
obvious,
the randrw of polling queue is about 9% more than interrupt; randwrite
and randread of polling queue is about 5% more than interrupt.


Thanks,
Ping


