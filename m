Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703477F86D8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 00:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjKXXkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 18:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjKXXkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 18:40:10 -0500
X-Greylist: delayed 6600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Nov 2023 15:40:16 PST
Received: from 3.mo581.mail-out.ovh.net (3.mo581.mail-out.ovh.net [46.105.34.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F8A1998
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 15:40:16 -0800 (PST)
Received: from director7.ghost.mail-out.ovh.net (unknown [10.108.20.39])
        by mo581.mail-out.ovh.net (Postfix) with ESMTP id 923F92AD2F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 21:11:57 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-wmx76 (unknown [10.110.208.112])
        by director7.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 225AE1FDEC;
        Fri, 24 Nov 2023 21:11:57 +0000 (UTC)
Received: from RCM-web2.webmail.mail.ovh.net ([176.31.232.109])
        by ghost-submission-6684bf9d7b-wmx76 with ESMTPSA
        id E+cDB50RYWVpxBkAOqy2KQ
        (envelope-from <rafal@milecki.pl>); Fri, 24 Nov 2023 21:11:57 +0000
MIME-Version: 1.0
Date:   Fri, 24 Nov 2023 22:11:56 +0100
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH] nvmem: Do not expect fixed layouts to grab a layout
 driver
In-Reply-To: <20231124193814.360552-1-miquel.raynal@bootlin.com>
References: <20231124193814.360552-1-miquel.raynal@bootlin.com>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <1d895bbb7e892507195db9ab81f88f54@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 31.11.218.106
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 1269170673624656716
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudehhedgudegiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvfevufgjfhgfkfigihgtgfesthekjhdttderjeenucfhrhhomheptfgrfhgrlhcuofhilhgvtghkihcuoehrrghfrghlsehmihhlvggtkhhirdhplheqnecuggftrfgrthhtvghrnheptdekvedtkeegteefheeifefhueetvedvvddvudekgfeihfdufefgleduheelgfevnecuffhomhgrihhnpehophgvnhifrhhtrdhorhhgnecukfhppeduvdejrddtrddtrddupdefuddruddurddvudekrddutdeipddujeeirdefuddrvdefvddruddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehrrghfrghlsehmihhlvggtkhhirdhplheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkedupdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-24 20:38, Miquel Raynal wrote:
> Two series lived in parallel for some time, which led to this 
> situation:
> - The nvmem-layout container is used for dynamic layouts
> - We now expect fixed layouts to also use the nvmem-layout container 
> but
> this does not require any additional driver, the support is built-in 
> the
> nvmem core.
> 
> Ensure we don't refuse to probe for wrong reasons.

I pushed a pretty much identical patch to OpenWrt (I just forgot
of_node_put()): commit 61f674df4f0c ("kernel: nvmem: fix "fixed-layout"
& support "mac-base""):
https://git.openwrt.org/?p=openwrt/openwrt.git;a=commitdiff;h=61f674df4f0ce2b1c53b0b7f6b0c1d03d99838c0

It's in use since July and seems to do the trick just fine.

Thanks for submitting this fix.


> Fixes: 27f699e578b1 ("nvmem: core: add support for fixed cells 
> *layout*")
> Cc: stable@vger.kernel.org
> Reported-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Tested-by: Rafał Miłecki <rafal@milecki.pl>

-- 
Rafał Miłecki
