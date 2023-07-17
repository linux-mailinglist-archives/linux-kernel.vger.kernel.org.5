Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35897559D2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 05:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjGQDEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 23:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjGQDEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 23:04:53 -0400
Received: from out0-209.mail.aliyun.com (out0-209.mail.aliyun.com [140.205.0.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEC9113;
        Sun, 16 Jul 2023 20:04:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047188;MF=changxian.cqs@antgroup.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---.TvN3iYk_1689563084;
Received: from 30.177.49.54(mailfrom:changxian.cqs@antgroup.com fp:SMTPD_---.TvN3iYk_1689563084)
          by smtp.aliyun-inc.com;
          Mon, 17 Jul 2023 11:04:45 +0800
Message-ID: <5a8325ec-2c56-b7c2-6808-f47882463563@antgroup.com>
Date:   Mon, 17 Jul 2023 11:04:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 1/8] rust: kernel: add basic abstractions for
 device-mapper
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     <linux-kernel@vger.kernel.org>,
        "=?UTF-8?B?55Sw5rSq5Lqu?=" <tate.thl@antgroup.com>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        "=?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>,
        "Martin Rodriguez Reboredo" <yakoyoku@gmail.com>,
        "Alice Ryhl" <aliceryhl@google.com>,
        "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>,
        "Asahi Lina" <lina@asahilina.net>, <rust-for-linux@vger.kernel.org>
References: <20230625121657.3631109-1-changxian.cqs@antgroup.com>
 <20230625121657.3631109-2-changxian.cqs@antgroup.com>
 <WCPFASroITvSjkBsoj04wbZMd7zWj-DiUVMJWWSLM3Lfx8oDWVtV4-EvQ_O9LeLwVzHG1rr_RrkYB2_oFc2suCcZpzJSztNfyha-If6d8z4=@proton.me>
From:   "Qingsong Chen" <changxian.cqs@antgroup.com>
In-Reply-To: <WCPFASroITvSjkBsoj04wbZMd7zWj-DiUVMJWWSLM3Lfx8oDWVtV4-EvQ_O9LeLwVzHG1rr_RrkYB2_oFc2suCcZpzJSztNfyha-If6d8z4=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/23 11:48 PM, Benno Lossin wrote:
>> - Declare `vtable` for basic target operations.
>> - Wrap `target_type` to register/unregister target.
>> - Wrap `dm_target`/`dm_dev` to handle io request.
>> - Add a dummy `bio` wrapper.
>>
>> Signed-off-by: Qingsong Chen <changxian.cqs@antgroup.com>
> 
> On my system this patch series (I did not test which patch exactly) does
> not compile.
> 
> I have left some comments below, they show some patterns present in
> the other patches as well.

Thanks for the comments. Maybe `CONFIG_BLK_DEV_ZONED=y` is needed to
compile this patchset. This is because I cannot define two functions
with the same name in a trait (using the `vtable` macro), just like
the C definition:
```c
#ifdef CONFIG_BLK_DEV_ZONED
typedef int (*dm_report_zones_fn) (struct dm_target *ti,
                                     struct dm_report_zones_args *args,
                                     unsigned int nr_zones);
#else
typedef int (*dm_report_zones_fn) (struct dm_target *dummy);
#endif
```
To fix the `vtable`, I send a little patch[1] the other day. Based on
that, the compile error of this patchset should be fixed too.

[1]:
https://lore.kernel.org/rust-for-linux/20230626074242.3945398-1-changxian.cqs@antgroup.com/

>> +/// The return values of target map function, i.e., [`TargetOperations::map`].
>> +#[repr(u32)]
>> +pub enum MapState {
>> +    /// The target will handle the io by resubmitting it later.
>> +    Submitted = bindings::DM_MAPIO_SUBMITTED,
>> +
>> +    /// Simple remap complete.
>> +    Remapped = bindings::DM_MAPIO_REMAPPED,
>> +
>> +    /// The target wants to requeue the io.
>> +    Requeue = bindings::DM_MAPIO_REQUEUE,
>> +
>> +    /// The target wants to requeue the io after a delay.
>> +    DelayRequeue = bindings::DM_MAPIO_DELAY_REQUEUE,
>> +
>> +    /// The target wants to complete the io.
>> +    Kill = bindings::DM_MAPIO_KILL,
>> +}
> 
> Is it really necessary to have these correspond to the exact values?
> Could we also just have a conversion function and leave the repr to
> the compiler?

Sure, we can have a conversion function to return its value to C side
(without `as _`).

Regards,
Qingsong
