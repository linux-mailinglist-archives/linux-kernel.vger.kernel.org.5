Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8C0793371
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 03:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbjIFBmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 21:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjIFBmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 21:42:36 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE3C1B3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 18:42:32 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RgQ4k1j8MztQSC;
        Wed,  6 Sep 2023 09:38:30 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 6 Sep 2023 09:42:28 +0800
Subject: Re: [PATCH] ubifs: fix possible dereference after free
To:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yusongping@huawei.com>, <artem.kuzin@huawei.com>
References: <20230905101222.1725230-1-konstantin.meskhidze@huawei.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <939c0385-8663-91a2-df20-920f264a2aa1@huawei.com>
Date:   Wed, 6 Sep 2023 09:42:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230905101222.1725230-1-konstantin.meskhidze@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2023/9/5 18:12, Konstantin Meskhidze Ð´µÀ:
> 'old_idx' could be dereferenced after free via 'rb_link_node' function
> call.
> 
> Fixes: b5fda08ef213 ("ubifs: Fix memleak when insert_old_idx() failed")
> Co-developed-by: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
> Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> ---
>   fs/ubifs/tnc.c | 1 +
>   1 file changed, 1 insertion(+)
> 

Only for static alarms£¬although it couldn't happen in theory.

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

> diff --git a/fs/ubifs/tnc.c b/fs/ubifs/tnc.c
> index 6b7d95b65f4b..f4728e65d1bd 100644
> --- a/fs/ubifs/tnc.c
> +++ b/fs/ubifs/tnc.c
> @@ -64,8 +64,9 @@ static void do_insert_old_idx(struct ubifs_info *c,
>   			p = &(*p)->rb_right;
>   		else {
>   			ubifs_err(c, "old idx added twice!");
>   			kfree(old_idx);
> +			return;
>   		}
>   	}
>   	rb_link_node(&old_idx->rb, parent, p);
>   	rb_insert_color(&old_idx->rb, &c->old_idx);
> 

