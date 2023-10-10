Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF107C4375
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 00:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjJJWGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 18:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjJJWGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 18:06:50 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E34398;
        Tue, 10 Oct 2023 15:06:48 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso1046618666b.0;
        Tue, 10 Oct 2023 15:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696975606; x=1697580406; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y/MtUEsTq6TBJZ5QdmQcvP3bfZZajTpabyqFCb9A1sU=;
        b=HGALKM1vPMzkKXk2UECPz5ZY0Dee4o/7GoE5McygB57oEz/gUHjH32TZ9YkkB48xqo
         GHYNg8VZok38z0keOe0OMRVX9VUGnpXOS9+Q8F0xu6EpPAfh29qV/fgJcDm5lbPtV7v0
         EJQVMZB3RCEPas5/3KYbd3hjcYvJfjej0YqJSGJ4zKXOeo/yL257LhaaG2YxOaZLUWJQ
         4QPdnG+0YaNUV/VKHkrwQfEBQRRxJbBXPrauzOmRh7FWHThCOJqySKhc4daiJWQo6XKq
         f3JMhxi5fJDTf7YiSLATYqFflEzDdxh2qJSGxmnunkTgBrcoU3EXlymLZtAhoAW0w1OD
         6ZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696975606; x=1697580406;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/MtUEsTq6TBJZ5QdmQcvP3bfZZajTpabyqFCb9A1sU=;
        b=BtzcIJcaXUmBdf3MIanBfq3753dW6pE2hmRydlcPAuSVgNbyW1hrU5/iMSF7jWqVY2
         W62ObEgSEv0Jn9CnuHdFZiRQjmibLB5Z87HdQqHM2E1S9PkSEEelfrdNHQ5VxSB/JNZf
         J/rKe4Q4tHo7JokzvQN694etXU/IAt3Dfq7fmepOazilhd7qmp31F6fYECkOvPPUp6AA
         taDd1zHhZflvFvfjl5YHbChHUlfSGP2oEp4UEJUEjRq0ZwysFytCz97E1rxTiixbGF5O
         7P2sAeau+fl9MvSLb/jFYPSSwXTy6M0uC3UXk/iZ7AFPmBiQ9PHGGNm7HN0FKC3fJ+cy
         g7ow==
X-Gm-Message-State: AOJu0Yx1GMeyIlB4m8CgDCRTonbnGRJSH1T2BaBkGeE52xe70p1E1BnS
        73PRH2hcYIMhrHsHHawEC5s=
X-Google-Smtp-Source: AGHT+IG03e1tNBYcqnFccNDQ828LInynPyQTUvGRc6mxVt8uzkdaj6sh8BpkA9p/SUWA68eWfHFLzg==
X-Received: by 2002:a17:906:1097:b0:9ad:be8a:a588 with SMTP id u23-20020a170906109700b009adbe8aa588mr16733832eju.1.1696975606309;
        Tue, 10 Oct 2023 15:06:46 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id y5-20020a17090629c500b0099bd453357esm8900882eje.41.2023.10.10.15.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 15:06:46 -0700 (PDT)
Date:   Wed, 11 Oct 2023 01:06:43 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: dsa: realtek: rtl8365mb: replace deprecated strncpy
 with ethtool_sprintf
Message-ID: <20231010220643.w5wmaftubiv7yo7t@skbuf>
References: <20231009-strncpy-drivers-net-dsa-realtek-rtl8365mb-c-v1-1-0537fe9fb08c@google.com>
 <20231010110717.cw5sqxm5mlzyi2rq@skbuf>
 <CAFhGd8pgGij4BXNzrB5fqk_2CNPDBTgf-3nN0i6cJak6vye_bA@mail.gmail.com>
 <CAFhGd8oriABD+Vob3pwXi3fQ7W3XOzp8a48mX_TYxJHDW+aBuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8oriABD+Vob3pwXi3fQ7W3XOzp8a48mX_TYxJHDW+aBuA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 02:48:07PM -0700, Justin Stitt wrote:
> On Tue, Oct 10, 2023 at 10:36 AM Justin Stitt <justinstitt@google.com> wrote:
> > > Is there any particular reason why you opted for the "%s" printf format
> > > specifier when you could have simply given mib->name as the single
> > > argument? This comment applies to all the ethtool_sprintf() patches
> > > you've submitted.
> >
> > Yeah, it causes a -Wformat-security warning for me. I briefly mentioned it
> > in one of my first patches like this [1].
> 
> For more context, here's some warnings in the wild:
> https://lore.kernel.org/netdev/20231003183603.3887546-3-jesse.brandeburg@intel.com/
> 
> >
> > [1]: https://lore.kernel.org/all/20231005-strncpy-drivers-net-dsa-lan9303-core-c-v2-1-feb452a532db@google.com/

Yeah, ok. It's a false positive warning, but I guess it would be too
hard for the compiler to figure that out.
