Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1C97B21C8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjI1PwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjI1PwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:52:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F497EB;
        Thu, 28 Sep 2023 08:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=hPdcYpQxen4e8NFhKYxy/N6WYUJPUeudEMjsy2z2FAk=; b=xJblSmwhfFiZwjwjM8gAPI32nK
        oaUlR6BGSVk8o6MC4wcNckcbpC4UmpOHFKiLF+zvGOW2MXofxJ5UeiwyKTj8RwneEo1Wg1fo21eVF
        dAPiFOoCrn4Q0N9uwcGM2pgi2lhJlW8uai0OtWXlQFrpy184lci0/HNAe9dY3R8IQlmO6Su9RxXg6
        SleSDay8zy8xKVwQQvXSF3/6DXuZWYzff1YJkzFDiLwyjtWk7wCWqrURaCbRPqVjDmYfdEw1QwPDE
        EN5JtPtPM/Z1JrEwzs0gSIwbkKYvitLoiwPv796eTcDxry0sxIuQmHoBy22Rxc8sUKYAoBGUoYsUl
        Mij7O5fA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qltIz-005fIC-06;
        Thu, 28 Sep 2023 15:51:57 +0000
Message-ID: <b3d4f630-9725-4ed0-a844-2d370cd67af5@infradead.org>
Date:   Thu, 28 Sep 2023 08:51:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] rpmsg: virtio: Make buffer size and number
 configurable
Content-Language: en-US
To:     Divin Raj <divin.raj@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Peter Hoyes <Peter.Hoyes@arm.com>
References: <20230928153825.151948-1-divin.raj@arm.com>
 <20230928153825.151948-2-divin.raj@arm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230928153825.151948-2-divin.raj@arm.com>
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

Hi,

On 9/28/23 08:38, Divin Raj wrote:
> From: Peter Hoyes <Peter.Hoyes@arm.com>
> 
> Replace the MAX_RPMSG_BUF_SIZE and MAX_RPMSG_NUM_BUFS #define in
> virtio_rpmsg_bus.c with the Kconfig parameters CONFIG_RPMSG_VIRTIO_BUF_SIZE
> and CONFIG_RPMSG_VIRTIO_MAX_NUM_BUFS, allowing user-provided customization.
> 
> Making both the number of buffers and size configurable facilitates aligning
> memory requirements between vdev-buffer and vdev-vrings for client drivers
> that require larger buffer sizes, for example.
> 
> Signed-off-by: Peter Hoyes <Peter.Hoyes@arm.com>
> Signed-off-by: Divin Raj <divin.raj@arm.com>
> ---
>  drivers/rpmsg/Kconfig            | 23 +++++++++++++++++++++++
>  drivers/rpmsg/virtio_rpmsg_bus.c | 27 +++------------------------
>  2 files changed, 26 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
> index d3795860f5c0..677f4a1ac8bb 100644
> --- a/drivers/rpmsg/Kconfig
> +++ b/drivers/rpmsg/Kconfig
> @@ -81,4 +81,27 @@ config RPMSG_VIRTIO
>  	select RPMSG_NS
>  	select VIRTIO
>  
> +config RPMSG_VIRTIO_MAX_BUF_SIZE
> +	int "Virtio RPMSG max buffer size (in bytes)"
> +	default 512

Looks to me like you need to:

(a) use the "range" kconfig keyword (Documentation/kbuild/kconfig-language.rst)
and/or
(b) change the source code (driver) to check that both of these new config
variables' values make sense.

As is (in this patch), I could enter a value of 1 for each of them
and see what happens.

> +	depends on RPMSG_VIRTIO
> +	help
> +	  This option allows you to configure the maximum buffer size (in bytes)
> +	  for Virtio RPMSG communications. The number of buffers will be computed
> +	  based on the number of buffers (CONFIG_RPMSG_VIRTIO_MAX_NUM_BUFS)
> +	  supported by the vring. By default, it supports up to a maximum of 512
> +	  buffers (256 in each direction). Each buffer consists of 16 bytes for the
> +	  message header and the remaining bytes for the payload.The default values

	                                                 payload. The

> +	  will utilize a maximum total space of 256KB for the buffers.
> +
> +config RPMSG_VIRTIO_MAX_NUM_BUFS
> +	int "Virtio RPMSG max buffer count (even number for TX and Rx)"

	                                                    Tx and Rx)"

> +	default 512
> +	depends on RPMSG_VIRTIO
> +	help
> +	  This option allows you to configure the maximum number of buffers used
> +	  for Virtio RPMSG communication. By default, it supports up to a maximum
> +	  of 512 buffers (256 in each direction). Please note that this value
> +	  should be an even number, as it accounts for both transmit (TX) and
> +	  receive (Rx) buffers.
>  endmenu


-- 
~Randy
