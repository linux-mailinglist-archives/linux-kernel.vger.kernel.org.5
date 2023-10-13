Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED727C81EF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjJMJYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjJMJYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:24:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8293595;
        Fri, 13 Oct 2023 02:24:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1927AC433C8;
        Fri, 13 Oct 2023 09:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697189076;
        bh=7IfoDnU1fNHDKyeP8m+8aGUt38qVXh15uI2Ni01PUrA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J35dmo33SSEMIUEFMJ6d55ek49G6ch/FaskK0E7xAheo+6D2v0lxwalYJBHggAXOG
         X8sCeOpKcwJm0QMakhnMHdBX6dLKJmSKnkJOMH1dxLYKRA5MgiZgCeM8ADlL+n2H75
         d+KF0wNS9ezgUd8zNUNONVRgvspLHoNmXUGUBsW3Po0PkuaX6k05s9B7r0/alDFT8b
         jwdC4Du7PMzsSWPs5zrSIbkdGG84ni5exmnHCSAgS2hSubA/72E3dxFnmY/RXCkkR7
         xzJXKWSCdGIaK6+lnl6FYSEX/oZXGmAUnV+2i9+REfkcxzQDGsk9nfo7MfMYXiugGF
         6msa+4Xkd4Rxw==
MIME-Version: 1.0
Date:   Fri, 13 Oct 2023 11:24:31 +0200
From:   Michael Walle <mwalle@kernel.org>
To:     =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc:     Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ajay Singh <ajay.kathat@microchip.com>, stable@vger.kernel.org,
        heiko.thiery@gmail.com
Subject: Re: [PATCH] wifi: wilc1000: use vmm_table as array in wilc struct
In-Reply-To: <20231013-wilc1000_tx_oops-v1-1-3761beb9524d@bootlin.com>
References: <20231013-wilc1000_tx_oops-v1-1-3761beb9524d@bootlin.com>
Message-ID: <f615b0895135489a2555d898afdcfbfa@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2023-10-13 10:26, schrieb Alexis Lothoré:
> From: Ajay Singh <ajay.kathat@microchip.com>
> 
> Enabling KASAN and running some iperf tests raises some memory issues 
> with
> vmm_table:
> 
> BUG: KASAN: slab-out-of-bounds in wilc_wlan_handle_txq+0x6ac/0xdb4
> Write of size 4 at addr c3a61540 by task wlan0-tx/95
> 
> KASAN detects that we are writing data beyond range allocated to 
> vmm_table.
> There is indeed a mismatch between the size passed to allocator in
> wilc_wlan_init, and the range of possible indexes used later: 
> allocation
> size is missing a multiplication by sizeof(u32)

Nice catch.

> While at it, instead of simply multiplying the allocation size, do not 
> keep
> dedicated dynamic allocation for vmm_table: define it as an array with 
> the
> relevant size in wilc struct, which is already dynamically allocated
> 
> Fixes: 40b717bfcefa ("wifi: wilc1000: fix DMA on stack objects")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>

Looks good to me. But you'll change the alignment of the table, not sure
if that matters for some DMA controllers.

-michael
