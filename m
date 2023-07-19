Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F11758D3F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 07:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjGSFiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 01:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjGSFhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 01:37:54 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865FFD2;
        Tue, 18 Jul 2023 22:37:53 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-992e22c09edso781120466b.2;
        Tue, 18 Jul 2023 22:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689745072; x=1690349872;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9f4CtJoJCzX/x40TI8zAL93yQmPRNTXehruGHLa0bwE=;
        b=dC/zDMlOuJXBONGUNnyEOvSoIxJFD/QFbH3cyH5Guohmly00wPfLdqNzwKB7aPcDsJ
         YXWtJrY4ICCpxCQbRR6z+gFaQCsGOqqE7M93QNyEMiEPxE5t7xscorUhX7Yt+GP2Xk9A
         hihjPuvFaFriIoMlUZVgKQkOzSNHd6nxBqKySe/BAgKWWVNUgBk73yoPajRz3LPuuWuK
         Qkaz7WQ+qrPY1fyYi4R7GUsd66R8Ls+xmvJxtH/Oqwk/8gXKDuQNL4i/ipzxKN3ipr51
         rHREum2gZNpzZbgxv9ZcCeKZoY9l775RtYkcDLkr5EWx54dMksGyGRjHmnvVj3RzNfpN
         NQ+A==
X-Gm-Message-State: ABy/qLajO0gmLbOjHDT3tJS7hGyP3VdclLSa8MDmX/yfEAOXgiQodxdB
        h4IsBVxL2l2cbbC+01oV47o=
X-Google-Smtp-Source: APBJJlHjHmGjveajp957Xi6M4qn/qDToGaC3nC3NG127oh1EcHDUUTVw25aGsswtp1jorP095HJ85A==
X-Received: by 2002:a17:906:6499:b0:993:f081:2c5a with SMTP id e25-20020a170906649900b00993f0812c5amr1739629ejm.5.1689745071866;
        Tue, 18 Jul 2023 22:37:51 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id ks20-20020a170906f85400b009929c09abdfsm1853705ejb.70.2023.07.18.22.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 22:37:51 -0700 (PDT)
Message-ID: <c5e71fa4-ad39-f958-4eca-887f60544f54@kernel.org>
Date:   Wed, 19 Jul 2023 07:37:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] serial: core: Fix serial core port id to not use
 port->line
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230719051235.46396-1-tony@atomide.com>
 <82c49602-8c6e-51c2-6f73-28fb9b458db8@kernel.org>
 <ZLd154hdaSG2lnue@smile.fi.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <ZLd154hdaSG2lnue@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 07. 23, 7:34, Andy Shevchenko wrote:
> On Wed, Jul 19, 2023 at 07:26:41AM +0200, Jiri Slaby wrote:
>> On 19. 07. 23, 7:12, Tony Lindgren wrote:
> 
> ...
> 
>>>    	int			ctrl_id;		/* optional serial core controller id */
>>> +	int			port_id;		/* optional serial core port id */
>>
>> Can the id be negative? If not, please use uint.
> 
> Does this suggestion apply to ctrl_id as well?

Sure, but he hasn't added it in this series ;). So it should go to 
someone's todo :P.

-- 
js
suse labs

