Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06472759326
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjGSKgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjGSKgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:36:16 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8096BE0;
        Wed, 19 Jul 2023 03:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1689762558; bh=zzi5kjyS7aIx9/ym7iyyPL9XVFwQcOnol4QUS4SlqUw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=foB3/ueojPefseN2KuCfAWKwfBnt5yovt63TIp91f1fXhyps1dSO8lCmWRJNE7UAB
         DkrBPZ62wGj0rusHYsgFtuq+lKLCna8xhWUMSsYxnU/lmsWxZINix9tXWFJ+g4pc5M
         Z7Gz4wwrO0+65Fi61ht2j2QuN81cdb+UMlwUTckM=
Received: from [100.100.34.13] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 3D4D46006F;
        Wed, 19 Jul 2023 18:29:18 +0800 (CST)
Message-ID: <f9e7fb54-a76e-a9b0-1b9c-8c9251f4af20@xen0n.name>
Date:   Wed, 19 Jul 2023 18:29:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v5] LoongArch: Fix CONFIG_CMDLINE_EXTEND and
 CONFIG_CMDLINE_BOOTLOADER handling
Content-Language: en-US
To:     Huacai Chen <chenhuacai@kernel.org>,
        Markus Elfring <Markus.Elfring@web.de>
Cc:     Zhihong Dong <donmor3000@hotmail.com>, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, Guo Ren <guoren@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Xuefeng Li <lixuefeng@loongson.cn>
References: <20230718153348.3340811-1-chenhuacai@loongson.cn>
 <261edc6c-e339-faeb-3045-bfe6604d1aef@web.de>
 <CAAhV-H5nNMmYZQXvoog85cgMUd+gM2QMaG3cUhYk_iGzjB=B4Q@mail.gmail.com>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAAhV-H5nNMmYZQXvoog85cgMUd+gM2QMaG3cUhYk_iGzjB=B4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/19 15:22, Huacai Chen wrote:
> Hi, Markus,
> 
> On Wed, Jul 19, 2023 at 2:51 PM Markus Elfring <Markus.Elfring@web.de> wrote:
>>
>>>                                                    …, so this patch add
>>> some code to fix it.
>>
>> Would you like to avoid a typo here?
>>
>> Will any other imperative change description variant become more helpful?
> Thank you for pointing this out, but since Zhihong is the original
> author, I don't want to completely rewrite the commit message, so just
> fix the typo...

AFAICT the commit message is totally uninformative even if "an 
imperative change description" were used. It basically:

1. repeated the patch title,
2. spent one sentence only for mentioning a function name without giving 
any more information,
3. mentioned why some change was not necessary due to some other 
existing code, but not explicitly calling that part out, then
4. finished with a sentence that boiled down to "we should do the 
similar thing".

My take:

 > Subject: Fix CMDLINE_EXTEND and CMDLINE_BOOTLOADER on non-FDT systems
 >
 > On FDT systems these command line processing are already taken care of
 > by early_init_dt_scan_chosen(). Add similar handling to the non-FDT
 > code path to allow these config options to work for non-FDT boxes too.

Would this sound better?

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

