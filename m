Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C3F75A3D7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 03:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjGTBWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 21:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGTBWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 21:22:14 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E4C1FD7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 18:22:13 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7679d444210so26967485a.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 18:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689816131; x=1690420931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVA6drGXi7u+m/uOyL9hmh7fUijxlyZAc3olxOhfruY=;
        b=fqSVCtzaW2L0CCx64PDoxXWac4ZRL5RO0YilB/Ap2YzVLI06cOHtMCeFWYBluMyw4a
         p5vMHnQlbBRR/DiLFtt0ZKUWoWekk6IBxTU4hI4OP80Sy6mCcHBpegvcL4+ODT8QgkpL
         gEeEfM8GEexXXtpcPjjeur2IeTHjb8lL4WRLYOzasQfv+Hx5szs+ABX1MFDEXBmC75AU
         6IAAFeSH6ddVvqZZEG7yo4z/l++2XMdsZJ4/0pUYR4TVNnZbFRT3tEHZIdfzxIqOzhKV
         xhLEkvjCfGXH69ICPWTLOaMNwc6H3mYp5N7SZ99N+dOJW4w1o7fGCyx/sAnhacWPFx+E
         gm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689816131; x=1690420931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVA6drGXi7u+m/uOyL9hmh7fUijxlyZAc3olxOhfruY=;
        b=JD+HAqbELNpMdLhCdplsOhU8R5aHHBjXKdGkeqbDqEo7InlqsKJJraQc2fkfEMp9XF
         bTVyySpTttWHA/gSwELCvjHO5YWM+fDkwlwGhlkpjkR4rTJdKe1XgJTKRXzDo8EaWhcc
         YVuLyVWETGC4d2z4wAdirki8K0kkA4/KXR+DocF3G03GYlaeKEVbfBgLBHBI2OlpyR5h
         ThVaUxyxy8VBZPik8PUNmp5uEZosszIr1xx7EkgoPVw0ynzNCPdVgHvgKdJUlBChTceP
         70AirMvnHgwZq5DjJ/6qThCSctAFVqaqzTbCrm3r1lj0CQGOeUuKSKh8GrRernUKy1Dm
         mVYg==
X-Gm-Message-State: ABy/qLaov8pdj8MC77Oz104+PTxIiq/ulnaM3hD/4+RH1pj/gYoanplg
        6zWYFEVbfxnxl+2O+0/vw1Y7O7masOU=
X-Google-Smtp-Source: APBJJlFSznkdmTOuBiXGpiSdQW6Nu4yy4kwn1kB1lnPoqtt7sAGb1Vx3Hdov0iCVPjzHx4eRGRDa3w==
X-Received: by 2002:a05:620a:3915:b0:767:fec4:1eb9 with SMTP id qr21-20020a05620a391500b00767fec41eb9mr1244906qkn.69.1689816130773;
        Wed, 19 Jul 2023 18:22:10 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a0f1700b00256b67208b1sm1772811pjy.56.2023.07.19.18.22.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jul 2023 18:22:10 -0700 (PDT)
Date:   Thu, 20 Jul 2023 09:31:17 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Shijie Sun <sunshijie@xiaomi.com>,
        LKML <linux-kernel@vger.kernel.org>, huyue2@coolpad.com,
        zhangwen@coolpad.com
Subject: Re: [PATCH] erofs: fix wrong primary bvec selection on deduplicated
 extents
Message-ID: <20230720093117.000072a1.zbestahu@gmail.com>
In-Reply-To: <20230719065459.60083-1-hsiangkao@linux.alibaba.com>
References: <20230719065459.60083-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 14:54:59 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> When handling deduplicated compressed data, there can be multiple
> decompressed extents pointing to the same compressed data in one shot.
> 
> In such cases, the bvecs which belong to the longest extent will be
> selected as the primary bvecs for real decompressors to decode and the
> other duplicated bvecs will be directly copied from the primary bvecs.
> 
> Previously, only relative offsets of the longest extent was checked to
> decompress the primary bvecs.  On rare occasions, it can be incorrect
> if there are several extents with the same start relative offset.
> As a result, some short bvecs could be selected for decompression and
> then cause data corruption.
> 
> For example, as Shijie Sun reported off-list, considering the following
> extents of a file:
>  117:   903345..  915250 |   11905 :     385024..    389120 |    4096
> ...
>  119:   919729..  930323 |   10594 :     385024..    389120 |    4096
> ...
>  124:   968881..  980786 |   11905 :     385024..    389120 |    4096
> 
> The start relative offset is the same: 2225, but extent 119 (919729..
> 930323) is shorter than the others.
> 
> Let's restrict the bvec length in addition to the start offset if bvecs
> are not full.
> 
> Reported-by: Shijie Sun <sunshijie@xiaomi.com>
> Fixes: 5c2a64252c5d ("erofs: introduce partial-referenced pclusters")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

