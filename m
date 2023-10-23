Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575567D404A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjJWTcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjJWTcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 15:32:10 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04524B4;
        Mon, 23 Oct 2023 12:32:08 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507a62d4788so5846458e87.0;
        Mon, 23 Oct 2023 12:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698089526; x=1698694326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uMutMjT7nYAjXNIUZq+zZiowd+ZGH08x+rX8MMHC5Do=;
        b=L7IJx3nJDXaBS9OwhZDPd8Fjmh/v//oy0nkhxr1RwN07N2wXg28tU1L0pW1J2LfwwH
         M6E2g+DWEqhKo/rODzIDDqkADdJTI1wAI8L6g/f6b2TF4wv/HSUtzPURyTMY8RfTVreb
         b7/Uvn60sj9aWE9xUZXtj6qlNhSuqMWeXHOkB/2OzxVu0Z6hs8BYsNs/tdo96E/2J2nX
         OA4AbuWhN/p2O9VDAR57T3jn2TVpJhVXZyMLXU5S8uqwOTajf4ig6eYnnt97e0wU3U0m
         sSR3tfruDXM+DCwaox3pL7lmKZHH/F+RVwO/MY+m2+qD+nLbK5HxpVC3SI8B55EXgtPU
         wCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698089526; x=1698694326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMutMjT7nYAjXNIUZq+zZiowd+ZGH08x+rX8MMHC5Do=;
        b=GB5V3V2Rt33i4eeXfu1KMFz/OPEWAcHVSSqKYeIYdwswBeNn6VSVvdE1J4q1S0fwvc
         +SeszSGePEz56h76I0LvjH3jVLC5hTlmCQnI83gJOiRRBPdiDlcLIeuXmjaLFFjkeakr
         LWYYy6J5wg3fYIN+h+48W3LoIg8TPGl6aMWVTjOghqeugrPPWFUllVqHJ4xezAviMI4M
         ChI+w3lMM01U1tWg1/ihkx8805JcdTjaKGumwU9xbVZZ3e8Rxo04oupZgQ5rEMrm6nS7
         p+2NwudmFXglkq7uRg6a9ZSo0hg1sssPU9t9CiE7bemXoZR/qB/yhj+1FEKC8PIhNX8w
         xmGg==
X-Gm-Message-State: AOJu0Yyc/8bH/7pXMm1a1QAjOmiCuqQPjUm05VYYpu/xVKwc4WSf3F12
        TUjkcr9ueYkDVwZBWh2OdXI=
X-Google-Smtp-Source: AGHT+IFwnCY/MaXxAJu+nrAFt1YbkaNoJzJUTr4aQ3gUDKk7pMFRaww+Lg0nqyZo1jn38ogXUz28HQ==
X-Received: by 2002:a05:6512:1396:b0:507:9615:b918 with SMTP id fc22-20020a056512139600b005079615b918mr8200716lfb.52.1698089525700;
        Mon, 23 Oct 2023 12:32:05 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id n15-20020aa7c68f000000b0053eb9af1e15sm6711383edq.77.2023.10.23.12.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 12:32:05 -0700 (PDT)
Date:   Mon, 23 Oct 2023 22:32:03 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>
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
Subject: Re: [PATCH net-next v2 1/2] net: dsa: Use conduit and user terms
Message-ID: <20231023193203.5mfflqi2zbtkepx2@skbuf>
References: <20231011222026.4181654-1-florian.fainelli@broadcom.com>
 <20231011222026.4181654-2-florian.fainelli@broadcom.com>
 <ZTYc6l2ZpLeGRFj9@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTYc6l2ZpLeGRFj9@duo.ucw.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Mon, Oct 23, 2023 at 09:12:42AM +0200, Pavel Machek wrote:
> On Wed 2023-10-11 15:20:25, Florian Fainelli wrote:
> > Use more inclusive terms throughout the DSA subsystem by moving away
> > from "master" which is replaced by "conduit" and "slave" which is
> > replaced by "user". No functional changes.
> 
> Note that by making it more "inclusive" you make it incomprehensible
> for users where english is not their first language.

I will preface by saying that I am quite indifferent to the whole inclusivity
movement, with a personal tendency of considering it silly and superficial,
and frankly a waste of time and resources. But I get that to some it may
matter more than to me. And it's not my time that gets wasted..

Based on "DSA has become incomprehensible because it replaced master/slave
with terms I don't know", I think an analogous attitude that's closer to
home could just as well be: "I'm a complete stranger, but why is eastern
Europe going through decommunization?! All I knew about eastern Europe
is that it was communist!"

I believe that in order to make an omelette, you need to break a few eggs,
and applied here, that seems to mean that A1 level English speakers get
to learn a word from the A2 vocabulary. I don't see how learning some
new words in a foreign language could do too much harm for the individual
going through that process.

> Plus, "user" already means something else in kernel context

If DSA is going to replace master/slave with something else, the
user/conduit terms have the legitimacy of being documented alternative
names at least since 2015's commit 77760e94928f ("Documentation:
networking: add a DSA document") and 2016's commit 83c0afaec7b7 ("net:
dsa: Add new binding implementation").

It also needs to be said that I never found master/slave to be a perfect
description of the hierarchy in DSA (but I just didn't care enough to
change it). If you think about it in terms of netdev adjacency lists for
example, the slaves are the uppers and the master (host interface) is
the lower... Or the subordination relationship could also be seen in
reverse because the user doesn't interact directly with the master/CPU
conduit interface most of the time, it just gets reconfigured
automatically, in a way initiated by some other entity, with what's
necessary to process switch-tagged traffic.

> so this will likely be confusing even for native speakers.

Sidetracking a bit, there was a joke I can't find anymore, so I'll just
paraphraze it:

"- what do drug dealers and computer engineers have in common?
 - they both call their customers 'users'".

I think/hope most native speakers got past the confusion at this point,
and just think of technical terms as words devoid of their original
meaning (which also makes the master/slave dilemma questionable TBH,
but what do I know). If there is any doubt, DSA has ample documentation
which clarifies what a slave (now user) port is. There is also a
paragraph documenting the naming change from master/slave.

> This is wrong.

Hmm, the topic is a bit arid for me to get too heated about it, but I
don't think that your arguments justify such a strong conclusion...
Your premise seems to be that people cannot learn, and can never adapt.
