Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F07C7827A7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjHULNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjHULNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:13:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F52E1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 04:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692616387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FLv+TkAFGQoQHMU5iUg8DMV6ijqUrDP2mgBfimkSRB8=;
        b=Vs5Gi8kzYdTXaI8t8WhjlqQQOZT/gUSqbQKRPSIUk7Pa+YchXXk4rHXx8C/uTMktkqdnHG
        YwenJO4ZTWX6xEWsUqplnne0eUpLKOFHpoW9TTuVSndtwJ1sprpaPNFoXBdlOmyblcAwls
        uqjKC7Z9XSZk0hn08CDWHuEhU9Yn5Z8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-Nqm2trGWOCeWrib4Wbv_3Q-1; Mon, 21 Aug 2023 07:13:05 -0400
X-MC-Unique: Nqm2trGWOCeWrib4Wbv_3Q-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-52a0f5f74d7so524777a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 04:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692616384; x=1693221184;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FLv+TkAFGQoQHMU5iUg8DMV6ijqUrDP2mgBfimkSRB8=;
        b=B96xhrbsN2MIcqmKUaHJX6pW9FJe0xyzs/3sRWsXkDDgNf7ts5gRi9mRAafsnt/DI2
         lxIBBGRNI5Kgs3BPtRJrgV+KxdTqpDlzckUbNp/735EaJN+YfpQS1ZJgSJoZGxA/CwR7
         JpBQubTCmur34wRaniy+tG8MCsHAyS06aDUQ5lFQcP3kpiq95+Vkl64w6Yqai5E+6n3A
         6V/NVSFozXRk6rlfIRfZYp+Xmet3n57neRWQdUCScQuqJX+zHufurbsw/P/fEHlFwxOv
         OMZJN8wMMxDFH/+waJdecwNL1hvMT09cgIOMtBkimfW+XMqYt/FGk1G4/Ba/Dux6tIGd
         VsYA==
X-Gm-Message-State: AOJu0YwLt/ErCNxPavF8VBujZReZrn9w70LmhNrH07sJ8XEflv7d1RIO
        r2nl5HfwPB8yFLvcKC+xYpiYGD+Prau5LmBU0FxSg97Ng2CcFoJOiA/j29JazMvd3LWfp0Ry/Si
        Nxiot8ciFg/ep0joZX+vHAUWL
X-Received: by 2002:a17:906:cc48:b0:99c:bb4d:f5a0 with SMTP id mm8-20020a170906cc4800b0099cbb4df5a0mr4863398ejb.14.1692616384694;
        Mon, 21 Aug 2023 04:13:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHWHdNmfToWu5FBCGghpN2lVEXfePQq5j5r60KTclBOe+eLY3OTLQaTvwFKHiCQS8piS/PcQ==
X-Received: by 2002:a17:906:cc48:b0:99c:bb4d:f5a0 with SMTP id mm8-20020a170906cc4800b0099cbb4df5a0mr4863391ejb.14.1692616384514;
        Mon, 21 Aug 2023 04:13:04 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id o22-20020a170906289600b0099bd86f9248sm6379338ejd.63.2023.08.21.04.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 04:13:04 -0700 (PDT)
Message-ID: <3d537df6-d5b1-835c-b856-1783747f4eb4@redhat.com>
Date:   Mon, 21 Aug 2023 13:13:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] platform/x86: ideapad-laptop: Add support for new hotkeys
 found on ThinkBook 14s Yoga ITL
Content-Language: en-US
To:     =?UTF-8?Q?Andr=c3=a9_Apitzsch?= <git@apitzsch.eu>,
        Ike Panhc <ike.pan@canonical.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230819-lenovo_keys-v1-1-9d34eac88e0a@apitzsch.eu>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230819-lenovo_keys-v1-1-9d34eac88e0a@apitzsch.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/19/23 09:12, André Apitzsch wrote:
> The Lenovo Thinkbook 14s Yoga ITL has 4 new symbols/shortcuts on their
> F9-F11 and PrtSc keys:
> 
> F9:    Has a symbol of a head with a headset, the manual says "Service key"
> F10:   Has a symbol of a telephone horn which has been picked up from the
>        receiver, the manual says: "Answer incoming calls"
> F11:   Has a symbol of a telephone horn which is resting on the receiver,
>        the manual says: "Reject incoming calls"
> PrtSc: Has a symbol of a siccor and a dashed ellipse, the manual says:
>        "Open the Windows 'Snipping' Tool app"
> 
> This commit adds support for these 4 new hkey events.
> 
> Signed-off-by: André Apitzsch <git@apitzsch.eu>

Thank you for your patch, I've applied this patch to my fixes
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Note it will show up in my fixes branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans

> ---
>  drivers/platform/x86/ideapad-laptop.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index d2fee9a3e239..6d9297c1d96c 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -1049,6 +1049,11 @@ static const struct key_entry ideapad_keymap[] = {
>  	{ KE_IGNORE,	0x03 | IDEAPAD_WMI_KEY },
>  	/* Customizable Lenovo Hotkey ("star" with 'S' inside) */
>  	{ KE_KEY,	0x01 | IDEAPAD_WMI_KEY, { KEY_FAVORITES } },
> +	{ KE_KEY,	0x04 | IDEAPAD_WMI_KEY, { KEY_SELECTIVE_SCREENSHOT } },
> +	/* Lenovo Support */
> +	{ KE_KEY,	0x07 | IDEAPAD_WMI_KEY, { KEY_HELP } },
> +	{ KE_KEY,	0x0e | IDEAPAD_WMI_KEY, { KEY_PICKUP_PHONE } },
> +	{ KE_KEY,	0x0f | IDEAPAD_WMI_KEY, { KEY_HANGUP_PHONE } },
>  	/* Dark mode toggle */
>  	{ KE_KEY,	0x13 | IDEAPAD_WMI_KEY, { KEY_PROG1 } },
>  	/* Sound profile switch */
> 
> ---
> base-commit: 7271b2a530428b879443b274c191b34536a4ea11
> change-id: 20230819-lenovo_keys-ed658f4d34d7
> 
> Best regards,

