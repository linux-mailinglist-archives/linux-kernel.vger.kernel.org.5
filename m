Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FD57806B8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 09:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358364AbjHRHxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 03:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358378AbjHRHwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 03:52:35 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0023A3A82
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 00:52:33 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bf3a2f44ffso2692835ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 00:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692345153; x=1692949953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8duZBb7/Vz58MaN/PoDCFguJ69017evWqg3k7byHQ8=;
        b=WHE5axGTJJDn72IbHvrVDFL9Shc7pKsphrM41sfga6yldUjEDjTrCFcJpIdEQ6X/d/
         ZedG5dJD3PhFdQ9nGeuXOgLXGHq3fAciJO7f6RaEugjCwKsFCvQrd/SyJTHEyGjHNqnt
         kdvi50NXP2xMIZV7BXu8Nv1k2M6gCW43BKxesg3PUBILx4YdjsnWvo96DTvW7e+OX7qA
         xac2cntYz9c1WDQd8W4Pf2Rtot8p+5L/6ySeBHINEuKOeVBD5HMKCDHJ4HFrdOMcHaMj
         kx8+6O2T2aH/YZH95d64zof7KJn1cgA1wdTs6MEWpNMgHketAxKgi+9HnCHMp2HafGTR
         J+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692345153; x=1692949953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8duZBb7/Vz58MaN/PoDCFguJ69017evWqg3k7byHQ8=;
        b=E5BDHbqeVdSqkpwsxyBPWxYBM1ojIXfNPg3Mhw1vn+GOOdQouuuAHcOE4fAgYMVh1C
         s8cBiw31f6tINPW3JBPo6qdNe6g8vpi+7dVyFkdm90fdd3diFHpVFaqYDwDj/ACwGOjO
         9ZNApD6xs/iEewp2MtxOpOSgZsy1i/5hrdCV7e02XyAQKmag8YYhTEVfpZ8MYQj6Medk
         6EQCos4c9iKLHrtLxEQfadO/lb0RXcqfB/3VKpFx91HR59y3nmYNFPwETg6S4aQT1R3O
         /cwExgzm4bqRobxcG7Ca5AW69iXmgsEn+Lv5t9LjO7Ose5gXXl25EpESFppnJn86Wunw
         YCwA==
X-Gm-Message-State: AOJu0YwoK4nJ9nNFuFEadKgTkAncAKNe/ZIEq2nIHEuOEMcj4fQY+f98
        zMoUyeIqPbfR+bL/uNcQ+nmxKpYk/EI=
X-Google-Smtp-Source: AGHT+IFVeicJUnhXS4O2X3WbCbT5hTFJs9hWM5MC641m0k5xentlHDNDAabEJjdJmUnrggei0ff3jQ==
X-Received: by 2002:a17:902:c94d:b0:1b8:88c5:2d2f with SMTP id i13-20020a170902c94d00b001b888c52d2fmr2095248pla.64.1692345153286;
        Fri, 18 Aug 2023 00:52:33 -0700 (PDT)
Received: from localhost ([156.236.96.163])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902b78900b001b5656b0bf9sm1038102pls.286.2023.08.18.00.52.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Aug 2023 00:52:33 -0700 (PDT)
Date:   Fri, 18 Aug 2023 16:02:16 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        huyue2@coolpad.com
Subject: Re: [PATCH 6/8] erofs: get rid of fe->backmost for cache
 decompression
Message-ID: <20230818160216.00002bfd.zbestahu@gmail.com>
In-Reply-To: <671a514f-8597-7693-1323-929e39c56dda@linux.alibaba.com>
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
        <20230817082813.81180-6-hsiangkao@linux.alibaba.com>
        <20230818135156.00005a05.zbestahu@gmail.com>
        <671a514f-8597-7693-1323-929e39c56dda@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2023 15:48:08 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On 2023/8/18 13:51, Yue Hu wrote:
> > On Thu, 17 Aug 2023 16:28:11 +0800
> > Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >   
> >> EROFS_MAP_FULL_MAPPED is more accurate to decide if caching the last
> >> incomplete pcluster for later read or not.
> >>
> >> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> >> ---
> >>   fs/erofs/zdata.c | 7 ++-----
> >>   1 file changed, 2 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> >> index 4009283944ca..c28945532a02 100644
> >> --- a/fs/erofs/zdata.c
> >> +++ b/fs/erofs/zdata.c
> >> @@ -528,8 +528,6 @@ struct z_erofs_decompress_frontend {
> >>   	z_erofs_next_pcluster_t owned_head;
> >>   	enum z_erofs_pclustermode mode;
> >>   
> >> -	/* used for applying cache strategy on the fly */
> >> -	bool backmost;
> >>   	erofs_off_t headoffset;
> >>   
> >>   	/* a pointer used to pick up inplace I/O pages */
> >> @@ -538,7 +536,7 @@ struct z_erofs_decompress_frontend {
> >>   
> >>   #define DECOMPRESS_FRONTEND_INIT(__i) { \
> >>   	.inode = __i, .owned_head = Z_EROFS_PCLUSTER_TAIL, \
> >> -	.mode = Z_EROFS_PCLUSTER_FOLLOWED, .backmost = true }
> >> +	.mode = Z_EROFS_PCLUSTER_FOLLOWED }
> >>   
> >>   static bool z_erofs_should_alloc_cache(struct z_erofs_decompress_frontend *fe)
> >>   {
> >> @@ -547,7 +545,7 @@ static bool z_erofs_should_alloc_cache(struct z_erofs_decompress_frontend *fe)
> >>   	if (cachestrategy <= EROFS_ZIP_CACHE_DISABLED)
> >>   		return false;
> >>   
> >> -	if (fe->backmost)
> >> +	if (!(fe->map.m_flags & EROFS_MAP_FULL_MAPPED))  
> > 
> > So, i understand (map.m_flags & EROFS_MAP_FULL_MAPPED) should be false if allocate cache is needed
> > (fe->backmost is true)?  
> 
> fe->backmost is inaccurate compared with !EROFS_MAP_FULL_MAPPED,
> if !EROFS_MAP_FULL_MAPPED, it should be cached instead.

Okay.

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> 
> Thanks,
> Gao Xiang

