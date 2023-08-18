Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFC078036E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 03:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357096AbjHRBjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 21:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357097AbjHRBjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 21:39:03 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B2710C7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 18:39:02 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RRkyT4BfPz1GDHl;
        Fri, 18 Aug 2023 09:37:37 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 18 Aug
 2023 09:38:59 +0800
Message-ID: <584734f7-3eb7-961f-10a2-3707cf03819c@huawei.com>
Date:   Fri, 18 Aug 2023 09:38:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] soc: kunpeng_hccs: fix some sparse warnings about
 incorrect type
To:     Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <liuyonglong@huawei.com>,
        <xuwei5@hisilicon.com>, <lihuisong@huawei.com>
References: <20230815125233.65469-1-lihuisong@huawei.com>
 <74f99c2f-fd9d-4cb9-a541-b699b79b928c@app.fastmail.com>
 <15c26edc-eb4f-a90c-d52c-dd532c9d12ea@huawei.com>
 <4f72b1d7-00b4-4318-b3c3-50d11e4a233c@app.fastmail.com>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <4f72b1d7-00b4-4318-b3c3-50d11e4a233c@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.59]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/8/17 19:54, Arnd Bergmann 写道:
> On Thu, Aug 17, 2023, at 03:37, lihuisong (C) wrote:
>> 在 2023/8/16 21:17, Arnd Bergmann 写道:
>>> On Tue, Aug 15, 2023, at 14:52, Huisong Li wrote:
>>>> @@ -199,8 +200,8 @@ static int hccs_pcc_cmd_send(struct hccs_dev *hdev, u8 cmd,
>>>>    			     struct hccs_desc *desc)
>>>>    {
>>>>    	struct hccs_mbox_client_info *cl_info = &hdev->cl_info;
>>>> -	struct acpi_pcct_shared_memory *comm_base = cl_info->pcc_comm_addr;
>>>> -	void *comm_space = (void *)(comm_base + 1);
>>>> +	void __iomem *comm_space = (u8 *)cl_info->pcc_comm_addr +
>>>> +					sizeof(struct acpi_pcct_shared_memory);
>>>>    	struct hccs_fw_inner_head *fw_inner_head;
>>>>    	struct acpi_pcct_shared_memory tmp = {0};
>>>>    	u16 comm_space_size;
>>> The cast still looks wrong, while both comm_space and ->pcc_comm_addr
>>> are __iomem pointers, casting to a non-__iomem u8 pointer should
>>> still produce that warning. I'd suggest casting to (u8 __iomem *)
>>> or (void __iomem *), I assume you still need a cast here to get
>>> the correct address.
>> Thanks Arnd.
>>
>> You are right. So I modify it by dropping (u8 *) here in patch v2.
>> Please take a look at this again.
> Right, if pcc_comm_addr is already a u8 __iomem* or void*, that
> works, I though the cast was needed since it points to a larger
> object, which would throw off the calculation.
This pcc_comm_addr is already defined "void __iomem *" type in patch v2.
So that works well, right?

/Huisong
>
>> If it is ok for you, can you apply this patch to soc/soc.git?
> Yes, of course.
>
>         Arnd
> .
