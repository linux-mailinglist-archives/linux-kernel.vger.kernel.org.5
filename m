Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33B279B9AE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjIKUrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbjIKJK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:10:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1217ACCD;
        Mon, 11 Sep 2023 02:10:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B6DC433C8;
        Mon, 11 Sep 2023 09:10:48 +0000 (UTC)
Message-ID: <be6b41e0-c610-49c3-ae6c-e811b56aca30@xs4all.nl>
Date:   Mon, 11 Sep 2023 11:10:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/17] media: qcom: camss: Move vfe_disable into a
 common routine where applicable
Content-Language: en-US, nl
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org, laurent.pinchart@ideasonboard.com,
        sakari.ailus@linux.intel.com, andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230907164410.36651-1-bryan.odonoghue@linaro.org>
 <20230907164410.36651-16-bryan.odonoghue@linaro.org>
 <8b424303-09c9-4270-abfd-4f209f5c41e0@linaro.org>
 <41d1e364-40a4-48b2-97ef-6c76d238002e@linaro.org>
 <c9570c8e-c9a5-43f5-8b69-d5c38d214061@linaro.org>
 <c5d64d12-668a-4d70-85ee-e4111d85a1be@linaro.org>
 <e1ab1df4-8431-483d-8f20-74de5349cfbc@linaro.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <e1ab1df4-8431-483d-8f20-74de5349cfbc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2023 12:36, Bryan O'Donoghue wrote:
> On 08/09/2023 11:24, Konrad Dybcio wrote:
>> On 8.09.2023 12:21, Bryan O'Donoghue wrote:
>>> On 08/09/2023 11:04, Konrad Dybcio wrote:
>>>> On 8.09.2023 12:02, Konrad Dybcio wrote:
>>>>> On 7.09.2023 18:44, Bryan O'Donoghue wrote:
>>>>>> We can move vfe_disable() into a common routine in the core VFE file
>>>>>> provided we make wm_stop() a VFE specific callback.
>>>>>>
>>>>>> The callback is required to capture the case where VFE 17x currently isn't
>>>>>> VC enabled where as VFE 480 is.
>>>>>>
>>>>>> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>>>>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>>>>> ---
>>>>> Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>>
>>>>> Konrad
>>>> Actually there's
>>>>
>>>> ret = vfe_reset(vfe);
>>>>
>>>> return ret;
>>>>
>>>>
>>>> which could just be
>>>>
>>>> return vfe_reset(vfe);
>>>>
>>>>
>>>> Konrad
>>>
>>> On purpose.
>>>
>>> I prefer the ret = ; return ret; pattern since it makes it easier / less work to
>>>
>>> ret = fn();
>>> if (ret)
>>>      goto error;
>>>
>>> error:
>>>      return ret;
>> There's no error label in vfe_disable_output
>>
>> Konrad
> 
> No there is not. Its a pattern I use to make adding jump labels easier later on.

This adds a bunch of extra lines just in case something might happen in the
future. That is generally a bad idea, so please change this. As you can see
it just causes reviewers to trip over this with exactly the question you got
here.

> 
> Just like you use the pattern of appending "," to aggregate initialisation.

Adding a comma at the end doesn't add extra lines. To be honest, I don't
have a strong opinion on this either way. Personally I would probably use a
comma if it is likely that the list would be extended in the future, and
leave it out if I am pretty certain that won't happen. In any case, I don't
mind either way.

Regards,

	Hans

> 
> ---
> bod

