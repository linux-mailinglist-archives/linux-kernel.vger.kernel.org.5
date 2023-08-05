Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2BA770E8C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 09:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjHEHqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 03:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHEHqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 03:46:52 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347D34ED0
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 00:46:51 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a751d2e6ecso2366811b6e.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 00:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691221610; x=1691826410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U1mEWjsyNQNOirkLaDS1Y1oFaBtO0Luk8gm6hQtL+B0=;
        b=gYpc42vwz/s19PPS5t63FXo5gl978IpSucQQFfGTi78M9HKDNRxK8GLTJVAFmqMXBX
         +F7ui19W2YKEx8yyrvhdMXvVtyKvYYL4xO15NEikMmV/nbPrgbiQVnTunVOUtkR9xy1v
         hKRZrorI88qOKX4qfus+OxJ8TKRtthdZlwMxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691221610; x=1691826410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1mEWjsyNQNOirkLaDS1Y1oFaBtO0Luk8gm6hQtL+B0=;
        b=PBfojyu3NC6h3iFGulN/AxQAa7qc21fMroIAUcz+uRixnGWQlb8+D2EfBcUQmz8WeJ
         DLdLHXI2v4a+at1qZg/c9+bNWDE4r8SEmhdeKww8/MQ9deH82HDtR8Equ6HwgcwTVGie
         9fvTKtJhqJ5Iiv58MOTc2SGCyI/rKTDKPY01q3gvGiM6fYoYDXzaNUGGAsyRS/LvieaQ
         oBiZks/k/BPHW/m5K0mEDw9gOSngCTgHm/j57DSXSbIXhrfmWNaxnVtma5gz8UmnH0PB
         dWwae8mcSzJqfipge6TCSb7itpZd2pCmrL3T8WEsGji3dtfkjpE++ulC2SfzM7I9XMvp
         QwLA==
X-Gm-Message-State: AOJu0YwfcF68vuQl26jcle9tDZdFCOtQi5q5TAuWjXS+kaEEYWBBKANs
        4uoSpVyzvyolM4Gw7/XAJ6wkQw==
X-Google-Smtp-Source: AGHT+IH+mecttJDCWN0D2JzxDKMjWIxjBSgbvyI8PDA2CSww2tKZAlAEgwnWhRF2ziiAIMLnqVMAqw==
X-Received: by 2002:a54:4006:0:b0:3a7:2599:e10 with SMTP id x6-20020a544006000000b003a725990e10mr4376705oie.41.1691221610504;
        Sat, 05 Aug 2023 00:46:50 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id g10-20020a62e30a000000b0066a613c4a58sm2614148pfh.102.2023.08.05.00.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 00:46:50 -0700 (PDT)
Date:   Sat, 5 Aug 2023 16:46:45 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     minchan@kernel.org, senozhatsky@chromium.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dusty Mabe <dusty@dustymabe.com>
Subject: Re: [PATCH] zram: take device and not only bvec offset into account
Message-ID: <20230805074645.GA907732@google.com>
References: <20230805055537.147835-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230805055537.147835-1-hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/08/05 07:55), Christoph Hellwig wrote:
> Commit af8b04c63708 ("zram: simplify bvec iteration in
> __zram_make_request") changed the bio iteration in zram to rely on the
> implicit capping to page boundaries in bio_for_each_segment.  But it
> failed to care for the fact zram not only care about the page alignment
> of the bio payload, but also the page alignment into the device.  For
> buffered I/O and swap those are the same, but for direct I/O or kernel
> internal I/O like XFS log buffer writes they can differ.
> 
> Fix this by open coding bio_for_each_segment and limiting the bvec len
> so that it never crosses over a page alignment boundary in the device
> in addition to the payload boundary already taken care of by
> bio_iter_iovec.
> 
> Fixes: af8b04c63708 ("zram: simplify bvec iteration in __zram_make_request")
> Reported-by: Dusty Mabe <dusty@dustymabe.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Sergey Senozhatsky <senozhatsky@chromium.org>
