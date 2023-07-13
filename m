Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CCE751C70
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbjGMJAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbjGMJAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:00:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CB31B6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:00:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91CE461A98
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2E5C433C7;
        Thu, 13 Jul 2023 09:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689238813;
        bh=FS6IGHNIU+MsMLrPhkS4TbBRHtXLi8wWNk5j5osD+DU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QCOtMw1RQz6X/mHeK6QOPmbM+fyZdqhp0fggevlZYpEuq1pw1vpKcJ2uzfyxCpIua
         3jagn/cfJzfeULxuMz1Tja3ZWYf32FI/VLi3zC4mrEvd6aOhyFZADhbRAnHVpgxsbg
         4aBg4BZ1LUcjZhpUC+aENAYzbEhtrbjU0ldeuW7n3y3n2QDnmZOLpVw8bAy4ypsbVS
         XbckHjyyCkyrXjb5qOu8qa8s2LIIxF5MfnquOaItWrPLbIb7qHrwKXe6p4t6gJhy2s
         0Uq9TL0WFJR20G1SKTWC3R8LQLqH4+umIzM258NPLNK+gtwnbKYfVXpiX5SNaktZ0p
         DBjTzeS2fAtwA==
MIME-Version: 1.0
Date:   Thu, 13 Jul 2023 11:00:07 +0200
From:   Michael Walle <mwalle@kernel.org>
To:     Simon Horman <simon.horman@corigine.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        =?UTF-8?Q?Marek_Beh?= =?UTF-8?Q?=C3=BAn?= <kabel@kernel.org>,
        Xu Liang <lxu@maxlinear.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 08/11] net: phy: add support for C45-over-C22
 transfers
In-Reply-To: <ZK+8M+FxJxY7UIyt@corigine.com>
References: <20230620-feature-c45-over-c22-v3-0-9eb37edf7be0@kernel.org>
 <20230620-feature-c45-over-c22-v3-8-9eb37edf7be0@kernel.org>
 <ZK+8M+FxJxY7UIyt@corigine.com>
Message-ID: <1bef1179238e09cdfce281cc2428ba56@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

Am 2023-07-13 10:56, schrieb Simon Horman:
> On Wed, Jul 12, 2023 at 05:07:08PM +0200, Michael Walle wrote:
> 
> ...
> 
>> @@ -780,6 +782,7 @@ static int get_phy_c45_devs_in_pkg(struct mii_bus 
>> *bus, int addr, int dev_addr,
>>   * the "devices in package" is invalid.
>>   */
>>  static int get_phy_c45_ids(struct mii_bus *bus, int addr,
>> +			   enum phy_access_mode mode,
> 
> Please add the new mode parameter to the kernel doc for this function,
> which is in the lines preceding this hunk.

Ahh. Sorry. You've already mentioned that last time :/

Also true for get_phy_c45_devs_in_pkg().

-michael
