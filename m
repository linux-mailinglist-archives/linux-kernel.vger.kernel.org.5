Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9888180E85D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjLLJ7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjLLJ7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:59:13 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9955A6;
        Tue, 12 Dec 2023 01:59:18 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 89DD2FF803;
        Tue, 12 Dec 2023 09:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702375156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q0/3Sh2eETJdeZKVLmp2oI+wYLwADP2lZuTfmz4YhfQ=;
        b=Rk79/zp7ossMcvHhiqp98keiVcv2gf1k87JOuYi/QLilq8f6xx+Gh19mWu7nDU4GeYpq5Q
        lRAq+xxqZKFZMqfm3v4apQZT8Eo9qLKTSvd08PZJt9pgPyMHVvNPn3vGh/gy+jkcjjZu5r
        wCvV60IHuTJoUZ/9pXNbrDOHs/6pqvz4+6vJDPlffMiVNhwS5sKlSDDoJbM/82dbwdegCM
        e/wzYFgh3Eyy3Q4vUTWXVi+n7g+kWD2I4tihNRFoZePsrg5xf0CTlntvsMEHd0sUIf5F+a
        GeETxE6cLFojuL7k1GfrfDLArZPz425zbHBa/uR6Zj/b3legUK3tmLo+C1qbLA==
Date:   Tue, 12 Dec 2023 10:59:14 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 0/5] Add support for framer infrastructure and PEF2256
 framer
Message-ID: <20231212105914.7eeb092b@bootlin.com>
In-Reply-To: <CACRpkdbrH-WWVrVWx6MvReUuUW8tU_J8Mb7nW3G8fJGAoiS38g@mail.gmail.com>
References: <20231128132534.258459-1-herve.codina@bootlin.com>
        <17b2f126-f6a4-431c-9e72-56a9c2932a88@sirena.org.uk>
        <CACRpkda5VMuXccwSBd-DBkM4W7A1E+UfZwBxWqtqxZzKjrqY4A@mail.gmail.com>
        <511c83d1-d77f-4ac0-927e-91070787bc34@sirena.org.uk>
        <CACRpkdYmN4318b1wXwUOeFjPN0S2w8M9FpXHOs3LtFa+XoTxVw@mail.gmail.com>
        <20231128173110.0ccb8f53@kernel.org>
        <CACRpkdbrH-WWVrVWx6MvReUuUW8tU_J8Mb7nW3G8fJGAoiS38g@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Wed, 29 Nov 2023 15:00:40 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Wed, Nov 29, 2023 at 2:31 AM Jakub Kicinski <kuba@kernel.org> wrote:
> > On Tue, 28 Nov 2023 15:51:01 +0100 Linus Walleij wrote:  
> > > > > I thought this thing would be merged primarily into the networking
> > > > > tree, and I don't know if they do signed tags, I usually create an
> > > > > immutable branch but that should work just as fine I guess.  
> > > >
> > > > Right, I'd expect a signed tag on the immutable branch - it's generally
> > > > helpful to avoid confusion about the branch actually being immutable.  
> > >
> > > Makes sense, best to create that in the netdev tree if possible
> > > I guess.  
> >
> > I think you offered creating the branch / tag in an earlier reply,
> > that's less work for me so yes please! :)  
> 
> OK I fix!
> 
> Just waiting for some final reviews to trickle in.
> 
> Herve: nag me if it doesn't happen in time!

As you tell me, this is my reminder.

Best regards,
Hervé

> 
> > FWIW I usually put the branches / tags in my personal k.org tree.
> > I don't wanna pollute the trees for the $many people who fetch
> > netdev with random tags.  
> 
> Aha yeah pin control is relatively small so I just carry misc sync
> tags there.
> 
> Yours,
> Linus Walleij
