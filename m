Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B46F76E154
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjHCH0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjHCH02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:26:28 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9DDF0;
        Thu,  3 Aug 2023 00:26:27 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-317b31203c7so576008f8f.2;
        Thu, 03 Aug 2023 00:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691047586; x=1691652386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AHFtRO/tSkaErM6Xq8nCEYygVuvC01toiTz73dK/KQo=;
        b=dx73NiHvmOlcXcdtvv9VFtyb4W1AxhG4NfqtKHCM4cnGdkjbdf5V0WVuVZShmnf5OO
         A2nyiE8iZEGhwxkQvItBpfCEQoyB+lyuck9iItmE7gf96c9fBd80sEdUaoPeVY3nqkUw
         VCPQgmDu4nENB/2Oyp0TmIGvviSlfvLOAkg785ARatKCqA1EvwOt9YGD+JweKCy9FSA0
         FdYvYLURCKhn6TXZpQ7V2lEeI/jz84ULctN+YFdRIsKYGu18lApWC5CB+IEjRRPefNS3
         bVmMdvzsU3Cx3EcNWWK7xk/pJXj/WK6o7Con5UTlFdx4VZiec2X0GA6SXxhd/zxz4ZKB
         VDyA==
X-Gm-Message-State: ABy/qLarO00AAk88B2McxSS8ISt+fzNU9CvuLU8tRcK9C8TTuZgzPRgP
        rIaOPT/++/RlmslM5j+gH6El6ny9q39OlA==
X-Google-Smtp-Source: APBJJlHhhmbl1NaKxT9yKMbGCYxJtoEPG4Io1aEdNg0fSc/mcwTSG+rNw8qoCV07ihQlA5bjWGtbTA==
X-Received: by 2002:adf:ff87:0:b0:317:7062:32d2 with SMTP id j7-20020adfff87000000b00317706232d2mr6559021wrr.54.1691047585418;
        Thu, 03 Aug 2023 00:26:25 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id d10-20020a056000114a00b00317046f21f9sm20806853wrx.114.2023.08.03.00.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 00:26:24 -0700 (PDT)
Message-ID: <c70538cf-8b5e-b501-f69f-fc16369b03f7@kernel.org>
Date:   Thu, 3 Aug 2023 09:26:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v2 1/1] serial: core: Fix serial_base_match() after fixing
 controller port name
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
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
References: <20230803071034.25571-1-tony@atomide.com>
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230803071034.25571-1-tony@atomide.com>
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

On 03. 08. 23, 9:10, Tony Lindgren wrote:
> While fixing DEVNAME to be more usable, I broke serial_base_match() as the
> ctrl and port prefix for device names seemed unnecessary.
> 
> The prefixes are still needed by serial_base_match() to probe the serial
> base controller port, and serial tx is now broken.
> 
> Let's fix the issue by checking against dev->type and drv->name instead
> of the prefixes that are no longer in the DEVNAME.
> 
> Fixes: 1ef2c2df1199 ("serial: core: Fix serial core controller port name to show controller id")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202308021529.35b3ad6c-oliver.sang@intel.com
> Signed-off-by: Tony Lindgren <tony@atomide.com>

A lot better:

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>


-- 
js
suse labs

