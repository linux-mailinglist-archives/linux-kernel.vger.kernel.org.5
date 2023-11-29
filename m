Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CB87FD117
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjK2Ij3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjK2IjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:39:15 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496A01BD1;
        Wed, 29 Nov 2023 00:39:08 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id 633F960514;
        Wed, 29 Nov 2023 08:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
        s=25mailst; t=1701247147;
        bh=4T2boRidFI8X28nZq5JoZ0Nop7HsXEFuU6HdeMnLYUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k9iCPhXf3wHSonjZls9kQPzVsqEbj1er44e00sKBvEUJo4lmUkLnF6fkTv7ipfyT2
         XLq2qZaeF0OvlE00LdoP4nHpeSBKCqRzQojG8loLErM6JyC2haeGWWhWCT56ZKWj1z
         KLzIdZ1FPlHc0ic+x8q7X2UgwS5xuE+rvgdQpCZPKkJKu8+yNp18nA4MsEKRcwcQQa
         RMQlZNobYSmF9TPKEUXvmweZ/eG3IC6P1SsT2xQ92+aTb4INPPKxnfqH5QKVN4Cqon
         81TSI/i9Yg+J3oWIN5EfnR4oLqggQuO/7IMejufJIq4yXZFTZH05sx54LCNvIHtoqQ
         AnDKOi2uRfSXw==
Date:   Wed, 29 Nov 2023 10:38:44 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH v4 2/2] Input: gpio-keys - Add system suspend support for
 dedicated wakeirqs
Message-ID: <20231129083844.GU5169@atomide.com>
References: <20231124083241.40780-1-tony@atomide.com>
 <20231124083241.40780-2-tony@atomide.com>
 <ZWF9F9JHKJ-SjUjp@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWF9F9JHKJ-SjUjp@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Dmitry Torokhov <dmitry.torokhov@gmail.com> [231125 04:50]:
> Hi Tony,
> 
> On Fri, Nov 24, 2023 at 10:32:41AM +0200, Tony Lindgren wrote:
> > +	/*
> > +	 * Wakeirq shares the handler with the main interrupt, it's only
> > +	 * active during system suspend. See gpio_keys_button_enable_wakeup()
> > +	 * and gpio_keys_button_disable_wakeup().
> > +	 */
> > +	error = devm_request_any_context_irq(dev, bdata->wakeirq, isr,
> > +					     irqflags, wakedesc, bdata);
> > +	if (error < 0) {
> > +		dev_err(dev, "Unable to claim wakeirq %d; error %d\n",
> > +			bdata->irq, error);
> > +		return error;
> > +	}
> > +
> > +	/*
> > +	 * Disable wakeirq until suspend. IRQF_NO_AUTOEN won't work if
> > +	 * IRQF_SHARED was set based on !button->can_disable.
> > +	 */
> > +	disable_irq_nosync(bdata->wakeirq);
> 
> Why _nosync() here and below? Is there any harm in sing the normal
> variant?

Well they are enabled the same time anyways for a while, so I see no
harm using the normal variant here. Will post updated patches after
some testing.

Regards,

Tony
