Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83FC7ED734
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 23:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjKOWaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 17:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjKOWaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 17:30:16 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB491AB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 14:30:12 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-28037d046b0so76860a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 14:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700087412; x=1700692212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YylxupOkQhFH1ncpqsZvMSikxbKYHt85VPH5cA+G+Oo=;
        b=UY5yWcNxei8PxZpZqzxd+lFoYgrgy/jNJZMxjVlaSeEZWSfPdnxu+FrfvYURvlHUlB
         DLWLWwnusiS2lBerr6nPgpZW4oNTflwThvOQn1U/VqkOnIQc3cEHNkWamvSqgMjj2WSZ
         XBnEMmp189E4O9bUV6L0BgChoewcfzpqP/AjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700087412; x=1700692212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YylxupOkQhFH1ncpqsZvMSikxbKYHt85VPH5cA+G+Oo=;
        b=JMKdMbSZtf2m062fPFq+K55rir5+H6LzvCE17zw+OuT1XB0lJQ0tC+ZLeEkst1nyL9
         eu+f+yKdmr8Ikqu79hMmaFy6NIn7kJZmbNphlzIWiFjhgJnr7SiJe3ttytJP03Vs0brZ
         ljlACHdje5QcZiAYQTBqOW+SRUfkg7Zjh2dHVRSLUTKV7ScSiRMx2z/3e5kzdymKfhpQ
         UffVomKcIyX4585OG4ebP+E8pmNNHiMIJC5jh0GmtNjvfnln8JkwIv2LZHmUGCm608gU
         60NFx/Ffl8Ql2PAkiDuPAl/12WgTVvsM7VNcGnGU9XmYjxyn0UxoCrfvfUr8ZqLxzi2P
         eQAw==
X-Gm-Message-State: AOJu0YxLOUIhZ3oIIhAPbGsV6G0PVYWRytipo6+r1gO8LuUmDNsgBg1L
        j+EGLLeLAJyt/WeCpcXPUIpyNA==
X-Google-Smtp-Source: AGHT+IH9POCXXZWRtQRhqbIqDlXwgNhDNOex4tdXVE7w2NANUENrUp1koUsAexp4kMfm8HYy5y/F9w==
X-Received: by 2002:a17:90b:1b52:b0:280:99ca:1611 with SMTP id nv18-20020a17090b1b5200b0028099ca1611mr10980882pjb.20.1700087412249;
        Wed, 15 Nov 2023 14:30:12 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id nr2-20020a17090b240200b0027d0de51454sm330562pjb.19.2023.11.15.14.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 14:30:11 -0800 (PST)
Date:   Wed, 15 Nov 2023 14:30:11 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, agordeev@linux.ibm.com,
        aou@eecs.berkeley.edu, bp@alien8.de, dave.hansen@linux.intel.com,
        davem@davemloft.net, gor@linux.ibm.com, hca@linux.ibm.com,
        linux-arch@vger.kernel.org, linux@armlinux.org.uk,
        mingo@redhat.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
        robin.murphy@arm.com, tglx@linutronix.de
Subject: Re: [PATCH v2 0/4] usercopy: generic tests + arm64 fixes
Message-ID: <202311151427.341BC07@keescook>
References: <20230321122514.1743889-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321122514.1743889-1-mark.rutland@arm.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 12:25:10PM +0000, Mark Rutland wrote:
> This series adds tests for the usercopy functions, which have found a
> few issues on most architectures I've tested on. The last two patches
> are fixes for arm64 (which pass all the tests, and are at least as good
> performance-wise as the existing implementation).
> [...]
>  lib/usercopy_kunit.c          | 506 ++++++++++++++++++++++++++++++++++

You didn't like lib/test_user_copy.c ? :)

There was a prior attempt to move it to KUnit:

https://lore.kernel.org/lkml/20200721174654.72132-1-vitor@massaru.org/

-- 
Kees Cook
