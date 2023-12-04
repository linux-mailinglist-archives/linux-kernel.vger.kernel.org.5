Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA0A8038FD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbjLDPjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234647AbjLDPjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:39:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7E1F3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 07:39:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0F8C433C8;
        Mon,  4 Dec 2023 15:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701704346;
        bh=G3X+vmde+cr11/lAMlOMQHfGd+SQv6ekjh9J8L55ZRY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CVZpLFeqSXJ+oqgWCvDcEICrbiSZaOdS+ZZIIYPJPyEynaYyEaqQBTFia3KGSAvQM
         LeA522/+DiQBb67g6AqvgJxMZBGqLnwdqey1BuqYfanwfE7HIyAFqZ4VtZaedSgHW7
         wDysUfO7qMGadjo3YCWhj26TQx25+SnUbP1EGwAfc/7m8xr7G20oA8+EoubfK9eqAw
         AkduxD8F9Tkm1jEW9+WUTo5mRhBMImuICHbMqFzYahEJ4CBdo9v7p9ac0dBvnFRzDF
         3GA01P9uc1n7CknA2RYxzjDIB7thFxTfDFeKSXPkvhM5IZwJ7zNO8xBfNZzTautCgc
         ZPzhPGWeyeFqw==
Date:   Mon, 4 Dec 2023 15:38:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc:     <nuno.sa@analog.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 03/12] iio: add the IIO backend framework
Message-ID: <20231204153855.71c9926f@jic23-huawei>
In-Reply-To: <20231121-dev-iio-backend-v1-3-6a3d542eba35@analog.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
        <20231121-dev-iio-backend-v1-3-6a3d542eba35@analog.com>
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

On Tue, 21 Nov 2023 11:20:16 +0100
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> This is a Framework to handle complex IIO aggregate devices.
> 
> The typical architecture is to have one device as the frontend device which
> can be "linked" against one or multiple backend devices. All the IIO and
> userspace interface is expected to be registers/managed by the frontend
> device which will callback into the backends when needed (to get/set
> some configuration that it does not directly control).

As this is first place backend / frontend terminology used (I think), make
sure to give an example so people understand what sorts of IP / devices thes
might be.

> 
> The basic framework interface is pretty simple:
>  - Backends should register themselves with @devm_iio_backend_register()
>  - Frontend devices should get backends with @devm_iio_backend_get()
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>

Looks good to me in general.  I'll need to have a really close read though
before we merge this as there may be sticky corners! (hopefully not)


...

> +static LIST_HEAD(iio_back_list);
> +static DEFINE_MUTEX(iio_back_lock);
> +
> +/*
> + * Helper macros to properly call backend ops. The main point for these macros
> + * is to properly lock the backend mutex on every call plus checking if the
> + * backend device is still around (by looking at the *ops pointer).
If just checking if it is around rather thank looking for a bug, then
I'd suggest a lighter choice than WARN_ON_x 

Btw, there were some interesting discussions on lifetimes and consumer / provider
models at plumbers. I think https://www.youtube.com/watch?v=bHaMMnIH6AM will be
the video.   Suggested the approach of not refcounting but instead allowing for
a deliberate removal of access similar to your check on ops here (and the one
we do in core IIO for similar purposes).  Sounded interesting but I've not
explored what it would really mean to switch to that model yet.

> + */
> +#define iio_backend_op_call(back, op, args...) ({ \
> +	struct iio_backend *__back = back; \
> +	int __ret; \
> +			\
> +	guard(mutex)(&__back->lock); \
> +	if (WARN_ON_ONCE(!__back->ops)) \
> +		__ret = -ENODEV; \
> +	else if (!__back->ops->op) \
> +		__ret = -EOPNOTSUPP; \
> +	else \
> +		__ret = __back->ops->op(__back, ##args); \
> +	\
> +	__ret; \
> +})

