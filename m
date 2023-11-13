Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E746D7E96B1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 07:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjKMGcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 01:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjKMGcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 01:32:08 -0500
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 2F1F3D4C;
        Sun, 12 Nov 2023 22:32:05 -0800 (PST)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 3389A604D5B99;
        Mon, 13 Nov 2023 14:32:01 +0800 (CST)
Message-ID: <042b7f36-aa38-0840-adc0-08ee52ec1c10@nfschina.com>
Date:   Mon, 13 Nov 2023 14:32:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] scsi: pm8001: return error code if no attached dev
Content-Language: en-US
To:     Jason Yan <yanaijie@huawei.com>, jinpu.wang@cloud.ionos.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com
Cc:     damien.lemoal@opensource.wdc.com, johannes.thumshirn@wdc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <d34527f0-f708-8ec0-33ea-6fd9d4260a6b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/13 13:56, Jason Yan wrote:
> Hi, Su
>
> On 2023/11/13 13:01, Su Hui wrote:
>> Clang static analyzer complains that value stored to 'res' is never 
>> read.
>> Return the error code when sas_find_attached_phy_id() failed.
>>
>> Fixes: ec64858657a8 ("scsi: pm8001: Use sas_find_attached_phy_id() 
>> instead of open coding it")
>
> This 'Fixes' tag is not right. This commit is only a refactor and did 
> not change the original logic here.
>
Hi, Jason

Thanks for your reply. But I think the logic of this code is changed.

>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>>   drivers/scsi/pm8001/pm8001_sas.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/scsi/pm8001/pm8001_sas.c 
>> b/drivers/scsi/pm8001/pm8001_sas.c
>> index a5a31dfa4512..a1f58bfff5c0 100644
>> --- a/drivers/scsi/pm8001/pm8001_sas.c
>> +++ b/drivers/scsi/pm8001/pm8001_sas.c
>> @@ -662,6 +662,8 @@ static int pm8001_dev_found_notify(struct 
>> domain_device *dev)
>>                      SAS_ADDR(dev->sas_addr),
>>                      SAS_ADDR(parent_dev->sas_addr));
>>               res = phy_id;
>> +            pm8001_free_dev(pm8001_device);
>> +            goto found_out;

Before this patch, we won't go to label 'found_out', and will call 
PM8001_CHIP_DISP->reg_dev_req() ....

After this patch, we just free the 'pm8001_device' and return the error 
code.

Or maybe I misunderstand somewhere?

Su Hui

