Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA837793C73
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 14:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238920AbjIFMRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 08:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjIFMRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 08:17:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFA0F9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 05:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694002595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PAHucxdj9KOQiqwrQG5G3puiuXj59YIgbUOHZSj51D4=;
        b=gfLozioXYaswzgr6+UKJKtHzKuOnkP5WQGU4Ap5LAEmk4JlCRVkN3FoN7GnUSvHUZdqkYH
        3+6636yd+3JqrBPmzhWI402/mNu0JnwbnTjHTuCbDN+fXHUYneZndcvgzbsC/k68MZyJNo
        o+yhA5tZXRpqd14NUfBLo69A7ZLYkCc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-pmp2sNsoNgaJLhUIQP2jkQ-1; Wed, 06 Sep 2023 08:16:33 -0400
X-MC-Unique: pmp2sNsoNgaJLhUIQP2jkQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-52e25bc2629so2515443a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 05:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694002592; x=1694607392;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PAHucxdj9KOQiqwrQG5G3puiuXj59YIgbUOHZSj51D4=;
        b=C1oJ1r5gQrpdgIDGr4uKP8XW+KEDc/d9Am6hsxdIgzVTlVCzu6Y8scUGdmNJQ6hPLW
         RmCTvREZ/0YBW5/uhUd8h8qUa37JZqTa2dmojihDcBObzp3aS8m314iuMfoLNJMP2Tld
         0JrA8ZzilGNAEEp2QYs7hib+nnpDhe10ygliEhQtCWvLpRlD/QZbqibOkQ3WSUfv2YjA
         17yL2Zntjv2Cil/kxwYJUeYWesARcUsdgtTP3/ZUzUlhIreW+MB+eCto9lqTehz9E/SJ
         3N/jJYqlPubmdbbBczjYFhb2qDiTJ3X1Y1vpa3bca0UItxXKHWhDdc+WhNptIgf0ZkyP
         eMQQ==
X-Gm-Message-State: AOJu0Yz5jmrW8NvyC0x4fZ+2IuI8NxnQ8fTgfh9eiAgtrGmDLNBp90AZ
        PWZj1J7Y4bjLtDejV4yxTzT973vsbjSd9LXfN8NLoInqvIzYwLC+pZqDXSN1nyIaMI3/6C1/9Sc
        dvjA60+DHKUUBJVjc+FeZrLF5
X-Received: by 2002:aa7:da4d:0:b0:525:6cc7:8092 with SMTP id w13-20020aa7da4d000000b005256cc78092mr2107810eds.13.1694002592483;
        Wed, 06 Sep 2023 05:16:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPPFghIQ4Z3iAsCdA1AIIPJ1b3fWeNYcB2xznceHz9+dt7MmsV9YCoZK80mUp4HAwHBg08eQ==
X-Received: by 2002:aa7:da4d:0:b0:525:6cc7:8092 with SMTP id w13-20020aa7da4d000000b005256cc78092mr2107793eds.13.1694002592080;
        Wed, 06 Sep 2023 05:16:32 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id r9-20020aa7d589000000b0052a1c0c859asm8444962edq.59.2023.09.06.05.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 05:16:31 -0700 (PDT)
Message-ID: <bce762af-0da7-bb5e-1580-b42803c183f6@redhat.com>
Date:   Wed, 6 Sep 2023 14:16:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] x86/platform/uv: refactor deprecated strcpy and
 strncpy
Content-Language: en-US, nl
To:     Ingo Molnar <mingo@kernel.org>,
        Justin Stitt <justinstitt@google.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20230905-strncpy-arch-x86-platform-uv-uv_nmi-v3-1-3efd6798b569@google.com>
 <ZPhsSzHG6YMViOSk@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZPhsSzHG6YMViOSk@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On 9/6/23 14:10, Ingo Molnar wrote:
> 
> * Justin Stitt <justinstitt@google.com> wrote:
> 
>> Both `strncpy` and `strcpy` are deprecated for use on NUL-terminated
>> destination strings [1].
>>
>> We can see that `arg` and `uv_nmi_action` are expected to be
>> NUL-terminated strings due to their use within `strcmp()` and format
>> strings respectively.
>>
>> With this in mind, a suitable replacement is `strscpy` [2] due to the
>> fact that it guarantees NUL-termination on its destination buffer
>> argument which is _not_ the case for `strncpy` or `strcpy`!
>>
>> In this case, we can drop both the forced NUL-termination and the `... -1` from:
>> |       strncpy(arg, val, ACTION_LEN - 1);
>> as `strscpy` implicitly has this behavior.
>>
>> Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
>> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
>> Link: https://github.com/KSPP/linux/issues/90
>> Cc: linux-hardening@vger.kernel.org
>> Signed-off-by: Justin Stitt <justinstitt@google.com>
> 
>>  arch/x86/platform/uv/uv_nmi.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> Note that this commit is already upstream:
> 
>   1e6f01f72855 ("x86/platform/uv: Refactor code using deprecated strcpy()/strncpy() interfaces to use strscpy()")
> 
> Below is the delta your v3 patch has compared to what is upstream - is it 
> really necessary to open code it, instead of using strnchrnul() as your 
> original patch did? Am I missing anything here?

The new version is a result of a review from my because IMHO:

	strscpy(arg, val, strnchrnul(val, sizeof(arg)-1, '\n') - val + 1);

Is really unreadable / really hard to reason about if
this is actually correct and does not contain any
of by 1 bugs.

Note that the diff of v3 compared to the code before v2 landed is
actually smaller now and actually matches the subject of:
"refactor deprecated strcpy and strncpy"

Where as v2 actually touches more code / refactor things
which fall outside of a "one change per patch" approach.
The:

	p = strchr(arg, '\n');
	if (p)
		*p = '\0';

was already there before v2 landed.

I also suggested to do a follow up patch to change things to:

	strscpy(arg, val, sizeof(arg));
	p = strchrnul(arg, '\n');
	*p = '\0';

Which IMHO is much more readable then what has landed
now. But since v2 has already landed I guess the best
thing is just to stick with what we have upstream now...

Regards,

Hans





> 
> Thanks,
> 
> 	Ingo
> 
> --- a/arch/x86/platform/uv/uv_nmi.c
> +++ b/arch/x86/platform/uv/uv_nmi.c
> @@ -202,10 +202,13 @@ static int param_set_action(const char *val, const struct kernel_param *kp)
>  {
>  	int i;
>  	int n = ARRAY_SIZE(valid_acts);
> -	char arg[ACTION_LEN];
> +	char arg[ACTION_LEN], *p;
>  
>  	/* (remove possible '\n') */
> -	strscpy(arg, val, strnchrnul(val, sizeof(arg)-1, '\n') - val + 1);
> +	strscpy(arg, val, sizeof(arg));
> +	p = strchr(arg, '\n');
> +	if (p)
> +		*p = '\0';
>  
>  	for (i = 0; i < n; i++)
>  		if (!strcmp(arg, valid_acts[i].action))
> 

