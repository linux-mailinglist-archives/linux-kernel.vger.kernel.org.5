Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA077AC6D1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 08:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjIXGhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 02:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXGhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 02:37:14 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B7E107;
        Sat, 23 Sep 2023 23:37:07 -0700 (PDT)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RtbpP15LZz15NRG;
        Sun, 24 Sep 2023 14:34:53 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sun, 24 Sep 2023 14:37:03 +0800
Message-ID: <407be945-9fd2-8e00-e72b-82e2f311dbeb@huawei.com>
Date:   Sun, 24 Sep 2023 14:37:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] scsi: core: scsi_device_online() return false if
 state is SDEV_CANCEL
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <louhongxiang@huawei.com>,
        <linux-scsi@vger.kernel.org>
References: <20230922093636.2645961-1-haowenchao2@huawei.com>
 <20230922093636.2645961-2-haowenchao2@huawei.com>
 <50b20a3e-e264-4788-8e52-f7b57cf944f0@acm.org>
From:   Wenchao Hao <haowenchao2@huawei.com>
In-Reply-To: <50b20a3e-e264-4788-8e52-f7b57cf944f0@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000012.china.huawei.com (7.193.23.142)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/22 23:23, Bart Van Assche wrote:
> On 9/22/23 02:36, Wenchao Hao wrote:
>> SDEV_CANCEL is set when removing device and scsi_device_online() should
>> return false if sdev_state is SDEV_CANCEL.
>>
>> IO hang would be caused if return true when state is SDEV_CANCEL with
>> following order:
>>
>> T1:                        T2:scsi_error_handler
>> __scsi_remove_device()
>>    scsi_device_set_state(sdev, SDEV_CANCEL)
>>                            scsi_eh_flush_done_q()
>>                         if (scsi_device_online(sdev))
>>                           scsi_queue_insert(scmd,...)
>>
>> The command added by scsi_queue_insert() would never be handled any
>> more.
> 
> Why not? I think the blk_mq_destroy_queue() call in __scsi_remove_device() will cause it to fail.
> 
> Thanks,
> 
> Bart.
> 

Sorry, I did not describe in detail, the __scsi_remove_device() would be blocked
in blk_mq_freeze_queue_wait() to wait all block requests finished, so
blk_mq_destroy_queue() would not be called, and the task which try to remove
scsi_device would be hung.
