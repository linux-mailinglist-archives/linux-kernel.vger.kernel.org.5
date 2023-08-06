Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D087713D2
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 09:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjHFHQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 03:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHFHQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 03:16:09 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857181FCD
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 00:16:07 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bba48b0bd2so22407985ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 00:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691306167; x=1691910967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f1cC44qcZYBIcGUfzoCdu9nx9KiNTrSbTmLs8T1S274=;
        b=Kd5pIGopqU5EnXakxalZyW2dhaMcCG0JQLJjdJbyY8/i5b/iAVZ6jacxFc/WBGw7TZ
         lNFxcdciTl/M7gTrFLHB+GRtlfq/ThS2fd8T5o3/p18HTpelyOOezVaATrbOeY9HRuAP
         mnviOjpeni7zbextffZd5mlV9tbYweMErJY+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691306167; x=1691910967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1cC44qcZYBIcGUfzoCdu9nx9KiNTrSbTmLs8T1S274=;
        b=UoB/xpS2R/23SDx3Zp+EjwFP9mrCtFjkh1T6dDNmQqebm0zbRt61QnEtFvoPwcs169
         UOAmg39mrJ05RpEEPBpMJvmzsGXLfegW66AMGe5zziwpYAe4a2AMrU+LsrsomzIjCgts
         CP+tXHgubJSR4CqXlVnI3dPHXpBby7f9sUtVBQf2meolAD+8pJ73ZoyPW/Uily8YHsvi
         X7YZdHuGwAOGolLq66LeXmHMMfIWOoeCgB1wHYuHshAiKRDszOTXS321zjl5laZWsXO7
         /ORGSEPW7Kc26xcQx5urXcJUEkpkMLQtT2wF9wWkgWJJwpkeN/RxPL6DfjDZOqapd+JW
         yy1g==
X-Gm-Message-State: AOJu0YzBd+HLVPDyHUjs8pAdRbnHVhAHXqqOlKGdtTq5Bs4LFpkEMKrs
        Ns+Cy7kleOIrAVtbuP0nbhsk4w==
X-Google-Smtp-Source: AGHT+IFEHBJ4DDuyqM/dQDN0aPzndo/IuYpJsH4xff2mPzui4ao44kG2ICtjSio+J2LQT8pzDs7LaA==
X-Received: by 2002:a17:902:e74c:b0:1b6:6b90:7c2f with SMTP id p12-20020a170902e74c00b001b66b907c2fmr5879078plf.55.1691306166662;
        Sun, 06 Aug 2023 00:16:06 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id p17-20020a170902ead100b001b03a1a3151sm4492969pld.70.2023.08.06.00.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 00:16:06 -0700 (PDT)
Date:   Sun, 6 Aug 2023 16:16:01 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>, minchan@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dusty Mabe <dusty@dustymabe.com>
Subject: Re: [PATCH] zram: take device and not only bvec offset into account
Message-ID: <20230806071601.GB907732@google.com>
References: <20230805055537.147835-1-hch@lst.de>
 <20230805074645.GA907732@google.com>
 <20230805081306.GA29615@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230805081306.GA29615@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/08/05 10:13), Christoph Hellwig wrote:
> On Sat, Aug 05, 2023 at 04:46:45PM +0900, Sergey Senozhatsky wrote:
> > > Fixes: af8b04c63708 ("zram: simplify bvec iteration in __zram_make_request")
> > > Reported-by: Dusty Mabe <dusty@dustymabe.com>
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > Acked-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> 
> Btw, are there any interesting test suites you want me to run on
> a > 4K page size system now that I do have this setup available?

I don't really have any special tests. I used to run fio, but switched
to a shell script that:

1) configures zram0 and adds zram1 as writeback
2) mkfs.ext4 on zram0, cp linux tar.gz, compile (in parallel)
3) deferred recompress (idle and size based)
4) idle writeback
5) re-reads all writtenback pages

I test on a system with 4K pages, tho, I probably need to get an image
with larger PAGE_SIZE.
