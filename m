Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5927F25AE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 07:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjKUGQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 01:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjKUGQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 01:16:57 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9817897;
        Mon, 20 Nov 2023 22:16:50 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SZDfj4nnyz4f3lwD;
        Tue, 21 Nov 2023 14:16:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 4516F1A0370;
        Tue, 21 Nov 2023 14:16:47 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
        by APP1 (Coremail) with SMTP id cCh0CgBXWhBCS1xldFINBg--.30356S3;
        Tue, 21 Nov 2023 14:16:42 +0800 (CST)
Message-ID: <b36401c6-36b8-3855-d7c3-9788b88e1b51@huaweicloud.com>
Date:   Tue, 21 Nov 2023 14:16:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] nbd: pass nbd_sock to nbd_read_reply() instead of index
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linan666@huaweicloud.com, josef@toxicpanda.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>, Ming Lei <ming.lei@redhat.com>
References: <20230911023308.3467802-1-linan666@huaweicloud.com>
 <ZRT7cVFcE6QMHfie@fedora>
 <47669fb6-3700-e327-11af-93a92b0984a0@huaweicloud.com>
 <ZRUt/vAQNGNp6Ugx@fedora>
 <41161d21-299c-3657-6020-0a3a9cf109ec@huaweicloud.com>
 <ZRU/7Bx1ZJSX3Qg3@fedora>
 <60f9a88b-b750-3579-bdfd-5421f2040406@huaweicloud.com>
 <ZRVGWkCzKAVVL9bV@fedora>
 <bbadaad4-172e-af7b-2a47-52f7e7c83423@huaweicloud.com>
 <a6393a45-8510-5734-c174-0826c7d76675@huaweicloud.com>
 <ZT+kzw3Zm/3XJqD7@fedora>
 <cc6274c3-b9ba-cd6e-5ef4-af736b1a1f13@huaweicloud.com>
From:   Li Nan <linan666@huaweicloud.com>
In-Reply-To: <cc6274c3-b9ba-cd6e-5ef4-af736b1a1f13@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBXWhBCS1xldFINBg--.30356S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XrWDKF13Jr1ktrWfAw43Wrg_yoW3Zrb_WF
        W0kr18Xw43JFnYqF9FkryfXrs3WF1Fq34rXr4Fvw45Xw13u3ykKF93X39avw18Gay8Cwn2
        kr95W3yjg39xWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbSxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIF
        xwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7V
        AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
        r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
        IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
        w20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5vtCUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jens

This patch has been reviewed by Yu Kuai and Ming Lei. Could you please
consider apply it?

在 2023/10/30 21:16, Yu Kuai 写道:
> 在 2023/10/30 20:42, Ming Lei 写道:
> 
>>> After reviewing some code, I found that it's wrong to grab config_lock,
>>> because other context will grab such lock and flush_workqueue(), and
>>> there is no gurantee that recv_work() will grab the lock first.
>>>
>>> Will it be acceptable to export blk_queue_enter()? I can't think of
>>> other way to retrieve the`nsock` reference at the entry of recv_work().
>>
>> Then I think it is easier to pass `nsock` from `recv_thread_args`, which
>> can be thought as local variable too.
>>
>> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> 
> Agreed
> 
> Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> 
> .

-- 
Thanks,
Nan

