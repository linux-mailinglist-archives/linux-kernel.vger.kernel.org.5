Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AFC7C7B9D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 04:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjJMCbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 22:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJMCa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 22:30:59 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04370CA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 19:30:58 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6bf58009a8dso1027241a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 19:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1697164257; x=1697769057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9AlSt/UmPpPe6qrtiCDOOfX5E4Znn3Anpv8O+XesUkY=;
        b=t7l4wyBl74o1MWNd5EGt92ncI1qSBLh26uNgNz1jZidkCSMm/hslP9MwX5JtVy4mCm
         /VbLbnXh0Yer4xJCUYbOMIVWwgdIW+KO3NqgWnNo1+qkCDUL0QG9zCKlpIzbNP6M0aly
         arss5MFB3ibA7cXi5Vv7e0u6gIi7jpMrMcG6IaGRi9ZxjlRXN2uVpDnpMBg6ZOZmICHy
         qQYRPSDJCRlhREyEKFZ33jMeRyzhzW1F6NSPK+ZwSub7/6PRTXzkT8HnrW78J2sph/Ro
         XpqM+ike6rlOx6F82fkyCWo8N8wCH3i8K073kr8cD8WRI6PJApWIG9rQTJClIV7AqPPB
         MJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697164257; x=1697769057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9AlSt/UmPpPe6qrtiCDOOfX5E4Znn3Anpv8O+XesUkY=;
        b=iuNEJzjGk3xRZ88aAUEGnw6iddGEPs0h/oRDvb4ll7L2L49F9l52smWUvvMB2UQ+u+
         rerDqgNo4UoItNr9z9B1vLTDvw4I8ozZeKJYKYFBZZOCcwHOsNEspCHLWEYoHrwPn2/1
         JQvQtuot+E5cBuBZYk0diKpDw0ljlsfMERLHpiGPjJvoMbij26eQjiOjS04qTcVgkuii
         u83Y1pDEjkFDGp/U0z4nBNRPcE0zAiIMN8MG8QLd3mXUuCyHVJzqmsNse6TJt/FreKP8
         g/n8tQj8soSdCHmQyTyx0l6ixPXxBMhXIBdlYcuUIxrsxAJe9X0O5SV++iPV30MT0NNe
         a5zA==
X-Gm-Message-State: AOJu0YxJeZ4Irq6lKR3mN/0KwoA2vVlpq9fTMLb8sOIDdmiX0SsRx3eL
        8mrv+FshBJ0U3aJu3q0Y/ril0Q==
X-Google-Smtp-Source: AGHT+IHH3S84jjyAAYr9ohOLASSdFKUdZmxPJl7BDa8RTAh3YuPi9ZQk+GpkCGTRwxLvo8btmJvx2g==
X-Received: by 2002:a05:6358:9691:b0:164:8742:525 with SMTP id o17-20020a056358969100b0016487420525mr21597307rwa.17.1697164257258;
        Thu, 12 Oct 2023 19:30:57 -0700 (PDT)
Received: from hermes.local (204-195-126-68.wavecable.com. [204.195.126.68])
        by smtp.gmail.com with ESMTPSA id u204-20020a6279d5000000b006b1e8f17b85sm379297pfc.201.2023.10.12.19.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 19:30:57 -0700 (PDT)
Date:   Thu, 12 Oct 2023 19:30:54 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v2 2/2] net: dsa: Rename IFLA_DSA_MASTER to
 IFLA_DSA_CONDUIT
Message-ID: <20231012193054.4c6759fe@hermes.local>
In-Reply-To: <20231012231345.3thxxxhe7pxs5bib@skbuf>
References: <20231011222026.4181654-1-florian.fainelli@broadcom.com>
        <20231011222026.4181654-3-florian.fainelli@broadcom.com>
        <20231011163003.32036b28@hermes.local>
        <20231012231345.3thxxxhe7pxs5bib@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023 02:13:45 +0300
Vladimir Oltean <olteanv@gmail.com> wrote:

> > I don't know if it would be acceptable in the kernel UAPI but what
> > we did in DPDK for similar situation to cause warning on use of deprecated value.
> > 
> > /**
> >  *  Macro to mark macros and defines scheduled for removal
> >  */
> > #if defined(RTE_CC_GCC) || defined(RTE_CC_CLANG)
> > #define RTE_PRAGMA(x)  _Pragma(#x)
> > #define RTE_PRAGMA_WARNING(w) RTE_PRAGMA(GCC warning #w)
> > #define RTE_DEPRECATED(x)  RTE_PRAGMA_WARNING(#x is deprecated)
> > #else
> > #define RTE_DEPRECATED(x)
> > #endif
> > 
> > ...
> > #define RTE_DEV_WHITELISTED \
> > 	RTE_DEPRECATED(RTE_DEV_WHITELISTED) RTE_DEV_ALLOWED
> > #define RTE_DEV_BLACKLISTED \
> > 	RTE_DEPRECATED(RTE_DEV_BLACKLISTED) RTE_DEV_BLOCKED  
> 
> What precedent exists in terms of intentionally breaking kernel headers?
> If none, would this create one?

It would cause warning, and most applications builds don't fail because of warning.
Kernel already has __diag_warn macro which is similar, but see no usages of it.
My comment was more of a "what if", probably not practical since it would just
fuel lots of angry user feedback.
