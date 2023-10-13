Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0258B7C8E29
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 22:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjJMUNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 16:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjJMUNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 16:13:09 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD04EB7;
        Fri, 13 Oct 2023 13:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=L87ipk/XEXKtmEMbuP/TQA9pUzG48gkBb6cfivxpP9A=; b=t0
        8lQ0j+j4YvxeAkASSJaGG2sOnEb6XNrauv5v6mHcTH/qPg9ykCUMFoLrijCkWn5nyjEdAwWSfDnED
        Earf0uBF36bLy6wfUE7KE3h0H5kakPHys71PpksHLeRiOOOIv8JOZ2Z9XiGNk/D1HH6plZPcYDMCt
        kJkj7cYglKkxV68=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qrOWm-00284c-ME; Fri, 13 Oct 2023 22:12:56 +0200
Date:   Fri, 13 Oct 2023 22:12:56 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: phy: tja11xx: replace deprecated strncpy with
 ethtool_sprintf
Message-ID: <0c401bcb-70a8-47a5-bca0-0b9e8e0439a8@lunn.ch>
References: <20231012-strncpy-drivers-net-phy-nxp-tja11xx-c-v1-1-5ad6c9dff5c4@google.com>
 <15af4bc4-2066-44bc-8d2e-839ff3945663@lunn.ch>
 <CAFhGd8pmq3UKBE_6ZbLyvRRhXJzaWMQ2GfosvcEEeAS-n7M4aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8pmq3UKBE_6ZbLyvRRhXJzaWMQ2GfosvcEEeAS-n7M4aQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 12:53:53PM -0700, Justin Stitt wrote:
> On Fri, Oct 13, 2023 at 5:22 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > -     for (i = 0; i < ARRAY_SIZE(tja11xx_hw_stats); i++) {
> > > -             strncpy(data + i * ETH_GSTRING_LEN,
> > > -                     tja11xx_hw_stats[i].string, ETH_GSTRING_LEN);
> > > -     }
> > > +     for (i = 0; i < ARRAY_SIZE(tja11xx_hw_stats); i++)
> > > +             ethtool_sprintf(&data, "%s", tja11xx_hw_stats[i].string);
> > >  }
> >
> > I assume you are using "%s" because tja11xx_hw_stats[i].string cannot
> > be trusted as a format string? Is this indicating we need an
> > ethtool_puts() ?
> 
> Indeed, it would trigger a -Wformat-security warning.
> 
> An ethtool_puts() would be useful for this situation.

Hi Justin

hyperv/netvsc_drv.c:			ethtool_sprintf(&p, netvsc_stats[i].name);
hyperv/netvsc_drv.c:			ethtool_sprintf(&p, vf_stats[i].name);
ethernet/intel/i40e/i40e_ethtool.c:		ethtool_sprintf(&p, i40e_gstrings_priv_flags[i].flag_string);
ethernet/intel/i40e/i40e_ethtool.c:		ethtool_sprintf(&p, i40e_gl_gstrings_priv_flags[i].flag_string);
ethernet/intel/ice/ice_ethtool.c:			ethtool_sprintf(&p, ice_gstrings_priv_flags[i].name);
ethernet/intel/igc/igc_ethtool.c:			ethtool_sprintf(&p, igc_gstrings_stats[i].stat_string);
ethernet/intel/ixgbe/ixgbe_ethtool.c:			ethtool_sprintf(&p, ixgbe_gstrings_test[i]);
ethernet/netronome/nfp/nfp_net_ethtool.c:			ethtool_sprintf(&data, nfp_self_test[i].name);
ethernet/netronome/nfp/nfp_net_ethtool.c:		ethtool_sprintf(&data, nfp_net_et_stats[i + swap_off].name);
ethernet/netronome/nfp/nfp_net_ethtool.c:		ethtool_sprintf(&data, nfp_net_et_stats[i - swap_off].name);
ethernet/netronome/nfp/nfp_net_ethtool.c:		ethtool_sprintf(&data, nfp_net_et_stats[i].name);
ethernet/fungible/funeth/funeth_ethtool.c:			ethtool_sprintf(&p, txq_stat_names[j]);
ethernet/fungible/funeth/funeth_ethtool.c:			ethtool_sprintf(&p, xdpq_stat_names[j]);
ethernet/fungible/funeth/funeth_ethtool.c:			ethtool_sprintf(&p, rxq_stat_names[j]);
ethernet/fungible/funeth/funeth_ethtool.c:			ethtool_sprintf(&p, tls_stat_names[j]);
ethernet/amazon/ena/ena_ethtool.c:		ethtool_sprintf(&data, ena_stats->name);
ethernet/amazon/ena/ena_ethtool.c:			ethtool_sprintf(&data, ena_stats->name);
ethernet/brocade/bna/bnad_ethtool.c:		ethtool_sprintf(&string, bnad_net_stats_strings[i]);
ethernet/pensando/ionic/ionic_stats.c:		ethtool_sprintf(buf, ionic_lif_stats_desc[i].name);
ethernet/pensando/ionic/ionic_stats.c:		ethtool_sprintf(buf, ionic_port_stats_desc[i].name);
ethernet/hisilicon/hns/hns_dsaf_gmac.c:		ethtool_sprintf(&buff, g_gmac_stats_string[i].desc);
ethernet/hisilicon/hns/hns_dsaf_xgmac.c:		ethtool_sprintf(&buff, g_xgmac_stats_string[i].desc);
vmxnet3/vmxnet3_ethtool.c:			ethtool_sprintf(&buf, vmxnet3_tq_dev_stats[i].desc);
vmxnet3/vmxnet3_ethtool.c:			ethtool_sprintf(&buf, vmxnet3_tq_driver_stats[i].desc);
vmxnet3/vmxnet3_ethtool.c:			ethtool_sprintf(&buf, vmxnet3_rq_dev_stats[i].desc);
vmxnet3/vmxnet3_ethtool.c:			ethtool_sprintf(&buf, vmxnet3_rq_driver_stats[i].desc);
vmxnet3/vmxnet3_ethtool.c:		ethtool_sprintf(&buf, vmxnet3_global_stats[i].desc);

It looks like there are enough potential users to justify adding
it. Do you have the time and patience?

    Andrew
