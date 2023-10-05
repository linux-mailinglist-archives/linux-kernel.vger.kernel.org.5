Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A908F7B99EC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 04:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbjJEC1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 22:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbjJEC1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 22:27:43 -0400
X-Greylist: delayed 69056 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Oct 2023 19:27:40 PDT
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4274BBF;
        Wed,  4 Oct 2023 19:27:40 -0700 (PDT)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:7e5d:5300::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id D9693224;
        Wed,  4 Oct 2023 19:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1696472860;
        bh=k9dGTvabPa4GHbKIwp8xZ0TDgZ+c9lWcoPsXISUj8rA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L1KlwZ52gZzhy2d3kHVfD1Q7MkBdDApGOs7f6Eo1djfLQHkejGftyk4aDockPrk89
         V1c6wwzaWJMZHoMq+tC1CYW5lOmhsDqfwqdfqQ+YjhVn/h8ejsAMn8fXRlwUldqvlk
         mVWzAUBgGn6rCjEtYjl7zGMmpmmypNAJOhqQMyK4=
Date:   Wed, 4 Oct 2023 19:27:38 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Andrew Jeffery <andrew@codeconstruct.com.au>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: aspeed: Allow changing hardware strap defaults
Message-ID: <f9b5694a-5859-4999-bb2d-0e6a79b35c95@hatter.bewilderbeest.net>
References: <20231004071605.21323-2-zev@bewilderbeest.net>
 <e5f0a67e05cf477bdb4ec6efd9c554f4aaa2cf8b.camel@codeconstruct.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e5f0a67e05cf477bdb4ec6efd9c554f4aaa2cf8b.camel@codeconstruct.com.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 06:17:50PM PDT, Andrew Jeffery wrote:
>On Wed, 2023-10-04 at 00:16 -0700, Zev Weiss wrote:
>> Previously we've generally assumed that the defaults in the hardware
>> strapping register are in fact appropriate for the system and thus
>> have avoided making any changes to its contents (with the exception of
>> the bits controlling the GPIO passthrough feature).
>>
>> Unfortunately, on some platforms corrections from software are
>> required as the hardware strapping is simply incorrect for the system
>> (such as the SPI1 interface being configured for passthrough mode when
>> master mode is in fact the only useful configuration for it).  We thus
>> remove the checks preventing changes to the strap register so that the
>> pinctrl subsystem can be used for such corrections.
>
>So the strapping for the SPI1 configuration seems to be prone to
>(copy/paste?) mistakes. Is there evidence that motivates dropping all
>the protection instead of poking a hole for SPI1 like we did for the
>passthrough GPIOs?
>
>I'm still a little attached to the policy that software should be
>beholden to the strapping, and to try to mitigate software mistakes
>given the smattering of bits required to drive the Aspeed pinmux.
>

I have no idea what else might be lurking out there so I took a broader 
(perhaps overly heavy-handed) approach, but the SPI1 mode bits are the 
only ones I've personally encountered being strapped wrong, so sure, I'd 
be fine with just extending the "hole-punch" a bit to add those bits.  
I'll send a v2 doing that shortly.


Thanks,
Zev

