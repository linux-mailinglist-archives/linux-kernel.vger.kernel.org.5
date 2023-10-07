Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FE57BC995
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 20:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344132AbjJGSm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 14:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJGSmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 14:42:55 -0400
Received: from proxima.lasnet.de (proxima.lasnet.de [IPv6:2a01:4f8:121:31eb:3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0198F93;
        Sat,  7 Oct 2023 11:42:53 -0700 (PDT)
Received: from [IPV6:2003:e9:d743:5c31:3105:419d:bcff:11c7] (p200300e9d7435c313105419dbcff11c7.dip0.t-ipconnect.de [IPv6:2003:e9:d743:5c31:3105:419d:bcff:11c7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id A9B5FC018D;
        Sat,  7 Oct 2023 20:42:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1696704167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EPgzJpN+KSTuOzQ3xY/vszJbchz47yeonl0DRQJME30=;
        b=jXhPRJ0iXYmaQCXG3Z910vQRe/gBwBVtk5SLWoak+NGfuKK6D9+7AJQfyC2Z3UHsFelL4c
        3kaw92Co2LihIDymaKx7g0gaK3QvbNfU9RZ+Pm24SJ7JHZXAL8IQ5/21NTsDSpghBRqvxd
        /XDp8xuqFEUHt+sglqW7M/ZAaojsYPO3/j6Sdl6WM9YsTLiA4hYb3lxVxECVJNiArM4+ao
        y3G2ksL+b5rJs7EeGmPqXw0YU+FYEuBH5YNbLxFnS60XPKtfYBIGRaNJNw3yUSgdp3Pn3L
        v6BnP0dho/ZNEPMonOuoQUqyohWZ/0lGYGPo3gp6zhAXXa48YvuQ7yH5RV3qZQ==
Message-ID: <c2b7264f-c533-2d80-e41e-a7019aefb602@datenfreihafen.org>
Date:   Sat, 7 Oct 2023 20:42:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] [v4] ieee802154: ca8210: Fix a potential UAF in
 ca8210_probe
Content-Language: en-US
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     stable@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Harry Morris <harrymorris12@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231007033049.22353-1-dinghao.liu@zju.edu.cn>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20231007033049.22353-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On 07.10.23 05:30, Dinghao Liu wrote:
> If of_clk_add_provider() fails in ca8210_register_ext_clock(),
> it calls clk_unregister() to release priv->clk and returns an
> error. However, the caller ca8210_probe() then calls ca8210_remove(),
> where priv->clk is freed again in ca8210_unregister_ext_clock(). In
> this case, a use-after-free may happen in the second time we call
> clk_unregister().
> 
> Fix this by removing the first clk_unregister(). Also, priv->clk could
> be an error code on failure of clk_register_fixed_rate(). Use
> IS_ERR_OR_NULL to catch this case in ca8210_unregister_ext_clock().
> 
> Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
> 
> Changelog:
> 
> v2: -Remove the first clk_unregister() instead of nulling priv->clk.
> 
> v3: -Simplify ca8210_register_ext_clock().
>      -Add a ';' after return in ca8210_unregister_ext_clock().
> 
> v4: -Remove an unused variable 'ret'.


This patch has been applied to the wpan tree and will be
part of the next pull request to net. Thanks!

regards
Stefan Schmidt

