Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83957F9D74
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjK0K1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbjK0K1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:27:45 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE7AEA;
        Mon, 27 Nov 2023 02:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3juK1mRN9IHZs49VX2tDFfNWRrH8ez7Xl+6AFxH3QDc=; b=QTQALexXzmeIletbhOMnhISn5s
        umwuXSRQhFnKzuHs/VC1UFKGna71cN9+j55XOnv/8Ndy+0B9BVsPssK3vNjoHveJMfeaTtrhQ4j2N
        fHd20O9ZbQdyf7LlI1xg5A1iEJpJQX64/GCVETR7Y2/rDaqdbkukPhK6VVIx6gqYfjNULPuRzGztX
        njJELWoKBCuONZh6O4/yelYYazEFbmt1b0iG4kFU9tllVUHiiWBetp7Nm8cY0eEbn/QLHksiyMOY+
        TXOVD5+tsGzaz3r7A3j013eyH037j0fKb0lfWqYUpC6kUsTJRftY3DMXdNHQOirITtP+dHGny4P8U
        3Uzjtqxw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33832)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r7Yq6-0005ed-0c;
        Mon, 27 Nov 2023 10:27:42 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r7Yq7-0001pZ-C5; Mon, 27 Nov 2023 10:27:43 +0000
Date:   Mon, 27 Nov 2023 10:27:43 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Gan Yi Fang <yi.fang.gan@intel.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Looi Hong Aun <hong.aun.looi@intel.com>,
        Voon Weifeng <weifeng.voon@intel.com>,
        Song Yoong Siang <yoong.siang.song@intel.com>,
        Lai Peter Jun Ann <jun.ann.lai@intel.com>
Subject: Re: [PATCH net 1/1] net: phylink: Add module_exit()
Message-ID: <ZWRvHw13l41HkciJ@shell.armlinux.org.uk>
References: <20231127101603.807593-1-yi.fang.gan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127101603.807593-1-yi.fang.gan@intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 06:16:03PM +0800, Gan Yi Fang wrote:
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 25c19496a336..7121503c9259 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -3724,7 +3724,10 @@ static int __init phylink_init(void)
>  	return 0;
>  }
>  
> +static void __exit phylink_exit(void){}

Please format that as:

static void __exit phylink_exit(void)
{
}

and move it _after_ module_init().

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
