Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C60B808895
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379175AbjLGMy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjLGMyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:54:54 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62837D6D;
        Thu,  7 Dec 2023 04:55:00 -0800 (PST)
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 508006607393;
        Thu,  7 Dec 2023 12:54:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701953699;
        bh=0avdqItorVWQlXzkKrdwMLjbDRMB/SdzTH77XcICv5Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dAOuFyzKah2MkArDPQMPp0s2dl3ePv5sfsOg8HxlVS+xyN4I/ZSAmpMb87G08U7tV
         pw0qJacO0PWsr7mjGKmzENh7sGWXvcfic7ZsR95HiA8TDTVmI1QNYUKcLcMRsyRjLA
         7nYIPkpZ9vxexf05n+vaM+/KgLP6qEYKzB754PZaKryAgWlh6U6I7sIzpQXvC/TNZh
         a27UH8E8WAmgzlErLkI2OpynEQ//kA8mtCVfzO4evIYO1Z2NG5ZGw8IbL/yBlL2S1R
         abjHwjmgmhTD4lQs5Ee3b0U1z9BhkZUeac7WHjylAgyYUjQM8FM+EgkQuigHoecBcH
         JtxkwoZsXLkbw==
Message-ID: <6046a40b-800c-4bf8-ab45-d7f1015b2d9c@collabora.com>
Date:   Thu, 7 Dec 2023 13:54:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] media: mediatek: vcodec: Fix mtk_vcodec_mem_free()
 error log criteria
Content-Language: en-US
To:     Fei Shao <fshao@chromium.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Tiffany Lin <tiffany.lin@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20231113123049.4117280-1-fshao@chromium.org>
 <20231113123049.4117280-4-fshao@chromium.org>
 <6c693161-0e89-4f9d-9a92-18f3783eefd2@collabora.com>
 <CAC=S1nhp3HoKGQr1UgKtZJ9SLMqvm-G_YZi9dEWWF3tj2d=OFQ@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAC=S1nhp3HoKGQr1UgKtZJ9SLMqvm-G_YZi9dEWWF3tj2d=OFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/12/23 12:17, Fei Shao ha scritto:
> Hi Angelo,
> 
> On Wed, Dec 6, 2023 at 6:19 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 13/11/23 13:26, Fei Shao ha scritto:
>>> mtk_vcodec_mem_free() shouldn't print error if the target DMA buffer has
>>> never been allocated or was freed properly in the previous call. That
>>> makes log confusing.
>>>
>>> Update the error path to print log only when the caller attempts to free
>>> nonzero-size buffer with VA being NULL, which indicates something indeed
>>> went wrong.
>>>
>>> This brings another benefit that the callers no more need to check
>>> mem->va explicitly to avoid the error, which can make the code more
>>> compact and neat.
>>>
>>> Signed-off-by: Fei Shao <fshao@chromium.org>
>>
>> I think that this error is supposed to catch two issues in one:
>>    - We're called to free no memory (something that does make no sense),
>>      this may happen for example when calling xxx_free() twice, and it
>>      is a mistake that *must* be fixed;
> When I made the change, I was thinking of kfree() that doesn't warn
> against a NULL pointer.
> I imagine mtk_vcodec_mem_free() calls with NULL VA and mem size 0
> probably have the similar nuance (if the buffer exists, free it; never
> mind otherwise), but I could have missed some important differences
> specific to the MTK vcodec driver.
> 
> Looking at the mtk_vcodec_mem_free() usages, almost every one of those
> checks VA beforehand, but nothing else - they don't warn or do
> anything special when they encounter a NULL VA, and they should if
> that's a concern.
> Some even don't check at all (and I think that's why I ended up seeing
> the errors mentioned in the cover letter). As for that, I think
> there's nothing else we can fix except prepending "if (mem->va)".
> So from all this, I feel perhaps we don't need to worry much about
> those NULL VA, and we can further remove the checks (or at least move
> it into mtk_vcodec_mem_free()) to trim the lines in the driver. That's
> the reason for patch [4/4].
> 
> Not sure if that makes sense to you.

What you say does make sense - and a lot - but still, I think that freeing
a NULL VA (= freeing nothing) is something that shouldn't happen...

> 
>>    - We're failing to free memory for real (which you covered)
>>
>> ....that said, I think that if you want to clarify the error messages
>> in this function, it should look something like this:
>>
>> if (!mem->va) {
>>          mtk_v4l2_err(plat_dev, "%s: Tried to free a NULL VA", __func__);
>>          if (mem->size)
>>                  mtk_v4l2_err(plat_dev, "Failed to free %lu bytes", mem->size);
>>          return;
>> }
> Sure, I can revise the patch with this, but I also want to make sure
> if the NULL VA print needs to be an error.
> If you still think it should, I guess I'll drop the current patch
> [4/4] and instead add the check before every mtk_vcodec_mem_free()
> calls. This should also work for the issue I want to address in the
> first place.
> 

... because if you notice, some of the calls to mtk_vcodec_mem_free() are not
checked with `if (something->va)` beforehand, so I think that those are cases
in which freeing with a NULL VA would actually be an indication of something
going wrong and/or not as expected anyway (checking beforehand = error won't
get printed from mtk_vcodec_mem_free(), not checking = print error if va==NULL)

It's an easy check:
cd drivers/media/platform/mediatek/vcodec
grep -rb1 mtk_vcodec_mem_free

P.S.: h264_if, av1_req_lat :-)

That's why I think that you should drop your [4/4] - unless MediaTek comes in
stating that the missed checks are something unintended, and that every instance
of VA==NULL should print an error.

I honestly wouldn't be surprised if they did so, because anyway this occurs only
in two decoders...

Regards,
Angelo
