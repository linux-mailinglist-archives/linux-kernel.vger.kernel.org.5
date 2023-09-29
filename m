Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6D37B2BEF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 07:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbjI2Fp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 01:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbjI2Fpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 01:45:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF921988;
        Thu, 28 Sep 2023 22:44:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BB4C433C8;
        Fri, 29 Sep 2023 05:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695966250;
        bh=kNJrnRROLK/zlovKI6ojWkpk5gYRk5hPMgbZvwKq91E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pky3UToXd+3pyTO8uIBHwYitjH2WT3H7AkCaG3BtgOXGUbAS7tK/k6R2uC11hvvM0
         UF4VuTfMhPUruIkyBG4LHNqFxS9VGQuxDzEq9qdvyqJhSdC6gF3m+1FbIJr5QGHz/B
         E69lTcW0ixfGzvmW7oAwtNqcKIFZsQk2JCG8wjzc=
Date:   Fri, 29 Sep 2023 07:44:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Graf <graf@amazon.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Olivia Mackall <olivia@selenic.com>,
        Petre Eftime <petre.eftime@gmail.com>,
        Erdem Meydanlli <meydanli@amazon.nl>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 1/2] misc: Add Nitro Secure Module driver
Message-ID: <2023092906-strangle-pawing-16e2@gregkh>
References: <20230928224645.19768-1-graf@amazon.com>
 <20230928224645.19768-2-graf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928224645.19768-2-graf@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 10:46:44PM +0000, Alexander Graf wrote:
> When running Linux inside a Nitro Enclave, the hypervisor provides a
> special virtio device called "NSM". This device has 2 main functions:
> 
>   1) Provide attestation reports
>   2) Modify PCR state
>   3) Provide entropy
> 
> This patch adds the core NSM driver that exposes a /dev/nsm device node
> which user space can use to request attestation documents and influence
> PCR states. A follow up patch will add a hwrng driver to feed its entropy
> into the kernel.
> 
> Originally-by: Petre Eftime <petre.eftime@gmail.com>

Hasn't this been submitted a long time ago?  What changed from that
submission?  Or am I mis-remembering things?

> --- /dev/null
> +++ b/drivers/misc/nsm.c
> @@ -0,0 +1,470 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Amazon Nitro Secure Module driver.
> + *
> + * Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.

Please drop the license "boiler-plate" text, the SPDX line is
sufficient.

thanks,

greg k-h
