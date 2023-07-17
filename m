Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B2A756D45
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjGQTcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjGQTcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:32:22 -0400
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B2F9D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:32:18 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id LTx9qUbpG8AXRLTx9qnrOu; Mon, 17 Jul 2023 21:32:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1689622336;
        bh=fgVFvsM19zb6DaIaPAT/vgxgFwW4LN9BClFowleWbAo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=QYWPLNrznyX3OwoF7j4CiAhkK5mHrVbhSjZsQRtaKsxkeYoG9aVLpEdpGUCck4ANy
         EM3qn7fLWJOYcP02W8t6bw7NCo/UJwxUzwOsTGiGexoqypRTchYBGSk5KKbt5L1Wfx
         n5rGf8jWAH41olni/e8TP6iUyWcCI7edd6jW5a6iUtoi1QxIMCKBanbsUHhr9J+mFK
         RArhbAk2KjY2HEd0lmIGaFPCjDeIz3UGAuKm7MmJ+3n6o1378/k9X/oPRVfC44q7xq
         eLjDG8yvMUttRLdrjfw8IEDgIqAA6n/vmd0mFOrBkuDp973uAwx84XwTkk/Dojjy4J
         3Rf3R+C3d56dA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 17 Jul 2023 21:32:16 +0200
X-ME-IP: 86.243.2.178
Message-ID: <5c10619b-14cb-a765-488c-8fbda857b4c2@wanadoo.fr>
Date:   Mon, 17 Jul 2023 21:32:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] driver core: Fix an error handling path in
 fw_devlink_create_devlink()
Content-Language: fr, en-US
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <858b140b276ceab52a84ce0d4f924b0c411560d1.1689618373.git.christophe.jaillet@wanadoo.fr>
 <CAGETcx91Vm60Os5fw7-kNQ6bGjYaPhOeEutyBy_GLQA62f6vfA@mail.gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <CAGETcx91Vm60Os5fw7-kNQ6bGjYaPhOeEutyBy_GLQA62f6vfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 17/07/2023 à 20:57, Saravana Kannan a écrit :
> On Mon, Jul 17, 2023 at 11:26 AM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>>
>> All error handling paths go to 'out', except this one. Be consistent and
>> also branch to 'out' here.
>>
>> Fixes: 74c782cff77b ("driver core: fw_devlink: Handle suppliers that don't use driver core")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> /!\ Speculative /!\
>>
>>     This patch is based on analysis of the surrounding code and should be
>>     reviewed with care !
>>
>>     If the patch is wrong, maybe a comment in the code could explain why.
>>
>> /!\ Speculative /!\
> 
> Looks okay to me, but I'd rather not much around the code for a
> subjective preference. The existing code also avoids the pointless
> put_device() and personally is easier to read (ok, nothing more of
> relevance is done after this return) than trying to follow the
> execution to the out and then realizing the put_device() is a NOP,
> etc. It also means future changes to "out" will need to accommodate
> for this path that doesn't really need the "out" path.
> 
> -Saravana

Agreed,

I didn't realized that this code was executed only if "if (sup_dev)" 
fails, so only if sup_dev is NULL.

Sorry for the noise.

CJ



> 
>> ---
>>   drivers/base/core.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index 3dff5037943e..854c1fab742c 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -2107,7 +2107,8 @@ static int fw_devlink_create_devlink(struct device *con,
>>              fwnode_ancestor_init_without_drv(sup_handle)) {
>>                  dev_dbg(con, "Not linking %pfwf - might never become dev\n",
>>                          sup_handle);
>> -               return -EINVAL;
>> +               ret = -EINVAL;
>> +               goto out;
>>          }
>>
>>          ret = -EAGAIN;
>> --
>> 2.34.1
>>
> 

