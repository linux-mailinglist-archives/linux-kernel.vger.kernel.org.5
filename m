Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD6A7D9B02
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346112AbjJ0OR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346080AbjJ0OR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:17:56 -0400
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE68BB8;
        Fri, 27 Oct 2023 07:17:52 -0700 (PDT)
Received: from [192.168.4.14] (unknown [62.77.71.229])
        by mx.gpxsee.org (Postfix) with ESMTPSA id 4166155CBD;
        Fri, 27 Oct 2023 16:17:50 +0200 (CEST)
Message-ID: <25173a48-529c-463b-88aa-2ee75dd604ff@gpxsee.org>
Date:   Fri, 27 Oct 2023 16:17:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] media: pci: mgb4: remove bogus 'select' statements
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Martin Tuma <martin.tuma@digiteqautomotive.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231023160539.1537355-1-arnd@kernel.org>
 <20231023160539.1537355-2-arnd@kernel.org>
From:   =?UTF-8?Q?Martin_T=C5=AFma?= <tumic@gpxsee.org>
In-Reply-To: <20231023160539.1537355-2-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23. 10. 23 18:05, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> As this is just a regular device driver, it has no business force-enabling
> other drivers in the system, it should be entirely independent of the
> implementation of the spi-nor layer or the specific DMA engine.
> 

The drivers are required for IP cores that are used on the card (in the 
FPGA). Without I2C_XILINX and XILINX_XDMA the card won't work at all. 
Without SPI_XILINX the access to the card's FLASH (used e.g. for FW 
changes) won't be possible.

A change to "depend" instead of "select" is thus possible if it makes 
more sense to you, but removing it would make the module not compile or 
not work at runtime (there is no symbol dependency to I2C_XILINX and 
SPI_XILINX, but both need to be present and are loaded using 
request_module() at runtime).

M.

> The IIO symbols that are selected here are library modules that
> are legitimately used.
> 
> Fixes: 0ab13674a9bd ("media: pci: mgb4: Added Digiteq Automotive MGB4 driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/media/pci/mgb4/Kconfig | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/media/pci/mgb4/Kconfig b/drivers/media/pci/mgb4/Kconfig
> index f2a05a1c8ffa..b90347c7f19b 100644
> --- a/drivers/media/pci/mgb4/Kconfig
> +++ b/drivers/media/pci/mgb4/Kconfig
> @@ -6,10 +6,6 @@ config VIDEO_MGB4
>   	select VIDEOBUF2_DMA_SG
>   	select IIO_BUFFER
>   	select IIO_TRIGGERED_BUFFER
> -	select I2C_XILINX
> -	select SPI_XILINX
> -	select MTD_SPI_NOR
> -	select XILINX_XDMA
>   	help
>   	  This is a video4linux driver for Digiteq Automotive MGB4 grabber
>   	  cards.

