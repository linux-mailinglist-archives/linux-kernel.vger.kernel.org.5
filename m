Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F1777CAFC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 12:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbjHOKK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 06:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236427AbjHOKKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 06:10:22 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0501710E5;
        Tue, 15 Aug 2023 03:10:21 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-99bf8e5ab39so712239266b.2;
        Tue, 15 Aug 2023 03:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692094219; x=1692699019;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DxtXbWDExluXUhdhGSwGLCixL784+N7oTAss+CZkeYk=;
        b=j7N5sGKUERuwaSo4mVjom6DK14ahAFygnH+9pwV41/9GV3b/HxbdsEIFjivLPpGaj9
         CzJOzmNL1EulFQIMUgwXnruk9AMr9T/4H6dZU3cA91l3ZHDrlz5yMKibdKGuzgDQ7+B2
         5MUton4eneDGnxWcEOJ8Guokqmnp1U7yjKh2h6HLXjvtvu9PmQPZi+nWfZv0US5d8tpH
         VKX5A1lzCCzT+wkmDNhlyICnFaew40LTN6cTbMS8ctI0aqfhLki4/6/6ZilU0AlQ58E1
         Qt8kk6WpU9dKW4aO3UBm9JNJHPE45p+NNPf/GGPAt3ra+RfJjad1QrCKVKBCRyTP8XpJ
         kiHQ==
X-Gm-Message-State: AOJu0YzLW46xdGx3ylxXURO2N/KpdOibcIDVvOSNITURL28BnPY07HHI
        cDB/3iZ0o42O77bAYzhyCf8=
X-Google-Smtp-Source: AGHT+IF5agxfKxVU9BmH+YKB+d6b0Jkki95Lu1aSccrJIQ2tweznM+t0gMjDj2I2PhSQV+xo2lcuJA==
X-Received: by 2002:a17:906:10c9:b0:991:fef4:bb7 with SMTP id v9-20020a17090610c900b00991fef40bb7mr10156437ejv.73.1692094219095;
        Tue, 15 Aug 2023 03:10:19 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id kq11-20020a170906abcb00b0099bcf563fe6sm6783209ejb.223.2023.08.15.03.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 03:10:18 -0700 (PDT)
Message-ID: <781f5f29-c53e-919c-9c31-0a048a625983@kernel.org>
Date:   Tue, 15 Aug 2023 12:10:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] serial: 8250: drop lockdep annotation from
 serial8250_clear_IER()
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20230811064340.13400-1-jirislaby@kernel.org>
 <878rae175n.fsf@jogness.linutronix.de>
 <7d8ae4f8-8900-5a06-5b7b-d4a3aea0673e@kernel.org>
 <87bkfa6nvx.fsf@jogness.linutronix.de> <ZNn7KHY3iMRarqAZ@alley>
 <154dfc10-76fa-b054-54a8-faa22ad52158@kernel.org> <ZNtE_dcBaDm-wbHt@alley>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <ZNtE_dcBaDm-wbHt@alley>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15. 08. 23, 11:27, Petr Mladek wrote:
> On Mon 2023-08-14 12:21:23, Jiri Slaby wrote:
>> On 14. 08. 23, 12:00, Petr Mladek wrote:
>>> I personally vote to keep it as is unless people see this warning
>>> on daily basis. After all, the lockdep splat is correct. The serial
>>> console might not work correctly in panic() when there is the race.
>>
>> Sorry, but no, the warning is not correct at all. The code path deliberately
>> does NOT take the lock and calls a function which is currently annotated
>> that the lock is _always_ taken. Therefore, the warning is clearly a false
>> positive and I see no reason in keeping it.
> 
> There might be a misunderstanding. I only want to keep panic()
> implementation as it is for now. I mean to keep calling
> debug_locks_off() right before console_flush_on_panic().
> The lockdep should stay on before to report potential problems
> in non-printk code, like kexec, panic notifiers.
> 
> But I am fine with disabling the particular lockdep_assert_held_once()
> during panic().
> 
> It should stay during the normal system state to catch not
> yet discovered races. John is working hard on preventing any
> races which might blow up after introducing the printk kthreads.
> 
> I mean something like:
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index ecfdc4534123..9533c1eedfb1 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -704,7 +704,8 @@ static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
>   static void serial8250_clear_IER(struct uart_8250_port *up)
>   {
>   	/* Port locked to synchronize UART_IER access against the console. */
> -	lockdep_assert_held_once(&up->port.lock);
> +	if (!oops_in_progress)
> +		lockdep_assert_held_once(&up->port.lock);

Yes, this is one of my suggestions ;). (Which I thought are not worth 
it, but I am not opposing either.)

thanks,
-- 
js
suse labs

