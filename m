Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C0F7F0245
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 20:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjKRTHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 14:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjKRTHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 14:07:12 -0500
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AEAD66
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 11:07:05 -0800 (PST)
Received: (wp-smtpd smtp.tlen.pl 29537 invoked from network); 18 Nov 2023 20:07:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1700334422; bh=ah97aCbN24GtUBFT8VSBvxF84jY96VzFBfOL/rbwUPw=;
          h=Subject:To:Cc:From;
          b=QIMdCusO1tTtUrw7L3tTLKOgB5VfiROd/ZmFSaxCo+kSCGyovbm8+BVYYg5ae7cyz
           zttG8pedzbbaQlkKNPJCW3+N/cWFo98RfdkHCJTc1rkZj0LOjh6UGdmpSfUgRUcIdd
           YFB+/oLZEHpi/kb4IAA4uMjOmXTw8UThtDtrX+3A=
Received: from aafl106.neoplus.adsl.tpnet.pl (HELO [192.168.1.22]) (mat.jonczyk@o2.pl@[83.4.141.106])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <mario.limonciello@amd.com>; 18 Nov 2023 20:07:02 +0100
Message-ID: <9a34ad89-6263-4cda-b938-348bdf62e155@o2.pl>
Date:   Sat, 18 Nov 2023 20:06:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] rtc: Add support for configuring the UIP timeout for
 RTC reads
Content-Language: en-GB
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, tobrohl@gmail.com, aalsing@gmail.com,
        Dhaval.Giani@amd.com, xmb8dsv4@gmail.com, x86@kernel.org
References: <20231117063220.65093-1-mario.limonciello@amd.com>
 <20231117063220.65093-4-mario.limonciello@amd.com>
From:   =?UTF-8?Q?Mateusz_Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Autocrypt: addr=mat.jonczyk@o2.pl; keydata=
 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
 TANkZ3QqXNX2
In-Reply-To: <20231117063220.65093-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 7ac0a0c6de035ddcdf3814c62d506835
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [waP0]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

W dniu 17.11.2023 o 07:32, Mario Limonciello pisze:
> The UIP timeout is hardcoded to 10ms for all RTC reads, but in some
> contexts this might not be enough time. Add a timeout parameter to
> mc146818_get_time() and mc146818_get_time_callback().
> Make all callers use 10ms to ensure no functional changes.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Fixes: ec5895c0f2d8 ("rtc: mc146818-lib: extract mc146818_avoid_UIP")

If you would like to Cc: stable this patch,

commit d2a632a8a117 ("rtc: mc146818-lib: reduce RTC_UIP polling period")

is a prerequisite.

> ---
>  arch/alpha/kernel/rtc.c        |  2 +-
>  arch/x86/kernel/hpet.c         |  2 +-
>  arch/x86/kernel/rtc.c          |  2 +-
>  drivers/base/power/trace.c     |  2 +-
>  drivers/rtc/rtc-cmos.c         |  6 +++---
>  drivers/rtc/rtc-mc146818-lib.c | 31 +++++++++++++++++++++++--------
>  include/linux/mc146818rtc.h    |  3 ++-
>  7 files changed, 32 insertions(+), 16 deletions(-)
>
[snip]
> --- a/drivers/rtc/rtc-mc146818-lib.c
> +++ b/drivers/rtc/rtc-mc146818-lib.c
> @@ -8,26 +8,29 @@
>  #include <linux/acpi.h>
>  #endif
>  
> +#define UIP_RECHECK_DELAY		100	/* usec */
> +
>  /*
>   * Execute a function while the UIP (Update-in-progress) bit of the RTC is
> - * unset.
> + * unset. The timeout is configurable by the caller in ms.
>   *
>   * Warning: callback may be executed more then once.
>   */
>  bool mc146818_avoid_UIP(void (*callback)(unsigned char seconds, void *param),
> +			int timeout,
>  			void *param)
>  {
>  	int i;
>  	unsigned long flags;
>  	unsigned char seconds;
>  
> -	for (i = 0; i < 100; i++) {
> +	for (i = 0; i < USEC_PER_MSEC / UIP_RECHECK_DELAY * timeout; i++) {
>  		spin_lock_irqsave(&rtc_lock, flags);
>  
>  		/*
>  		 * Check whether there is an update in progress during which the
>  		 * readout is unspecified. The maximum update time is ~2ms. Poll
> -		 * every 100 usec for completion.
> +		 * for completion.
>  		 *
>  		 * Store the second value before checking UIP so a long lasting
>  		 * NMI which happens to hit after the UIP check cannot make
> @@ -37,7 +40,7 @@ bool mc146818_avoid_UIP(void (*callback)(unsigned char seconds, void *param),
>  
>  		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP) {
>  			spin_unlock_irqrestore(&rtc_lock, flags);
> -			udelay(100);
> +			udelay(UIP_RECHECK_DELAY);
>  			continue;
>  		}
>  
> @@ -56,7 +59,7 @@ bool mc146818_avoid_UIP(void (*callback)(unsigned char seconds, void *param),
>  		 */
>  		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP) {
>  			spin_unlock_irqrestore(&rtc_lock, flags);
> -			udelay(100);
> +			udelay(UIP_RECHECK_DELAY);
>  			continue;
>  		}
>  

I think that when reading the RTC is not finished in 100ms or so
(irrespective of the timeout parameter), the code should log
a warning / an error message.

Greetings,

Mateusz

