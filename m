Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275E3797368
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237471AbjIGPXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbjIGPW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:22:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F6C1B2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:22:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9662C32797;
        Thu,  7 Sep 2023 15:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694099061;
        bh=WdK8JvU3w5OYNIGaa0wOy4tgpIjNtj7P6a7gO95XcG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qUKejfETy2wAwfuiS4Y6C8C8DBMzG0d6rEwsaM41SfymYUnPapd6kZpy0IY4B6+1P
         Fz401cF5Ct1/bLp2Ej8NWhmusAFht2YiWjozrZbQASo+/vBE1iT88l4vNj5RwXk5j5
         HICWPBSMm/dAH86aW9sMKAx6W9UD/Mxb9R6fQ2wYHqQidUVSb4Aab/C8JKSaUSCovI
         XeF1mHhU8LJRSkBq/0tXfUwfior3J9E5dO3kD+Qs3iERxI1H93pE1p63CsurQK6FMc
         FsE22m+UvWnxSaiy0dlo7FIxQf7iP35LHRYYwtvKncvScT2AePURjDibnf0X6pfr56
         uJ0T/kmYANTKQ==
Date:   Thu, 7 Sep 2023 17:04:16 +0200
From:   Simon Horman <horms@kernel.org>
To:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        sebastian.tobuschat@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v3 6/6] net: phy: nxp-c45-tja11xx: implement
 mdo_insert_tx_tag
Message-ID: <20230907150416.GE434333@kernel.org>
References: <20230906160134.311993-1-radu-nicolae.pirea@oss.nxp.com>
 <20230906160134.311993-7-radu-nicolae.pirea@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906160134.311993-7-radu-nicolae.pirea@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 07:01:34PM +0300, Radu Pirea (NXP OSS) wrote:
> Implement mdo_insert_tx_tag to insert the TLV header in the ethernet
> frame.
> 
> If extscs parameter is set to 1, then the TLV header will contain the
> TX SC that will be used to encrypt the frame, otherwise the TX SC will
> be selected using the MAC source address.
> 
> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
> ---

...

> @@ -166,6 +170,18 @@
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
> +static bool macsec_extscs;
> +module_param(macsec_extscs, bool, 0);
> +MODULE_PARM_DESC(macsec_extscs, "Select the TX SC using TLV header information. PTP frames encryption cannot work when this feature is enabled");

Hi Radu,

I hate to be the bearer of bad news, but
I don't think we can accept new module parameters in Networking code.

...
