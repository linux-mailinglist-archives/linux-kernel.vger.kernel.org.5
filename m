Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A216782408
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 08:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbjHUGwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 02:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjHUGwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 02:52:41 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id C187EAD;
        Sun, 20 Aug 2023 23:52:38 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id E04366061F6CA;
        Mon, 21 Aug 2023 14:52:34 +0800 (CST)
Message-ID: <e07b89c3-4a1b-67e6-c434-7c8aef62d68e@nfschina.com>
Date:   Mon, 21 Aug 2023 14:52:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/amdgpu: Avoid possible buffer overflow
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     Hawking.Zhang@amd.com, le.ma@amd.com, lijo.lazar@amd.com,
        yifan1.zhang@amd.com, candice.li@amd.com, Yuliang.Shi@amd.com,
        guchun.chen@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <7ac675b6-a000-6ad7-36f3-a3ce186414b6@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/21 14:47, Christophe JAILLET wrote:
> Le 21/08/2023 à 08:19, Su Hui a écrit :
>> smatch error:
>> drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1257 
>> amdgpu_discovery_reg_base_init() error:
>> testing array offset 'adev->vcn.num_vcn_inst' after use.
>>
>> change the assignment order to avoid buffer overflow.
>>
>> Fixes: c40bdfb2ffa4 ("drm/amdgpu: fix incorrect VCN revision in SRIOV")
>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> index 8e1cfc87122d..ba95526c3d45 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> @@ -1250,11 +1250,12 @@ static int 
>> amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>>                    *     0b10 : encode is disabled
>>                    *     0b01 : decode is disabled
>>                    */
>> - adev->vcn.vcn_config[adev->vcn.num_vcn_inst] =
>> -                    ip->revision & 0xc0;
>> +
>>                   ip->revision &= ~0xc0;
>>                   if (adev->vcn.num_vcn_inst <
>>                       AMDGPU_MAX_VCN_INSTANCES) {
>> + adev->vcn.vcn_config[adev->vcn.num_vcn_inst] =
>> +                        ip->revision & 0xc0;
>
> Hi,
> I don't think that the patch is correct.
>
> Because of the "ip->revision &= ~0xc0" which is now above it, 
> "ip->revision & 0xc0" should now always be 0.
>
> Maybe both lines should be moved within the "if"?
>
> CJ

Hi,

Oh, really sorry for this, I just missed this line.
you are right, I will send v2 soon.
Thanks for your reminder!

Su Hui

>
>
>
>
>
>> adev->vcn.num_vcn_inst++;
>>                       adev->vcn.inst_mask |=
>>                           (1U << ip->instance_number);
>
