Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9705C7D7D48
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344159AbjJZHGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjJZHGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:06:47 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A16129
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:06:45 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cac925732fso4354315ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698304005; x=1698908805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wMNJftQVf2QXKCuFxZZxgj6EiiH5We62gPsWdhpccM8=;
        b=ixD/WJ73VL6PzyLB/IeIZWO1I9/G+Noqw7o0qSb8dcA0Nt3efnXSui475gBT0UvSc2
         gPcSUfClpcbfvc0BD8ulupLMsglO3uf7mG8Y/19c09D7YnO3GGrGgWqZD5+oH/0SL1yO
         tVhcv6pe3gFAFHquCtVcNL/bagRgHUnAsjWPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698304005; x=1698908805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMNJftQVf2QXKCuFxZZxgj6EiiH5We62gPsWdhpccM8=;
        b=oq1ScnzjijLgD1YR76YNyz600BfTH7Cq4pvIaIeyoGqy3dJ9t9afmdRYXrvxoc+wq3
         pR1a+p2xHlqIyKQqf+WmKgzuVX4ZiR0ScF0Dn0HM1x9L+/9DDgmYUQAXfnkxDRv+riiY
         wG0ayIy31s4Uh5RlyUS+wGcL30WQCCbaMrtUZlQKWdLxLihI60gxwCvHjGXt4l3Iij72
         1xm3v+wV3G/heIhhaen9zt+q/rr0PtgPpAb7XoBFe9uGipvSDNV8IvYSZCw+BDDl/L4H
         d9PVrjFWhg/v0QC/XPkxb2717TniEfQtdnsBcoSPLGeIxmQ8gMtkz1lybBOeWpxcrmxe
         guqA==
X-Gm-Message-State: AOJu0YxeneLVZplw1ZRgALoCiuUZtTIp9Rtu9m125+jAfZikpBNyj3xk
        Ur7RPFi1LOdFJ7R6itrXQJW8Fg==
X-Google-Smtp-Source: AGHT+IGHuqs6cJxAO05b4OtnwLDo1D2gymVrsLExkse7C+G6Afwt0vVL7asDisJo5osA7Lk44ixdag==
X-Received: by 2002:a17:903:110d:b0:1c9:e508:ad43 with SMTP id n13-20020a170903110d00b001c9e508ad43mr17082989plh.8.1698304004990;
        Thu, 26 Oct 2023 00:06:44 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f228:3a07:1e7f:b38f])
        by smtp.gmail.com with ESMTPSA id f11-20020a170902ce8b00b001c5076ae6absm10295706plg.126.2023.10.26.00.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 00:06:44 -0700 (PDT)
Date:   Thu, 26 Oct 2023 16:06:39 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, yosryahmed@google.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] zswap: export compression failure stats
Message-ID: <20231026070639.GB15694@google.com>
References: <20231024234509.2680539-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024234509.2680539-1-nphamcs@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/10/24 16:45), Nhat Pham wrote:
> 
> During a zswap store attempt, the compression algorithm could fail (for
> e.g due to the page containing incompressible random data). This is not
> tracked in any of existing zswap counters, making it hard to monitor for
> and investigate. We have run into this problem several times in our
> internal investigations on zswap store failures.
> 
> This patch adds a dedicated debugfs counter for compression algorithm
> failures.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

FWIW,
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
