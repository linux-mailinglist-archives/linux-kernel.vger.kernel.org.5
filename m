Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BAA758D11
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 07:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjGSF0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 01:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGSF0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 01:26:47 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3701BFF;
        Tue, 18 Jul 2023 22:26:44 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-992f15c36fcso885988666b.3;
        Tue, 18 Jul 2023 22:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689744403; x=1690349203;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FkqbYbjdTmfdmwbpTZcaS47hRrcpLSmcRO9/uedHGVk=;
        b=DpjtgJtqJQGMs42Bc+ZZ/0uDzcODRSKTGH1uzHKsKsfR3pRgBRTKDDS4VqUXEpSX3x
         EW3ZLbESLu29c1FlRrGw9zVNEbQpGUCw9btPJki/oOhU0gkl9KDkG5iHVafH2Vq2sZW8
         mMa3OAEsOSzQcitivGTA25l701QcZbF+DRwYLXwLyTALoDbFwKgg4bwMOK0Q4UdgcwgA
         7ra9/6gpcteLuNhPs1DiRWicQpjpIrhnyIf6SgfWFGI1pVuvtSISejtqeBwgYKNuXhC/
         Llw3B+LscyPXq7UTtfkSdoIw3SISgi9oUl7++EEbWVT549QA9roGBfUfndDWPftvLjn9
         y47A==
X-Gm-Message-State: ABy/qLZW8rIhBodi+EwE4cwJ3htjra9QmhrtmA1euwOanBDoG1KSqhzi
        c5Csmbbbl7qfuxKaPlQ4oCM=
X-Google-Smtp-Source: APBJJlGYTe913/o5gN5WIizy47yhpxnSmX4U7gZ4db3GLraXCbUSs2axkaTkxAeQmdoX5+v3Tq0pCQ==
X-Received: by 2002:a17:907:970c:b0:994:4ec3:147f with SMTP id jg12-20020a170907970c00b009944ec3147fmr1793215ejc.67.1689744403296;
        Tue, 18 Jul 2023 22:26:43 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id e21-20020a170906045500b0098cf565d98asm1795867eja.22.2023.07.18.22.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 22:26:42 -0700 (PDT)
Message-ID: <82c49602-8c6e-51c2-6f73-28fb9b458db8@kernel.org>
Date:   Wed, 19 Jul 2023 07:26:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] serial: core: Fix serial core port id to not use
 port->line
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230719051235.46396-1-tony@atomide.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230719051235.46396-1-tony@atomide.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 07. 23, 7:12, Tony Lindgren wrote:
> The serial core port id should be serial core controller specific port
> instance, which is not always the port->line index.
> 
> For example, 8250 driver maps a number of legacy ports, and when a
> hardware specific device driver takes over, we typically have one
> driver instance for each port. Let's instead add port->port_id to
> keep track serial ports mapped to each serial core controller instance.
> 
> Currently this is only a cosmetic issue for the serial core port device
> names. The issue can be noticed looking at /sys/bus/serial-base/devices
> for example though. Let's fix the issue to avoid port addressing issues
> later on.

...
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -460,6 +460,7 @@ struct uart_port {
>   	int			(*iso7816_config)(struct uart_port *,
>   						  struct serial_iso7816 *iso7816);
>   	int			ctrl_id;		/* optional serial core controller id */
> +	int			port_id;		/* optional serial core port id */

Can the id be negative? If not, please use uint.

thanks,
-- 
js
suse labs

