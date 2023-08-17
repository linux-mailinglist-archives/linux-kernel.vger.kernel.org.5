Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3708677EEC7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 03:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347561AbjHQBiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 21:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347564AbjHQBhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 21:37:50 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D3C2727
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 18:37:48 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RR6zX6M5PzrS03;
        Thu, 17 Aug 2023 09:36:24 +0800 (CST)
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 17 Aug 2023 09:37:46 +0800
Message-ID: <15c26edc-eb4f-a90c-d52c-dd532c9d12ea@huawei.com>
Date:   Thu, 17 Aug 2023 09:37:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] soc: kunpeng_hccs: fix some sparse warnings about
 incorrect type
To:     Arnd Bergmann <arnd@arndb.de>, <xuwei5@hisilicon.com>,
        Arnd Bergmann <arnd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <liuyonglong@huawei.com>,
        <lihuisong@huawei.com>
References: <20230815125233.65469-1-lihuisong@huawei.com>
 <74f99c2f-fd9d-4cb9-a541-b699b79b928c@app.fastmail.com>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <74f99c2f-fd9d-4cb9-a541-b699b79b928c@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/8/16 21:17, Arnd Bergmann 写道:
> On Tue, Aug 15, 2023, at 14:52, Huisong Li wrote:
>> @@ -199,8 +200,8 @@ static int hccs_pcc_cmd_send(struct hccs_dev *hdev, u8 cmd,
>>   			     struct hccs_desc *desc)
>>   {
>>   	struct hccs_mbox_client_info *cl_info = &hdev->cl_info;
>> -	struct acpi_pcct_shared_memory *comm_base = cl_info->pcc_comm_addr;
>> -	void *comm_space = (void *)(comm_base + 1);
>> +	void __iomem *comm_space = (u8 *)cl_info->pcc_comm_addr +
>> +					sizeof(struct acpi_pcct_shared_memory);
>>   	struct hccs_fw_inner_head *fw_inner_head;
>>   	struct acpi_pcct_shared_memory tmp = {0};
>>   	u16 comm_space_size;
> The cast still looks wrong, while both comm_space and ->pcc_comm_addr
> are __iomem pointers, casting to a non-__iomem u8 pointer should
> still produce that warning. I'd suggest casting to (u8 __iomem *)
> or (void __iomem *), I assume you still need a cast here to get
> the correct address.
Thanks Arnd.

You are right. So I modify it by dropping (u8 *) here in patch v2.
Please take a look at this again.
If it is ok for you, can you apply this patch to soc/soc.git?

/Huisong
