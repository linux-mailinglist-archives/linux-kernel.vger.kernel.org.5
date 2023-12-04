Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB9F802D3C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 09:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjLDIb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjLDIb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:31:57 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE7BD5;
        Mon,  4 Dec 2023 00:32:03 -0800 (PST)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SkGxl6yRdzShgS;
        Mon,  4 Dec 2023 16:27:39 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 16:32:00 +0800
Message-ID: <5402aa8a-a20f-4d28-bd36-3b88702ea6ae@huawei.com>
Date:   Mon, 4 Dec 2023 16:31:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     <shaojijie@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
        Hao Chen <chenhao418@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: hns3: reduce stack usage in hclge_dbg_dump_tm_pri()
To:     Arnd Bergmann <arnd@kernel.org>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <20231204072932.1077878-1-arnd@kernel.org>
From:   Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20231204072932.1077878-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.120.192]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


on 2023/12/4 15:29, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
>
> @@ -981,7 +981,7 @@ static const struct hclge_dbg_item tm_pri_items[] = {
>   
>   static int hclge_dbg_dump_tm_pri(struct hclge_dev *hdev, char *buf, int len)
>   {
> -	char data_str[ARRAY_SIZE(tm_pri_items)][HCLGE_DBG_DATA_STR_LEN];
> +	char *data_str;
>   	struct hclge_tm_shaper_para c_shaper_para, p_shaper_para;
>   	char *result[ARRAY_SIZE(tm_pri_items)], *sch_mode_str;
>   	char content[HCLGE_DBG_TM_INFO_LEN];
> @@ -991,9 +991,13 @@ static int hclge_dbg_dump_tm_pri(struct hclge_dev *hdev, char *buf, int len)
>   	ret = hclge_tm_get_pri_num(hdev, &pri_num);
>   	if (ret)
>   		return ret;

Thanks,
  But it would be better if there is an empty line here.

> +	data_str = kcalloc(ARRAY_SIZE(tm_pri_items), HCLGE_DBG_DATA_STR_LEN,
> +			   GFP_KERNEL);
> +	if (!data_str)
> +		return -ENOMEM;
>   
>   	for (i = 0; i < ARRAY_SIZE(tm_pri_items); i++)
> -		result[i] = &data_str[i][0];
> +		result[i] = &data_str[i * HCLGE_DBG_DATA_STR_LEN];
>   
>   	hclge_dbg_fill_content(content, sizeof(content), tm_pri_items,
>   			       NULL, ARRAY_SIZE(tm_pri_items));
> @@ -1035,6 +1039,7 @@ static int hclge_dbg_dump_tm_pri(struct hclge_dev *hdev, char *buf, int len)
>   		pos += scnprintf(buf + pos, len - pos, "%s", content);
>   	}
>   

all exception condition also need to free memory before return. eg:
	for (i = 0; i < pri_num; i++) {
		ret = hclge_tm_get_pri_sch_mode(hdev, i, &sch_mode);
		if (ret)
			return ret;

		ret = hclge_tm_get_pri_weight(hdev, i, &weight);
		if (ret)
			return ret;

> +	kfree(data_str);
>   	return 0;
>   }
>   
