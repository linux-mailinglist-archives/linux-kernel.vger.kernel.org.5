Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93847BF2D3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442215AbjJJGPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442156AbjJJGPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:15:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAC997;
        Mon,  9 Oct 2023 23:15:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFFDC433C8;
        Tue, 10 Oct 2023 06:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696918543;
        bh=wY8QJkm+jocEeUpbq07zihxLMe27HPMooctLb8gtMAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JWDN21mJ9Z8E6RBWQSwNWfPjoNta/kvTTopqAQAUKPlYbHjSKbVZIBEvBi7qP3YeL
         yH7t8Wo+Ylsa+5+lhUVhorqFdYvjb8qAyx1c9MN1h8Dye+aKfLpNQswtI6d8x0M5K1
         MJO1iForDWmtCxJQJyElkm25bgEXzEPHJII+D9ps=
Date:   Tue, 10 Oct 2023 08:15:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Graf <graf@amazon.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Olivia Mackall <olivia@selenic.com>,
        Petre Eftime <petre.eftime@gmail.com>,
        Erdem Meydanlli <meydanli@amazon.nl>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Kyunghwan Kwon <k@mononn.com>
Subject: Re: [PATCH v4 2/2] misc: Add Nitro Secure Module driver
Message-ID: <2023101010-margarita-whomever-d4a2@gregkh>
References: <20231009212053.2007-1-graf@amazon.com>
 <20231009212053.2007-3-graf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009212053.2007-3-graf@amazon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 09:20:53PM +0000, Alexander Graf wrote:
> When running Linux inside a Nitro Enclave, the hypervisor provides a
> special virtio device called "NSM". This device has 3 main functions:
> 
>   1) Provide attestation reports
>   2) Modify PCR state
>   3) Provide entropy
> 
> This patch adds a driver for NSM that exposes a /dev/nsm device node which
> user space can issue ioctls on to request attestation documents, influence
> PCR states, read entropy and enumerate status of the device. In addition,
> the driver implements a hwrng backend and exposes some of the NSM device
> metadata as sysfs entries.
> 
> Originally-by: Petre Eftime <petre.eftime@gmail.com>
> Signed-off-by: Alexander Graf <graf@amazon.com>
> 
> ---
> 
> v1 -> v2:
> 
>   - Remove boilerplate
>   - Add uapi header
> 
> v2 -> v3:
> 
>   - Move globals to device struct
>   - Add compat handling
>   - Simplify some naming
>   - Remove debug prints
>   - Use module_virtio_driver
>   - Drop use of uio.h
> 
> v3 -> v4:
> 
>   - Merge hwrng into the misc driver
>   - Add dependency on CBOR library
>   - Add internal and ioctl logic for all current NSM actions
>   - Use in-struct arrays instead of kvecs
>   - Add sysfs entries for NSM metadata

You forgot Documentation/ABI/ entries for your new sysfs files so we can
see what exactly they are and if they are sane.

thanks,

greg k-h
