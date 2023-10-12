Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4AD7C69FC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235599AbjJLJrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbjJLJr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:47:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCFEE1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697104002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ThRb+UcGK85QIazXPneMxqNNLJr2GRSmiyAMj75w/LA=;
        b=jEKKiil1HnJmKjj3QJtC5ojt++wzPh0Sv8X7uSIPAlBIFV6RfW8Uk+XKUlKJV7e8APy0jn
        TUaNLmsNCHNhL0JUhxOebSNifb315I80OQl/TpY39Cb0Cj3tJEFRBJUCHkY9JjELicvFZ8
        7geZqB4m1VTzqCKBvX2vzQGYnRL1CW4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-gNV-5VyjNLSoKfnEcCoevw-1; Thu, 12 Oct 2023 05:46:41 -0400
X-MC-Unique: gNV-5VyjNLSoKfnEcCoevw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4053a5c6a59so5275055e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697104000; x=1697708800;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ThRb+UcGK85QIazXPneMxqNNLJr2GRSmiyAMj75w/LA=;
        b=GDarYug223Q5aPUMYSf5/E0NXC7OtaOFvyinWSN8cYWMyAhCEC90EChauhqQCUkccz
         IYzmfE2NPmTqSosqCnQE8jwXtqi5qTTN9vogb+KNtY8o1/pKNG4EBhC4FAc427hO4UXd
         ypO0DDR8aEZwYYyKNnm4YJWqXaNOsjO9L1khdvyQBbjqR5RQ1a6rapt6FHAIwBspeS5h
         jU0GhhteFcDv3HmLVrHkPmjcqEVzSMhARzKML30O5LUS9kmQ+PX4GpQRZytqTJPBVYWi
         xZ1KXs/cO1pwJ5X3pvq+ZriOeTcxoqenUHZft2pdrJU4yspeEb5s2XUkWIwU1liUDD2N
         FTDQ==
X-Gm-Message-State: AOJu0YwEsQWPnbHSfsJ29Umd571e2CY6KcGTbOgV1Ev4Ah2M/vKVEoiq
        fsq2JXCPdEmXDG5VuH1yTzG4g8qwTYxwBBUYrFBFv1Hs7ZDs82SyPe6R3c9IAGxpvNl6Ro3xZC8
        eoTmRSTpPwndKqzVOzZNR7Z6U
X-Received: by 2002:a7b:c851:0:b0:405:3252:fe2 with SMTP id c17-20020a7bc851000000b0040532520fe2mr20044584wml.14.1697104000195;
        Thu, 12 Oct 2023 02:46:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFoTJKOUlXNGuTxyVfpeYk3pzXXcIpsxixiWv56qeWL3YsmKEdqeyry4llLnNXWO3k3t8ZEA==
X-Received: by 2002:a7b:c851:0:b0:405:3252:fe2 with SMTP id c17-20020a7bc851000000b0040532520fe2mr20044570wml.14.1697103999801;
        Thu, 12 Oct 2023 02:46:39 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
        by smtp.gmail.com with ESMTPSA id u6-20020a05600c00c600b00402ff8d6086sm18968884wmm.18.2023.10.12.02.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 02:46:38 -0700 (PDT)
Date:   Thu, 12 Oct 2023 05:46:36 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc:     Gabriel Somlo <somlo@cmu.edu>, qemu-devel@nongnu.org,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] riscv, qemu_fw_cfg: Add support for RISC-V architecture
Message-ID: <20231012054613-mutt-send-email-mst@kernel.org>
References: <20231011114721.193732-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231011114721.193732-1-bjorn@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 01:47:21PM +0200, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> Qemu fw_cfg support was missing for RISC-V, which made it hard to do
> proper vmcore dumps from qemu.
> 
> Add the missing RISC-V arch-defines.
> 
> You can now do vmcore dumps from qemu. Add "-device vmcoreinfo" to the
> qemu command-line. From the qemu montior:
>   (qemu) dump-guest-memory vmcore
> 
> The vmcore can now be used, e.g., with the "crash" utility.
> 
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> ---

with typo fixed:

Acked-by: Michael S. Tsirkin <mst@redhat.com>


>  drivers/firmware/Kconfig       | 2 +-
>  drivers/firmware/qemu_fw_cfg.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index b59e3041fd62..f05ff56629b3 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -155,7 +155,7 @@ config RASPBERRYPI_FIRMWARE
>  
>  config FW_CFG_SYSFS
>  	tristate "QEMU fw_cfg device support in sysfs"
> -	depends on SYSFS && (ARM || ARM64 || PARISC || PPC_PMAC || SPARC || X86)
> +	depends on SYSFS && (ARM || ARM64 || PARISC || PPC_PMAC || RISCV || SPARC || X86)
>  	depends on HAS_IOPORT_MAP
>  	default n
>  	help
> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
> index a69399a6b7c0..1448f61173b3 100644
> --- a/drivers/firmware/qemu_fw_cfg.c
> +++ b/drivers/firmware/qemu_fw_cfg.c
> @@ -211,7 +211,7 @@ static void fw_cfg_io_cleanup(void)
>  
>  /* arch-specific ctrl & data register offsets are not available in ACPI, DT */
>  #if !(defined(FW_CFG_CTRL_OFF) && defined(FW_CFG_DATA_OFF))
> -# if (defined(CONFIG_ARM) || defined(CONFIG_ARM64))
> +# if (defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_RISCV))
>  #  define FW_CFG_CTRL_OFF 0x08
>  #  define FW_CFG_DATA_OFF 0x00
>  #  define FW_CFG_DMA_OFF 0x10
> 
> base-commit: 1c8b86a3799f7e5be903c3f49fcdaee29fd385b5
> -- 
> 2.39.2

