Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464B37CECE8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 02:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjJSAm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 20:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJSAm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 20:42:58 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F76C11D;
        Wed, 18 Oct 2023 17:42:54 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4083dbc43cfso8928235e9.3;
        Wed, 18 Oct 2023 17:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697676172; x=1698280972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oEsE/+qks89QI4eb1Y3e4mK4O1PQPTOYfAd9vXSG79U=;
        b=OS8GOY5Sb+i/NZ62vayvgzkRgmOhzdhdOy32dV4bsPYeqRzqw5UHU0Q3+nO4rDMaF2
         nopASjIMZTRnoTF+3XLLR0CPeXpEgbHpOftEgpPihvIo6oXDeYnlVw0QF+P+hZkEV+TF
         j1b5Z69DN5hYwaiPNUPjGNwKxofHXHzzXLeKsko+/EU+cyp1tRuFJly0CYhTt4UbLS1H
         J607LOYy6PrXANpWqkd2rYnl7mUp5uScIqIY8HY3uotQAILOB4uYbT4NbuT7th2fMDCF
         alHClvvZTmhitMA8OjigiyYWD/tDOReEscSnw9Gj+mo42iZq2D8cpNf+hvEKifhhc0pF
         1QdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697676172; x=1698280972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEsE/+qks89QI4eb1Y3e4mK4O1PQPTOYfAd9vXSG79U=;
        b=tX758ttfJAHNnuFbP/AwqrZ4urmMjSGuBbPvRlfjNiXT7eaxO8xb/AldGAL1fbFLPg
         DE7UedzuPmDkeBRseIqEIUmJHNR3RFLj11clQRrTUD06HEBMZ/oyg6wfquhHEmzDbk7W
         Xta7vU/1/3x4XWxC46gSk+PnpNneNcCKdVynenTiOYF9BQUfNYXwhA4U3Ksc3DlSW2qO
         E5CtB+1bRwMF7Ff//3JuePaz+BYo7schTEy1/g9Oghldgt4sjzBLCLlVpWJ8yFq5Naps
         1avpGfE6geiP3f41KKTaW5iRh8/W8lMdiVIjWex9IRUfj8GkOXefmCZRKSjCQo6sEF6V
         x/bA==
X-Gm-Message-State: AOJu0Yypb7y0yWQEri6cfwRcUd1qRrARGwAKzK5tpFnb3S2bjblk95Tw
        Gwe22wwupRwOhy1rbJPZ718=
X-Google-Smtp-Source: AGHT+IF4BhRxQY0I79+pOR23Kn9puugy8LkI+A2ymuJCK9OGr71dSyxlcqy0ilVsg4LAZ1g/arAemA==
X-Received: by 2002:a05:600c:a44:b0:401:bf87:9898 with SMTP id c4-20020a05600c0a4400b00401bf879898mr666226wmq.25.1697676172221;
        Wed, 18 Oct 2023 17:42:52 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id n13-20020adffe0d000000b0031ad2f9269dsm3186662wrr.40.2023.10.18.17.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 17:42:52 -0700 (PDT)
Date:   Thu, 19 Oct 2023 03:42:49 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
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
Subject: Re: [PATCH net-next v6 2/2] net: dsa: Rename IFLA_DSA_MASTER to
 IFLA_DSA_CONDUIT
Message-ID: <20231019004249.as4zlbb754eyagwz@skbuf>
References: <20231018175820.455893-1-florian.fainelli@broadcom.com>
 <20231018175820.455893-1-florian.fainelli@broadcom.com>
 <20231018175820.455893-3-florian.fainelli@broadcom.com>
 <20231018175820.455893-3-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018175820.455893-3-florian.fainelli@broadcom.com>
 <20231018175820.455893-3-florian.fainelli@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 10:58:20AM -0700, Florian Fainelli wrote:
> This preserves the existing IFLA_DSA_MASTER which is part of the uAPI
> and creates an alias named IFLA_DSA_CONDUIT.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
