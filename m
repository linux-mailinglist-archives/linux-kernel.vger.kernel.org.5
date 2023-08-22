Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DAF7848E0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 19:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjHVR7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 13:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjHVR7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:59:11 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBB2196;
        Tue, 22 Aug 2023 10:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=LK06T23V52CL3+Hym+ZPbCcNQEC7s+0AXFEJE2GMEVo=; b=FV+7qPfKHMpy6L4pNss6BxnA61
        ULmfP++J2dE74zcTCp73I2SXD1GZ67uRJ0vN2ijhkuT3ZAdwpW0qcuf5BTLLfhwkQsJH1NmR8D+bF
        1e6fK1mc5WSWQQbbIIvLTWlGsfyFG7ZtLf8NLgJpkVUADkdrBc5HNKilqACScz7CESSg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qYVee-004o5H-3S; Tue, 22 Aug 2023 19:59:00 +0200
Date:   Tue, 22 Aug 2023 19:59:00 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Justin Lai <justinlai0215@realtek.com>
Cc:     kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, jiri@resnulli.us
Subject: Re: [PATCH net-next v6 1/2] net/ethernet/realtek: Add Realtek
 automotive PCIe driver code
Message-ID: <aa7e5c75-e337-4150-bba5-a139ab4fc02f@lunn.ch>
References: <20230822031805.4752-1-justinlai0215@realtek.com>
 <20230822031805.4752-2-justinlai0215@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822031805.4752-2-justinlai0215@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	do {
> +		status = RTL_R32(tp, ivec->isr_addr);
> +
> +		handled = 1;
> +		RTL_W32(tp, ivec->imr_addr, 0x0);
> +		RTL_W32(tp, ivec->isr_addr, (status & ~FOVW));
> +
> +		if ((status & ivec->imr)) {
> +			if (likely(napi_schedule_prep(&ivec->napi)))
> +				__napi_schedule(&ivec->napi);
> +		}
> +	} while (false);

Remember i said that if you do something which no other network driver
does, it is probably wrong. How many drivers have a do {} while (false);
loop?

Please spend a few days just reading other drivers, and compare your
code with those drivers. Try to find all the things your driver does
which no other driver has. That code is probably wrong and you should
fix it.

	Andrew
