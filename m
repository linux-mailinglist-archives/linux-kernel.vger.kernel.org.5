Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D7178243F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjHUHQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbjHUHQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:16:28 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id CEA5DA8;
        Mon, 21 Aug 2023 00:16:24 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id D8355606212E9;
        Mon, 21 Aug 2023 15:16:21 +0800 (CST)
Message-ID: <07ffd0f9-853c-8aca-d2b6-8f643f83c940@nfschina.com>
Date:   Mon, 21 Aug 2023 15:16:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/ast: Avoid possible NULL dereference
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        airlied@redhat.com, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch
Cc:     eich@suse.de, tiwai@suse.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <38503377-ec27-09dd-dc6b-836a9ac0a5df@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/21 15:04, Christophe JAILLET wrote:
> Le 21/08/2023 à 08:22, Su Hui a écrit :
>> smatch error:
>> drivers/gpu/drm/ast/ast_dp501.c:227 ast_launch_m68k() error:
>> we previously assumed 'ast->dp501_fw' could be null (see line 223)
>>
>> when "!ast->dp501_fw" and "ast_load_dp501_microcode(dev) >= 0" is true,
>> there will be a NULL dereference of 'ast->dp501_fw'.
>>
>> Fixes: 12f8030e05c6 ("drm/ast: Actually load DP501 firmware when 
>> required")
>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>>   drivers/gpu/drm/ast/ast_dp501.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/ast/ast_dp501.c 
>> b/drivers/gpu/drm/ast/ast_dp501.c
>> index 1bc35a992369..d9f3a0786a6f 100644
>> --- a/drivers/gpu/drm/ast/ast_dp501.c
>> +++ b/drivers/gpu/drm/ast/ast_dp501.c
>> @@ -224,8 +224,10 @@ static bool ast_launch_m68k(struct drm_device *dev)
>>                   ast_load_dp501_microcode(dev) < 0)
>>                   return false;
>>   -            fw_addr = (u8 *)ast->dp501_fw->data;
>> -            len = ast->dp501_fw->size;
>> +            if (ast->dp501_fw) {
>> +                fw_addr = (u8 *)ast->dp501_fw->data;
>> +                len = ast->dp501_fw->size;
>> +            }
>>           }
>>           /* Get BootAddress */
>>           ast_moutdwm(ast, 0x1e6e2000, 0x1688a8a8);
>
> Hi,
>
> this looks like a false positive.
>
> If "!ast->dp501_fw", and ast_load_dp501_microcode()>=0, then 
> ast_load_dp501_microcode() will set a valid value in ast->dp501_fw.

Hi,

Sorry for the noise, you are right, this is a false positive.
I will take more careful next time.

Su Hui

>
> CJ
