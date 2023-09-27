Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9A77AF84D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 04:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbjI0CuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 22:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjI0CsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 22:48:09 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D0F5FD1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 19:15:56 -0700 (PDT)
X-UUID: 999c3971b0eb4d75a43b87d6a16689f0-20230927
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:1416603b-0ac3-4db7-bb60-931020906e72,IP:5,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-10
X-CID-INFO: VERSION:1.1.31,REQID:1416603b-0ac3-4db7-bb60-931020906e72,IP:5,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:-10
X-CID-META: VersionHash:0ad78a4,CLOUDID:112450bf-14cc-44ca-b657-2d2783296e72,B
        ulkID:23092621101442OWP2A1,BulkQuantity:3,Recheck:0,SF:24|17|19|44|64|38|8
        17|102,TC:nil,Content:0|-5,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:
        nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 999c3971b0eb4d75a43b87d6a16689f0-20230927
X-User: liucong2@kylinos.cn
Received: from [172.20.119.219] [(116.128.244.169)] by mailgw
        (envelope-from <liucong2@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES128-GCM-SHA256 128/128)
        with ESMTP id 817738456; Wed, 27 Sep 2023 10:15:42 +0800
Message-ID: <3b71215d-3ad5-e8c8-20eb-a48610403359@kylinos.cn>
Date:   Wed, 27 Sep 2023 10:15:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From:   Cong Liu <liucong2@kylinos.cn>
Subject: Re: [PATCH 2/2] drm/amd/display: Fix null pointer dereference in
 error message
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Tom Chung <chiahsuan.chung@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230926055618.119195-1-liucong2@kylinos.cn>
 <a71a61fb-2330-4fba-85a7-9ba2a3642dc7@amd.com>
Content-Language: en-US
In-Reply-To: <a71a61fb-2330-4fba-85a7-9ba2a3642dc7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> 
> On 2023-09-26 01:56, Cong Liu wrote:
>> This patch fixes a null pointer dereference in the error message that is
>> printed when the Display Core (DC) fails to initialize. The original
>> message includes the DC version number, which is undefined if the DC is
>> not initialized.
>>
>> Fixes: 9788d087caff ("drm/amd/display: improve the message printed when loading DC")
>> Signed-off-by: Cong Liu <liucong2@kylinos.cn>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 8e98dda1e084..bf52a909f558 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -1703,8 +1703,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>>   		DRM_INFO("Display Core v%s initialized on %s\n", DC_VER,
>>   			 dce_version_to_string(adev->dm.dc->ctx->dce_version));
>>   	} else {
>> -		DRM_INFO("Display Core v%s failed to initialize on %s\n", DC_VER,
>> -			 dce_version_to_string(adev->dm.dc->ctx->dce_version));
>> +		DRM_INFO("Display Core failed to initialize with v%s!\n", DC_VER);
> 
> There is value in printing the version number. Let's not remove it.
> 
> Instead you can probably fix it by doing a NULL check on adev->dm.dc->ctx.

Hi Harry

I don't understand what you mean. Are you saying that I need to add a 
NULL check in the if statement (i.e. if(adev->dm.dc && 
adev->dm.dc->ctx)), because adev->dm.dc is NULL in the else statement 
and there is no way to print adev->dm.dc->ctx->dce_version.

Regards
Cong

> 
> Harry
> 
>>   		goto error;
>>   	}
>>   
> 
