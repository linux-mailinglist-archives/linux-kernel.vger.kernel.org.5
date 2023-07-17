Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDA6755A29
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 05:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjGQDmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 23:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGQDmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 23:42:43 -0400
Received: from out0-216.mail.aliyun.com (out0-216.mail.aliyun.com [140.205.0.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428C5134;
        Sun, 16 Jul 2023 20:42:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047190;MF=changxian.cqs@antgroup.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---.TvN3zt8_1689565354;
Received: from 30.177.49.54(mailfrom:changxian.cqs@antgroup.com fp:SMTPD_---.TvN3zt8_1689565354)
          by smtp.aliyun-inc.com;
          Mon, 17 Jul 2023 11:42:35 +0800
Message-ID: <081f7e9b-a769-b4cf-4df4-b0bb5c9a1594@antgroup.com>
Date:   Mon, 17 Jul 2023 11:42:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 2/8] rust: kernel: add `request` related
 TargetOperations
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     <linux-kernel@vger.kernel.org>,
        "=?UTF-8?B?55Sw5rSq5Lqu?=" <tate.thl@antgroup.com>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        "=?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>,
        <rust-for-linux@vger.kernel.org>
References: <20230625121657.3631109-1-changxian.cqs@antgroup.com>
 <20230625121657.3631109-3-changxian.cqs@antgroup.com>
 <-IRG_a-qIx3Io5P-2p2t7mTbhsaV-Jizcvu0frlx6Pfj5mrnYL92vL5ZGfhY5lXdfAP-g3B02SpBAKWgPwpfxVpWBjMMWmTnhF9DLdU9808=@proton.me>
From:   "Qingsong Chen" <changxian.cqs@antgroup.com>
In-Reply-To: <-IRG_a-qIx3Io5P-2p2t7mTbhsaV-Jizcvu0frlx6Pfj5mrnYL92vL5ZGfhY5lXdfAP-g3B02SpBAKWgPwpfxVpWBjMMWmTnhF9DLdU9808=@proton.me>
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

On 7/14/23 11:49 PM, Benno Lossin wrote:
>> @@ -31,6 +31,39 @@ pub trait TargetOperations: Sized {
>>      /// Map block IOs. Return [`MapState`] to indicate how to handle the `bio`
>>      /// later (end or resubmit).
>>      fn map(t: &mut Target<Self>, bio: Pin<&mut Bio>) -> MapState;
>> +
>> +    /// Map `request`. Return [`MapState`] and the optional cloned `request`.
>> +    #[allow(unused)]
>> +    fn clone_and_map_rq<'a>(
>> +        t: &mut Target<Self>,
>> +        rq: Pin<&mut Request>,
>> +        map_ctx: &mut MapInfo,
>> +    ) -> (MapState, Option<Pin<&'a mut Request>>) {
>> +        unimplemented!()
> 
> Note that these should be implemented when you submit this as an actual
> patch. (Not sure what you would do in this case, but throwing a panic is
> not a good idea.) This also applies to all subsequent patches.
> I think you might have done this, because you want the C side to choose
> the default implementation. But it should also be possible to call these
> from the Rust side.

In fact, we don't want users to call these callbacks manually. The 
normal call-chain would be like this: `map_request`(c) ->
`dm_clone_and_map_rq_fn`(unsafe rust) -> `clone_and_map_rq`(rust).
If users don't implement `clone_and_map_rq`, we would check the
corresponding field of `TargetType`, using the `check_target_operations`
macro. So it won't call the default implementation generally.

Regards,
Qingsong
