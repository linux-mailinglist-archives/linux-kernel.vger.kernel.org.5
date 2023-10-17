Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2D47CBE09
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbjJQIrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJQIre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:47:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF748E;
        Tue, 17 Oct 2023 01:47:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FB1C433C8;
        Tue, 17 Oct 2023 08:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697532453;
        bh=Bn6xXXAWpQvwsW5L9Wtxkhfcme+lm1ca7BBUnXIdZks=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BZX5IroC0wVtNty+iQqGTDm7MVrOy17NbdNmrJHLQRHMMGUorbXhEfbXQ3143gSEd
         XEhomT0rkznVkR4CPaDbuUYiNr0o3VJfLqzI9A/QtHMcFill6oVJdIIpb2FDd+S/CD
         WHPxUqzkTSZv+0N3Nn9z+aHOT4mPJHRdQWOSkL36+Jp939r9OOhtdAJXs35qtf9eR7
         s/m0R6nFE4D8Zeydcb84FaWwlKE/bPvMttPTeD9NoW4QGZr5dpcvvXd8MjBQ3StHFz
         WKdMi7k940UGSNmuQf7EOeWobz4ODHCYtfEyc3Y0q079b1PH13GwTpMUcXuRu7saL1
         pjMmEXAWIB3NQ==
MIME-Version: 1.0
Date:   Tue, 17 Oct 2023 10:47:28 +0200
From:   Michael Walle <mwalle@kernel.org>
To:     =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc:     Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ajay Singh <ajay.kathat@microchip.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] wifi: wilc1000: use vmm_table as array in wilc struct
In-Reply-To: <20231017-wilc1000_tx_oops-v3-1-b2155f1f7bee@bootlin.com>
References: <20231017-wilc1000_tx_oops-v3-1-b2155f1f7bee@bootlin.com>
Message-ID: <8f50e47f00d31b3d40cf4acb0ff5856a@kernel.org>
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

Am 2023-10-17 10:43, schrieb Alexis Lothoré:
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
