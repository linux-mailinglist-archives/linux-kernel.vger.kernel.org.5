Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A3A78285D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbjHUL5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbjHUL47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:56:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5755EA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 04:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692618957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JZlQIqocknrIlMtIJUoMhvddTuUyuE/0jPIZUKQyydA=;
        b=iGqtKl9YKyergrp38ul8U55hj8pSIyRety6vA2jObl2/QdhID/jLHJZxTcYc9wEFg2Q4jD
        MrjbYQoyHyW/HYum//5zOGY7kUCBuVeOQUDTX8R8croRGGJbZBlwS9wl4QiNXe+p9kxtdV
        99vDJelvC2yUnfQ5yxCQNVXa1b3G3V4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-6BX3sLzzPEWmKiNWKstU7Q-1; Mon, 21 Aug 2023 07:55:56 -0400
X-MC-Unique: 6BX3sLzzPEWmKiNWKstU7Q-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9a19085f0d4so151388266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 04:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692618955; x=1693223755;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JZlQIqocknrIlMtIJUoMhvddTuUyuE/0jPIZUKQyydA=;
        b=fEQDQLUW6VZTwBepTUS9/AjCD0jLybKLMyosw35m+CB7L4diCzcOK5j7yV9dbG0iUG
         g23jnxlfjH+xAIFFEbt11+3yxkzDD6c0Exa4GU8sB1Etba/MuvX96BQFa/y4SM2QA/jV
         rkp4n0z8QzUjarg0aMpEMMfcZ8SkC/S5KGLxrTppNW4xqfjJnTq77T0jpMjlqs4XzV9X
         Xi2eB+3b4jSGSx+RxL+yvG2S7vxJppYcGIsU3arxF4/jE8RxpWqhVFSKqB65C7XM65qX
         /4/NeL+QUt9rI8sSQ3fUEx/dZlmvTGG2+KJ9h3V/S/M1WFGUDnillfB8SezcnCrI61rJ
         iqwA==
X-Gm-Message-State: AOJu0YyG8zK3lHpOxpf5LmOcQjIpWyaAVDvdjXHmI6NCYxasCSIdjgSP
        j3J+4FfhomCCFW3q8/efQP+/mzw97SPAiCKc8YiYXq0/3ZVmOB7mUCCQcRK01NAtK4UrpK7A+bl
        mb5UEwwRDSGVZI2+akW7LaoJVBaFSlDn/
X-Received: by 2002:a05:6402:34cf:b0:51d:b184:efd with SMTP id w15-20020a05640234cf00b0051db1840efdmr6553361edc.20.1692618954840;
        Mon, 21 Aug 2023 04:55:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEABWvi6B1Krzc1SSY2cCBIIEFUFPascY0xaQ3yGfVFTEepN9Pwava+XwcBzunnU5jT4KODyg==
X-Received: by 2002:a05:6402:34cf:b0:51d:b184:efd with SMTP id w15-20020a05640234cf00b0051db1840efdmr6553347edc.20.1692618954554;
        Mon, 21 Aug 2023 04:55:54 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id d16-20020a50fb10000000b005224d15d3dfsm5905781edq.87.2023.08.21.04.55.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 04:55:54 -0700 (PDT)
Message-ID: <767165e4-5eae-a35c-aead-1db7801050dd@redhat.com>
Date:   Mon, 21 Aug 2023 13:55:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] hp-bioscfg: Update steps how order list elements are
 evaluated
Content-Language: en-US
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas@t-8ch.de, ilpo.jarvinen@linux.intel.com,
        dan.carpenter@linaro.org
References: <20230809210740.18392-1-jorge.lopez2@hp.com>
 <10276e15-8528-41a9-4b90-7fdf6b890206@redhat.com>
 <CAOOmCE9PFi5Xwmyr4jMPZ7LgofPY1fwLW71itfXw1km50B-Ybg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAOOmCE9PFi5Xwmyr4jMPZ7LgofPY1fwLW71itfXw1km50B-Ybg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jorge,

On 8/14/23 15:44, Jorge Lopez wrote:
> Hi Hans,
> 
> On Mon, Aug 14, 2023 at 3:41 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Jorge,
>>
>> On 8/9/23 23:07, Jorge Lopez wrote:
>>> Update steps how order list elements data and elements size are
>>> evaluated
>>>
>>> Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>
>>>
>>> ---
>>> Based on the latest platform-drivers-x86.git/for-next
>>> ---
>>>  .../x86/hp/hp-bioscfg/order-list-attributes.c    | 16 ++++++++++++++--
>>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
>>> index b19644ed12e0..d2b61ab950d4 100644
>>> --- a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
>>> +++ b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
>>> @@ -152,7 +152,7 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
>>>
>>>               switch (order_obj[elem].type) {
>>>               case ACPI_TYPE_STRING:
>>> -                     if (elem != PREREQUISITES && elem != ORD_LIST_ELEMENTS) {
>>> +                     if (elem != PREREQUISITES) {
>>>                               ret = hp_convert_hexstr_to_str(order_obj[elem].string.pointer,
>>>                                                              order_obj[elem].string.length,
>>>                                                              &str_value, &value_len);
>>> @@ -266,6 +266,15 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
>>>                       if (ret)
>>>                               goto exit_list;
>>>
>>> +                     /*
>>> +                      * It is expected for the element size value
>>> +                      * to be 1 and not to represent the actual
>>> +                      * number of elements stored in comma
>>> +                      * separated format. element size value is
>>> +                      * recalculated to report the correct number
>>> +                      * of data elements found.
>>> +                      */
>>> +
>>>                       part_tmp = tmpstr;
>>>                       part = strsep(&part_tmp, COMMA_SEP);
>>>                       if (!part)
>>> @@ -273,11 +282,14 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
>>>                                       tmpstr,
>>>                                       sizeof(ordered_list_data->elements[0]));
>>>
>>> -                     for (olist_elem = 1; olist_elem < MAX_ELEMENTS_SIZE && part; olist_elem++) {
>>> +                     for (olist_elem = 0; olist_elem < MAX_ELEMENTS_SIZE && part; olist_elem++) {
>>>                               strscpy(ordered_list_data->elements[olist_elem],
>>>                                       part,
>>>                                       sizeof(ordered_list_data->elements[olist_elem]));
>>> +
>>>                               part = strsep(&part_tmp, COMMA_SEP);
>>> +                             if (part && ordered_list_data->elements_size < MAX_ELEMENTS_SIZE)
>>> +                                     ordered_list_data->elements_size++;
>>>                       }
>>
>> I believe that you can replace the:
>>
>>                                 if (part && ordered_list_data->elements_size < MAX_ELEMENTS_SIZE)
>>                                         ordered_list_data->elements_size++;
>>                         }
>>
>> Lines with simply (after the loop has finished) doing:
>>
>>                         }
>>                         ordered_list_data->elements_size = olist_elem'
>>
>> Or am I missing something ?
> 
> The lines cannot be replaced with a single line for several reasons,
> 1. elements_size is initially set to 1 and it is only incremented when
> a COMMA_SEP is found.  (See part variable)

Right, but we are not incrementing elements_size here, but overriding it,
so the start value does not matter.

olist_elem keeps count of how many times strscpy() has been called
and thus of how many elements there are in
the ordered_list_data->elements_size, so:

                         ordered_list_data->elements_size = olist_elem;

will give us the correct size with much simpler code.

> 2. Limit the number of element_size to  MAX_ELEMENTS_SIZE.  The user
> requires entering all items in the new order when a change is needed.
> For instance, updating boot order.

olist_elem itself is also already limited to MAX_ELEMENTS_SIZE.

> 3. Limiting  elements_size and not just olist_elem to to
> MAX_ELEMENTS_SIZE removes the possibility of  array overflow
> (ordered_list_data->elements[..]).   olist_elem value is 0 (zero)
> based while elements_size is 1 based

As already mentioned olist_elem itself is already limited to MAX_ELEMENTS_SIZE,
so doing:

ordered_list_data->elements_size = olist_elem;

Automatically limits ordered_list_data->elements_size too.

###

I see you also left the "if (!part)" above the loop.

That is not necessary because after the first strsep() call part
will always be non NULL.

For a string without any delimiters, so only 1 element strsep()
will only return NULL on the second strsep() call.

strsep() always returns *part_tmp, which before the first
call is non NULL, so the first call always returns non NULL.

###

And there still is an unused assignment of size directly
after "case ORD_LIST_ELEMENTS" :

                        size = ordered_list_data->elements_size;

###

Also you seem to have based this patch on top of a weird base
commit. This patch assumes both strsep() calls use COMMA_SEP
as separator. But the latest code in:

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Still uses the wrong SEMICOLON_SEP for the second strsep() call.

Please make sure to base your next version on top of the latest
review-hans commit.

###

TL;DR: for your next version the "case ORD_LIST_ELEMENTS"
should end up looking like this:

		case ORD_LIST_ELEMENTS:
			/*
			 * Ordered list data is stored in hex and comma separated format
			 * Convert the data and split it to show each element
			 */
			ret = hp_convert_hexstr_to_str(str_value, value_len, &tmpstr, &tmp_len);
			if (ret)
				goto exit_list;

			part_tmp = tmpstr;
			part = strsep(&part_tmp, COMMA_SEP);

			for (olist_elem = 0; olist_elem < MAX_ELEMENTS_SIZE && part; olist_elem++) {
				strscpy(ordered_list_data->elements[olist_elem],
					part,
					sizeof(ordered_list_data->elements[olist_elem]));
				part = strsep(&part_tmp, COMMA_SEP);
			}
			ordered_list_data->elements_size = olist_elem;

			kfree(str_value);
			str_value = NULL;
			break;

Unless I'm missing something and you believe that this will not work.

Regards,

Hans

