Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DD8774D5E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjHHVwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjHHVwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:52:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB7DB1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 14:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691531524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=irFVMLOEn+k+XTN2GD/NILLHK1tPorHJ0UIXqR+CLE8=;
        b=MnQLxKIcgHYqCf/Bvcyc/cDFYDd7gsCAhTskm5rGhX44+2jCyebom0vn27kOJu34Z3MtmD
        vwOqDxxR8EFoX6xQFRNPwCka2zfMncbR3oZ/Yl6n8kdMy2wcUm9kbaFvALS61REVnJO3YM
        E6dviSuLwl/bOXSRgVpQVKwKzq6PRM8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-I7sEjPC9PIGsngqnW1pwsg-1; Tue, 08 Aug 2023 17:52:02 -0400
X-MC-Unique: I7sEjPC9PIGsngqnW1pwsg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5223bdb71e5so4072813a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 14:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691531521; x=1692136321;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=irFVMLOEn+k+XTN2GD/NILLHK1tPorHJ0UIXqR+CLE8=;
        b=C+NVi5e6wU+Xshk8F+MzFBG1V3/ueQmH1mnSyewZYUh3XZCInWfkReEa7/csNRgvuG
         z9101d1dOuJ2e18pDhm3psQtXQ45qZHVdRqMEdtP1IwZ+SPo8RYRNQyPsn1gyXdGvlDp
         8sdZ9Bx5IPMNMR7nOczrgu9fb6Uvz6DS0mS1szlQE9kkyxcjbIl87SFWS1z7sOz1ntyf
         DCjkSGIVjzRUP9f2JNTRSceGI9bRi/RmGzCMsUFcgyuB2a75WDYHolg6d33oTZgXaE1G
         E2uU2qDDPYQLnjWiaQBPP662BDWFeJffCaaOic22fGH+O6zo55PvxmPvbBTIkvzpbBNj
         GNNw==
X-Gm-Message-State: AOJu0YzybOttiXIhuVZJS7S26gNipF8a11f4qKcCjJeba5XXZjg3JV+9
        viPuwKh0Pt3mT85jGs2X50C50fC4YUD9cU6XA2Ene6UtG+mXpkAEzoQ5YhgdnKA0iLBKDI6mjoi
        t1qZ4LCmuVyvNnhNpN5dIkcIg
X-Received: by 2002:a05:6402:10cd:b0:521:8777:b00d with SMTP id p13-20020a05640210cd00b005218777b00dmr735713edu.15.1691531521386;
        Tue, 08 Aug 2023 14:52:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFp6xNb3mk5D2sUVhHwLaXBN7n7DkWJKbPENHa7ETzVmYnMJpETNbtu2qnaUFQ5qMoVwUymgA==
X-Received: by 2002:a05:6402:10cd:b0:521:8777:b00d with SMTP id p13-20020a05640210cd00b005218777b00dmr735704edu.15.1691531521107;
        Tue, 08 Aug 2023 14:52:01 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id r14-20020aa7da0e000000b0052286e8dee1sm7176742eds.76.2023.08.08.14.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 14:52:00 -0700 (PDT)
Message-ID: <1ea7e949-e05b-985c-bb0c-6d0b00bb8b5f@redhat.com>
Date:   Tue, 8 Aug 2023 23:51:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] hp-bioscfg: Update string length calculation
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas@t-8ch.de, ilpo.jarvinen@linux.intel.com,
        dan.carpenter@linaro.org
References: <20230801191629.45942-1-jorge.lopez2@hp.com>
 <4ab55129-d35c-fea5-0c59-5183928d55d1@redhat.com>
 <CAOOmCE_DGqUh3+8LmrX2_7eTeDG_7p7-JKN7Q2syvDQu60UWmQ@mail.gmail.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAOOmCE_DGqUh3+8LmrX2_7eTeDG_7p7-JKN7Q2syvDQu60UWmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/8/23 22:25, Jorge Lopez wrote:
> Hi Hans,
> 
> On Mon, Aug 7, 2023 at 6:28 AM Hans de Goede <hdegoede@redhat.com> wrote:

<snip>

>> 3. ordered_list_data->elements_size is set but never validated. You should compare elem after the loop with ordered_list_data->elements_size and make sure they match. IOW verify that 0-(ordered_list_data->elements_size-1) entries of the ordered_list_data->elements[] array have been filled.
> 
> ordered_list_data->elements_size is checked against MAX_ELEMENTS_SIZE
> and not against the number of elements in the array.  Initially, size
> value was reported (sysfs) but after a couple reviews, size was
> removed from being reported (sysfs).  size value will be determined by
> the application when it enumerates the values reported in elements.

Right, but after splitting the string on commas there should be ordered_list_data->elements_size entries, right ? So we should verify that. Also what if the string after splitting has more entries then MAX_ELEMENTS_SIZE, then currently the code will overflow the array, so the loop splitting the string on commas should ensure that MAX_ELEMENTS_SIZE is not exceeded.

>>
>> 4. For specific values of eloc the code expects the current order_obj[elem] to be either an integer or a string, but this is not validated. Please validate that order_obj[elem].type matches with what is expected (string or int) for the current value of eloc.
> 
> The purpose for 'eloc' is  to help skip reading values such
> ORD_LIST_ELEMENTS and PREREQUISITES when ORD_LIST_ELEMENTS and/or
> PREREQUISITES_SIZE values are zero.
> Normally, 'eloc' and 'elem' are the same.

Never mind what I meant to say is that you should to a check like this:

                /* Check that both expected and read object type match */
                if (expected_order_types[eloc] != order_obj[elem].type) {
                        pr_err("Error expected type %d for elem %d, but got type %d instead\n"
                               expected_order_types[eloc], elem, order_obj[elem].type);
                        return -EIO;
                }

But I see now that that check is already there.

Regards,

Hans


