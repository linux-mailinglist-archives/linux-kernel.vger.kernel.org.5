Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4647F8C43
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 17:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjKYQIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 11:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjKYQIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 11:08:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F4092
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 08:08:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42535C433C7;
        Sat, 25 Nov 2023 16:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700928493;
        bh=+JdvZzFz1fUXLr7nCkndqXtxJjfFTBUCZxGIR3myW/U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XK82r4cpxnh9hdFs2xGKa0X1tALGw0LxQ1t2THSEhxqG76NMMrS5TELZ2Y7cjfUz1
         9x0nQUCp9Gbx4GA2D7xj5X5s2tLvIM9oelKKTxWMFlDOMW+CeVcEhPYFcwkn94DRAE
         1ebETkgDslvfycoGPAlUPjmlH8+XVd90RSJYwBW4mRiomWagnPqgOpMWexMGeWsuh/
         jQ4SU/Oqbq6i8U5NmgP9ohB2ENdhhxjH6sUnlmJT3snaU8DY1kjbfjxgrDQdmaF2gI
         FMRXp9V1EXuAHYb6g+EAB8u0TsMRk6R/rA9JrP3l3ZOvcTmnyF9fuQkpEUVUpgv899
         ZFZ4wf0DLKpIw==
Date:   Sat, 25 Nov 2023 16:08:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc:     <beniamin.bia@analog.com>, <paul.cercueil@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] Add support for AD7091R-2/-4/-8
Message-ID: <20231125160804.63c30be9@jic23-huawei>
In-Reply-To: <cover.1700751907.git.marcelo.schmitt1@gmail.com>
References: <cover.1700751907.git.marcelo.schmitt1@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 23 Nov 2023 13:29:12 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> 
> This series adds support for AD7091R-2/-4/-8 ADCs which can do single shot
> or sequenced readings. Threshold events are also supported.
> Overall, AD7091R-2/-4/-8 are very similar to AD7091R-5 except they use SPI interface.
> 
> This has been tested with raspberrypi and eval board on kernel 6.1 from ADI fork.
> Link: https://wiki.analog.com/resources/tools-software/linux-drivers/iio-adc/ad7091r8
> 
> I ran get_maintainers on driver files but completely forgot to run it on the
> yaml doc, my bad.
> I made the changes requested so far.
> For v2, I also ran dt_binding_check on iio testing branch to check out for any
> additional dt-schema issues. None reported.
> Didn't see any other warn after running Sparse, Smatch, and Coccicheck.
> I get a warn from checkpatch about IIO_DMA_MINALIGN which I don't know how to fix :(

Fix checkpatch :)
It has some exclusions for some of the warnings so probably look at what was added
to avoid issues with __cacheline_aligned and friends.
https://elixir.bootlin.com/linux/latest/source/scripts/checkpatch.pl#L515


> 
> Change log v1 -> v2:
> - Added device tree related To/Cc recipients.
> - Removed extra print of error code
> - $ref: "adc.yaml" -> $ref: adc.yaml
> - Fixed defined but not used build warn
> - Moved dt documentation of required properties to after patternProperties.
> - Removed incorrect return before regmap_update_bits().
> 
> Marcelo Schmitt (7):
>   iio: adc: ad7091r-base: Set alert config and drvdata
>   MAINTAINERS: Add MAINTAINERS entry for AD7091R
>   iio: adc: ad7091r: Move defines to header file
>   iio: adc: ad7091r: Alloc IIO device before generic probe
>   dt-bindings: iio: Add binding documentation for AD7091R-8
>   iio: adc: Add support for AD7091R-8
>   iio: adc: ad7091r-base: Add debugfs reg access
> 
>  .../bindings/iio/adc/adi,ad7091r8.yaml        | 101 +++++++
>  MAINTAINERS                                   |  12 +
>  drivers/iio/adc/Kconfig                       |  16 ++
>  drivers/iio/adc/Makefile                      |   4 +-
>  drivers/iio/adc/ad7091r-base.c                | 114 +++++---
>  drivers/iio/adc/ad7091r-base.h                |  64 ++++-
>  drivers/iio/adc/ad7091r5.c                    |  55 ++--
>  drivers/iio/adc/ad7091r8.c                    | 270 ++++++++++++++++++
>  8 files changed, 549 insertions(+), 87 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7091r8.yaml
>  create mode 100644 drivers/iio/adc/ad7091r8.c
> 

