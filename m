Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6152176E7D4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbjHCMHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbjHCMHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:07:00 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2723C3E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 05:06:41 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RGncs58njz4f47DG
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 20:06:21 +0800 (CST)
Received: from [10.174.176.83] (unknown [10.174.176.83])
        by APP1 (Coremail) with SMTP id cCh0CgCnAh09mMtk5HSqOg--.25574S2;
        Thu, 03 Aug 2023 20:06:22 +0800 (CST)
Message-ID: <d535f8ee-47b1-0e3e-d611-c26769f3764f@huaweicloud.com>
Date:   Thu, 3 Aug 2023 20:06:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mtd: fix use-after-free in mtd release
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>
References: <20230727145758.3880967-1-alexander.usyskin@intel.com>
 <ZMKJRNDoQV8p0DH4@smile.fi.intel.com> <20230727172013.7c85c05d@xps-13>
 <ZMKUJbl7kFOfgKGg@smile.fi.intel.com> <20230727183611.37d01f51@xps-13>
 <CY5PR11MB63660B9CE604C0CFF2E088DAED04A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <d9d56389-7409-79ae-6854-00ab8de7da4d@huawei.com>
 <20230802144426.2411bba2@xps-13>
From:   huaweicloud <zhangxiaoxu@huaweicloud.com>
In-Reply-To: <20230802144426.2411bba2@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgCnAh09mMtk5HSqOg--.25574S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUU5E7kC6x804xWl14x267AKxVW8JVW5JwAF
        c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7
        xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
        FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr
        0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxv
        r21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7jXdUUUUU
X-CM-SenderInfo: x2kd0wp0ld053x6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/2 20:44, Miquel Raynal 写道:
> Hi zhang,
> 
> zhangxiaoxu5@huawei.com wrote on Mon, 31 Jul 2023 09:35:42 +0800:
> 
>> 在 2023/7/30 19:10, Usyskin, Alexander 写道:
>>> Miquel, is this patch helps with your original problem of devices not freed?
>>>
>>> Zhang, is this patch helps with your problem with KAsan?
>> After this patch applied, the problem can still be reproduced.
> 
> Did you test my patch as well? Does Kasan still complain with it?
After this patch applied, the problem can still be reproduced.


> 
> Thanks,
> Miquèl

