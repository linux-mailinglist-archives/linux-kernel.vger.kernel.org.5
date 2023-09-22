Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F88F7AA7BB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 06:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjIVE01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 00:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjIVE00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 00:26:26 -0400
X-Greylist: delayed 554 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Sep 2023 21:26:18 PDT
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C56F1;
        Thu, 21 Sep 2023 21:26:18 -0700 (PDT)
Received: from [192.168.68.112] (ppp14-2-88-115.adl-apt-pir-bras31.tpg.internode.on.net [14.2.88.115])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 12076201B9;
        Fri, 22 Sep 2023 12:16:51 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1695356217;
        bh=Qb0gRj6pnqlTclpvVQaaCBr09PUiG9zueH5w8ndfnhk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Hg/jnYstvcPUnQYL7gXd43PHO+Cy5vuOCBxTd3C/au0t02Z1QLZB+yiTYoG2IkuU4
         9JIDRFmpJFTDDJbnKB0iO9xFWyWSq2WHirAma7WtkuA+6Io3MT/IbRHkmuvyvxScR8
         RO4T/44rfsOv7adGIcwkYeFZmfdGTSn2rUJxOW4AfDTlVOuqIkS8/AGFFaahnfUUb9
         /gyrPVeacfZahfQjrvco1R1ztvzSD/4kyBAmsl+mm2+rCoeRnFn+8oTiRoGR0uCI6C
         7gD5p0XannjiyPhnwVJCE0TLzPQ2GT466QgZZRhzuyo5WTV31Z5g8RZc7inBxDDLJ9
         H7/7om750V2PQ==
Message-ID: <91be26169ebbddf3c05cd19626478246cb72a72a.camel@codeconstruct.com.au>
Subject: Re: [PATCH] watchdog: aspeed: Add sysfs attributes for reset mask
 bits
From:   Andrew Jeffery <andrew@codeconstruct.com.au>
To:     Zev Weiss <zev@bewilderbeest.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-watchdog@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org,
        Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Eddie James <eajames@linux.ibm.com>,
        Ivan Mikhaylov <i.mikhaylov@yadro.com>
Date:   Fri, 22 Sep 2023 13:46:50 +0930
In-Reply-To: <20230922013542.29136-2-zev@bewilderbeest.net>
References: <20230922013542.29136-2-zev@bewilderbeest.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-21 at 18:35 -0700, Zev Weiss wrote:
> The AST2500 and AST2600 watchdog timers provide the ability to control
> which devices are reset by the watchdog timer via a reset mask
> resgister.  Previously the driver ignored that register, leaving
> whatever configuration it found at boot and offering no way of
> altering its settings.  Add a 'reset_ctrl' sysfs subdirectory with a
> file per bit so that userspace can determine which devices the reset
> is applied to.
>=20
> Note that not all bits in the hardware register are exposed -- in
> particular, the ARM CPU and SOC/misc reset bits are left hidden since
> clearing them can render the system unable to reboot.
>=20
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>=20
> I'm porting OpenBMC to a platform that requires that the LPC controller r=
emain
> un-reset by a BMC reboot.  With this patch userspace can control the rese=
t
> mask of the Aspeed watchdog timer, with a few bits remaining unexposed so=
 as
> to prevent some almost-certainly undesirable situations.  If there are ot=
her
> bits that people feel shouldn't be exposed (or conversely if someone feel=
s
> strongly that the "dangerous" bits _should_ be exposed) I can adjust
> accordingly.


Is there a reason this has to be managed by userspace? It sounds a lot
like a property of platform design, in which case exposing this feature
in the devicetree might be a better approach.

Andrew
