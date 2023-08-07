Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3B3772264
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjHGLdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbjHGLcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:32:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB5555A9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 04:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691407685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L+DEVgtcyYjHcyymwge3U6fgCPUFF6bULa9g46xzT1g=;
        b=N0aBuSpCNdhlECXDZo9J7C+dedzo0VGYFS2aDG3yR2Z5jS/nOTi5JwFmt+Q/ca5nuLECMa
        dJpju7Aobh+PJJicdiB6m7RRvhKhXvKgEGxd/gZltdc/2But1bqYb0yAIXE49jxWbXbh4U
        BI6hpwpckYHhDDE5YmAW6jwW1CDKyN4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-Y1Yppg5dOQ-4GJqOy1S31A-1; Mon, 07 Aug 2023 07:28:04 -0400
X-MC-Unique: Y1Yppg5dOQ-4GJqOy1S31A-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-99388334de6so344110566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 04:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691407683; x=1692012483;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+DEVgtcyYjHcyymwge3U6fgCPUFF6bULa9g46xzT1g=;
        b=HAWnHpoNV/4hoOEi9RxdarJtl8kzAOJ/lWf/Sh9A1dqOUHZyhnoO2tuD1rNYRx+19o
         SVDOrY2kNzWvceSpC+lmmn1HhldZ2HGeL+iOpeK1q8j3D9YuafE60UbwguxjxVhQX9S3
         c7Om7NlTeRjzkTDrMU4ZPb14kKAuL7Wk9Jw5bMu9E6Au0+R8heJTFsdNxniiKonLHdMt
         3IqabnpFMR3ACQ12YNx57zzmsROCU6fDClILKUixhuJAwoQ/VOE7P/6HW1VmovG1ak2k
         98W4P/M+B+4I0XEtX8IDtEO28PXSrwC+gt7IKfRAQ2/SWhON0erYMkgl36QbpcNn2iqS
         kojg==
X-Gm-Message-State: AOJu0YwT1ZOpbg/u/B2bb3aKl79T6xs74GDtcgyx5aP7Km5qIX2ONVYQ
        QjbxD2/I81ubskmMuHHCPohrsGAxWEjjTTvtJqzQOlvqeDwGc2y/gRO3wGv22ts4D5pBmeSlK+n
        29AL+5bmTRDs2alcjKEZFpz4i
X-Received: by 2002:a17:907:7888:b0:99b:7297:fbf5 with SMTP id ku8-20020a170907788800b0099b7297fbf5mr8492239ejc.61.1691407683347;
        Mon, 07 Aug 2023 04:28:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0lkFbI/zZjElmBIpJVyuqN+E93cJNxamRKeqNSP680dkoF4EwoL/NR/d8EakF6TXJm7nkFQ==
X-Received: by 2002:a17:907:7888:b0:99b:7297:fbf5 with SMTP id ku8-20020a170907788800b0099b7297fbf5mr8492227ejc.61.1691407683079;
        Mon, 07 Aug 2023 04:28:03 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id s5-20020a170906168500b00999bb1e01dfsm5042686ejd.52.2023.08.07.04.28.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 04:28:02 -0700 (PDT)
Message-ID: <4ab55129-d35c-fea5-0c59-5183928d55d1@redhat.com>
Date:   Mon, 7 Aug 2023 13:28:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] hp-bioscfg: Update string length calculation
Content-Language: en-US
To:     Jorge Lopez <jorgealtxwork@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas@t-8ch.de, ilpo.jarvinen@linux.intel.com,
        dan.carpenter@linaro.org
References: <20230801191629.45942-1-jorge.lopez2@hp.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230801191629.45942-1-jorge.lopez2@hp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jorge,

On 8/1/23 21:16, Jorge Lopez wrote:
> Replace method how the string length is calculated.
> Removed unused variable 'size'
> 
> Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

While reviewing this I have noticed that the parsing of ORD_LIST_ELEMENTS
in hp_populate_ordered_list_elements_from_package() seems to be quite buggy:

1. Normally str_value and value_len get set for string type package elements by:

                case ACPI_TYPE_STRING:
                        if (elem != PREREQUISITES && elem != ORD_LIST_ELEMENTS) {
                                ret = hp_convert_hexstr_to_str(order_obj[elem].string.pointer,
                                                               order_obj[elem].string.length,
                                                               &str_value, &value_len);
                                if (ret)
                                        continue;
                        }
                        break;

But notice how the  hp_convert_hexstr_to_str() call gets stepped when
elem == ORD_LIST_ELEMENTS .

Yes when next dealing with ORD_LIST_ELEMENTS the never updated str_value and value_len
get used:

		switch (eloc) {
		...
                case ORD_LIST_ELEMENTS:
                        /*
                         * Ordered list data is stored in hex and comma separated format
                         * Convert the data and split it to show each element
                         */
                        ret = hp_convert_hexstr_to_str(str_value, value_len, &tmpstr, &tmp_len);
                        if (ret)
                                goto exit_list;

So that does not seem right.

2. ordered_list_data->elements[0] never gets filled when there actually is a comma in
   the ordered-list, iow when there is more then 1 element:

                        part_tmp = tmpstr;
                        part = strsep(&part_tmp, COMMA_SEP);
                        if (!part)
                                strscpy(ordered_list_data->elements[0],
                                        tmpstr,
                                        sizeof(ordered_list_data->elements[0]));

                        for (elem = 1; elem < MAX_ELEMENTS_SIZE && part; elem++) {
                                strscpy(ordered_list_data->elements[elem],
                                        part,
                                        sizeof(ordered_list_data->elements[elem]));
                                part = strsep(&part_tmp, SEMICOLON_SEP);
                        }

Notice how the for starts at elem = 1, so if part is not NULL (and it is never NULL for the first call strsep will always return tmpstr) then ordered_list_data->elements[0] never gets filled.

3. ordered_list_data->elements_size is set but never validated. You should compare elem after the loop with ordered_list_data->elements_size and make sure they match. IOW verify that 0-(ordered_list_data->elements_size-1) entries of the ordered_list_data->elements[] array have been filled.

4. For specific values of eloc the code expects the current order_obj[elem] to be either an integer or a string, but this is not validated. Please validate that order_obj[elem].type matches with what is expected (string or int) for the current value of eloc.

This all makes me wonder if this specific code-path has been tested ?  Please make sure to test this specific code-path.

Regards,

Hans





> 
> ---
> Based on the latest platform-drivers-x86.git/for-next
> ---
>  drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
> index cffc1c9ba3e7..b19644ed12e0 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
> @@ -258,13 +258,11 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
>  				eloc++;
>  			break;
>  		case ORD_LIST_ELEMENTS:
> -			size = ordered_list_data->elements_size;
> -
>  			/*
>  			 * Ordered list data is stored in hex and comma separated format
>  			 * Convert the data and split it to show each element
>  			 */
> -			ret = hp_convert_hexstr_to_str(str_value, value_len, &tmpstr, &tmp_len);
> +			ret = hp_convert_hexstr_to_str(str_value, strlen(str_value), &tmpstr, &tmp_len);
>  			if (ret)
>  				goto exit_list;
>  
> @@ -279,7 +277,7 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
>  				strscpy(ordered_list_data->elements[olist_elem],
>  					part,
>  					sizeof(ordered_list_data->elements[olist_elem]));
> -				part = strsep(&part_tmp, SEMICOLON_SEP);
> +				part = strsep(&part_tmp, COMMA_SEP);
>  			}
>  
>  			kfree(str_value);

