Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD5F7C5432
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345055AbjJKMlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbjJKMlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:41:35 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDA298;
        Wed, 11 Oct 2023 05:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=10jsCd0D/yud1X3V4ZeOq13dIfU5Nng3hYOVE5ex/Z8=; b=vhmROl4kvWcn2i7OSqV2XejI7k
        5tzzV66f9OL32F7zw41dIhsVGzhDVx2lfYhHC0+IHeW0IQPD2CabyyOoeNVa3nRX1Ma9PcpEHYerG
        ywJNw+TRvOZmzwU5iTrRI28yWNp5ff9Yr3oFkefEN34Xwl+TGVPmLWE9PschKKnty2ko=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qqYWk-001Zg4-1L; Wed, 11 Oct 2023 14:41:26 +0200
Date:   Wed, 11 Oct 2023 14:41:26 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, srk@ti.com,
        Vignesh Raghavendra <vigneshr@ti.com>, r-gunasekaran@ti.com,
        Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH] net: ti: icssg-prueth: Fix tx_total_bytes count
Message-ID: <4d7c2ab9-e980-42a5-9452-79bc0d33e094@lunn.ch>
References: <20231011063700.1824093-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011063700.1824093-1-danishanwar@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -29,7 +30,12 @@ void emac_update_hardware_stats(struct prueth_emac *emac)
>  			     base + icssg_all_stats[i].offset,
>  			     val);
>  
> +		if (!strncmp(icssg_ethtool_stats[i].name, "tx_good_frames", ETH_GSTRING_LEN))
> +			tx_pkt_cnt = val;

Doing a strncmp seems very expensive. Could you make use of
icssg_stats.offset?

	Andrew
