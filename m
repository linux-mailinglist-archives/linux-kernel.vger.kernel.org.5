Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C1C760618
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 04:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjGYC6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 22:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjGYC6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 22:58:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5783F1;
        Mon, 24 Jul 2023 19:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=bscdJezkW977NS2usn50EadsF7pWATnyCd2yjIB1NM8=; b=Yx7q9pjEcU59tWFBgVNSVbmLcC
        vmofQzSyukuhzwubEhtOsjx1o/DHwC3Pqyjxhb09Cihbp3ZZoHTUNmKdNN09JXaICzFzKdWMebzBc
        Ly6Pk9CLE+KafGmp7jaynS5DogDTWlT5MdkRiAsobLFvqfQV7NhZqS3xRU1U0DRGraI2I5sNQekPI
        4QJMzIWwIVumJGvpnnF86FB9LGaNFS09ejqvs2wM7gwE8PbZbX8tmb4LO2kMj182K2QSlM62DDfr6
        OAwKq3RTC9DFkmCs4xns6olYo2Sx1dBWceGDHTzmo7TvH60PpK4DiRlzOHXl/EsKQ+1fmg5K9v/uX
        RbBkvowQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qO8FH-005yWd-11;
        Tue, 25 Jul 2023 02:57:55 +0000
Message-ID: <e4cc043b-76b9-5cc6-2fc7-e6a5722037ce@infradead.org>
Date:   Mon, 24 Jul 2023 19:57:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 03/32] xhci: sideband: add initial api to register a
 sideband entity
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, bgoswami@quicinc.com,
        Thinh.Nguyen@synopsys.com
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, alsa-devel@alsa-project.org,
        quic_jackp@quicinc.com, pierre-louis.bossart@linux.intel.com,
        oneukum@suse.com, albertccwang@google.com, o-takashi@sakamocchi.jp,
        Mathias Nyman <mathias.nyman@linux.intel.com>
References: <20230725023416.11205-1-quic_wcheng@quicinc.com>
 <20230725023416.11205-4-quic_wcheng@quicinc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230725023416.11205-4-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/23 19:33, Wesley Cheng wrote:
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index c170672f847e..d9dc92bea525 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -104,6 +104,15 @@ config USB_XHCI_RZV2M
>  	  Say 'Y' to enable the support for the xHCI host controller
>  	  found in Renesas RZ/V2M SoC.
>  
> +config USB_XHCI_SIDEBAND
> +	bool "xHCI support for sideband"
> +	help
> +	  Say 'Y' to enable the support for the xHCI sideband capability.
> +	  provide a mechanism for a sideband datapath for payload associated

	  Provide

> +	  with audio class endpoints. This allows for an audio DSP to use
> +	  xHCI USB endpoints directly, allowing CPU to sleep while playing
> +	  audio

	  audio.


-- 
~Randy
