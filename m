Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2B87EE576
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 17:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345292AbjKPQsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 11:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjKPQsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 11:48:43 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B8CD68
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 08:48:39 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50a6ff9881fso1525844e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 08:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700153317; x=1700758117; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UKTCm7ggbJLm3ZHcQ81iQju2vexC4L52XL08aMMC/TA=;
        b=O2scRUTBMQFAD9c0p80AES7z/RSreQtvMoIBUD1Po/8nf5B0ov/a1w2e1EdGmZgaCV
         fUlKzOra4FnpAmoPvYQr0+C+HMNh1YVmyrcONH/BNo7tIg0eSG7PzZOokq6T1I+390/+
         k0wsdr6KGcF4x0kK+DPmgR/MCWOdT39wa0IZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700153317; x=1700758117;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UKTCm7ggbJLm3ZHcQ81iQju2vexC4L52XL08aMMC/TA=;
        b=TGDwCZ4li8oEPJkbSr1jfBcAFUW6Yb8J+uuINYvH+35DkKeRYthKRehfXeVOGFmHJG
         U7AUHEnS6lJEUzjPaikP9N0OovRDP9x6qD9QgaokERcpk443glpIDTp2/QfKfZ2DCuet
         OoIyjUcoyfIf+O7IfOuRjfhwt45TgwozMrsVAQ5r2DXxx5OJsqooXrgcvZ6ZMDXwFaqM
         xPaHFBIe3NJ86KX+pQA0shMG699c0Is+AGzNAcJ1awK5smSLlHq85lL4bq/FXcbOJbMo
         8UfC7OzTsLC8FV+UcsThkhGt4alLDe6IU0c+9GkQuCbQQYGqEDyRPwv0fR+1LE9vdGhC
         Qbfg==
X-Gm-Message-State: AOJu0Yx6GqBPj1PeZ1oG4+WnFAVUmt1PRivspSSD6Cr+17RBvW8XoW3D
        oF49GBrxzKU5GtKHRpcHWZBC3ASIJb0J/QE0mtoMg4Qw
X-Google-Smtp-Source: AGHT+IFA6zV97NNrbCe7wpNb0k4qp76woBKpxC2JgLpvyXjWsg+PYoTGD5K/AigWtQmQebXquYF0Cw==
X-Received: by 2002:a05:6512:4d1:b0:509:8eb6:6837 with SMTP id w17-20020a05651204d100b005098eb66837mr11613165lfq.47.1700153317139;
        Thu, 16 Nov 2023 08:48:37 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id p11-20020a056402074b00b0053da3a9847csm7925925edy.42.2023.11.16.08.48.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 08:48:36 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-54366784377so1486361a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 08:48:36 -0800 (PST)
X-Received: by 2002:aa7:d510:0:b0:533:520:a5a8 with SMTP id
 y16-20020aa7d510000000b005330520a5a8mr12500577edq.29.1700153316001; Thu, 16
 Nov 2023 08:48:36 -0800 (PST)
MIME-Version: 1.0
References: <202311061616.cd495695-oliver.sang@intel.com> <3865842.1700061614@warthog.procyon.org.uk>
 <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
 <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com>
 <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com>
 <20231115190938.GGZVUXcuUjI3i1JRAB@fat_crate.local> <CAHk-=wh0TcXyGmKHfs+Xe=5Sd5bNn=NNV9CEtOy_tbyHAAmk9g@mail.gmail.com>
 <20231116154406.GDZVY4xmFvRQt0wGGE@fat_crate.local>
In-Reply-To: <20231116154406.GDZVY4xmFvRQt0wGGE@fat_crate.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Nov 2023 11:48:18 -0500
X-Gmail-Original-Message-ID: <CAHk-=wjGQh3ucZFmFR0evbKu2OyEuue-bOjsrnCvxSQdj8x6aw@mail.gmail.com>
Message-ID: <CAHk-=wjGQh3ucZFmFR0evbKu2OyEuue-bOjsrnCvxSQdj8x6aw@mail.gmail.com>
Subject: Re: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput
 -16.9% regression
To:     Borislav Petkov <bp@alien8.de>
Cc:     David Howells <dhowells@redhat.com>,
        kernel test robot <oliver.sang@intel.com>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        David Laight <David.Laight@aculab.com>, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023 at 10:44, Borislav Petkov <bp@alien8.de> wrote:
>
> Reportedly and apparently, this pretty much addresses the issue at hand.
> However, I'd still like for the compiler to handle the small length
> cases by issuing plain MOVs instead of blindly doing "call memcpy".
>
> Lemme see how it would work with your patch...

Hmm. I know about the '-mstringop-strategy' flag because of the fairly
recently discussed bug where gcc would create a byte-by-byte copy in
some crazy circumstances with the address space attributes:

    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=111657

But I incorrectly thought that "-mstringop-strategy=libcall" would
then *always* do library calls.

So I decided to test, and that shows that gcc still ends up doing the
"expand small constant size copies inline" even with that option, and
doesn't force library calls for those cases.

IOW, my assumption was just broken, and using
"-mstringop-strategy=libcall" may well be the right thing to do.

Of course, it's also possible that with all the function call overhead
introduced by the CPU mitigations on older CPU's, we should just say
"rep movsb" is always correct - if you have a new CPU with FSRM it's
good, and if you have an old CPU it's no worse than the horrendous CPU
mitigation overhead for function call/returns.

I really hate the mitigations. Oh well.

Ayway, maybe your patch is the RightThing(tm). Or maybe we should use
'rep_byte' instead of 'libcall'. Who knows..

             Linus
