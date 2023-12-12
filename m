Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A9380F959
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377409AbjLLV2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbjLLV2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:28:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070CB126
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:27:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14121C433C8;
        Tue, 12 Dec 2023 21:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702416476;
        bh=50sFTmtihceq90x+RGmpNwjBeohVEhFnNKDvNFakuCA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cOoZS9exiz+criCcYP/hy4pMCbxjVobEJPVZikpnLMiLu9+LcCWBzWPi4aTIDBXgc
         dSuTTDVXilOpc5MPdrnDKrT0+u8QHqj4d8uWVNQl/c9XwjMxtkutTKKLnnXZfAdDTU
         bo2A7ur6ykv92o4V0uNuKAc5gyTi759qgkJdhJHffc1XdriqXESYHJ3Objhp2J6TY6
         3EJpTob+C4Y/YOylS/2shzOmc24laqtXsrKFepI8VhrfUJUK5f8QyxnW4eCkidKqKe
         lGmNtWKTd18InnWc19jXiik5Xtzg/VJQS+EPeW6TSrKPdzqD7qAwd+UcNiOJrHYofr
         UdTCg89/aKllg==
Date:   Tue, 12 Dec 2023 13:27:55 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kunwu Chan <chentao@kylinos.cn>
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunwu Chan <kunwu.chan@hotmail.com>
Subject: Re: [PATCH] net: dsa: vsc73xx: Add null pointer check to
 vsc73xx_gpio_probe
Message-ID: <20231212132755.261ee49d@kernel.org>
In-Reply-To: <20231211024549.231417-1-chentao@kylinos.cn>
References: <20231211024549.231417-1-chentao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 10:45:49 +0800 Kunwu Chan wrote:
>  	vsc->gc.label = devm_kasprintf(vsc->dev, GFP_KERNEL, "VSC%04x",
>  				       vsc->chipid);
> +	if (!vsc->gc.label) {
> +		dev_err(vsc->dev, "Fail to allocate memory\n");
> +		return -ENOMEM;
> +	}

Don't add error prints on memory allocations.
There will be an OOM splat in the logs.
-- 
pw-bot: cr
