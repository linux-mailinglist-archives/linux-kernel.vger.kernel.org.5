Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EE1790BD9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 14:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbjICMOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 08:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjICMOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 08:14:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF8CE6;
        Sun,  3 Sep 2023 05:14:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46A85611CC;
        Sun,  3 Sep 2023 12:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3112BC433C8;
        Sun,  3 Sep 2023 12:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693743278;
        bh=Wp/zhY3Hfebka0jVHUrjgVCRxLYDjR8TD2H7pf/90Rk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eZDJUoxrUmESyNqoVNRuboDT+3ZrWPI41MnMd0hwtYAL7Ke0QDblzsquBJyD3DC5T
         HsdYtBf1Gg4cabnYi+5d50UcmFXbZiqdhY1XRl5x0hbzi4oj7XAtpNG5VLdCAxg4tf
         0AFYma/tbYoZScoiLNO9saJcqn3TzvZGHUkuS5xEsSSJO9n7ooUwN55OmFr09EiIMv
         ql/+btdjYBMv3gjFSVxBtvgrQ9alxNw9ONjfDU+f5bcrfM02DSqgF/unbR4/6lLhgU
         8ZHXbnxoL1taMjWLn3cefDkgTk9MOvWcp3PgqKrkv+5QYphgcO9BmjGk7HqrEmT1xZ
         /fT2G1u9RK8YA==
Date:   Sun, 3 Sep 2023 13:15:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?= =?UTF-8?B?Zw==?= 
        <u.kleine-koenig@pengutronix.de>, Marek Vasut <marex@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH v3 0/4] Match data improvements for mcp4725 driver
Message-ID: <20230903131505.7a2bd3c3@jic23-huawei>
In-Reply-To: <20230903115548.59306-1-biju.das.jz@bp.renesas.com>
References: <20230903115548.59306-1-biju.das.jz@bp.renesas.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  3 Sep 2023 12:55:44 +0100
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> This patch series aims to add match data improvements for mcp4725 driver.
> 
> This patch series is only compile tested.
> 
> v2->v3:
>  * Added struct mcp4725_chip_info with chan_spec and chip_id variable and
>    used that as OF/ID table match data.
>  * Added variables use_ext_ref_voltage and dac_reg_offset to struct
>    mcp4725_chip_info to handle hw differences between mcp4725 and
>    mcp4726.
> v1->v2:
>  * Update commit description with reason for change.
> 
> Biju Das (4):
>   iio: dac: mcp4725: Replace variable 'id' from struct mcp4725_data
>   iio: dac: mcp4725: Use i2c_get_match_data()
>   iio: dac: mcp4725: Add use_ext_ref_voltage to struct mcp4725_chip_info
>   iio: dac: mcp4725: Add dac_reg_offset to struct mcp4725_chip_info
> 
>  drivers/iio/dac/mcp4725.c | 42 ++++++++++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 14 deletions(-)
> 

I've applied this, but still plenty of time for more comments as I'll only
be pushing it out as a non rebasing tree after rc1.

Thanks,

Jonathan
