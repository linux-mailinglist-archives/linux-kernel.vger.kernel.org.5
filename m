Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B31C78F451
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 22:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345052AbjHaU6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 16:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjHaU6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 16:58:07 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0003B5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 13:58:04 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68bedc0c268so1059509b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 13:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693515484; x=1694120284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=55mVwzwCwX2OqOMYg+qP8dIaDr0iPQAAOCdnJlCo4kM=;
        b=C2TgXXmebjk0VBpKND8fekJcda/lj/3NUo6XkKS49pX+tLm0u1RwVVWxm87liQFZpI
         3EUOGWWOJ5fDwys0HvHnd1qpNXmtrFbSKF+o56cMriHdQDB+eyhyFtP3u1TejW34ahV0
         WBBSHPEH8ybtq8o8ld67U1/pwGBtiJugu+Rjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693515484; x=1694120284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55mVwzwCwX2OqOMYg+qP8dIaDr0iPQAAOCdnJlCo4kM=;
        b=YU8yVsMa0P75H+8cdxBb60/HZzCmOXs0/Lhd3Tn/Sl6+Hfm7H+v/Nt37IH2TyyoYPh
         ciiSowaWLML6eJ9suYy6IpUUMDsB+wpkgYC3jcjGs9bk+XEuP1XhwnJxrWhFkcxuSyFb
         h8nivtNPxASyWjvIiRE/9w0sjq/pbDKhmmVMe/pyzXbH3Xx6O13Ji0ou/gR765vQe8PS
         +6RmApkj9dpIdwVSYLEwCZ8yRfBH2ki+4oeHL+UVqTOC0rLLrR5+gPFrPLYpbnJ3h/mJ
         hKTVzI1li3V8a6Xkd5xPsUYv45Skg3dlL+lDum5HU40EEIu4mW3L/+ikyyU2FQRiZhcc
         PmnA==
X-Gm-Message-State: AOJu0YwNC+NJa0mlzfVhtxp0/vraCW0Nb/ZLY9pCgmsr61alZ5FVBV+3
        BS6kq2743ynafRn5OdL2snpUUrRE0Sr4uHSWfXA=
X-Google-Smtp-Source: AGHT+IEXDJyww5pTYs3pWv2py0AWvx4YaPKnNIw+6CJoyGsEzDk2+0n/6iY4jlqfBsbXstPmulq7YA==
X-Received: by 2002:a05:6300:8084:b0:14d:8624:b144 with SMTP id ap4-20020a056300808400b0014d8624b144mr803446pzc.61.1693515484146;
        Thu, 31 Aug 2023 13:58:04 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z192-20020a6333c9000000b00565cc03f150sm1675590pgz.45.2023.08.31.13.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 13:58:03 -0700 (PDT)
Date:   Thu, 31 Aug 2023 13:58:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] pstore: Base compression input buffer size on estimated
 compressed size
Message-ID: <202308311344.2DC911AC3@keescook>
References: <20230830212238.135900-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830212238.135900-1-ardb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 11:22:38PM +0200, Ard Biesheuvel wrote:
> So let's fix both issues, by bringing back the typical case estimation of
> how much ASCII text captured from the dmesg log might fit into a pstore
> record of a given size after compression. The original implementation
> used the computation given below for zlib, and so simply taking 2x as a
> ballpark number seems appropriate here.
> 
>   switch (size) {
>   /* buffer range for efivars */
>   case 1000 ... 2000:
>   	cmpr = 56;
>   	break;
>   case 2001 ... 3000:
>   	cmpr = 54;
>   	break;
>   case 3001 ... 3999:
>   	cmpr = 52;
>   	break;
>   /* buffer range for nvram, erst */
>   case 4000 ... 10000:
>   	cmpr = 45;
>   	break;
>   default:
>   	cmpr = 60;
>   	break;
>   }
> 
>   return (size * 100) / cmpr;

I remained suspicious of this since the old worst-case was 60%, not
50%... In testing with some instrumentation I was able to find compression
failures (see the "-22" results in the middle):

pstore: backend max size:1024 dump size:2034 zipped size:800
pstore: backend max size:1024 dump size:1943 zipped size:714
pstore: backend max size:1024 dump size:2008 zipped size:739
pstore: backend max size:1024 dump size:2024 zipped size:722
pstore: backend max size:1024 dump size:2017 zipped size:926
pstore: backend max size:1024 dump size:2046 zipped size:-22
pstore: backend max size:1024 dump size:2046 zipped size:-22
pstore: backend max size:1024 dump size:2007 zipped size:890
pstore: backend max size:1024 dump size:2035 zipped size:830
pstore: backend max size:1024 dump size:2012 zipped size:844
pstore: backend max size:1024 dump size:1978 zipped size:823
pstore: backend max size:1024 dump size:2013 zipped size:543
pstore: backend max size:1024 dump size:2000 zipped size:820

So, I altered the patch slightly to use the 60% worst-case (i.e. an
underestimate), and that did the trick (you can see the smaller "dump
size" output from the kmsg dumper):

pstore: backend max size:1024 dump size:1590 zipped size:553
pstore: backend max size:1024 dump size:1534 zipped size:792
pstore: backend max size:1024 dump size:1647 zipped size:414
pstore: backend max size:1024 dump size:1641 zipped size:599
pstore: backend max size:1024 dump size:1670 zipped size:643
pstore: backend max size:1024 dump size:1692 zipped size:684
pstore: backend max size:1024 dump size:1697 zipped size:934
pstore: backend max size:1024 dump size:1696 zipped size:870
pstore: backend max size:1024 dump size:1677 zipped size:791
pstore: backend max size:1024 dump size:1683 zipped size:772
pstore: backend max size:1024 dump size:1677 zipped size:742
pstore: backend max size:1024 dump size:1704 zipped size:714
pstore: backend max size:1024 dump size:1683 zipped size:715
pstore: backend max size:1024 dump size:1693 zipped size:479
pstore: backend max size:1024 dump size:1667 zipped size:487
pstore: backend max size:1024 dump size:1639 zipped size:760

However, we still need a different _decompression_ size, as we want to
over-estimate that buffer size. I just used 3x which is going always
be enough.

I'll send a v2 to see what you think...

-- 
Kees Cook
