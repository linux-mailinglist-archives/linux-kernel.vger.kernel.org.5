Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52397D5BDD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 21:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344300AbjJXTvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 15:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344313AbjJXTvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:51:45 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9305510DA;
        Tue, 24 Oct 2023 12:51:42 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53ebf429b4fso7614911a12.1;
        Tue, 24 Oct 2023 12:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698177100; x=1698781900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JUj/EbiokY8d7LdNm6RQo8caawEG1TrnDKw19EfO3ho=;
        b=llukYWrL4R7r9w+2Xqza6rAGAKkhf6q8uIi1+AhJx+BcfrmzQ4G6DMYeuQfS6IS/j3
         J4pXJMGvObhFLhf7Nh2m729/cSMQCXsfC7dHZ6WMSX0oUSRr+pPXdpEjDNf4vL0WJMz3
         f5LxzsYxlTI6T9BGupyAVdfJlxhZv+tXfnPkbOa67vjUh7IrS0vSfsXA/lPeh0LTgZo6
         zzTMQRK79nQjGs2aB8hXqe4rQ+LW42goyuXK6VqWIQSKVCCJAAUphdUwWyJt6FVGeRXo
         CcRqhOlqy2fJG0QcBhQF3oo565lhPdOgbfZ/zvKEHsLmZbJ3KHX3WJ+xT0RRkQnL2BIC
         +bUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698177100; x=1698781900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUj/EbiokY8d7LdNm6RQo8caawEG1TrnDKw19EfO3ho=;
        b=C0MFFXIWHFkUyNfDbRPYwO2qD1NpT6NQ6ecrD3Om0BIFeUxVvgOpdBmM6rjp0jBL54
         670sxRac8P59Lo7R1naUs3D/KJbEd2AtJLVAANLwrqkZnRlEV6N/xuZ/GOKe0iq/IWc1
         a5J5sOcaBYLi87mpLyHwjm0xbHnBgNti0lSrzu59pb3ILsPTua1KYC4wPi3dTjh0h/WX
         hqnhlCfc3UPR3hQ+FwPNrcHX4Luou2KfG2JVpFR5bzKERkssDfO6GCCFQmyI9HmDLOSP
         qXqXfehBZPNbv6SUGMQE45X0Ch3ARDAn88U+R/MotAxpPRlUEa0i0dWXlFzal3ZxTEii
         BhaQ==
X-Gm-Message-State: AOJu0Yxq79jiFLN8Ul2e8VTuKRTZu3ptQBlCs/HXT+pWUF57HmEbQpaO
        u+lWuuHan+HSohzz+rcnARc=
X-Google-Smtp-Source: AGHT+IG1BP5ROpvBcq82uPkVt2IykY39Qtb6MXydHhu5xMIX7B2RI0+qsY/OIOKtA3Sz56zxhshLhw==
X-Received: by 2002:a05:6402:5243:b0:530:e2e3:28af with SMTP id t3-20020a056402524300b00530e2e328afmr11299128edd.31.1698177100282;
        Tue, 24 Oct 2023 12:51:40 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id v30-20020a50a45e000000b0053da3a9847csm8563621edb.42.2023.10.24.12.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 12:51:40 -0700 (PDT)
Date:   Tue, 24 Oct 2023 22:51:37 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Enrico Mioso <mrkiko.rs@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7 5/7] ARM64: dts: marvell: Fix some common
 switch mistakes
Message-ID: <20231024195137.2fgustgmyl2r7cdt@skbuf>
References: <20231024-marvell-88e6152-wan-led-v7-0-2869347697d1@linaro.org>
 <20231024-marvell-88e6152-wan-led-v7-5-2869347697d1@linaro.org>
 <20231024182842.flxrg3hjm3scnhjo@skbuf>
 <ZTgVE8TzMEPvVeOr@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTgVE8TzMEPvVeOr@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 08:03:47PM +0100, Russell King (Oracle) wrote:
> On Tue, Oct 24, 2023 at 09:28:42PM +0300, Vladimir Oltean wrote:
> > U-Boot code does this, so you can't rename "ports":
> > 
> > 	/*
> > 	 * now if there are more switches or a SFP module coming after,
> > 	 * enable corresponding ports
> > 	 */
> > 	if (id < peridot + topaz - 1) {
> > 		res = fdt_status_okay_by_pathf(blob,
> > 					       "%s/switch%i@%x/ports/port@a",
> > 					       mdio_path, id, addr);
> > 	} else if (id == peridot - 1 && !topaz && sfp) {
> > 		res = fdt_status_okay_by_pathf(blob,
> > 					       "%s/switch%i@%x/ports/port-sfp@a",
> > 					       mdio_path, id, addr);
> > 	} else {
> > 		res = 0;
> > 	}
> 
> So that's now two platforms that do this. I think at this stage, we
> have to regard these node paths as an ABI that we just can't change
> without causing some breakage.

No, it's still the same as the one I pointed out on v4:
https://patchwork.kernel.org/project/netdevbpf/patch/20231018-marvell-88e6152-wan-led-v4-5-3ee0c67383be@linaro.org/

aka the Turris MOX. But it looks like my previous comment wasn't quite
clear, thus Linus' conversion still cleans up too much in this device
tree.

> If we can't fix up all platforms, doesn't that make the YAML
> conversion harder?

Well, I do see this as a valid concern that could potentially bite back,
yes. I did express that the schema should not emit warnings for
$nodename, but TBH I don't know how that constraint could be eliminated:
https://patchwork.kernel.org/project/netdevbpf/patch/20231018-marvell-88e6152-wan-led-v4-6-3ee0c67383be@linaro.org/

> You've asked me to test the Clearfog GT-8k change - which is something
> that won't happen for a while as I don't have the hardware to hand at
> my current location, nor remotely.
> 
> What I can do is poke about in the u-boot sources I have for that
> board and see# whether it's doing anything with those node paths. Off
> the top of my# head, given what the board is, I think it's highly
> unlikely though,# but I will check - possibly tomorrow.

Ok, if U-Boot is the only bootloader, I also looked through the upstream
board source files and only noticed any fixups for MOX. I don't know
what these boards ship with, and how far that is from mainline U-Boot.
