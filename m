Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0547CF147
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjJSHbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjJSHa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:30:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDA69F;
        Thu, 19 Oct 2023 00:30:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E478DC433C8;
        Thu, 19 Oct 2023 07:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697700654;
        bh=9g/oL5ciNynJcn9WgauUXtHsSALIsdoIPjlIDDbWEys=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=KRvWN9M6Omb2EVLdylaIEl4OTKB6w92CHI5vHjZIMrWPeWS5m5xxzwc4Svg15O4K+
         PSP7OveM/o+APV5fOwGPsPs31FyZa4VPZS2zSvYMJNwljwOJ4ryUMf0ddezjFfYRH0
         /oCi2R4j9Ty6XAL6MV+Yp91x+04hyBo/uG12eDCXAAZ0m2eFXF0/FKdJXoa1+ZFmtb
         grkx5g/glQxPH7wAq4qbM2JAfmbxjfYXldpL+uXzvYibDTj+1X9gPDqFOspPxpoGtZ
         0tQWY/ftgAG4V1d1qpUt2RNXLRX42CxjgXu2aZg0vQfDvWb7qlyGSXiAKcWcyylyJM
         F5CX5JTmq/pag==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] wifi: wilc1000: use vmm_table as array in wilc struct
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231017-wilc1000_tx_oops-v3-1-b2155f1f7bee@bootlin.com>
References: <20231017-wilc1000_tx_oops-v3-1-b2155f1f7bee@bootlin.com>
To:     =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc:     Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Michael Walle <mwalle@kernel.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ajay Singh <ajay.kathat@microchip.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        stable@vger.kernel.org,
        =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169770065004.117236.8779995270709198838.kvalo@kernel.org>
Date:   Thu, 19 Oct 2023 07:30:51 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexis Lothoré <alexis.lothore@bootlin.com> wrote:

> From: Ajay Singh <ajay.kathat@microchip.com>
> 
> Enabling KASAN and running some iperf tests raises some memory issues with
> vmm_table:
> 
> BUG: KASAN: slab-out-of-bounds in wilc_wlan_handle_txq+0x6ac/0xdb4
> Write of size 4 at addr c3a61540 by task wlan0-tx/95
> 
> KASAN detects that we are writing data beyond range allocated to vmm_table.
> There is indeed a mismatch between the size passed to allocator in
> wilc_wlan_init, and the range of possible indexes used later: allocation
> size is missing a multiplication by sizeof(u32)
> 
> Fixes: 40b717bfcefa ("wifi: wilc1000: fix DMA on stack objects")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
> Reviewed-by: Michael Walle <mwalle@kernel.org>
> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Patch applied to wireless-next.git, thanks.

05ac1a198a63 wifi: wilc1000: use vmm_table as array in wilc struct

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231017-wilc1000_tx_oops-v3-1-b2155f1f7bee@bootlin.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

