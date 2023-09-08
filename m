Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B74779801C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 03:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240842AbjIHBX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 21:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjIHBX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 21:23:57 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 1ADDF19A7;
        Thu,  7 Sep 2023 18:23:52 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 0819C602A11D1;
        Fri,  8 Sep 2023 09:23:22 +0800 (CST)
Message-ID: <45027fa0-cda5-2a80-f1cd-ed805d2717ee@nfschina.com>
Date:   Fri, 8 Sep 2023 09:23:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] driver base: slience unused warning
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <3b710f6d-05cf-49d5-b004-849ee2a3ca42@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/9/7 18:49, Dan Carpenter wrote:
> On Thu, Aug 31, 2023 at 03:36:55PM +0800, Su Hui wrote:
>> Avoid unused warning with gcc and W=1 option.
>>
>> drivers/base/module.c:36:6: error:
>> variable ‘no_warn’ set but not used [-Werror=unused-but-set-variable]
>>
>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>>   drivers/base/module.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/module.c b/drivers/base/module.c
>> index 46ad4d636731..10494336d601 100644
>> --- a/drivers/base/module.c
>> +++ b/drivers/base/module.c
>> @@ -33,7 +33,7 @@ static void module_create_drivers_dir(struct module_kobject *mk)
>>   void module_add_driver(struct module *mod, struct device_driver *drv)
>>   {
>>   	char *driver_name;
>> -	int no_warn;
>> +	int __maybe_unused no_warn;
> Just delete the variable if it isn't used.

Hi,

The variable "no_warn" is used to avoid warning like this:

drivers/base/module.c: In function ‘module_add_driver’:
drivers/base/module.c:62:2: error: ignoring return value of 
‘sysfs_create_link’ declared with attribute ‘warn_unused_result’ 
[-Werror=unused-result]

    62 |  sysfs_create_link(&drv->p->kobj, &mk->kobj, "module");
       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This variable is been used but never be read, so gcc and W=1 give such 
warning.

drivers/base/module.c:36:6: error:
variable ‘no_warn’ set but not used [-Werror=unused-but-set-variable]

I wanted to use "__maybe_unused" to avoid  this warning.

However it seems like a wrong using of "__maybe_unused" as Greg KH said:

"But no_warn is being used in this file, it's being set but not read
which is ok.  That's a real use, so this change really isn't correct,
sorry."

Su Hui

>   
>
> regards,
> dan carpenter
>
