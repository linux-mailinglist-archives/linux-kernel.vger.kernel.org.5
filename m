Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B83380F1CF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbjLLQFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjLLQFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:05:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B8FAD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:05:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63252C433C8;
        Tue, 12 Dec 2023 16:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702397110;
        bh=shND2JWB5x3Z+S1RTbK6XSI5qan81/apFSZ9av6syEw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LCRmmo05GoXe35HGbVELJxl+iJSKsbGcS7DMz5/zRrwrkJ1Asc4O1ckCoCzGQm2Vo
         bnS/b8JK2m3bO/xGfj41wH03YUPrU1mOhXh5Wy3O7gwX1z1BYasvfAB3ffFyeH88Ba
         6A3kLUpE0b0DaVkBStOVm135c+L49bR+zm90kuHQKMafGzNTghxHwSWlfMtROxmAYG
         1tiMHGc9G1/W9zN5mcgqCzB+AzZMwG0Qn6n93X5QijNvpQYIo2EjPUMjfCzSFJGbuN
         BJjToaL+zoR7L0YJQX2DwS25QxM3xA99ATkdXZm97k0FQQ9Gnjrykxtvw4dBw3HRMM
         d5+Lvkq9CJ4ig==
Date:   Tue, 12 Dec 2023 08:05:09 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Justin Lai <justinlai0215@realtek.com>
Cc:     Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
        edumazet@google.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, andrew@lunn.ch, pkshih@realtek.com,
        larry.chiu@realtek.com
Subject: Re: [PATCH net-next v14 01/13] rtase: Add pci table supported in
 this module
Message-ID: <20231212080509.48ec4931@kernel.org>
In-Reply-To: <0d8195d3c1aaec85e74d7ae2bf5b1a5b9c1a0b78.camel@redhat.com>
References: <20231208094733.1671296-1-justinlai0215@realtek.com>
        <20231208094733.1671296-2-justinlai0215@realtek.com>
        <0d8195d3c1aaec85e74d7ae2bf5b1a5b9c1a0b78.camel@redhat.com>
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

On Tue, 12 Dec 2023 10:36:16 +0100 Paolo Abeni wrote:
> > +static void rtase_remove_one(struct pci_dev *pdev)
> > +{
> > +	struct net_device *dev = pci_get_drvdata(pdev);
> > +	struct rtase_private *tp = netdev_priv(dev);
> > +	struct rtase_int_vector *ivec;
> > +	u32 i;
> > +
> > +	for (i = 0; i < tp->int_nums; i++) {
> > +		ivec = &tp->int_vector[i];
> > +		netif_napi_del(&ivec->napi);
> > +	}  
> 
> You must unregister the netdev before napi_del or you will risk races.

Or del them in the ndo_open / ndo_stop... Note that ndo_stop is always
called if ndo_open was called.
