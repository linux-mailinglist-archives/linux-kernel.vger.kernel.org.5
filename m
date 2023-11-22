Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321247F4F5C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344154AbjKVSXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjKVSXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:23:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507F51AB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 10:23:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41197C433C7;
        Wed, 22 Nov 2023 18:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700677428;
        bh=yZFggWdceu7rn7hUogOUO9F9Pf31Wzul4TPKXAC/3U0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cfx7RL1y4ISdbaje+SGuou7CtcmZrlVSo+mA0tr2l4eyuKze0qLS9FLGsH/Uvv546
         s7lFQoD9HyEbwfoxy4Cvr6kIYavw/xkIhD5Bn5iNAQKfzXemwOgQb3bplHnFm5BIg7
         w5kgoNaYBleytc03xf9iMLLT8dpedTeV5o0w4OEXK1C+iS0AJ4kNeMn1VzMRH5PHgQ
         U4MvOpuzoVT+CffnRb3OADnazbboACsZBf0jhbD2rj8OQrhsqR4YB24oNzNd2p9IGm
         gmTmjf9ABiSuJpyWpqzQ0LvRp116ghdK8gRzUr9Sq4s4P6kzIC1GKYmZwcBH5PdgmM
         +k9NrEe+MlV+g==
Date:   Wed, 22 Nov 2023 10:23:47 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Robert Marko <robimarko@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [net-next PATCH] net: phy: aquantia: drop wrong endianness
 conversion for addr and CRC
Message-ID: <20231122102347.0bde86bb@kernel.org>
In-Reply-To: <655e4025.df0a0220.50550.3d70@mx.google.com>
References: <20231122170813.1222-1-ansuelsmth@gmail.com>
        <ZV45UY6nYZ/WAHpG@shell.armlinux.org.uk>
        <655e4025.df0a0220.50550.3d70@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 18:53:39 +0100 Christian Marangi wrote:
> So they DO get converted to the HOST endian on reading the firmware from
> an nvmem cell or a filesystem?

They don't get converted when "reading from nvmem / fs". 
They get converted when you do:

		word = get_unaligned((const u32 *)(data + pos));

get_unaligned() is basically:

#if BIGENDIAN
#define		get_unaligned	get_unaligned_be32
#else
#define		get_unaligned	get_unaligned_le32
#endif

so you'll get different behavior here depending on the CPU.
