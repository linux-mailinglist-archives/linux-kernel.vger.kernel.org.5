Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293DB7AD9FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjIYOWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjIYOWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:22:22 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47C7B6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 07:22:15 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RvQ2m3Cs5zNnfR;
        Mon, 25 Sep 2023 22:18:24 +0800 (CST)
Received: from [10.174.178.209] (10.174.178.209) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 25 Sep 2023 22:22:12 +0800
Message-ID: <cc5c393d-c495-8f0d-9cc8-4e195c25c237@huawei.com>
Date:   Mon, 25 Sep 2023 22:22:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [RFC] mtd: Fix error code loss in mtdchar_read() function.
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>
References: <20230923005856.2538223-1-wangzhaolong1@huawei.com>
 <20230925104938.3f7b4284@xps-13>
From:   ZhaoLong Wang <wangzhaolong1@huawei.com>
In-Reply-To: <20230925104938.3f7b4284@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.209]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> There is this comment right above, and I'm not sure it is still up to
> date because I believe many drivers just don't provide the data upon
> ECC error:

After observing the nand_base framework code, I think the current nand_base
framework can limit the length of retlen to 0 when an ECC error occurs. The
prerequisite is that the NAND driver development personnel can correctly 
provide
the return value of the function according to the requirements of the 
chip->ecc.read_page()
callback.

However, the read_page() callback comment does not notice the 
particularity of the
following two error codes:

* -EUCLEAN - Returned by the MTD layer when maxbitflips greater then 
bitflip_threshold
* -EBADMSG - Returned by NAND Generic Layer when the statistical ECC 
error stats
                          changes and the number of retries is exhausted.

These two error codes are handled by the upper layer and should not be 
returned by the
NAND driver developer. But some driver developers don't realize this.

So I don't think it's worth fixing right now, but is the description of 
the return value of the
callback too simplistic? Is there any other more detailed description 
document for reference?

