Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0CC7FAB99
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjK0Ubj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjK0UbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:31:24 -0500
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A95D1706
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 12:31:25 -0800 (PST)
Received: (wp-smtpd smtp.tlen.pl 29066 invoked from network); 27 Nov 2023 21:31:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1701117080; bh=AVLfSEKQHabLjQ2op4Bnsbc4bMus8YV3MiHTkOWOTvE=;
          h=Subject:To:Cc:From;
          b=U+iHv3Hd+CuZ2OKDVmzz+RgPnHjEqi2CladEWxSy3bln6TX+CIMBzlyEq/5AXSfvb
           0OJI8B/RtbP54v2PcX07GE4wSZxLJMZhwEFnkomcm2o+46bsy6mgTIdcF1DVPEXhDN
           OYWq5WcfH9vXlaKhKUBgJUgcMPCP68EI+rjxpagY=
Received: from aaez25.neoplus.adsl.tpnet.pl (HELO [192.168.1.22]) (mat.jonczyk@o2.pl@[83.4.129.25])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <mario.limonciello@amd.com>; 27 Nov 2023 21:31:20 +0100
Message-ID: <c179a0cb-1b98-4a4f-a3c6-cad7b980a337@o2.pl>
Date:   Mon, 27 Nov 2023 21:31:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] rtc: Add support for configuring the UIP timeout
 for RTC reads
Content-Language: en-GB
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, tobrohl@gmail.com, aalsing@gmail.com,
        Dhaval.Giani@amd.com, xmb8dsv4@gmail.com, x86@kernel.org,
        dhaval.giani@gmail.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
References: <20231127192553.9734-1-mario.limonciello@amd.com>
 <20231127192553.9734-4-mario.limonciello@amd.com>
From:   =?UTF-8?Q?Mateusz_Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Autocrypt: addr=mat.jonczyk@o2.pl; keydata=
 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
 TANkZ3QqXNX2
In-Reply-To: <20231127192553.9734-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 1a138dafb272c999ed76f246b5ecae23
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [sYMB]                               
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

W dniu 27.11.2023 o 20:25, Mario Limonciello pisze:
> The UIP timeout is hardcoded to 10ms for all RTC reads, but in some
> contexts this might not be enough time. Add a timeout parameter to
> mc146818_get_time() and mc146818_get_time_callback().
>
> If UIP timeout is configured by caller to be >=100 ms and a call
> takes this long, log a warning.
>
> Make all callers use 10ms to ensure no functional changes.
>
> Cc: stable@vger.kernel.org # 6.1.y
> Fixes: ec5895c0f2d8 ("rtc: mc146818-lib: extract mc146818_avoid_UIP")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2->v3:
>  * Logic adjustments
>  * Clarify warning message
> v1->v2:
>  * Add a warning if 100ms or more
>  * Add stable and fixes tags
[snip]
> diff --git a/drivers/rtc/rtc-mc146818-lib.c b/drivers/rtc/rtc-mc146818-lib.c
> index 43a28e82674e..ab077dde397b 100644
> --- a/drivers/rtc/rtc-mc146818-lib.c
> +++ b/drivers/rtc/rtc-mc146818-lib.c
> @@ -8,26 +8,31 @@
>  #include <linux/acpi.h>
>  #endif
>  
> +#define UIP_RECHECK_DELAY		100	/* usec */
> +#define UIP_RECHECK_DELAY_MS		(USEC_PER_MSEC / UIP_RECHECK_DELAY)
> +#define UIP_RECHECK_TIMEOUT_MS(x)	(x / UIP_RECHECK_DELAY_MS)
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
> +	for (i = 0; i < UIP_RECHECK_TIMEOUT_MS(timeout); i++) {

Sorry, this will not work. UIP_RECHECK_DELAY_MS is 10, so
UIP_RECHECK_TIMEOUT_MS(timeout) will be 1 for timeout=10. Should be

      for (i = 0; UIP_RECHECK_TIMEOUT_MS(i) < timeout; i++) {

With this, for i == 99, UIP_RECHECK_TIMEOUT_MS(i) = 9
for i == 100, UIP_RECHECK_TIMEOUT_MS(i) = 10 and the loop correctly terminates.

The macro should probably be renamed UIP_RECHECK_LOOPS_MS as it converts
loop count to ms.

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
> @@ -37,7 +42,7 @@ bool mc146818_avoid_UIP(void (*callback)(unsigned char seconds, void *param),
>  
>  		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP) {
>  			spin_unlock_irqrestore(&rtc_lock, flags);
> -			udelay(100);
> +			udelay(UIP_RECHECK_DELAY);
>  			continue;
>  		}
>  
> @@ -56,7 +61,7 @@ bool mc146818_avoid_UIP(void (*callback)(unsigned char seconds, void *param),
>  		 */
>  		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP) {
>  			spin_unlock_irqrestore(&rtc_lock, flags);
> -			udelay(100);
> +			udelay(UIP_RECHECK_DELAY);
>  			continue;
>  		}
>  
> @@ -72,6 +77,10 @@ bool mc146818_avoid_UIP(void (*callback)(unsigned char seconds, void *param),
>  		}
>  		spin_unlock_irqrestore(&rtc_lock, flags);
>  
> +		if (i >= UIP_RECHECK_TIMEOUT_MS(100))

Same, should be:

          if (UIP_RECHECK_TIMEOUT_MS(i) >= 100)

> +			pr_warn("Reading current time from RTC took around %d ms\n",
> +				UIP_RECHECK_TIMEOUT_MS(i));
> +
>  		return true;
>  	}
>  	return false;

[snip]

Greetings,

Mateusz


