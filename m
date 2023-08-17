Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E85977F469
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 12:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350000AbjHQKnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 06:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242143AbjHQKml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 06:42:41 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721B930C0;
        Thu, 17 Aug 2023 03:42:39 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-99c4923195dso1020097066b.2;
        Thu, 17 Aug 2023 03:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692268958; x=1692873758;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nx8C1TQb0Mqh/RAxYdompjsQPHnLTeqEO4RjNoQPyqc=;
        b=JMTBNEQb3zwn01i7/j64vn4Dt5ze+hbtlda/91SkWIbSWr7VztQwm0zAvFXBvCSAk4
         BzJPvTH7NymYUo4Unv79GUHn/TPUd3fnspIkMSqN9kG39A9oU1DzLRNnHVJ9/fRBYD9H
         /073fqYf6AqZU04iwIdaOpsYr+Xe9Xo5nLf3oDnZp/Gqt+52UdNDYkbSrkIOqd1qXRYL
         7Fu4LvvD/0oOV5N+QBM1jjzVVbabno/JfnFBxyrcgALm1WD+zKo33d3Y1WnyIdXTbYxD
         eJf6QpX181ouzCpktNidKoaOHPVCA3JbMHQo04ycMh7xJVIuopjIQzHeop23YnFW+2Y1
         rRjQ==
X-Gm-Message-State: AOJu0YxmVKVYpEuqkVDAh4o1k4TuzAZrG8SzgSQdIaiqMtfsxHf/ceoc
        hJH+QjVMfLFYyrPDSHYFHEs=
X-Google-Smtp-Source: AGHT+IHYPovmnZkm2UjGEgpa8Ye7BOl9mgW7wDmffHz5AIot8qURL7uylDpLtKqfpKP6SEkkWwseoA==
X-Received: by 2002:a17:907:1df2:b0:99d:fc31:242f with SMTP id og50-20020a1709071df200b0099dfc31242fmr2431853ejc.66.1692268957473;
        Thu, 17 Aug 2023 03:42:37 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id jj27-20020a170907985b00b0099cb0a7098dsm10065306ejc.19.2023.08.17.03.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 03:42:36 -0700 (PDT)
Message-ID: <ad29a619-f50b-2866-b89a-8e770ca3a883@kernel.org>
Date:   Thu, 17 Aug 2023 12:42:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 27/36] tty: propagate u8 data to tty_operations::write()
Content-Language: en-US
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Karsten Keil <isdn@linux-pingi.de>,
        Scott Branden <scott.branden@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        David Lin <dtwlin@gmail.com>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Jiri Kosina <jikos@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Oliver Neukum <oneukum@suse.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20230810091510.13006-1-jirislaby@kernel.org>
 <20230810091510.13006-28-jirislaby@kernel.org>
 <ZNYhBCKWPdyuBhtz@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <ZNYhBCKWPdyuBhtz@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11. 08. 23, 13:52, Alexander Gordeev wrote:
> On Thu, Aug 10, 2023 at 11:15:01AM +0200, Jiri Slaby (SUSE) wrote:
> 
> Hi Jiri,
> 
>> Data are now typed as u8. Propagate this change to
>> tty_operations::write().
> ...
>>   drivers/s390/char/con3215.c            | 3 +--
>>   drivers/s390/char/con3270.c            | 3 +--
>>   drivers/s390/char/sclp_tty.c           | 2 +-
>>   drivers/s390/char/sclp_vt220.c         | 2 +-
> ...
>> diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
>> index a1fef666c9b0..16b6f430dfd3 100644
>> --- a/drivers/s390/char/con3215.c
>> +++ b/drivers/s390/char/con3215.c
>> @@ -1021,8 +1021,7 @@ static unsigned int tty3215_write_room(struct tty_struct *tty)
>>   /*
>>    * String write routine for 3215 ttys
>>    */
>> -static int tty3215_write(struct tty_struct *tty,
>> -			 const unsigned char *buf, int count)
>> +static int tty3215_write(struct tty_struct *tty, const u8 *buf, int count)
>>   {
>>   	handle_write(tty->driver_data, buf, count);
>>   	return count;
>> diff --git a/drivers/s390/char/con3270.c b/drivers/s390/char/con3270.c
>> index d9983550062d..123524bff734 100644
>> --- a/drivers/s390/char/con3270.c
>> +++ b/drivers/s390/char/con3270.c
>> @@ -1803,8 +1803,7 @@ static void tty3270_do_write(struct tty3270 *tp, struct tty_struct *tty,
>>   /*
>>    * String write routine for 3270 ttys
>>    */
>> -static int tty3270_write(struct tty_struct *tty,
>> -			 const unsigned char *buf, int count)
>> +static int tty3270_write(struct tty_struct *tty, const u8 *buf, int count)
>>   {
>>   	struct tty3270 *tp;
>>   
>> diff --git a/drivers/s390/char/sclp_tty.c b/drivers/s390/char/sclp_tty.c
>> index 971fbb52740b..cc0f6a97124e 100644
>> --- a/drivers/s390/char/sclp_tty.c
>> +++ b/drivers/s390/char/sclp_tty.c
>> @@ -230,7 +230,7 @@ static int sclp_tty_write_string(const unsigned char *str, int count, int may_fa
>>    * routine will return the number of characters actually accepted for writing.
>>    */
>>   static int
>> -sclp_tty_write(struct tty_struct *tty, const unsigned char *buf, int count)
>> +sclp_tty_write(struct tty_struct *tty, const u8 *buf, int count)
>>   {
>>   	if (sclp_tty_chars_count > 0) {
>>   		sclp_tty_write_string(sclp_tty_chars, sclp_tty_chars_count, 0);
>> diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
>> index a32f34a1c6d2..44974d801c1e 100644
>> --- a/drivers/s390/char/sclp_vt220.c
>> +++ b/drivers/s390/char/sclp_vt220.c
>> @@ -463,7 +463,7 @@ __sclp_vt220_write(const unsigned char *buf, int count, int do_schedule,
>>    * number of characters actually accepted for writing.
>>    */
>>   static int
>> -sclp_vt220_write(struct tty_struct *tty, const unsigned char *buf, int count)
>> +sclp_vt220_write(struct tty_struct *tty, const u8 *buf, int count)
>>   {
>>   	return __sclp_vt220_write(buf, count, 1, 0, 1);
>>   }
> ...
> 
> In this and following patch it is only ::write() (and other) callbacks
> switched to u8, while the called internal functions stay with old types.
> 
> Do you plan to follow with part II etc, or it is archs/drivers that
> are expected to sort it out eventually?

Yes, I would say something like part V. would do the job -- at least 
that's my plan. Slowly propagating from the tty core to leafs (drivers).

> (I speak for s390, but the other affected archs are in the same boat I guess).


thanks,
-- 
js
suse labs

