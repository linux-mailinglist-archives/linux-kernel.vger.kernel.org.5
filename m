Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736C3763034
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjGZIpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbjGZIp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:45:27 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A160E0;
        Wed, 26 Jul 2023 01:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=RAU0cPXH92fccMay1mm1XuQEOIvzdh7WIU3f587dsCI=; b=19FUvKyFVXqzZLN143udiZB+9n
        jOVsdfJXaR0AVtp6/XVgx6Q6mG7vMGdXjzfQnH+g6R+tOd1F+Au2XBnapGLSzVn6L/xPqgpyF4GxC
        BsbUzcuGv1OdH1fcE5Idi/uz9J87rLntH3Hc/o/aLakld8zzDYVFA0oM4a8N4Iq1SVBM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qOa0k-002L4n-O6; Wed, 26 Jul 2023 10:36:46 +0200
Date:   Wed, 26 Jul 2023 10:36:46 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Hayes Wang <hayeswang@realtek.com>
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        nic_swsd@realtek.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] r8152: adjust generic_ocp_write function
Message-ID: <c63b0f24-4e6b-4df3-8783-9899d178b16e@lunn.ch>
References: <20230726030808.9093-417-nic_swsd@realtek.com>
 <20230726030808.9093-418-nic_swsd@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726030808.9093-418-nic_swsd@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 11:08:07AM +0800, Hayes Wang wrote:
> Reduce the control transfer if all bytes of first or the last DWORD are
> written.
> 
> The original method is to split the control transfer into three parts
> (the first DWORD, middle continuous data, and the last DWORD). However,
> they could be combined if whole bytes of the first DWORD or last DWORD
> are written. That is, the first DWORD or the last DWORD could be combined
> with the middle continuous data, if the byte_en is 0xff.

How often is byte_en 0xff? Do you have some benchmark numbers to show
it is worth the complexity?

   Andrew
