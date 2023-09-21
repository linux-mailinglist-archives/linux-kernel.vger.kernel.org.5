Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B097A9994
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjIUSQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjIUSP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:15:28 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACD2E08A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:49:05 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-493545b4eaeso516830e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1695318544; x=1695923344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yr/T9kX37mjruI2YODshHpmgcsopLzBXqNS+RBfjBUE=;
        b=oH0bnqHw0clAFiDJdW/EOS96QC+LBG1gi+rzGK/Z3Ek20naaXRsRLYXZ9Ji4YUDnmq
         8s5NV3n16B4KgKOLMoFKT4AZRZ5rdqPf6lqwE4zpWlkBZ6L5sZ5btzqT1eQPMqSkx86f
         iHoeTJW2g0GPvuMcM4rXc7CgYo4cy/tB6SA7ozEF8TNPk5HMJ4zH8v4qAihhXVvfHso2
         7fF0SYPO8DGO6x0ZyGMdKoOfjpEjAAoh5KzKSE5MhMJlTe/6IvaIw6KwPb+n2aPBEkzl
         3e3jXsR761rRt1k8cNUgESQrR5k8lDEyym07vcZ0JdVICilff5Z34UIk5ny4vnfdjgS7
         mebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318544; x=1695923344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yr/T9kX37mjruI2YODshHpmgcsopLzBXqNS+RBfjBUE=;
        b=OlT/dEe6Dg8fkENm+cbSTcri3pAP58tmlC402jaYQKXPuTsHwWQdlWTPKLWDrcO13Y
         WUHA9/8BJtLyiDw7iCz+g5AHFITo3NtOYJPxkAXAUAAVtZXXMzfMCDwfvgS0uqiR8hDv
         AvXJEVfegT8w8aha90UTPK8kWMo1wFJBhIFdcxiC1ZB+OzXPIZbhzYV6kQo7VFEsq6Ur
         O8H9sMjZamDPHRIUiblws8BWOJthpNQav/z7s8zuHCbaNsrPkzhcJEyVOxvYXmOxuw0M
         m/aVULsA2sBPi9/RE2AUf6kx7p5ymApj7hGzht+Frxs6F/nW6MXq9Rq6BLKp0TTsuan1
         cMUw==
X-Gm-Message-State: AOJu0YxgdlTEtixcDM5STWfjU9pwRGZlRvom+yIPwCS1Ae2AQDjUBGFc
        6dp9/kXL/dyN2nMJoDJg1cpADp1jwDjRv+/K7I2z3Q==
X-Google-Smtp-Source: AGHT+IE3J0hPYG3mlCf0LBXPDD4F3dt6Xy+7aUsS0fZmwILVCrE54YYcSKTbvRwSwG6maa7zoRunYA==
X-Received: by 2002:a05:6a20:914e:b0:14b:e604:9f0a with SMTP id x14-20020a056a20914e00b0014be6049f0amr5003289pzc.20.1695267460994;
        Wed, 20 Sep 2023 20:37:40 -0700 (PDT)
Received: from hermes.local (204-195-112-131.wavecable.com. [204.195.112.131])
        by smtp.gmail.com with ESMTPSA id jc10-20020a17090325ca00b001b9be3b94d3sm251294plb.140.2023.09.20.20.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 20:37:40 -0700 (PDT)
Date:   Wed, 20 Sep 2023 20:37:38 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Mirko Lindner <mlindner@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sky2: Make sure there is at least one frag_addr
 available
Message-ID: <20230920203738.7e2c58c6@hermes.local>
In-Reply-To: <20230920202509.never.299-kees@kernel.org>
References: <20230920202509.never.299-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2023 13:25:13 -0700
Kees Cook <keescook@chromium.org> wrote:

> In the likely pathological case of building sky2 with 16k PAGE_SIZE,
> make sure there is at least 1 frag_addr in struct rx_ring_info:
> 
>    In file included from include/linux/skbuff.h:28,
>                     from include/net/net_namespace.h:43,
>                     from include/linux/netdevice.h:38,
>                     from drivers/net/ethernet/marvell/sky2.c:18:
>    drivers/net/ethernet/marvell/sky2.c: In function 'sky2_rx_unmap_skb':
>    include/linux/dma-mapping.h:416:36: warning: array subscript i is outside array bounds of 'dma_addr_t[0]' {aka 'long long unsigned int[]'} [-Warray-bounds=]
>      416 | #define dma_unmap_page(d, a, s, r) dma_unmap_page_attrs(d, a, s, r, 0)
>          |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/net/ethernet/marvell/sky2.c:1257:17: note: in expansion of macro 'dma_unmap_page'
>     1257 |                 dma_unmap_page(&pdev->dev, re->frag_addr[i],
>          |                 ^~~~~~~~~~~~~~
>    In file included from drivers/net/ethernet/marvell/sky2.c:41:
>    drivers/net/ethernet/marvell/sky2.h:2198:25: note: while referencing 'frag_addr'
>     2198 |         dma_addr_t      frag_addr[ETH_JUMBO_MTU >> PAGE_SHIFT];
>          |                         ^~~~~~~~~
> 
> With CONFIG_PAGE_SIZE_16KB=y, PAGE_SHIFT == 14, so:
> 
>   #define ETH_JUMBO_MTU   9000
> 
> causes "ETH_JUMBO_MTU >> PAGE_SHIFT" to be 0. Use "?: 1" to solve this build warning.
> 
> Cc: Mirko Lindner <mlindner@marvell.com>
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309191958.UBw1cjXk-lkp@intel.com/
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

With page size of 16K the frag_addr[] array would never be used, so the original
code was correct that size should be 0. But the compiler now gets upset with 0
size arrays thinking this is some flex array leftover? Or can't figure out that
in this case an rx skb with fragments would never be created.

The workaround is fine, but could you add an explanatory comment?
