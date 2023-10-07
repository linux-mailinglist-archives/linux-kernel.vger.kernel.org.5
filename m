Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4187BC442
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 04:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbjJGCtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 22:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbjJGCth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 22:49:37 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADDABD;
        Fri,  6 Oct 2023 19:49:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4S2VBH0rLcz4f3khj;
        Sat,  7 Oct 2023 10:49:27 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAXrt06xyBlfdFPCQ--.31163S3;
        Sat, 07 Oct 2023 10:49:32 +0800 (CST)
Subject: Re: [PATCH -next v3 00/25] md: synchronize io with array
 reconfiguration
To:     Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230928061543.1845742-1-yukuai1@huaweicloud.com>
 <CAPhsuW5cUgqy9fqj+Z4nGPQrAok-eQ=NipNxb0TL_kuCFaPMcw@mail.gmail.com>
 <f59cbb99-33dd-c427-2e43-5a07ab9fbf51@huaweicloud.com>
 <CAPhsuW7TRODsR_N95AmXJCZvpTuSKgbOjnYGxMGAWtmt3x9Vkw@mail.gmail.com>
 <eb4ea24d-f7b4-899b-9259-2d48dc83e48f@huaweicloud.com>
 <CAPhsuW72zSALeSk96QAdq4cHf=y_n13MOBmxH-dTUKjkbc_jig@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <9ce30c2f-bc45-6072-b454-aca154b779ce@huaweicloud.com>
Date:   Sat, 7 Oct 2023 10:49:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW72zSALeSk96QAdq4cHf=y_n13MOBmxH-dTUKjkbc_jig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXrt06xyBlfdFPCQ--.31163S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYk7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
        6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
        kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
        cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
        Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
        6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72
        CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4II
        rI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr4
        1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
        67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
        8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
        wI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/10/07 10:40, Song Liu 写道:
>> Can you take a look about this new cover letter?
> 
> I don't have time right now to look into all the details, but it looks
> great at first glance. We can still edit it a little bit when applying the
> patchset, but that may not be necessary.

Yeah, it's not urgent so you can take it slow, I just want to make sure
that you're good with it. I'll edit this cover letter a bit and send v4
soon.

Thanks,
Kuai

