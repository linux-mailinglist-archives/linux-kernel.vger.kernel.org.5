Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E376807584
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378480AbjLFQn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjLFQn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:43:27 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA3BD47;
        Wed,  6 Dec 2023 08:43:34 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50bfa5a6cffso4330634e87.0;
        Wed, 06 Dec 2023 08:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701881012; x=1702485812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zUpkLHka5kYwhvClkLnYahC6G9D+w/JULwDjw/f4rQs=;
        b=mm5FIgotDo5WzTm6m6ynx5HH1MYn0fUNthXjdd+t1kqUqud86kEo+ZHZizouppp1uF
         0mWYOX7v9VR65INj+vyvteiW3M3uwHBlPVoH33N71x8EsnTpbavxvFbN1qkuiLAmszqa
         EX+7ZGDAOh2sr+8qGevHwvNkVZ4rBwydn0fNEiuxPuDeJpNzDuV0yi0CarlP9pw92v9B
         fuyRd7+xn6v+2lUoRzkPMD6oyKXlt2vRCIgzzBhJ/FsnNFjrD1J62m8wNzZuoU7m1GEj
         0uKVwj7D+8zxe444W4khISjjy/t7tiZLRj+aoBSxwhU7md9rmAADHrms6AWbT3MNoo5n
         R/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701881012; x=1702485812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUpkLHka5kYwhvClkLnYahC6G9D+w/JULwDjw/f4rQs=;
        b=iQiblb4mNAJRSLorFZc2HjFDy4dzhIzPosAfmhtPjSQuVy7UBAoL1hHoa6IDbcKfsK
         pTMcABfKwb0SPlK6HC5opiv9gqBlz4DNjL//cSdDW9M/D/Qq1iwcG0ozVWL2X1GYzB8l
         BlNPlvij7g4BS1H3dBS2sKfjMMsPU/vfrHUdNfyS0amN9Y7qnAcLvXeRGl5nb3ecFxjB
         k0l/zcTjeiB8vWCz6vPUgT2kJpmZsKyMJj9VDNRv5x0raNYNBlkBplYIEOvADzjRLQE5
         wg69++xUe2iKtX3PTdiy00HHlLGGz1g/cwYtQH48o8B7zlBbV3t+sYMBIoOO9q5H0G5u
         bEpQ==
X-Gm-Message-State: AOJu0YyTM5L3rThWhrhzkJxeF9LgOKn2qFt90o2EvLm3lg/thrmOc+Wu
        nQ9dmrqYqNAT1I270Vap9Rg=
X-Google-Smtp-Source: AGHT+IF9WlTStknbcxL3fvGYNhUFNrrN9eRVZG4ocV/Fwh4u4BMSClhXfoneS1LduLey87n4ix/mHQ==
X-Received: by 2002:ac2:4a6b:0:b0:50b:f2f4:279 with SMTP id q11-20020ac24a6b000000b0050bf2f40279mr624240lfp.110.1701881011931;
        Wed, 06 Dec 2023 08:43:31 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id q11-20020a056402032b00b0054d486674d8sm169871edw.45.2023.12.06.08.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 08:43:31 -0800 (PST)
Date:   Wed, 6 Dec 2023 18:43:29 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v1 3/3] net: dsa: microchip: Fix PHY loopback
 configuration for KSZ8794 and KSZ8873
Message-ID: <20231206164329.fszkmpilktyq6r6v@skbuf>
References: <20231121152426.4188456-1-o.rempel@pengutronix.de>
 <20231121152426.4188456-3-o.rempel@pengutronix.de>
 <35045f6ef6a5b274063186c065a8215088b94cd5.camel@redhat.com>
 <20231206085520.GA1293736@pengutronix.de>
 <20231206151406.75eglqtsrrb4vegf@skbuf>
 <20231206155440.GA1324895@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206155440.GA1324895@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 04:54:40PM +0100, Oleksij Rempel wrote:
> > I don't see DSA implementing ndo_set_features(), nor offering NETIF_F_LOOPBACK.
> > The PHY is integrated, so DSA is the only relevant netdev driver. Is
> > there any other way to test this functionality?
> 
> yes - net_selftest()

Ok, I didn't notice net_test_phy_loopback_enable(). So it can be
triggered after all, it seems.

But I mean, if it's exclusively a selftest that fails, and has always
failed since its introduction, I think it can be considered new
development work when it stops failing? I don't believe that the impact
of the bug is relevant for users. It's not a production functionality.
Documentation/process/stable-kernel-rules.rst doesn't specifically say
this, but it does imply that we should triage the "real bugs that bother
people" as much as possible.

> > If not, I think it's a case of "tree falling in the woods and nobody
> > hearing it". Not "stable" material. But it definitely has nothing to do
> > with not caring about the switch variant.
> 
> Sorry, my intention is not to criticize anyone. I am not getting
> feedbacks or bug reports for ksz88xx variants, so it seems like not many
> people use it in upstream.
> 
> When I have time slots to work on this driver, I try to use them to do
> fixes and also clean up the code. Since there is some sort of fog of
> uncertainty about when I get the next time slot, or even if I get it at
> all, I am trying to push both fixes and cleanups together.
> 
> But, you are right, it is not a good reason for not caring about stable :)
> 
> What is the decision about this patch set?

I wouldn't bend over backwards for this, and reorder the patches.
I would spend my time doing more meaningful things.
