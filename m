Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981AE7B98B1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 01:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240762AbjJDX2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 19:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbjJDX2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 19:28:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3311C9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 16:28:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5F1C433C7;
        Wed,  4 Oct 2023 23:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696462112;
        bh=qbZU7R3Zsw96CbqqTm9vDJi7eGwTuFjG+uwNT9ctvJY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L8EfGQ55WKi2LtRA9Xq3ybLy4Wo7O+1h42hkjCU7fXyLjgOwfulSK88we8iNeXqMg
         4WNGn9C+lCAzRAU/+j7fLKqOXpcNguoZXELO17m/GIBD1XQpBLMUKAwPizMkYrLY9M
         8aoFnvoq7EuL3yA+tS6n85VijY+Fq3YDH7dVhSSNkClHBSEOzqZgt42/RksJXBJoQP
         J4OAuBhXO9SaGtypP7nm3WuD6IkXmrkny8BcMfMHO5dyI9MhHLWVzWUmOeBIcc1n/i
         hptqd23VLm5iLw1D6CUkZ5fXAZ25kcnj4I8jY00293ZWz60lkhNyMA7wnrp/kdNje7
         Dar0izIYT0FnQ==
Date:   Wed, 4 Oct 2023 16:28:31 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [RFC PATCH net-next] net: phy: aquantia: add firmware load
 support
Message-ID: <20231004162831.0cf1f6a8@kernel.org>
In-Reply-To: <20230930104008.234831-1-robimarko@gmail.com>
References: <20230930104008.234831-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Sep 2023 12:39:44 +0200 Robert Marko wrote:
> +	ret = of_property_read_string(dev->of_node, "firmware-name",
> +				      &fw_name);

Perhaps a well established weirdness of the embedded world but why read
the fw name from OF?! You can identify what PHY it is and decide the
file name based on that. And also put that fw name in MODULE_FIRMWARE()
so that initramfs can be built with appropriate file in place :S

> +	ret = request_firmware(&fw, fw_name, dev);
