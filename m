Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCCE7FE784
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 04:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344265AbjK3DEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 22:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjK3DEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 22:04:47 -0500
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A981D5E;
        Wed, 29 Nov 2023 19:04:53 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0VxQ.kvS_1701313489;
Received: from 30.240.112.131(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VxQ.kvS_1701313489)
          by smtp.aliyun-inc.com;
          Thu, 30 Nov 2023 11:04:50 +0800
Message-ID: <50c44afb-f1ea-4136-9d85-4916a4f3d109@linux.alibaba.com>
Date:   Thu, 30 Nov 2023 11:04:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 4/5] drivers/perf: add DesignWare PCIe PMU driver
Content-Language: en-US
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     kaishen@linux.alibaba.com, helgaas@kernel.org,
        yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com, chengyou@linux.alibaba.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        mark.rutland@arm.com, zhuo.song@linux.alibaba.com,
        renyu.zj@linux.alibaba.com
References: <20231121013400.18367-1-xueshuai@linux.alibaba.com>
 <20231121013400.18367-5-xueshuai@linux.alibaba.com>
 <aaf365bf-ada5-a52-c35-d7dd2d598b49@os.amperecomputing.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <aaf365bf-ada5-a52-c35-d7dd2d598b49@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/30 09:43, Ilkka Koskinen wrote:
> 
> On Tue, 21 Nov 2023, Shuai Xue wrote:
>> This commit adds the PCIe Performance Monitoring Unit (PMU) driver support
>> for T-Head Yitian SoC chip. Yitian is based on the Synopsys PCI Express
>> Core controller IP which provides statistics feature. The PMU is a PCIe
>> configuration space register block provided by each PCIe Root Port in a
>> Vendor-Specific Extended Capability named RAS D.E.S (Debug, Error
>> injection, and Statistics).
>>
>> To facilitate collection of statistics the controller provides the
>> following two features for each Root Port:
>>
>> - one 64-bit counter for Time Based Analysis (RX/TX data throughput and
>>  time spent in each low-power LTSSM state) and
>> - one 32-bit counter for Event Counting (error and non-error events for
>>  a specified lane)
>>
>> Note: There is no interrupt for counter overflow.
>>
>> This driver adds PMU devices for each PCIe Root Port. And the PMU device is
>> named based the BDF of Root Port. For example,
>>
>>    30:03.0 PCI bridge: Device 1ded:8000 (rev 01)
>>
>> the PMU device name for this Root Port is dwc_rootport_3018.
>>
>> Example usage of counting PCIe RX TLP data payload (Units of bytes)::
>>
>>    $# perf stat -a -e dwc_rootport_3018/Rx_PCIe_TLP_Data_Payload/
>>
>> average RX bandwidth can be calculated like this:
>>
>>    PCIe TX Bandwidth = Rx_PCIe_TLP_Data_Payload / Measure_Time_Window
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>
>> Tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> 
> Looks good to me and seems to work fine. Thus,
> 
>   Reviewed-and-tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> 
> 
> You can keep my "Tested-by: ..." in the other patches.
> 
> Cheers, Ilkka

Thank you very much :)

Cheers
Shuai

