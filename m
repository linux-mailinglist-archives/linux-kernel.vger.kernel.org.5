Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BDA80742A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379456AbjLFP6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379445AbjLFP6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:58:16 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F01C112;
        Wed,  6 Dec 2023 07:58:22 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a1ceae92ab6so137585566b.0;
        Wed, 06 Dec 2023 07:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701878301; x=1702483101; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rQIFe2zeaw4/tiB/WH3ULeCXQ+CV2IFd2F5SNho/m1w=;
        b=Z8R6G4dVjOG+y8gLgCUO9RJgrrCg7q1TUoWwF44EPkGx6cd+YwtAt4ioWu7dHeDfCR
         SgDe7IFUC6auzMUcq4nlxFdPVQShX7CqW8Uk52eiY2ur2gNnadB4+iauq/QNcRBVikC7
         +DfTAxsXfruW1yFixZj6QBXN6j9HeJ9asHWd2dgnkY0XCjxYhjOcVukseuQAsn5moXBH
         3xnTDIRZQPjc7n/HUWory9CSEOvMtAqZ/L/AuskUrMonrh2bIHYRClHTfxhHIdBuI1c9
         910Hn+3j2GB+Xnii6TSamL0DZ6lSJ+JvvEe9WhPXd/btQvKelRxf3c/ZePxQPuQCT4r9
         YBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701878301; x=1702483101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQIFe2zeaw4/tiB/WH3ULeCXQ+CV2IFd2F5SNho/m1w=;
        b=LIq2e+pIt0CfuxOTlzEJy1Cg48JduMfoqTVkVzDgahnMYN8QB7ifmzOPi5yMUVOguQ
         LMFEUQ+cHfgi8HDYkhYCgfZG7mD8aEPyHHvAOFWIvwFvfcPanEPm8o4r4POf/w5Wbza1
         JIAL5wQCrvwGdc+5xoOafRyVTniRsyaQYQzhEa5zr7nrLdisL05FkyMFPkiiw75IKjYt
         I2kcC0uybpOHVmwdHqOby/Z36e0+nHj9vhiNGpYOjctPZbUkDthylRQtSbvfR8eG1N+/
         2ExrWWD/G1yro5mOpufiR+UyC+4FsqkwuKr/Lxb9UYPfYEijRyiwukrAX0S8k9ZUFaO4
         qQCA==
X-Gm-Message-State: AOJu0Yw9rBYNLpSmG3V2KBvB4EBoGl/Nt1SWZdRmz/czX91kjTop9Ejw
        bTYw7Bnym8lCQoAp8Vtr6Co=
X-Google-Smtp-Source: AGHT+IGJh9qAYPIpNL8sJLfcvEyhlcogPDSic4zQQiDf6bo6WhzWS5zS6hjkrP5D6hAjCKlCx9DEsA==
X-Received: by 2002:a17:906:279b:b0:a18:d0d5:baba with SMTP id j27-20020a170906279b00b00a18d0d5babamr697522ejc.24.1701878300665;
        Wed, 06 Dec 2023 07:58:20 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id g17-20020a1709062db100b00a1d1b8a088esm97534eji.92.2023.12.06.07.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 07:58:20 -0800 (PST)
Date:   Wed, 6 Dec 2023 17:58:18 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Arun.Ramadoss@microchip.com, Woojung.Huh@microchip.com,
        UNGLinuxDriver@microchip.com, andrew@lunn.ch, f.fainelli@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: microchip: use DSA_TAG_PROTO without
 _VALUE define
Message-ID: <20231206155818.p5ll7au2mwqipvf3@skbuf>
References: <20231206072442.1628505-1-sean@geanix.com>
 <DM5PR11MB0076D755B7492A38337A6A7DEF84A@DM5PR11MB0076.namprd11.prod.outlook.com>
 <B0DA4901-0C2F-4D4D-966F-BF89C67219DD@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B0DA4901-0C2F-4D4D-966F-BF89C67219DD@geanix.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 10:00:52AM +0100, Sean Nyekjaer wrote:
> Hi Arun,
> 
> > On 6 Dec 2023, at 09.58, <Arun.Ramadoss@microchip.com> <Arun.Ramadoss@microchip.com> wrote:
> > 
> > Hi Sean,
> > 
> >> -----Original Message-----
> >> Correct the use of define DSA_TAG_PROTO_LAN937X_VALUE to
> >> DSA_TAG_PROTO_LAN937X to improve readability.
> >> 
> >> Fixes: 99b16df0cd52 ("net: dsa: microchip: lan937x: add dsa_tag_protocol")
> >> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > 
> > Not sure, whether it is a bug fix or not. Since it only improves readability.
> > I believe it should point to net-next. 
> > 
> 
> Agree :)
> 
> Feel free to remove the Fixes tag while applying.
> 
> /Sean

If you're talking to Arun: he can't do that. Only Jakub, David, Paolo
and Eric can apply patches, and based on history, I don't think that
either of them is keen on editing patches before applying. One way or
another, based on past experience, you might be better off just resending,
with the Fixes tag dropped, and patch retargeted to net-next (and
counter incremented to v2).

The criteria from Documentation/process/stable-kernel-rules.rst still
apply pretty much to net.git as well, since these patches land in stable
trees too. We triage as much as possible, to give users of stable
kernels a worthwhile reason to update, not a change that results in
absolutely the same generated machine code.
