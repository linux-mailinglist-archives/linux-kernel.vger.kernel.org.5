Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D2977C413
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 01:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbjHNXwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 19:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjHNXvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 19:51:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A315C10C8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 16:51:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89DD41063;
        Mon, 14 Aug 2023 16:52:22 -0700 (PDT)
Received: from [10.57.90.230] (unknown [10.57.90.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06FF33F762;
        Mon, 14 Aug 2023 16:51:38 -0700 (PDT)
Message-ID: <88c943b9-40e7-1eb8-cd68-56418fcdbd8f@arm.com>
Date:   Tue, 15 Aug 2023 00:51:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] hwtracing: hisi_ptt: Use pci_dev_id() to simplify the
 code
To:     Yicong Yang <yangyicong@huawei.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        jonathan.cameron@huawei.com
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, yangyingliang@huawei.com,
        yangyicong@hisilicon.com, alexander.shishkin@linux.intel.com
References: <20230808030835.167538-1-wangxiongfeng2@huawei.com>
 <1a155116-9476-88f9-75e4-405570cd70e0@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1a155116-9476-88f9-75e4-405570cd70e0@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2023 15:28, Yicong Yang wrote:
> On 2023/8/8 11:08, Xiongfeng Wang wrote:
>> PCI core API pci_dev_id() can be used to get the BDF number for a pci
>> device. We don't need to compose it mannually using PCI_DEVID(). Use
>> pci_dev_id() to simplify the code a little bit.
>>
>> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> 
> Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>

Thanks Yicong Yang, for looping me in.

In the future, please Cc me for any patches may need to be picked
up via coresight tree. For now:


Applied, thanks!

[1/1] hwtracing: hisi_ptt: Use pci_dev_id() to simplify the code
       https://git.kernel.org/coresight/c/484281bd5b98

Best regards,
--
Suzuki K Poulose <suzuki.poulose@arm.com>


> 
>> ---
>>   drivers/hwtracing/ptt/hisi_ptt.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
>> index ba081b6d2435..49ea1b0f7489 100644
>> --- a/drivers/hwtracing/ptt/hisi_ptt.c
>> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
>> @@ -618,13 +618,13 @@ static int hisi_ptt_notifier_call(struct notifier_block *nb, unsigned long actio
>>   	if (!root_port)
>>   		return 0;
>>   
>> -	port_devid = PCI_DEVID(root_port->bus->number, root_port->devfn);
>> +	port_devid = pci_dev_id(root_port);
>>   	if (port_devid < hisi_ptt->lower_bdf ||
>>   	    port_devid > hisi_ptt->upper_bdf)
>>   		return 0;
>>   
>>   	info.is_port = pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT;
>> -	info.devid = PCI_DEVID(pdev->bus->number, pdev->devfn);
>> +	info.devid = pci_dev_id(pdev);
>>   
>>   	switch (action) {
>>   	case BUS_NOTIFY_ADD_DEVICE:
>> @@ -664,7 +664,7 @@ static int hisi_ptt_init_filters(struct pci_dev *pdev, void *data)
>>   	if (!root_port)
>>   		return 0;
>>   
>> -	port_devid = PCI_DEVID(root_port->bus->number, root_port->devfn);
>> +	port_devid = pci_dev_id(root_port);
>>   	if (port_devid < hisi_ptt->lower_bdf ||
>>   	    port_devid > hisi_ptt->upper_bdf)
>>   		return 0;
>> @@ -674,7 +674,7 @@ static int hisi_ptt_init_filters(struct pci_dev *pdev, void *data)
>>   	 * should be partial initialized and users would know which filter fails
>>   	 * through the log. Other functions of PTT device are still available.
>>   	 */
>> -	filter = hisi_ptt_alloc_add_filter(hisi_ptt, PCI_DEVID(pdev->bus->number, pdev->devfn),
>> +	filter = hisi_ptt_alloc_add_filter(hisi_ptt, pci_dev_id(pdev),
>>   					    pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT);
>>   	if (!filter)
>>   		return -ENOMEM;
>>

