Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4D87CA6E1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbjJPLlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbjJPLlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:41:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7565DC;
        Mon, 16 Oct 2023 04:41:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510BDC433C8;
        Mon, 16 Oct 2023 11:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697456466;
        bh=Y58rCXuF/l5eSXkcjq2QOHO2o9mynnSscDqicFlbC74=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bzj10yoU16IONm22GE6uQ4TJX7JU2wL8tAmfHBHqpKSsrPERv3w/IoQQm2x+1xOzi
         wjdl5dyndgqfIeo5fj1Sfmh5Q9MW7DNTgfgXCf3GXnksOpz3ZtU9yg3p+gLghSR99R
         yxZsbbpKuzcBDt1fee7kqrwycAunZ0/tHLIp0vCf9u4HPaQ11bKtOX2+JdqrQU1sz4
         1p50qvGFjti2HRLlvjYibJWMoS6Uun8VrCtKe8rHO70LIGVfYAMrFj9NoUUx5jT23g
         TtXA6lKdKanO1dcEmZjlpzHefmHxpRmSdgqVovZHQq+yKZ4Fj00lTHo78KAv9VW/Ke
         xtWCdlkq62DDw==
MIME-Version: 1.0
Date:   Mon, 16 Oct 2023 13:41:01 +0200
From:   Michael Walle <mwalle@kernel.org>
To:     =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc:     Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ajay Singh <ajay.kathat@microchip.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] wifi: wilc1000: use vmm_table as array in wilc struct
In-Reply-To: <20231016-wilc1000_tx_oops-v2-1-8d1982a29ef1@bootlin.com>
References: <20231016-wilc1000_tx_oops-v2-1-8d1982a29ef1@bootlin.com>
Message-ID: <f286d5e476c78b29e1e6bbad641644e1@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-10-16 10:29, schrieb Alexis Lothoré:
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
> 
> Fixes: 40b717bfcefa ("wifi: wilc1000: fix DMA on stack objects")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>

Reviewed-by: Michael Walle <mwalle@kernel.org>

-michael
