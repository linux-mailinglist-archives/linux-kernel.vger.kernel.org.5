Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816787E10D7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 20:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjKDTwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 15:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjKDTwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 15:52:35 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D634B7;
        Sat,  4 Nov 2023 12:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=PMOi+T8xIxdqSkXvWodzilS0QtzvEJry+WzCgwe+EsQ=; b=5OJ5/1DHuabtlpyDDpP5v0PIKI
        Aj3ZS5N5hEtmnNgzmCY1Ra0Sw/sYDK59eQbk/9mjFV1Cns907kAuA70N27HV61U6l5WtysMxffvWX
        UDtLf0oRsOupye0xElKhL3ohdcjb46n1JSpiEGYTEn3ME7MvJjvUO82Lb5m+1azex714=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qzMh1-000u6h-MZ; Sat, 04 Nov 2023 20:52:27 +0100
Date:   Sat, 4 Nov 2023 20:52:27 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Justin Lai <justinlai0215@realtek.com>
Cc:     kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net-next v10 09/13] net:ethernet:realtek:rtase: Implement
 pci_driver suspend and resume function
Message-ID: <0af3a54f-09da-4a8b-b385-c6968334ace4@lunn.ch>
References: <20231102154505.940783-1-justinlai0215@realtek.com>
 <20231102154505.940783-10-justinlai0215@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102154505.940783-10-justinlai0215@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int rtase_resume(struct pci_dev *pdev)
> +{
> +	struct net_device *dev = pci_get_drvdata(pdev);
> +	struct rtase_private *tp = netdev_priv(dev);
> +	int ret;
> +
> +	pci_set_power_state(pdev, PCI_D0);
> +	pci_restore_state(pdev);
> +	pci_enable_wake(pdev, PCI_D0, 0);
> +
> +	/* restore last modified mac address */
> +	rtase_rar_set(tp, dev->dev_addr);
> +
> +	if (!netif_running(dev))
> +		goto out;
> +
> +	rtase_wait_for_quiescence(dev);
> +	netif_device_attach(dev);
> +
> +	rtase_tx_clear(tp);
> +	rtase_rx_clear(tp);
> +
> +	ret = rtase_init_ring(dev);
> +	if (ret)
> +		netdev_alert(dev, "unable to init ring\n");

If you fail to init the ring, is it safe to keep going?

	Andrew
