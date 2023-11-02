Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2847DEEC7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 10:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345533AbjKBJZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 05:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjKBJZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 05:25:31 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADB3FB;
        Thu,  2 Nov 2023 02:25:27 -0700 (PDT)
Received: from dggpemm500011.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SLdKN3Nm8zvQ77;
        Thu,  2 Nov 2023 17:06:32 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggpemm500011.china.huawei.com
 (7.185.36.110) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 2 Nov
 2023 17:06:34 +0800
From:   Ren Mingshuai <renmingshuai@huawei.com>
To:     <kuba@kernel.org>
CC:     <caowangbao@huawei.com>, <davem@davemloft.net>,
        <khlebnikov@openvz.org>, <liaichun@huawei.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <oneukum@suse.com>, <renmingshuai@huawei.com>, <yanan@huawei.com>
Subject: Re: [PATCH] net: usbnet: Fix potential NULL pointer dereference
Date:   Thu, 2 Nov 2023 17:06:30 +0800
Message-ID: <20231102090630.938759-1-renmingshuai@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231101213832.77bd657b@kernel.org>
References: <20231101213832.77bd657b@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500011.china.huawei.com (7.185.36.110)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> >23ba07991dad said SKB can be NULL without describing the triggering 
>> >scenario. Always Check it before dereference to void potential NULL 
>> >pointer dereference.
>> I've tried to find out the scenarios where SKB is NULL, but failed.
>> It seems impossible for SKB to be NULL. If SKB can be NULL, please 
>> tell me the reason and I'd be very grateful.
>
>What do you mean? Grepping the function name shows call sites with NULL getting passed as skb.

Yes And I just learned that during the cdc_ncm_driver.probe, it is possible to pass a NULL SKB to usbnet_start_xmit().
