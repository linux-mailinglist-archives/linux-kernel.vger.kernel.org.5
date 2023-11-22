Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D5A7F4A10
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjKVPRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjKVPRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:17:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB84A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700666227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HNZF0SqnqKoxtxQfSsYiCYBkXnRbbx9Gogs3wh0979A=;
        b=hF4nUseY1sn4eYrWfUD9lQu31uau0ThYLNQeZU+5INFaB3XmWNYCV8vwZGbeAiaqGI8/ia
        gMM+MJcb2EEwtkuz3xPRCAnS8P2ETfq4vBGeIIJj0208McivEGVv9OChdT4t4m158Kkd0v
        DsoMkjM4SIPtFn4ajD4UosBzd1zMBzg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-rRhUWlTVNMGH0n9LduqBxw-1; Wed, 22 Nov 2023 10:17:04 -0500
X-MC-Unique: rRhUWlTVNMGH0n9LduqBxw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50aa861dcf7so4339982e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700666223; x=1701271023;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HNZF0SqnqKoxtxQfSsYiCYBkXnRbbx9Gogs3wh0979A=;
        b=vXoy88B9ZCW7i9rB3GnYfZzAJ7dxLtlNQyNB3cWgIVoxjlz4SHrp8dPF7aZVRU3dLR
         RLYQxEuC7mKUPrvaImiBs73Ui9OYlg79XM8TETG+mGj4NbRLUpwJUyDlO3AX0011ONds
         Pwh/SWNb1dt/oVDl1MTG4ZiLbMxq+u8WPHO/miUXFBDukGUBnzFqoo2yYi2Llh+BHyLx
         +EqcsqK0lACDTR80oc+47Cuxei9QvaEh6Oa191kBSrAjD7qcdezHaxVpxINJgqfOzshy
         b8OG5kKdDqjjodxFr+P7hwEDWEbS1va97XxKQwDaO65pFbVxyTi3qPT0oE7khibDLxD6
         xGxA==
X-Gm-Message-State: AOJu0YwzVpc8NzULjmxX3wx31UD1ZogSI60lQqf3g81yXDENLXs8YU3Q
        Inz1azdYI/f/E03mY1lO2jW5mlzyc6IOax26enLci67f3NZ/OSJNzkAxDOyAdQXwdwJqGtuEZ/T
        xoEdplomoPbBaXbj+liIOfxg+
X-Received: by 2002:a19:f818:0:b0:509:8e22:ae5 with SMTP id a24-20020a19f818000000b005098e220ae5mr1804412lff.60.1700666223052;
        Wed, 22 Nov 2023 07:17:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhNkk8osKUkuMiPV2p7kvM34eDJmsK95p+FLf/21RrBimt6NwiyXB5Qui/5kgPXgAMHMEmbw==
X-Received: by 2002:a19:f818:0:b0:509:8e22:ae5 with SMTP id a24-20020a19f818000000b005098e220ae5mr1804397lff.60.1700666222725;
        Wed, 22 Nov 2023 07:17:02 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id u10-20020aa7d88a000000b00548ac1f7c5esm4002104edq.64.2023.11.22.07.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 07:17:02 -0800 (PST)
Message-ID: <0e3cd2e2-ea09-4772-88ed-b90a913937a0@redhat.com>
Date:   Wed, 22 Nov 2023 16:17:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: i8042 - add quirk for Lenovo ThinkPad T14 Gen 1
Content-Language: en-US, nl
To:     Jonathan Denose <jdenose@chromium.org>
Cc:     linux-input@vger.kernel.org, Jonathan Denose <jdenose@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Takashi Iwai <tiwai@suse.de>,
        Werner Sembach <wse@tuxedocomputers.com>,
        linux-kernel@vger.kernel.org
References: <20230925163313.1.I55bfb5880d6755094a995d3ae44c13810ae98be4@changeid>
 <fbcf0fee-b97d-8f47-9df4-44bc1b475144@redhat.com>
 <CALNJtpUH_0+ETa+7MfKRbpc_c1TTTasUrZ4zA4V9EHb_BtAUwg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CALNJtpUH_0+ETa+7MfKRbpc_c1TTTasUrZ4zA4V9EHb_BtAUwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On 11/21/23 21:23, Jonathan Denose wrote:
> Hello Hans,
> 
> On Tue, Sep 26, 2023 at 5:37 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 9/25/23 23:33, Jonathan Denose wrote:
>>> The ThinkPad T14 Gen 1 touchpad works fine except that clicking
>>> and dragging by tapping the touchpad or depressing the touchpad
>>> do not work. Disabling PNP for controller setting discovery enables
>>> click and drag without negatively impacting other touchpad features.
>>>
>>> Signed-off-by: Jonathan Denose <jdenose@google.com>
>>
>> Thanks, patch looks good to me:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>
>> Regards,
>>
>> Hans
> 
> I just wanted to double check that I haven't missed anything, has this
> patch been applied yet?

Dmitry unfortunately does not have a lot of time for
reviewing / merging input subsystem patches. So AFAICT this
has not been processed / merged yet.

I've just send Dmitry a friendly worded email ping for another
patch, I've also brought this patch to his attention in
that email.

Regards,

Hans


