Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83ACA7E078B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 18:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjKCRhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 13:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjKCRhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 13:37:16 -0400
Received: from mail-1.server.selfnet.de (mail-1.server.selfnet.de [141.70.126.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65116D4D;
        Fri,  3 Nov 2023 10:37:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7097742119;
        Fri,  3 Nov 2023 18:37:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selfnet.de; s=selfnet;
        t=1699033023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DMSZVLxL4ogAD5wj1ttv7z4THeQR0MDtGmLU6KGKDuA=;
        b=A34KeUSFMP/CwZ0SmwAAgeVyYDX9tSMB41HtasB+kX7eoQ4nkrOaGNjEiqRZACcGZwdX6s
        HgyvS84YNP6Qqd+g33MqNrkknYC6utbyqtDdrQ5FoafB2RjN4xJF45PiQuoovZRcvbuBtQ
        THOLXAG5sLNzqPTF0/dgY3zggJNaVp/yPypZUDKx7dIm9xrdyW6VTVTwaLbx2rluiM+EzC
        cjgpRMCJ1+WMBbM9OjFdIczhmykagOa9SKnolCzhNz4DxE+YjXN1V30p9uSUgfLRc4UyaF
        zWZFY1O3lkYFpbFkngWfjJLuiz2khWV53WQ0wxw2Z1RQnSZpU/ey/sOh5X2NEw==
Authentication-Results: mail-1.server.selfnet.de;
        auth=pass smtp.auth=marcovr smtp.mailfrom=marcovr@selfnet.de
From:   Marco von Rosenberg <marcovr@selfnet.de>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marco von Rosenberg <marcovr@selfnet.de>
Subject: Re: [PATCH] net: phy: broadcom: Wire suspend/resume for BCM54612E
Date:   Fri, 03 Nov 2023 18:37:00 +0100
Message-ID: <2315175.ElGaqSPkdT@5cd116mnfx>
In-Reply-To: <999020b2-692b-4582-8ca0-e19c7b45ee92@gmail.com>
References: <20231030225446.17422-1-marcovr@selfnet.de> <4890615.31r3eYUQgx@5cd116mnfx>
 <999020b2-692b-4582-8ca0-e19c7b45ee92@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, November 3, 2023 4:39:55 AM CET Florian Fainelli wrote:
> We have an unconditional call to __phy_resume() in phy_start() and we
> should always have a call to phy_start() regardless of the path though
> you have a point Andrew that we should ensure that by the time
> phy_init_hw() is called we have taken the device out of IDDQ-SR.
> 
> > I agree with all of your points. This is just one way which happens to
> > solve this specific problem. Of course it might be asymmetric to see the
> > patch as a solution to my problem. However is there anything
> > fundamentally wrong with adding suspend/resume callbacks? I see some
> > other drivers having these callbacks defined and some not (it seems a bit
> > inconsistent throughout the drivers in broadcom.c to be honest).
> > 
> > I'm wondering if I should just omit this whole "motivation" paragraph in
> > the commit message and just use the commit message of commit 38b6a9073007
> > ("net: phy: broadcom: Wire suspend/resume for BCM50610 and BCM50610M") as
> > a template. I mean, regardless of my motivation, I would say it makes
> > sense for this PHY to support suspend and resume.
> 
> I would remove the motivation aspect from the paragraph and we could
> also improve the driver a bit to ensure that IDDQ-SR is disabled upon
> config_init(). Other than that your patch is just fine with me. Can you
> re-submit in a few days when net-next opens again?

Ok, I'll re-submit the patch when net-next is open again with an updated 
commit message. And I agree, disabling IDDQ-SR in config_init() would make 
sense for a future patch since this would fix this potential issue also for 
other PHYs.

	Marco


