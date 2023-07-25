Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3294760EFC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjGYJ1y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Jul 2023 05:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbjGYJ1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:27:17 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BB33A90;
        Tue, 25 Jul 2023 02:26:01 -0700 (PDT)
Received: from dggpeml500018.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R9BSn5RnZz1GDP1;
        Tue, 25 Jul 2023 17:24:57 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 17:25:49 +0800
Received: from dggpeml500019.china.huawei.com ([7.185.36.137]) by
 dggpeml500019.china.huawei.com ([7.185.36.137]) with mapi id 15.01.2507.027;
 Tue, 25 Jul 2023 17:25:49 +0800
From:   michenyuan <michenyuan@huawei.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools: iio: iio_generic_buffer: Fix some integer type and
 calculation
Thread-Topic: [PATCH] tools: iio: iio_generic_buffer: Fix some integer type
 and calculation
Thread-Index: Adm+2ezSCoh0JLHoG0Ga7g1GW4oDiw==
Date:   Tue, 25 Jul 2023 09:25:48 +0000
Message-ID: <af6c573f378545a0b4b73260f2dc4331@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.184.199]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chenyuan Mi wrote: 
> Hi,
> 
> In principle I support hardening code, though in this case we are talking about example code only.  We have libiio and similar for anyone who wants to do more than basic tests.
> 
> > In function size_from_channelarray(), the return value 'bytes' is 
> > defined as int type. However, the calcution of 'bytes' in this 
> > function is designed to use the unsigned int type. So it is necessary 
> > to change 'bytes' type to unsigned int to avoid integer overflow.
> 
> For this one, in practice it's controlled entirely by the kernel drivers and they won't get anywhere near integer overflow.  The change is small however and doesn't hurt readability so I guess no harm applying it.
> 
> > 
> > The size_from_channelarray() is called in main() function, its return 
> > value is directly multipled by 'buf_len' and then used as the malloc() parameter.
> > The 'buf_len' is completely controllable by user, thus a 
> > multiplication overflow may occur here. This could allocate an unexpected small area.
> 
> That would have to be a very large allocation...  I suppose it is possible someone might try it...
> 
> > 
> > Signed-off-by: Chenyuan Mi <michenyuan@huawei.com>
> 
> My first inclination is not to apply this on basis that it adds slight complexity to example code (the aim of which is too illustrate the interface), however on the other side of things the checks don't add significant complexity...
> 
> So I tried to apply it, but it doesn't go on cleanly and patch is telling me it's malformed. I'm not quite sure why.
> 
> patching file tools/iio/iio_generic_buffer.c
> patch: **** malformed patch at line 68:                 ret = -ENOMEM;
> 
> Jonathan

I re-send a patch v2, and test patch v2 to make sure it can be applied. Thank you!
