Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD96A79D28A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbjILNnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjILNnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:43:23 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B6010CE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:43:19 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-570a432468bso4759765a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694526198; x=1695130998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WKq1CwYyAbmQWns7LQv80RiVk9XLUwPxMYeYInEJp54=;
        b=guAxpTTY05jKIPo8RMQCRJSaBGwOKC/0N4tUCMlJ2zYM4RL5q6zU03ghQRUDpucuil
         L1iUr1whVxsw4ZTd2b2vwrRFzZWS/GoF3eFifNcF5vYIgWlpdBA+yy0tBxcAK1ETZ0jA
         S8c+2tIzO1Mrq79fN8oJBugnxZBEwnJfrVeBa1WP23SzsArgQpkSuG1Fm2ySVGEfu/le
         SfaA7mXsPcEOOrxTQddNo3BT21pAY0ekpzzTZA3Tf4xs+9JX+CAp0LxZfhE6lz96iUPW
         edj/TCrhg3th9RU3DQNpr4OwD57BFLOz0WJPnlk2bKciDK8iXCYpl1smWfZEWlbw1aVk
         zcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694526198; x=1695130998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKq1CwYyAbmQWns7LQv80RiVk9XLUwPxMYeYInEJp54=;
        b=vM8BJfJwRgAoCZI+52SudD+eu0MVbDwN1xuyYiD3Rbnu5VFyIHlW+5Bt3KUW2XApRy
         kvodZ+96yaEjrYGw+RDpOGI0qE0JmSYl9DDeXON7cwZbFPiY0MdPKHFx+kO3Ib17T/cj
         z/rm5JIoasZ80YNs5QAlzu4ZcpBMcGiLvDD01VjacNlsNgCVSur3yDNAcdCDj1Cjq4Nt
         ICmzOqqtqv/2Y07dPeMGsqCaM64E8Ga5XCdeWcf6vusD0MDKGSuWXqSKoPw5Fiw9py+l
         wYnT6XkaV5Bh32nDvOa1mSeaKhh4ffgIf/t5V+aXMWAYaDc/axz1hkGiXbRcGk3gnKK6
         iBcA==
X-Gm-Message-State: AOJu0YzBxuE6KbpuxIVBMzhLAvgyrzm9u8mRO2WI3XL/kOFiGrNiGDBX
        No/QS0iAwNAl952yZMBoi5Q=
X-Google-Smtp-Source: AGHT+IFcy9pbZS0e8W0NdIZCKQVqCu4A3lrffXL4gq3cqb2foPmyJHCan3jkkHhLWAPeUwhjr9TROA==
X-Received: by 2002:a17:90b:a4e:b0:261:219b:13b3 with SMTP id gw14-20020a17090b0a4e00b00261219b13b3mr3477418pjb.16.1694526197577;
        Tue, 12 Sep 2023 06:43:17 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id bf11-20020a17090b0b0b00b0026801e06ac1sm7537115pjb.30.2023.09.12.06.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:43:17 -0700 (PDT)
Date:   Tue, 12 Sep 2023 06:43:15 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 1/4] bitmap: define a cleanup function for bitmaps
Message-ID: <ZQBq81QRFVOMBmnB@yury-ThinkPad>
References: <20230912085541.13682-1-brgl@bgdev.pl>
 <20230912085541.13682-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912085541.13682-2-brgl@bgdev.pl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 10:55:38AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add support for autopointers for bitmaps allocated with bitmap_alloc()
> et al.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  include/linux/bitmap.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 03644237e1ef..ba8c0d733842 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -6,6 +6,7 @@
>  
>  #include <linux/align.h>
>  #include <linux/bitops.h>
> +#include <linux/cleanup.h>
>  #include <linux/find.h>
>  #include <linux/limits.h>
>  #include <linux/string.h>
> @@ -125,6 +126,8 @@ unsigned long *bitmap_alloc_node(unsigned int nbits, gfp_t flags, int node);
>  unsigned long *bitmap_zalloc_node(unsigned int nbits, gfp_t flags, int node);
>  void bitmap_free(const unsigned long *bitmap);
>  
> +DEFINE_FREE(bitmap, unsigned long *, bitmap_free(_T))

So now it doesn't do weird  "if (_T) bitmap_free(_T)". Have you got any
feedback from Peter for that?

My point is that if the above is correct, all the following
declarations need to be revisited:

yury:linux$ git grep DEFINE_FREE|grep if
include/linux/cleanup.h:25: * DEFINE_FREE(kfree, void *, if (_T) kfree(_T))
include/linux/device.h:1058:DEFINE_FREE(device_del, struct device *, if (_T) device_del(_T))
include/linux/device.h:1228:DEFINE_FREE(put_device, struct device *, if (_T) put_device(_T))
include/linux/mutex.h:224:DEFINE_FREE(mutex, struct mutex *, if (_T) mutex_unlock(_T))
include/linux/rwsem.h:208:DEFINE_FREE(up_read, struct rw_semaphore *, if (_T) up_read(_T))
include/linux/rwsem.h:209:DEFINE_FREE(up_write, struct rw_semaphore *, if (_T) up_write(_T))
include/linux/sched/task.h:164:DEFINE_FREE(put_task, struct task_struct *, if (_T) put_task_struct(_T))
include/linux/slab.h:231:DEFINE_FREE(kfree, void *, if (_T) kfree(_T))

For the patch:
Acked-by: Yury Norov <yury.norov@gmail.com>
