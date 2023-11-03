Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7187DFE18
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 03:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbjKCCcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 22:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbjKCCcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 22:32:04 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41A9125
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 19:31:59 -0700 (PDT)
X-UUID: 2a7ddf9ad16b4c9eb7720d5cde1990ae-20231103
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:0b01e04e-72d4-4eac-9ac1-23a9e2c0b857,IP:10,
        URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:-5
X-CID-INFO: VERSION:1.1.32,REQID:0b01e04e-72d4-4eac-9ac1-23a9e2c0b857,IP:10,UR
        L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:5f78ec9,CLOUDID:a3e018fc-4a48-46e2-b946-12f04f20af8c,B
        ulkID:231102193258W1UEKU65,BulkQuantity:6,Recheck:0,SF:44|64|66|38|24|17|1
        9|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,
        COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: 2a7ddf9ad16b4c9eb7720d5cde1990ae-20231103
X-User: chentao@kylinos.cn
Received: from [172.21.13.26] [(116.128.244.171)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 219426355; Fri, 03 Nov 2023 10:31:51 +0800
Message-ID: <4ca799cb-25d1-4b2a-9555-08fd6d8eaf66@kylinos.cn>
Date:   Fri, 3 Nov 2023 10:31:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915: Fix potential spectre vulnerability
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@gmail.com, daniel@ffwll.ch,
        andi.shyti@linux.intel.com, robdclark@chromium.org,
        jonathan.cavitt@intel.com, andrzej.hajda@intel.com,
        chris.p.wilson@intel.com, alan.previn.teres.alexis@intel.com
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kunwu.chan@hotmail.com
References: <20231102101642.52988-1-chentao@kylinos.cn>
 <d300506c-ab82-4cc1-b750-61e54ec2ad9e@linux.intel.com>
From:   Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <d300506c-ab82-4cc1-b750-61e54ec2ad9e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tvrtko,
Thank you very much for your kind suggestion, I have modified it in 
accordance with your suggestion.

On 2023/11/2 19:32, Tvrtko Ursulin wrote:
> 
> On 02/11/2023 10:16, chentao wrote:
>> Fix smatch warning:
>> drivers/gpu/drm/i915/gem/i915_gem_context.c:847 set_proto_ctx_sseu()
>> warn: potential spectre issue 'pc->user_engines' [r] (local cap)
>>
>> Signed-off-by: chentao <chentao@kylinos.cn>
> 
> I don't know if this is actually exploitable given the time deltas 
> between the index is read from userspace and acted upon here, which is 
> at least two ioctls apart. But I suppose no harm in fixing and for 
> safety so we need to add:
> 
> Fixes: d4433c7600f7 ("drm/i915/gem: Use the proto-context to handle 
> create parameters (v5)")
> Cc: <stable@vger.kernel.org> # v5.15+
> 
>> ---
>>   drivers/gpu/drm/i915/gem/i915_gem_context.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c 
>> b/drivers/gpu/drm/i915/gem/i915_gem_context.c
>> index 9a9ff84c90d7..b2fdfc7ca4de 100644
>> --- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
>> @@ -843,7 +843,7 @@ static int set_proto_ctx_sseu(struct 
>> drm_i915_file_private *fpriv,
>>           if (idx >= pc->num_user_engines)
>>               return -EINVAL;
>> -
> 
> Just please refrain from random whitespace modifications like this blank 
> line removal. If you resend without that you can add my r-b.
> 
> Regards,
> 
> Tvrtko
> 
>> +        idx = array_index_nospec(idx, pc->num_user_engines);
>>           pe = &pc->user_engines[idx];
>>           /* Only render engine supports RPCS configuration. */
