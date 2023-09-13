Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B6F79E8D1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240921AbjIMNMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240962AbjIMNLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:11:54 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF6326AA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 06:11:39 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rm11t0dbbz6D99p;
        Wed, 13 Sep 2023 21:06:58 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 13 Sep
 2023 14:11:37 +0100
Date:   Wed, 13 Sep 2023 14:11:36 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jinhui Guo <guojinhui.liam@bytedance.com>,
        <linux-kernel@vger.kernel.org>
CC:     <catalin.marinas@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <lizefan.x@bytedance.com>, <robin.murphy@arm.com>,
        <will@kernel.org>
Subject: Re: [PATCH] arm64: cpufeature: Expose the real mpidr value to EL0
Message-ID: <20230913141136.00006a47@Huawei.com>
In-Reply-To: <20230913105133.2902-1-guojinhui.liam@bytedance.com>
References: <20230912115116.000049b0@Huawei.com>
        <20230913105133.2902-1-guojinhui.liam@bytedance.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2023 18:51:33 +0800
Jinhui Guo <guojinhui.liam@bytedance.com> wrote:

> > As a follow up question, is there some information that is missing from
> > current topology description?  (there is lots missing but I'm curious
> > as to what might matter for your use case!)  
> 
> We want to know the infomation about dies to advoid memroy accessing
> across dies (some settings like 2 numa per die).

The NUMA access characteristics should give you the info you want - it's
the variation in latency and bandwidth between dies that matters, not that
they are dies.  If you got really bad access characteristics across a die
that info would be equally useful.

I think it is not that this is a die that matters, but rather that there
are groups of Numa nodes with relatively small differences in access
characteristics, then others with much larger variation (and I assume
a layer above that which is inter socket which is even worse).

The info is in HMAT, but the kernel presentation of HMAT is rather limited
currently - so you may want to look at extending what is visible in sysfs
from that table.

Thanks,

Jonathan

> 
> thanks,
> 
> Jinhui Guo
> 

