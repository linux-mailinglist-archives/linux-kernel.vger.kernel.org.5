Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD64786B28
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjHXJI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbjHXJIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:08:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A996910FA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:08:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FBC76684A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:08:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2781C433C8;
        Thu, 24 Aug 2023 09:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692868113;
        bh=cGe2w464vT5iQRrd8L3sTAx4e+OvBRkYjXHp0yCt0Gk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=quo8P0wxFXUeiy1k5RVcF7e/z/U50j7obbGyAqBdPiEXyp3nFD15tW4j/JmXUaZJ/
         9Acfd8wXjpOtx6goFSqsxulSGX8KwxVTbnDrIWDj+b38USbrj6lzX1ZInt2CZFfCpR
         XhuaeeSWxhX9toVGf9WjtNOy7ejOqi/68HrtGQoAShsGphj1pZ9L5qzr2bcOzi6r/7
         i6Nmg1Nyp28CxJ0+vEAgdybs2Z5mwIqccff6dWf/zyfWq7OIIVxq09QtmdVHqcekMO
         pm1e/o5+xFX3TyrbnxbpbMVfuFJh6rQtKh3clcTu2NOFD4KPw7CY0gZE0OGlaRVi/Q
         M/NNUdOyqjxDA==
Date:   Thu, 24 Aug 2023 11:08:19 +0200
From:   Simon Horman <horms@kernel.org>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Marko <robimarko@gmail.com>
Subject: Re: [PATCH net-next v2] net: generalize calculation of skb
 extensions length
Message-ID: <20230824090819.GG3523530@kernel.org>
References: <20230823-skb_ext-simplify-v2-1-66e26cd66860@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230823-skb_ext-simplify-v2-1-66e26cd66860@weissschuh.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 11:28:38AM +0200, Thomas Weißschuh wrote:
> Remove the necessity to modify skb_ext_total_length() when new extension
> types are added.
> Also reduces the line count a bit.
> 
> With optimizations enabled the function is folded down to the same
> constant value as before during compilation.
> This has been validated on x86 with GCC 6.5.0 and 13.2.1.
> Also a similar construct has been validated on godbolt.org with GCC 5.1.
> In any case the compiler has to be able to evaluate the construct at
> compile-time for the BUILD_BUG_ON() in skb_extensions_init().
> 
> Even if not evaluated at compile-time this function would only ever
> be executed once at run-time, so the overhead would be very minuscule.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Reviewed-by: Simon Horman <horms@kernel.org>




