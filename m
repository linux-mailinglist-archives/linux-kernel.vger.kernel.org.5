Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F137E9722
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 08:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjKMHuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 02:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjKMHuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 02:50:21 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BEE10D1;
        Sun, 12 Nov 2023 23:50:17 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 88D901C0007;
        Mon, 13 Nov 2023 07:50:14 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.96)
        (envelope-from <peter@korsgaard.com>)
        id 1r2Ri1-00B27Y-2l;
        Mon, 13 Nov 2023 08:50:13 +0100
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Andi Shyti <andi.shyti@kernel.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: ocores: Move system PM hooks to the NOIRQ phase
References: <20231113023249.1185682-1-samuel.holland@sifive.com>
Date:   Mon, 13 Nov 2023 08:50:13 +0100
In-Reply-To: <20231113023249.1185682-1-samuel.holland@sifive.com> (Samuel
        Holland's message of "Sun, 12 Nov 2023 18:32:45 -0800")
Message-ID: <87r0kuf5xm.fsf@48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: peter@korsgaard.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Samuel" == Samuel Holland <samuel.holland@sifive.com> writes:

 > When an I2C device contains a wake IRQ subordinate to a regmap-irq chip,
 > the regmap-irq code must be able to perform I2C transactions during
 > suspend_device_irqs() and resume_device_irqs(). Therefore, the bus must
 > be suspended/resumed during the NOIRQ phase.

 > Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Acked-by: Peter Korsgaard <peter@korsgaard.com>

> ---

 > Changes in v2:
 >  - Rebase on v6.7-rc1

 >  drivers/i2c/busses/i2c-ocores.c | 4 ++--
 >  1 file changed, 2 insertions(+), 2 deletions(-)

 > diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
 > index 041a76f71a49..e106af83cef4 100644
 > --- a/drivers/i2c/busses/i2c-ocores.c
 > +++ b/drivers/i2c/busses/i2c-ocores.c
 > @@ -771,8 +771,8 @@ static int ocores_i2c_resume(struct device *dev)
 >  	return ocores_init(dev, i2c);
 >  }
 
 > -static DEFINE_SIMPLE_DEV_PM_OPS(ocores_i2c_pm,
 > -				ocores_i2c_suspend, ocores_i2c_resume);
 > +static DEFINE_NOIRQ_DEV_PM_OPS(ocores_i2c_pm,
 > +			       ocores_i2c_suspend, ocores_i2c_resume);
 
 >  static struct platform_driver ocores_i2c_driver = {
 >  	.probe   = ocores_i2c_probe,
 > -- 

 > 2.42.0


-- 
Bye, Peter Korsgaard
