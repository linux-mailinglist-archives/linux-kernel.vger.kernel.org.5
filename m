Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE1E79D52C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjILPmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjILPmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:42:13 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846DE10DE;
        Tue, 12 Sep 2023 08:42:09 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-401bbfc05fcso63864235e9.3;
        Tue, 12 Sep 2023 08:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694533328; x=1695138128; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/Jg3m+l3nv9mAWoSPMXyNeTwQN5jCAeTIcsjB6I5Pck=;
        b=nzxxPFgmWjz35pMQvdo4qwF0o7l1v6GKKErvZsQFIVoOHm+fpClhoxEgNgTdicGKB8
         v0mDzMmPsmLb+HiTi0EkSSBfxrs+mBUQBX5ef7H+tcEXDqFLbVCdxHwto60xkXG2VGyp
         s9Y12RW1a1jkCuaeQxVI1Sq9ElVg0SuR9s1grewe72DngR6Jex9wyqF+2D72QqJFWImI
         7caBrQJ9Cbs/SijD5UQx7S0Pl9DiZVwtDsVhT6XUodCAIWHsJgb4musd/6BKcWqhCg1D
         nAro8pPoRcqVqVRSvjwbw/QSijuAZow2SSIkqNspk0dN7W8Cm2lRTB79BTubJhx3uqNi
         wm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694533328; x=1695138128;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Jg3m+l3nv9mAWoSPMXyNeTwQN5jCAeTIcsjB6I5Pck=;
        b=L2NFcYBFELYOm7APOgKjHexuNR3gHdDDRf8vP/0pe1XQ2TE+f/br8Pgw1rzAQguVvv
         X/RSgtSt9aVLJhDZfkEao2ZeeBOXqsApEk2MMkiKombvmaObrDg6ymiNqz5vMrMhTusr
         mohljAZ1x0lfazUHAlFrV/m9gMZXFH541bVOFG33jQfatpV6G7q3vigHV9XrPeO7d4JU
         zHv1a1OPqcBS/YiKWaPVt3rMhGXeufGaBxmvI170BAb4NL0zTyF8oIBojeHZcs/rXpLA
         VWu5mCk4ktxBwWvPq9jR8IE/DBa6V+OsIS9s2agVZ0D6epemsH7ElhhlqV8UaqTdPvmS
         EFqA==
X-Gm-Message-State: AOJu0Ywyo9XX6HgerNZSZpP4Fm+5Gkkm3dLb+TZB8rW5AhMYyzqJRH6Y
        v7lA+hg+0L6uoP+WdjbnlPM=
X-Google-Smtp-Source: AGHT+IG4OaWWbodV2V25GNsBTDg9QvInfQ/gyrMSZBW1KRZJg8QRHdc8G+AcywfYyJ4UduxuLUUWQw==
X-Received: by 2002:a05:6000:10c:b0:318:f7a:e3c8 with SMTP id o12-20020a056000010c00b003180f7ae3c8mr9730024wrx.57.1694533327618;
        Tue, 12 Sep 2023 08:42:07 -0700 (PDT)
Received: from skbuf ([188.25.254.186])
        by smtp.gmail.com with ESMTPSA id a5-20020aa7cf05000000b0052576969ef8sm6058701edy.14.2023.09.12.08.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 08:42:07 -0700 (PDT)
Date:   Tue, 12 Sep 2023 18:42:04 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     =?utf-8?B?UGF3ZcWC?= Dembicki <paweldembicki@gmail.com>
Cc:     netdev@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/8] net: dsa: vsc73xx: add
 port_stp_state_set function
Message-ID: <20230912154204.633wv564dih3p6we@skbuf>
References: <20230912122201.3752918-1-paweldembicki@gmail.com>
 <20230912122201.3752918-5-paweldembicki@gmail.com>
 <20230912144802.czdpb6hpn2yiewvf@skbuf>
 <CAJN1Kkyn4V2FNVdZZMWHTSqP+=5bKacKSEpkF5t4sNptc1vtCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJN1Kkyn4V2FNVdZZMWHTSqP+=5bKacKSEpkF5t4sNptc1vtCg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 05:27:45PM +0200, Paweł Dembicki wrote:
> > To forward a packet between port A and port B, both of them must be in
> > BR_STATE_FORWARDING, not just A.
> >
> 
> In this patch bridges are unimplemented. Please look at 8/8 patch [0].
> 
> [0] https://lore.kernel.org/netdev/20230912122201.3752918-9-paweldembicki@gmail.com/T/#u

Yes, but vsc73xx_port_stp_state_set() remains unchanged until the end.
What am I missing? In your implementation, nothing prevents port i
(which is in BR_STATE_FORWARDING) from forwarding packets towards a port j,
present in vsc->forward_map[i] & BIT(j), which is *not* in BR_STATE_FORWARDING.
If you don't have access to the STP protocol yet, you can put port j
down and it will go to the DISABLED state and you can confirm that other
ports in the bridge will still remain configured to forward to it.

> > > diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitesse-vsc73xx.h
> > > index f79d81ef24fb..224e284a5573 100644
> > > --- a/drivers/net/dsa/vitesse-vsc73xx.h
> > > +++ b/drivers/net/dsa/vitesse-vsc73xx.h
> > > @@ -18,6 +18,7 @@
> > >
> > >  /**
> > >   * struct vsc73xx - VSC73xx state container
> > > + * @forward_map: Forward table cache
> >
> > If you start describing the member fields, shouldn't all be described?
> > I think there will be kdoc warnings otherwise.
> >
> 
> Jakub in v1 series points kdoc warn in this case. I added a
> description to the field added by me. Should I prepare in the v4
> series a separate commit for other descriptions in this struct?

Yes, but please hold off posting it until I'm done reviewing this version.
