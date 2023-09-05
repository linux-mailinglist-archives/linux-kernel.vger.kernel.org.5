Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3CA792D81
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237343AbjIESle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240551AbjIESWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:22:19 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEE5BCA;
        Tue,  5 Sep 2023 11:21:47 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8Cx7+tgZPdkSMQfAA--.62735S3;
        Wed, 06 Sep 2023 01:24:48 +0800 (CST)
Received: from [0.0.0.0] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx5sxgZPdk7UltAA--.46048S3;
        Wed, 06 Sep 2023 01:24:48 +0800 (CST)
Message-ID: <40f32814-ca87-6e29-0e10-4b4463a2920d@loongson.cn>
Date:   Wed, 6 Sep 2023 01:24:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC,drm-misc-next v4 3/9] drm/radeon: Implement .be_primary()
 callback
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Sui Jingfeng <sui.jingfeng@linux.dev>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
References: <20230904195724.633404-1-sui.jingfeng@linux.dev>
 <20230904195724.633404-4-sui.jingfeng@linux.dev>
 <d3e6a9ce-1c7a-8e44-3127-413cd471a8e9@amd.com>
From:   suijingfeng <suijingfeng@loongson.cn>
In-Reply-To: <d3e6a9ce-1c7a-8e44-3127-413cd471a8e9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx5sxgZPdk7UltAA--.46048S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxGry3tr4UZrW7Zr1fCw13WrX_yoWruFW8pa
        ySqFW7ArykG3W0y347Aw4UuFyrX3yrJayUtrn5Jas5Zws8JrW0vryjvw4qgasrJrZ3Aw4Y
        va4ag3W7ZFyDA3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
        AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
        8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
        CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
        1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
        daVFxhVjvjDU0xZFpf9x07j0WlkUUUUU=
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 2023/9/5 13:50, Christian König wrote:
> Am 04.09.23 um 21:57 schrieb Sui Jingfeng:
>> From: Sui Jingfeng <suijingfeng@loongson.cn>
>>
>> On a machine with multiple GPUs, a Linux user has no control over 
>> which one
>> is primary at boot time.
>
> Question is why is that useful? Should we give users the ability to 
> control that?
>
> I don't see an use case for this.
>

On a specific machine with multiple GPUs mounted, only the
primary graphics get POST-ed (initialized) by the firmware.
Therefore the DRM drivers for the rest video cards have to
work without the prerequisite setups done by firmware, This
is called as POST.

One of the use cases is to test if a specific DRM driver
would works properly, under the circumstance of not being
POST-ed, The ast drm driver is the first one which refused
to work if not being POST-ed by the firmware.

Before apply this series, I was unable make drm/ast as the
primary video card easily. The problem is that on a multiple
video card configuration, the monitor connected with my
AST2400 card not light up. While confusing, a naive programmer
may suspect the PRIME is not working.

After applied this series and passing ast.modeset=10 on the
kernel cmd line, I found that the monitor connected with my
ast2400 video card still black, It doesn't display and It
doesn't show image to me.

While in the process of study drm/ast, I know that drm/ast
driver has the POST code shipped, See the ast_post_gpu() function.
Then, I was wondering why this function doesn't works.

After a short-time (hasty) debugging, I found that the ast_post_gpu()
function didn't get run. Because it have something to do with the
ast->config_mode. Without thinking too much, I hardcoded the
ast->config_mode as ast_use_p2a, the key point is to force the
ast_post_gpu() function to run.


```

--- a/drivers/gpu/drm/ast/ast_main.c
+++ b/drivers/gpu/drm/ast/ast_main.c
@@ -132,6 +132,8 @@ static int ast_device_config_init(struct ast_device 
*ast)
                 }
         }

+       ast->config_mode = ast_use_p2a;
+
         switch (ast->config_mode) {
         case ast_use_defaults:
                 drm_info(dev, "Using default configuration\n");

```

Then, the monitor light up, it display the Ubuntu greeter to me. Therefore
my patch is useful, at least for the Linux drm driver tester and developer.
It allow programmers to test the specific part of a specific driver without
changing a line of the source code and without the need of sudo authority.

It improves the efficiency of the testing and patch verification. I know
the PrimaryGPU option of Xorg conf, but this approach will remember the
setup have been made, you need modify it with root authority each time
you want to switch the primary. But on the process of rapid developing
and/or testing for multiple video drivers, with only one computer hardware
resource available. What we really want is a one-shot command, as provided
by this series.  So, this is the first use case.


The second use case is that sometime the firmware is not reliable.
While there are thousands of ARM64, PowerPC and Mips servers machine,
Most of them don't have a good UEFI firmware support. I haven't test the
drm/amdgpu and drm/radeon at my ARM64 server yet. Because this ARM64
server always use the platform(BMC) integrated display controller as primary.
The UEFI firmware of it does not provide options menu to tune.
So, for the first time, the discrete card because useless, despite more powerful.
I will take time to carry on the testing, so I will be able to tell more
in the future.


Even on X86, when select the PEG as primary on the UEFI BIOS menu.
There is no way to tell the bios which one of my three
discrete video be the primary. Not to mention some old UEFI
firmware, which doesn't provide a setting at all.
While the benefit of my approach is the flexibility.
Yes the i915, amdgpu and radeon are good quality,
but there may have programmers want to try nouveau.


The third use case is that VGAARB is also not reliable, It will
select a wrong device as primary. Especially on Arm64, Loongarch
and mips arch etc. And the X server will use this wrong device
as primary and completely crash there. Either because of lacking
a driver or the driver has a bug which can not bear the graphic
environment up. VGAARB is firmware dependent.
My patch provide a temporary method to rescue.


The forth is probably the PRIME and reverse PRIME development
and developing driver for new video cards.

