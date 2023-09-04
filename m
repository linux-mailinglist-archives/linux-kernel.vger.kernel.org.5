Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645B57917C1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 15:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352994AbjIDNFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 09:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjIDNFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 09:05:36 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762FD136;
        Mon,  4 Sep 2023 06:05:32 -0700 (PDT)
Received: from dggpemm500012.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RfTLX0QnDz1DDZr;
        Mon,  4 Sep 2023 21:02:12 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 4 Sep 2023 21:05:29 +0800
Message-ID: <6408e1c5-df6a-e257-26c8-2d100be6db97@huawei.com>
Date:   Mon, 4 Sep 2023 21:05:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v5 3/3] scsi: qla2xxx: Use DEFINE_SHOW_STORE_ATTRIBUTE
 helper for debugfs
Content-Language: en-CA
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <john.g.garry@oracle.com>, <damien.lemoal@opensource.wdc.com>,
        <akpm@linux-foundation.org>, <viro@zeniv.linux.org.uk>,
        <himanshu.madhani@cavium.com>, <felipe.balbi@linux.intel.com>,
        <gregkh@linuxfoundation.org>, <uma.shankar@intel.com>,
        <anshuman.gupta@intel.com>, <animesh.manna@intel.com>,
        <linux-usb@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <prime.zeng@hisilicon.com>, <kangfenglong@huawei.com>,
        <chenxiang66@hisilicon.com>
References: <20230904084804.39564-1-yangxingui@huawei.com>
 <20230904084804.39564-4-yangxingui@huawei.com>
 <ZPW39NRmd0Z0WRwW@smile.fi.intel.com>
From:   yangxingui <yangxingui@huawei.com>
In-Reply-To: <ZPW39NRmd0Z0WRwW@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.120.108]
X-ClientProxiedBy: dggpemm500022.china.huawei.com (7.185.36.162) To
 dggpemm500012.china.huawei.com (7.185.36.89)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/4 18:56, Andy Shevchenko wrote:
> On Mon, Sep 04, 2023 at 08:48:04AM +0000, Xingui Yang wrote:
>> Use DEFINE_SHOW_STORE_ATTRIBUTE helper for read-write file to reduce some
>> duplicated code and delete unused macros.
> 
>> Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
>> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
> 
> Same comments as per previous patch.
> 
> ...
> 
>> -/*
>> - * Helper macros for setting up debugfs entries.
>> - * _name: The name of the debugfs entry
>> - * _ctx_struct: The context that was passed when creating the debugfs file
>> - *
>> - * QLA_DFS_SETUP_RD could be used when there is only a show function.
>> - * - show function take the name qla_dfs_<sysfs-name>_show
>> - *
>> - * QLA_DFS_SETUP_RW could be used when there are both show and write functions.
>> - * - show function take the name  qla_dfs_<sysfs-name>_show
>> - * - write function take the name qla_dfs_<sysfs-name>_write
>> - *
>> - * To have a new debugfs entry, do:
>> - * 1. Create a "struct dentry *" in the appropriate structure in the format
>> - * dfs_<sysfs-name>
>> - * 2. Setup debugfs entries using QLA_DFS_SETUP_RD / QLA_DFS_SETUP_RW
>> - * 3. Create debugfs file in qla2x00_dfs_setup() using QLA_DFS_CREATE_FILE
>> - * or QLA_DFS_ROOT_CREATE_FILE
>> - * 4. Remove debugfs file in qla2x00_dfs_remove() using QLA_DFS_REMOVE_FILE
>> - * or QLA_DFS_ROOT_REMOVE_FILE
>> - *
>> - * Example for creating "TEST" sysfs file:
>> - * 1. struct qla_hw_data { ... struct dentry *dfs_TEST; }
>> - * 2. QLA_DFS_SETUP_RD(TEST, scsi_qla_host_t);
>> - * 3. In qla2x00_dfs_setup():
>> - * QLA_DFS_CREATE_FILE(ha, TEST, 0600, ha->dfs_dir, vha);
>> - * 4. In qla2x00_dfs_remove():
>> - * QLA_DFS_REMOVE_FILE(ha, TEST);
>> - */
> 
> I believe this comment (in some form) has to be preserved.
> Try to rewrite it using reference to the new macro.
Thanks for your reply, I checked and these macros aren't being called 
anywhere else, so I decided to delete them all. Of course, maybe this 
macro will be used in the future, and I can resubmit another version 
based on your suggestion.

Thanks.
Xingui
> 
> Otherwise looks good to me.
> 
