Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325C07BC42C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 04:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbjJGCY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 22:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbjJGCY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 22:24:27 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A99BBF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 19:24:25 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3af608eb34bso1758462b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 19:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696645465; x=1697250265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e9UWXPGpBqN8/aGLtCDuuQnwCBGM2WifajEW12m85LU=;
        b=ZNsfcdCpmj2gbSBbVYL0oGP+wUsjukbRmMJSW8GWncBBLNO28mIsezWj0fFY1TlFdU
         jWEjJqMJjggafU56u4cfsWVnl2t39EKpENCbqaO6TfOu8xx3m7J/MQp+ueeRc1vbn6HH
         5yqegWEx9hnmIcUThF2LsNoMdXYD/GrzrSD8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696645465; x=1697250265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9UWXPGpBqN8/aGLtCDuuQnwCBGM2WifajEW12m85LU=;
        b=slAdowp1GMwVJgnrLER5uelzHKXt+rme9EBHkooXS8LBKvKqBqxpMSn/SCWBUAhRas
         JlZ3mkz08RsHLZaPPLISLwS+oyQDJAO4WntYFjJDW9ACQjcTV9BkgXwFMv5Ccd/03o+R
         km04SynKlF4UhtA45WXSpCLVy3Inr1Ou/uiXjGWWXx5lKwpCXAHjqXDHPKwHUziMLynW
         6lEJIUgOrXabAtjrajI0mTk3YEkQAINp0OlEamKQktPvnUBrofDKsHgiUcQ056iDw95v
         e86vMHLyLfP+FvKl1KNma9hAbqwPsnBHIDAFsNfugFsfaz7T6A+RiyEarP26NoHE0Uyo
         daLQ==
X-Gm-Message-State: AOJu0Yz7f8kGpsc88qdiscWeQYxxCU0BZNH0FQy6hrjcbvcHy89qV9us
        vcWhCPVewNtWSBKrbwBJvvSCeg==
X-Google-Smtp-Source: AGHT+IHzkphbjEVz/o20GkGeZNmC6qgu3BYytys8/iIThThDt3sjc1ZRrJDHBBv1x8FOc4/t6VoC5A==
X-Received: by 2002:a05:6808:c3:b0:3a7:3ce0:1ad7 with SMTP id t3-20020a05680800c300b003a73ce01ad7mr9128888oic.20.1696645464800;
        Fri, 06 Oct 2023 19:24:24 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l30-20020a63701e000000b00578cc5f4905sm3966426pgc.28.2023.10.06.19.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 19:24:23 -0700 (PDT)
Date:   Fri, 6 Oct 2023 19:24:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Lukas Loidolt <e1634039@student.tuwien.ac.at>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Marth <daniel.marth@inso.tuwien.ac.at>
Subject: Re: Missing cache considerations in randstruct performance feature
Message-ID: <202310061840.045F218F08@keescook>
References: <f3ca77f0-e414-4065-83a5-ae4c4d25545d@student.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3ca77f0-e414-4065-83a5-ae4c4d25545d@student.tuwien.ac.at>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 12:30:01AM +0200, Lukas Loidolt wrote:
> Hello!
> 
> I have been looking into the implementation of the "randstruct" gcc-plugin
> and noticed a potential bug in its performance version, which is supposed to
> limit randomization to cache-line sized groupings of structure members.
> I haven't been able to find too much documentation on this version of
> randstruct, but my general understanding of its intended behavior is as
> follows:
> 
> - in performance mode, randstruct groups structure members into cache line
> sized partitions of 64 bytes each
> - the order of these partitions is randomized
> - the order of structure members within each partition is also randomized
> 
> In my tests, however, the performance version behaves more or less like the
> full version of randstruct.
> For example, testing on a struct of 10 function pointers:
> 
> struct test_struct{
>     void (*func1)(void);
>     void (*func2)(void);
>     void (*func3)(void);
>     void (*func4)(void);
>     void (*func5)(void);
>     void (*func6)(void);
>     void (*func7)(void);
>     void (*func8)(void);
>     void (*func9)(void);
>     void (*func10)(void);
> };
> 
> resulted in the following randomized memory layout:
> 
> func3 (offset 0)
> func5 (offset 8)
> func10 (offset 16)
> func2 (offset 24)
> func1 (offset 32)
> func6 (offset 40)
> func8 (offset 48)
> func7 (offset 56)
> func9 (offset 64)
> func4 (offset 72)

I'd agree; this doesn't look like an expected layout.

> I would have expected cache-line sized partitions of (up to) 8 pointers, so
> that func1 through func8 are adjacent in the final layout, but these
> partitions are seemingly not preserved.

I'd expect the order of func1-func8 to be randomized together, and
func9-func10 order to be randomized together, and then they're pasted
together.

> Assuming that this is indeed not the intended behavior, the culprit is line
> 213 in "randomize_layout_plugin.c"
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/gcc-plugins/randomize_layout_plugin.c?id=f291209eca5eba0b4704fa0832af57b12dbc1a02#n213
> 
> where
> 
> randnum = ranval(prng_state) % (i + 1);
> 
> should probably be something like
> 
> randnum = size_group[x].start + ranval(prng_state) % size_group[x].length;

I thought the intent was to handle it in the loop offsets:

	for (i = size_group[x].start + size_group[x].length - 1; i > size_group[x].start; i--) {

But, no, this looks wrong, see below...

> After changing this line, cache-line sized partitions are created and
> preserved as expected.
> However, while structure members within each partition are randomized, the
> order of the partitions themselves is not randomized and remains the same as
> in the original struct declaration.

size_group[] is what holds the initial partitions. I would agree,
though, the group shuffling doesn't seem to do anything.

> I assume that the for loop in lines 200 to 206 is intended to shuffle the
> partition_group structures
> 
> for (i = num_groups - 1; i > 0; i--) {
>         struct partition_group tmp;
>         randnum = ranval(prng_state) % (i + 1);
>         tmp = size_group[i];
>         size_group[i] = size_group[randnum];
>         size_group[randnum] = tmp;
> }
> 
> but the order of the partition_group structs is not written back into the
> newtree object, so the randomization from this loop is not reflected in the
> final layout.

I'd expect the newtree index to start at 0, rather than reusing "i", if
the intent was to move groups around too. But in fact, the second
shuffle loop seems to just not work at all: it's not shuffling within
the group, since it operates from 0 to i, not size_group[x].start
through size_group[x].start + size_group[x].length.

> I would be interested to know if this is an actual issue with the
> implementation or if I'm misinterpreting how randstruct is supposed to work
> here.

I'd agree; this looks totally broken.

-Kees

-- 
Kees Cook
