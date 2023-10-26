Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C517D7EC3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344603AbjJZIqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZIqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:46:42 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0CCBC10E;
        Thu, 26 Oct 2023 01:46:39 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id AF3DB60863911;
        Thu, 26 Oct 2023 16:46:30 +0800 (CST)
Message-ID: <54d21280-6e1e-780c-372d-d630630a4fe9@nfschina.com>
Date:   Thu, 26 Oct 2023 16:46:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] vga_switcheroo: Fix impossible judgment condition
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     lukas@wunner.de, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, tiwai@suse.de, Jim.Qu@amd.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <4ec2b80b-f042-4abf-b799-0a9ef364f0fa@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/26 12:44, Dan Carpenter wrote:
> On Thu, Oct 26, 2023 at 10:10:57AM +0800, Su Hui wrote:
>> 'id' is enum type like unsigned int, so it will never be less than zero.
>>
>> Fixes: 4aaf448fa975 ("vga_switcheroo: set audio client id according to bound GPU id")
>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>>   drivers/gpu/vga/vga_switcheroo.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
>> index 365e6ddbe90f..d3064466fd3a 100644
>> --- a/drivers/gpu/vga/vga_switcheroo.c
>> +++ b/drivers/gpu/vga/vga_switcheroo.c
>> @@ -375,7 +375,7 @@ int vga_switcheroo_register_audio_client(struct pci_dev *pdev,
>>   	mutex_lock(&vgasr_mutex);
>>   	if (vgasr_priv.active) {
>>   		id = vgasr_priv.handler->get_client_id(vga_dev);
>> -		if (id < 0) {
>> +		if ((int)id < 0) {
> Hi,
>
> I feel like you're using Smatch?  Which is great!  Fantastic!
Yep, Smatch helps me  a lot to find these bugs! I really like this 
excellent tool!
>
> Have you built the cross function database?  If you have there is a
> command that's useful.
Not yet, bu I want to build this.
> $ ~/smatch/smatch_db/smdb.py functions vga_switcheroo_handler get_client_id | tee where
> drivers/gpu/drm/nouveau/nouveau_acpi.c | (struct vga_switcheroo_handler)->get_client_id | nouveau_dsm_get_client_id | 1
> drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | (struct vga_switcheroo_handler)->get_client_id | amdgpu_atpx_get_client_id | 1
> drivers/gpu/drm/radeon/radeon_atpx_handler.c | (struct vga_switcheroo_handler)->get_client_id | radeon_atpx_get_client_id | 1
> drivers/platform/x86/apple-gmux.c | (struct vga_switcheroo_handler)->get_client_id | gmux_get_client_id | 1
> $ make cscope
> $ vim where
> Use cscope to jump to each of those four functions.  Move the cursor to
> the nouveau_dsm_get_client_id and hit CTRL-].
Sounds great! I must try this!
>
> They never return negatives.  The enum vga_switcheroo_client_id has a
> VGA_SWITCHEROO_UNKNOWN_ID define which I guess these functions are
> supposed to return on error.  They never do return that, but I bet
> that's what we are supposed to check for.  It honestly might be good
> to check for both...
>
> 		if ((int)id < 0 || id == VGA_SWITCHEROO_UNKNOWN_ID) {
> 			mutex_unlock(&vgasr_mutex);
> 			return -EINVAL;
> 		}
Agreed, I will send v2 patch soon.
Really thanks for your wonderful suggestion! :)

Su Hui

> regards,
> dan carpenter
>
