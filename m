Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715FA7BEFA3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 02:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379205AbjJJASB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 20:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379111AbjJJAR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 20:17:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D388BA6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 17:17:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C90C433C7;
        Tue, 10 Oct 2023 00:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696897078;
        bh=x5Hc0rpJ7iF4Mvhk6x/zisCDD/PrRTFpDv53CC2O8pA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RjEMjD8MS+Q/5+QVyLx7bOMRZwbOvv6hrQ0H1E66dMXO53QxybMIYqFaoqwn/m/Hx
         TQeL93+lTvBp1WmmW1ecVZGbFxtOj+ddjkXaUOOFy+fJUZtXNegWa6coc28H0BZ09d
         U01Bs/Y9TJm0BSV8xlqEPS0OAeDy0cVW+HlHL1IlqSD25zqI/yPp4pMQ+WRf68zXUA
         o8ZYOacL4onZsTDagE9EEcMTrTwH6P56hMmnDXJ1hssLKfqSoHKds0fya38S2gIQQQ
         N8QqzKh8YbWb2/DU9YrHJyS0CpEKw30fiCMZ7vTGxPxIveJfvQLLNXaHnx1aiQXFNV
         7/nVKk/SLQhZg==
Date:   Mon, 9 Oct 2023 17:17:56 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [PATCH net-next v7 3/3] net: axienet: Introduce dmaengine
 support
Message-ID: <20231009171756.23e00a89@kernel.org>
In-Reply-To: <MN0PR12MB5953E37D081382AF52C309E2B7CEA@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <1695843151-1919509-1-git-send-email-radhey.shyam.pandey@amd.com>
        <1695843151-1919509-4-git-send-email-radhey.shyam.pandey@amd.com>
        <20231004135317.2b460acf@kernel.org>
        <MN0PR12MB5953B3DD4936EAFC7BBD944AB7C9A@MN0PR12MB5953.namprd12.prod.outlook.com>
        <20231006143230.4230fdc2@kernel.org>
        <MN0PR12MB5953E37D081382AF52C309E2B7CEA@MN0PR12MB5953.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Oct 2023 19:41:35 +0000 Pandey, Radhey Shyam wrote:
> > But somewhere else or just here after printing the warning?  
> 
> There is call to netif_stop_queue(ndev) just before this netdev_warn.
> I copied below for quick reference.
> 
> +	sg_len = skb_shinfo(skb)->nr_frags + 1;
> +	if (!CIRC_SPACE(lp->tx_ring_head, lp->tx_ring_tail, TX_BD_NUM_MAX)) {
> +		netif_stop_queue(ndev);
> +		if (net_ratelimit())
> +			netdev_warn(ndev, "TX ring unexpectedly full\n");
> +		return NETDEV_TX_BUSY;
> +	}
> 
> However, I noticed above check doesn't account for all frags - so will 
> modify the if check to see if available space is less than sg_len. If yes, then 
> stop the queue and return busy , else continue with xmit.

Please take a look at:

https://www.kernel.org/doc/html/next/networking/driver.html#stop-queues-in-advance

