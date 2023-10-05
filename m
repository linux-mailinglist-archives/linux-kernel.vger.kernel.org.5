Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12AD7B9987
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 03:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244301AbjJEBR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 21:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244241AbjJEBR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 21:17:57 -0400
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA469C6;
        Wed,  4 Oct 2023 18:17:54 -0700 (PDT)
Received: from [192.168.68.112] (ppp118-210-84-62.adl-adc-lon-bras32.tpg.internode.on.net [118.210.84.62])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8B8D1200DB;
        Thu,  5 Oct 2023 09:17:51 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1696468672;
        bh=WN/ilaCxe3QgMddZZjU7PId19PdgcBpr/ZP9C7Gmuag=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=m9x/vKg/TE3TAGrcLxTojNzClrEkgYnOEY5+tf8xe76QiqAhHIeMjif1oQec6sjbL
         CcLutjUOP4/x2v5wDlX6JEfJ8iO3sFLOS+VVSRT6IbtsC7d0lI8rBShKgChEaGp4k8
         N3/L7kqwcY4VqvrStpYmNLwcR67dHYh8kYnUUdneo9S0IU8nVRq5DqlDqR5qX+Q08M
         Vi/4W18RcVM5VsxUv/BTFv4ASfhE6ZP5krKuY8Zcoon8WFB7dosKCDDrN3CsB30B8c
         YI4QZmkNccNHGsOr4AueM848o8vtRNwvshBjzznt2Ei/8qA/6n8pIaB4gyUDLjlixk
         j/cExR+TeHnNg==
Message-ID: <e5f0a67e05cf477bdb4ec6efd9c554f4aaa2cf8b.camel@codeconstruct.com.au>
Subject: Re: [PATCH] pinctrl: aspeed: Allow changing hardware strap defaults
From:   Andrew Jeffery <andrew@codeconstruct.com.au>
To:     Zev Weiss <zev@bewilderbeest.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org
Cc:     openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 05 Oct 2023 11:47:50 +1030
In-Reply-To: <20231004071605.21323-2-zev@bewilderbeest.net>
References: <20231004071605.21323-2-zev@bewilderbeest.net>
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

On Wed, 2023-10-04 at 00:16 -0700, Zev Weiss wrote:
> Previously we've generally assumed that the defaults in the hardware
> strapping register are in fact appropriate for the system and thus
> have avoided making any changes to its contents (with the exception of
> the bits controlling the GPIO passthrough feature).
>=20
> Unfortunately, on some platforms corrections from software are
> required as the hardware strapping is simply incorrect for the system
> (such as the SPI1 interface being configured for passthrough mode when
> master mode is in fact the only useful configuration for it).  We thus
> remove the checks preventing changes to the strap register so that the
> pinctrl subsystem can be used for such corrections.

So the strapping for the SPI1 configuration seems to be prone to
(copy/paste?) mistakes. Is there evidence that motivates dropping all
the protection instead of poking a hole for SPI1 like we did for the
passthrough GPIOs?

I'm still a little attached to the policy that software should be
beholden to the strapping, and to try to mitigate software mistakes
given the smattering of bits required to drive the Aspeed pinmux.

Andrew

