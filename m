Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5E87BD79E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346005AbjJIJuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346002AbjJIJug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:50:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5BE94;
        Mon,  9 Oct 2023 02:50:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83416C433C8;
        Mon,  9 Oct 2023 09:50:32 +0000 (UTC)
Message-ID: <bb2f3663-3ed2-49dd-a105-cc8468773165@xs4all.nl>
Date:   Mon, 9 Oct 2023 11:50:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the v4l-dvb-next tree
Content-Language: en-US, nl
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231009110852.36b0bd42@canb.auug.org.au>
 <3edb10ab-2c14-4750-962c-c0b874c34b88@linaro.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <3edb10ab-2c14-4750-962c-c0b874c34b88@linaro.org>
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

On 09/10/2023 11:25, Bryan O'Donoghue wrote:
> On 09/10/2023 01:08, Stephen Rothwell wrote:
>> Hi all,
>>
>> After merging the v4l-dvb-next tree, today's linux-next build (x86_64
>> allmodconfig) failed like this:
>>
>> drivers/media/platform/qcom/camss/camss.c: In function 'camss_probe':
>> drivers/media/platform/qcom/camss/camss.c:1634:17: error: label 'err_cleanup' used but not defined
>>   1634 |                 goto err_cleanup;
>>        |                 ^~~~
>>
>> Caused by commits
>>
>>    7405116519ad ("media: qcom: camss: Fix pm_domain_on sequence in probe")
>>    b278080a89f4 ("media: qcom: camss: Fix V4L2 async notifier error path")
>>
>> interacting with commit
>>
>>    2c1bae27df78 ("media: qcom: camss: Fix pm_domain_on sequence in probe")
>>
>> from the v4l-dvb tree.
>>
>> I have applied the following merge resolution patch for today.
>>
>> From: Stephen Rothwell <sfr@canb.auug.org.au>
>> Date: Mon, 9 Oct 2023 11:05:26 +1100
>> Subject: [PATCH] v4l-dvb-next: fix up for bad automatic merge.
>>
>> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>> ---
>>   drivers/media/platform/qcom/camss/camss.c | 6 ------
>>   1 file changed, 6 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
>> index 38d20b12cdd8..8e78dd8d5961 100644
>> --- a/drivers/media/platform/qcom/camss/camss.c
>> +++ b/drivers/media/platform/qcom/camss/camss.c
>> @@ -1628,12 +1628,6 @@ static int camss_probe(struct platform_device *pdev)
>>           return ret;
>>       }
>>   -    ret = camss_configure_pd(camss);
>> -    if (ret < 0) {
>> -        dev_err(dev, "Failed to configure power domains: %d\n", ret);
>> -        goto err_cleanup;
>> -    }
>> -
>>       ret = camss_init_subdevices(camss);
>>       if (ret < 0)
>>           goto err_genpd_cleanup;
> 
> commit: f69791c39745e ("media: qcom: camss: Fix genpd cleanup") already appears in linux-next/master @ next-20231009 which commit: 2c1bae27df78 ("media: qcom: camss: Fix pm_domain_on sequence in
> probe") depends on.
> 
> Already looks resolved.

There is a spurious patch committed in https://git.linuxtv.org/media_tree.git/log/

I'm not sure why it's there, but Mauro needs to drop that patch.

Regards,

	Hans
