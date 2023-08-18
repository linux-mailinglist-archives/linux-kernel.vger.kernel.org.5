Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AF97805C0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 07:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357637AbjHRFme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 01:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357608AbjHRFmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 01:42:15 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C4526AD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 22:42:13 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6889350bc2bso536802b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 22:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692337333; x=1692942133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vbsontTSe91e+7xkegR3LXuXKl/OSAKaLmQPXVzW/Y=;
        b=EEYomjMCvwvK4W68km7HvqhGMG7uMp9aMRL2By/T6Vmw0UpPDXVzkeESzUEcJZhrnz
         ZcC5PQ68aPsSce1fvL4aGR/YzMCki7QL/c6pTftL5rdDyi2Q4OLzuPHU4kdmIu2sqgmw
         d94SiL8OeBV8zTIr0smNhUpFK0xR8IsOu2+3ZV0mwjV+sf6weeWOj7Xgpdnb3tm8+ys3
         PtsUu+d0oQFovM2yIENNP8YDhZFd3vrX0oto9HYIXV+//093St1mYGxwMBYnbTVXqLvr
         lMg+gREVHMrKI2onsYHXK4aKr9V2OufZsYl7xgnpVL4Kox/1+2MmPYj6tzUb1O04bVTk
         hRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692337333; x=1692942133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vbsontTSe91e+7xkegR3LXuXKl/OSAKaLmQPXVzW/Y=;
        b=DSHwRYBUp8fPkHAI0vVLypgrXjSEQFSSyFg61ybP1MxBoSvKZc1FDGt8uiJ6IEkhYL
         RXBg9j3ES2w3qxSMjOrvhPL6CHeKsYiTS5W9xZkJeXJSuotQ7A1mpQiAts4BvAFcb63E
         21C29yjUn1rtQei6rdO8UVIGO9Yt2cRHXy8ebuhuwE5r6fWLT4o4egMv5WufIYfgzonE
         CwMziV8Wx08VV58xp1f9JoVo73DLi7plgNtNXwyBkzyiK/BFhczmTeYyBZ1/c5Z9O6mj
         VrabYjx6+ReYzBEy0fFUuPy9VLCneZJD2RGN1rhPQpMv+0roWb2M6/papuWV7PVR/vdJ
         P61w==
X-Gm-Message-State: AOJu0YyYLbpwkhmbmH1kOa2WCE+LfB+m+7MzV1E1SQBrBmUert562+BX
        Bq6u4beIpbFjeLr0OQRp4eT1NgFs4w0=
X-Google-Smtp-Source: AGHT+IGUtWffSgvMQmRtj5Av3UCmUmKImM8BO8FzcM/titcddiHq1b7c9c+/A/73gLWrjU0DljOJlA==
X-Received: by 2002:a05:6a00:22c4:b0:687:596e:fa6a with SMTP id f4-20020a056a0022c400b00687596efa6amr2069845pfj.16.1692337333341;
        Thu, 17 Aug 2023 22:42:13 -0700 (PDT)
Received: from localhost ([156.236.96.163])
        by smtp.gmail.com with ESMTPSA id r13-20020a62e40d000000b00686f0133b49sm694048pfh.63.2023.08.17.22.42.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Aug 2023 22:42:13 -0700 (PDT)
Date:   Fri, 18 Aug 2023 13:51:56 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        huyue2@coolpad.com
Subject: Re: [PATCH 6/8] erofs: get rid of fe->backmost for cache
 decompression
Message-ID: <20230818135156.00005a05.zbestahu@gmail.com>
In-Reply-To: <20230817082813.81180-6-hsiangkao@linux.alibaba.com>
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
        <20230817082813.81180-6-hsiangkao@linux.alibaba.com>
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

On Thu, 17 Aug 2023 16:28:11 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> EROFS_MAP_FULL_MAPPED is more accurate to decide if caching the last
> incomplete pcluster for later read or not.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/zdata.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 4009283944ca..c28945532a02 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -528,8 +528,6 @@ struct z_erofs_decompress_frontend {
>  	z_erofs_next_pcluster_t owned_head;
>  	enum z_erofs_pclustermode mode;
>  
> -	/* used for applying cache strategy on the fly */
> -	bool backmost;
>  	erofs_off_t headoffset;
>  
>  	/* a pointer used to pick up inplace I/O pages */
> @@ -538,7 +536,7 @@ struct z_erofs_decompress_frontend {
>  
>  #define DECOMPRESS_FRONTEND_INIT(__i) { \
>  	.inode = __i, .owned_head = Z_EROFS_PCLUSTER_TAIL, \
> -	.mode = Z_EROFS_PCLUSTER_FOLLOWED, .backmost = true }
> +	.mode = Z_EROFS_PCLUSTER_FOLLOWED }
>  
>  static bool z_erofs_should_alloc_cache(struct z_erofs_decompress_frontend *fe)
>  {
> @@ -547,7 +545,7 @@ static bool z_erofs_should_alloc_cache(struct z_erofs_decompress_frontend *fe)
>  	if (cachestrategy <= EROFS_ZIP_CACHE_DISABLED)
>  		return false;
>  
> -	if (fe->backmost)
> +	if (!(fe->map.m_flags & EROFS_MAP_FULL_MAPPED))

So, i understand (map.m_flags & EROFS_MAP_FULL_MAPPED) should be false if allocate cache is needed
(fe->backmost is true)?

>  		return true;
>  
>  	if (cachestrategy >= EROFS_ZIP_CACHE_READAROUND &&
> @@ -939,7 +937,6 @@ static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
>  		erofs_workgroup_put(&pcl->obj);
>  
>  	fe->pcl = NULL;
> -	fe->backmost = false;
>  }
>  
>  static int z_erofs_read_fragment(struct super_block *sb, struct page *page,

