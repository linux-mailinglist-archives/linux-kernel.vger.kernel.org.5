Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4037D66FC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbjJYJgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjJYJgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:36:40 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED91BA1;
        Wed, 25 Oct 2023 02:36:37 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40838915cecso44637095e9.2;
        Wed, 25 Oct 2023 02:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698226596; x=1698831396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zxxdJb0Pk2jGCZTNDTuKKyAUkRDhJczRSr4g1VjXqPQ=;
        b=LeWrMUFw/pW1F+kAXzCJfFK8Gz8EPrItOW259u1rheFNqZfY0b2iC1LjyqsJXPo074
         SFL2+BO2czxhIpWlwCEkOLGaK4B+x4IGmOtnLVAhCBP7SVTZKu+KJqvK7C3EqnUr9byp
         3DZW8B8T44KX+NGJlbqIae/p8vMH0eOmxZRJxUZB7Mbhb4MNYNAU4VjEsPmp5afZag/i
         aWpG4WRd5RU2sUdvdQKmJt6XwIkuLPIjORN3nwSVhYlSL8/xoLoNmuX6yyDNMn/zXtDQ
         j/0P0fbNq9E+Wd+wEdZB3tYNF4wRVQOBzL1tX2KSxTTGMODWv2Q1GLRS9/LtIO9JXU7A
         taNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698226596; x=1698831396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxxdJb0Pk2jGCZTNDTuKKyAUkRDhJczRSr4g1VjXqPQ=;
        b=i7ArbXV3NR3J0OnD7vdDkzwnRla8bcvxyC+RKWTXF4VNzdy3vNOXtW6fxecFv1QJTO
         V2FwA1li0YvW41g1XTKyVYkI5oa7Zz7DgyZzzyW55e6CL6ONazU0xyV4nNOltVoTvuoG
         SMnEz+QIsJMTDe9htG+bt57Xt4MnhzB7QFbz1Pochghdt5zTv8XoRAdpH+sOTcMmBbg8
         VfDrjVQlhzP8u7lH8lf4Dp5ypXPrBaz6socMFkt5mpUPp6iSYqFva6Rzt+LQpK2Zsf5D
         J6icpBH+rDrLYD2GNPddQe8tFNc1dLQsjSqArJzeWaNYajIevMJW//+pKilTxIzH6q/P
         pEwA==
X-Gm-Message-State: AOJu0YzIPX+AGv/HoduVTK1KlTF5fNomWo1Mpl0O2pQtngDFN6JwfGCq
        /5oslQeX9dqVU1RI02t3gaM=
X-Google-Smtp-Source: AGHT+IFbQlJbnygwGkAyBUdZ5bdVJ2E1WB/Uqc1fDFXVse42xvqBgs+4TMgpGZ2Nnsmk2uPqYbjaGA==
X-Received: by 2002:adf:e7d2:0:b0:32d:9541:b1e3 with SMTP id e18-20020adfe7d2000000b0032d9541b1e3mr10511483wrn.26.1698226596082;
        Wed, 25 Oct 2023 02:36:36 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id m17-20020a056000009100b0032d829e10c0sm11764732wrx.28.2023.10.25.02.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 02:36:35 -0700 (PDT)
Date:   Wed, 25 Oct 2023 12:36:32 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     davem@davemloft.net, patchwork-bot+netdevbpf@kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux@armlinux.org.uk, f.fainelli@gmail.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        kabel@kernel.org, ansuelsmth@gmail.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        robh@kernel.org, vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v7 0/7] Create a binding for the Marvell
 MV88E6xxx DSA switches
Message-ID: <20231025093632.fb2qdtunzaznd73z@skbuf>
References: <20231024-marvell-88e6152-wan-led-v7-0-2869347697d1@linaro.org>
 <169822622768.10826.14051215485905127447.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169822622768.10826.14051215485905127447.git-patchwork-notify@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Wed, Oct 25, 2023 at 09:30:27AM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to netdev/net-next.git (main)
> by David S. Miller <davem@davemloft.net>:
> 
> On Tue, 24 Oct 2023 15:20:26 +0200 you wrote:
> > The Marvell switches are lacking DT bindings.
> > 
> > I need proper schema checking to add LED support to the
> > Marvell switch. Just how it is, it can't go on like this.
> > 
> > Some Device Tree fixes are included in the series, these
> > remove the major and most annoying warnings fallout noise:
> > some warnings remain, and these are of more serious nature,
> > such as missing phy-mode. They can be applied individually,
> > or to the networking tree with the rest of the patches.
> > 
> > [...]

Can you please revert this series? It breaks the boot on the Turris MOX
board.
