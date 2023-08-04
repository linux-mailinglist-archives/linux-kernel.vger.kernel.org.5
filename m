Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DD376F81D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 04:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjHDCyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 22:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjHDCyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 22:54:41 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBA8E3AA3;
        Thu,  3 Aug 2023 19:54:38 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8Dx6eptaMxkvQAQAA--.31557S3;
        Fri, 04 Aug 2023 10:54:37 +0800 (CST)
Received: from [10.20.42.201] (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxDc9saMxkZsdHAA--.54057S3;
        Fri, 04 Aug 2023 10:54:36 +0800 (CST)
Subject: Re: [PATCH v6 1/2] soc: dt-bindings: add loongson-2 pm
To:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        soc@kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, loongarch@lists.linux.dev,
        Liu Yun <liuyun@loongson.cn>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        zhuyinbo@loongson.cn
References: <20230803063703.5659-1-zhuyinbo@loongson.cn>
 <20230803063703.5659-2-zhuyinbo@loongson.cn>
 <193f9138-57e0-4d4b-8225-54d38be9bfbc@app.fastmail.com>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <8efeac46-ebb7-fa05-3d88-7c21acd59c8b@loongson.cn>
Date:   Fri, 4 Aug 2023 10:54:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <193f9138-57e0-4d4b-8225-54d38be9bfbc@app.fastmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxDc9saMxkZsdHAA--.54057S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2023/8/3 ÏÂÎç3:44, Arnd Bergmann Ð´µÀ:
> On Thu, Aug 3, 2023, at 08:37, Yinbo Zhu wrote:
> 
>> +  loongson,suspend-address:
>> +    $ref: /schemas/types.yaml#/definitions/uint64
>> +    description:
>> +      The "loongson,suspend-address" is a deep sleep state (Suspend To
>> +      RAM) firmware entry address which was jumped from kernel and it's
>> +      value was dependent on specific platform firmware code. In
>> +      addition, the PM need according to it to indicate that current
>> +      SoC whether support Suspend To RAM.
>> +
> 
> I just commented on this in the driver patch, assuming this
> was an MMIO address, but I'm even more confused now, since
> we try hard to not rely on being able to just interface with
> firmware like this.
> 
> If this is executable code, where does this actually reside?


Pmon firmware code.

> Is this some SRAM that needs to execute the suspend logic
> in order to shut down memory and cache controllers? 


Yes, The suspend-to-ram after into pmon firmware code and set
self-refresh mode in memory controller and ensure that memory data is
not lost then shut down memory controller.

> Or is
> this a runtime firmware interface similar to how UEFI handles
> its runtime services to keep the implementation out of
> the kernel?


No, The main cpu and other cpu will offline that after into firmware and
finished Corresponding operations, the pmon firmware will not run.

> 
> Does the code work with both traditional suspend-to-ram and
> modern suspend-to-idle logic?


Yes, It can support suspend-to-ram and suspend-to-idle.

Thanks,
Yinbo

