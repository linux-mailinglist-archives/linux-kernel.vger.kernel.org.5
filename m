Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F304803782
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbjLDOux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjLDOuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:50:51 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAC5D3;
        Mon,  4 Dec 2023 06:50:58 -0800 (PST)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SkRLz181JzShMs;
        Mon,  4 Dec 2023 22:46:35 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 22:50:55 +0800
Message-ID: <7df7cfcb-d39b-4643-a378-a18b8d2b5b35@huawei.com>
Date:   Mon, 4 Dec 2023 22:50:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     <shaojijie@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
        Hao Chen <chenhao418@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [v2] net: hns3: reduce stack usage in
 hclge_dbg_dump_tm_pri()
To:     Arnd Bergmann <arnd@kernel.org>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <20231204085735.4112882-1-arnd@kernel.org>
From:   Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20231204085735.4112882-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.120.192]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


on 2023/12/4 16:57, Arnd Bergmann wrote:
> s already allocated by debugfs,
> but that is a much larger change.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: fix error handling leak
> ---
>   .../hisilicon/hns3/hns3pf/hclge_debugfs.c     | 21 ++++++++++++-------
>   1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
> index ff3f8f424ad9..8f94e13c1edf 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
> @@ -981,7 +981,7 @@ static const struct hclge_dbg_item tm_pri_items[] = {
>   
>   static int hclge_dbg_dump_tm_pri(struct hclge_dev *hdev, char *buf, int len)
>   {
> -	char data_str[ARRAY_SIZE(tm_pri_items)][HCLGE_DBG_DATA_STR_LEN];
> +	char *data_str;

We want to define variables in an inverted triangle based on the code length.
so, "char *data_str" should move four lines down.

   	struct hclge_tm_shaper_para c_shaper_para, p_shaper_para;
	char *result[ARRAY_SIZE(tm_pri_items)], *sch_mode_str;
	char content[HCLGE_DBG_TM_INFO_LEN];
	u8 pri_num, sch_mode, weight, i, j;
	char *data_str;
	int pos, ret;

>   	struct hclge_tm_shaper_para c_shaper_para, p_shaper_para;
>   	char *result[ARRAY_SIZE(tm_pri_items)], *sch_mode_str;
>   	char content[HCLGE_DBG_TM_INFO_LEN];
> @@ -992,8 +992,13 @@ static int hclge_dbg_dump_tm_pri(struct hclge_dev *hdev, char *buf, int len)
>   	if (ret)
>   		return ret;
>
