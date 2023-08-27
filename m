Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB25789C08
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 10:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjH0IF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 04:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjH0IFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 04:05:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6167DC
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 01:05:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6539A60B8F
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 08:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3795C433C7;
        Sun, 27 Aug 2023 08:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693123538;
        bh=bgFpKrbb5BKBRFqPi18KpBHYxGjE5puzerlvZWDQ17A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G7jI+fyHyygOeBw/iXHQqZiebINK9a96l2XPhsAEELxL4UkNEO9tkjgME8vP3XD57
         sIpYru6738QMDZ+U7bv/xiIjM5KIko/XysZm55n0cU/rwWFF7W8IWArU98ivQR6oGa
         83tRPKA2pQHZLwI56xo8h+RjMupTGwo4Up7oYYH2lW8nvpnsMLzfb3tIUIpHjkg21r
         TqxHwLYe8ZLFT7dNclJXnAdF1b9d2lZ0b0FugX99aypAEGXpz//i/KAW+eyGaE2WJo
         IKjvUksVNTV6HzeDxpDPeGJIag50Ogv8NvLI7B1Jna/jdLuCeRZp203u0SjsDu47io
         aRPIperAhApvA==
Date:   Sun, 27 Aug 2023 10:05:31 +0200
From:   Simon Horman <horms@kernel.org>
To:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        sebastian.tobuschat@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v2 5/5] net: phy: nxp-c45-tja11xx: implement
 mdo_insert_tx_tag
Message-ID: <20230827080531.GR3523530@kernel.org>
References: <20230824091615.191379-1-radu-nicolae.pirea@oss.nxp.com>
 <20230824091615.191379-6-radu-nicolae.pirea@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824091615.191379-6-radu-nicolae.pirea@oss.nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 12:16:15PM +0300, Radu Pirea (NXP OSS) wrote:
> Implement mdo_insert_tx_tag to insert the TLV header in the ethernet
> frame.
> 
> If extscs parameter is set to 1, then the TLV header will contain the
> TX SC that will be used to encrypt the frame, otherwise the TX SC will
> be selected using the MAC source address.
> 
> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
> ---
>  drivers/net/phy/nxp-c45-tja11xx-macsec.c | 66 ++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/drivers/net/phy/nxp-c45-tja11xx-macsec.c b/drivers/net/phy/nxp-c45-tja11xx-macsec.c

...

> @@ -167,6 +171,18 @@
>  #define MACSEC_INPBTS			0x0638
>  #define MACSEC_IPSNFS			0x063C
>  
> +#define TJA11XX_TLV_TX_NEEDED_HEADROOM	(32)
> +#define TJA11XX_TLV_NEEDED_TAILROOM	(0)
> +
> +#define MACSEC_TLV_CP			BIT(0)
> +#define MACSEC_TLV_SC_ID_OFF		(2)
> +
> +#define ETH_P_TJA11XX_TLV		(0x4e58)
> +
> +bool extscs;

Hi Radu,

Sparse suggests that extscs should be static.

> +module_param(extscs, bool, 0);
> +MODULE_PARM_DESC(extscs, "Select the TX SC using TLV header information.");

...
