Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0DA7DF264
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347436AbjKBM3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347435AbjKBM3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:29:39 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE0C1A2;
        Thu,  2 Nov 2023 05:29:32 -0700 (PDT)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SLjqV0GwhzVlhD;
        Thu,  2 Nov 2023 20:29:26 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 2 Nov 2023 20:29:28 +0800
Message-ID: <67db0780-59b6-48d2-8d1b-9492c13380e3@huawei.com>
Date:   Thu, 2 Nov 2023 20:29:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     <shaojijie@huawei.com>, <shenjian15@huawei.com>,
        <wangjie125@huawei.com>, <liuyonglong@huawei.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 1/7] net: hns3: fix add VLAN fail issue
To:     Paolo Abeni <pabeni@redhat.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>
References: <20231028025917.314305-1-shaojijie@huawei.com>
 <20231028025917.314305-2-shaojijie@huawei.com>
 <6603e0480feea2e7a28a865705da52bb99679a35.camel@redhat.com>
From:   Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <6603e0480feea2e7a28a865705da52bb99679a35.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.120.192]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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


on 2023/11/2 18:31, Paolo Abeni wrote:
> On Sat, 2023-10-28 at 10:59 +0800, Jijie Shao wrote:
>
>   	/* when port base vlan enabled, we use port base vlan as the vlan
>   	 * filter entry. In this case, we don't update vlan filter table
> @@ -10481,7 +10482,9 @@ int hclge_set_vlan_filter(struct hnae3_handle *handle, __be16 proto,
>   		 * and try to remove it from hw later, to be consistence
>   		 * with stack
>   		 */
> +		mutex_lock(&hdev->vport_lock);
>   		set_bit(vlan_id, vport->vlan_del_fail_bmap);
> +		mutex_unlock(&hdev->vport_lock);
> It looks like that the 'hclge_rm_vport_vlan_table()' call a few lines
> above will now happen with the vport_lock unlocked.
>
> That looks racy and would deserve at least a comment explaining why
> it's safe.
>
> Thanks,
>
> Paolo

Yeah, this is a problem that causes the function to be invoked when it 
is not locked. We'll get lock before the function be invoked in V2 
Thanks, Jijie

