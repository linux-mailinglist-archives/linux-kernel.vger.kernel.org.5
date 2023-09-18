Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7757A5262
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 20:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjIRSzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 14:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjIRSzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:55:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF02F7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 11:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=1wuXWfoShaYErwZYG6GsYlxB9uESfAN5ZYWeSZRWiFA=; b=JVSK8J8D6eDqgIonPoDJr3IfRQ
        5meI3XznR0B6UCp1cO+R3TpARv3/Ug2pnPilVGQE/Vj2H3S7fz3tcjM2Ae5xn7uaHDT3+02Pg7BIc
        raONEFCQRd+zTfOABcLVHULWSwzxRqYnySxnfX6a4ZH8NpE9ucrp8LPDgm5bdIIQGqM2aevIwPkmS
        KhdAwbzKqHbrclyV21jV4fGBF68FcM21h6vIwmYwO0S4DVz6Xu++yxry2iUt4ndzZfd7OiknRP46x
        RQIpPisXwkz4nEubxRrbCD4Dl+IpJuPOXwdUdQzh5xet3o+BCx4nHANkE3yYKlugWD68EDzepJRAU
        jwrPTZew==;
Received: from [2601:1c2:980:9ec0::9fed]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qiJP3-00G73e-2K;
        Mon, 18 Sep 2023 18:55:25 +0000
Message-ID: <ab54121d-04a2-497c-8c56-573608eb820e@infradead.org>
Date:   Mon, 18 Sep 2023 11:55:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soundwire: bus: Make IRQ handling conditionally built
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
References: <20230918161026.472405-1-ckeepax@opensource.cirrus.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230918161026.472405-1-ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/18/23 09:10, Charles Keepax wrote:
> SoundWire has provisions for a simple callback for the IRQ handling so
> has no hard dependency on IRQ_DOMAIN, but the recent addition of IRQ
> handling was causing builds without IRQ_DOMAIN to fail. Resolve this by
> moving the IRQ handling into its own file and only add it to the build
> when IRQ_DOMAIN is included in the kernel.
> 
> Fixes: 12a95123bfe1 ("soundwire: bus: Allow SoundWire peripherals to register IRQ handlers")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309150522.MoKeF4jx-lkp@intel.com/
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/soundwire/Makefile   |  4 +++
>  drivers/soundwire/bus.c      | 31 +++----------------
>  drivers/soundwire/bus_type.c | 11 +++----
>  drivers/soundwire/irq.c      | 59 ++++++++++++++++++++++++++++++++++++
>  drivers/soundwire/irq.h      | 43 ++++++++++++++++++++++++++
>  5 files changed, 115 insertions(+), 33 deletions(-)
>  create mode 100644 drivers/soundwire/irq.c
>  create mode 100644 drivers/soundwire/irq.h
> 

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy
