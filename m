Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0277ED1C8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 21:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344310AbjKOUHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 15:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344093AbjKOUHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 15:07:47 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9281892
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 12:07:44 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c509f2c46cso404201fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 12:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700078862; x=1700683662; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WW2Yloo89o/8fjCDn3VtwHsMIhFIpKiAMzGXOe2NTzA=;
        b=Q9b6oqJoy689+rub+E+mNLZB4McDefCubqrAd1Re2Umc99LoLd0aq8O7ewWKhBv2K5
         ppdJwgw7O6EG7ufEjar3aiaR77fpGUE8g3yuEv/aq91AZcZHLWon6KWxnLafsQYeEApd
         97IhlsrK12DJ1ee/4av+ctll2x7VHPuEPKbfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700078862; x=1700683662;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WW2Yloo89o/8fjCDn3VtwHsMIhFIpKiAMzGXOe2NTzA=;
        b=MlE5RE0+NQ8VLO8Nu8XhI9xZvQYDHGINJ3SsmGMsZYvi8fQupAvVhY8Ebyc663+XHr
         4N8beUpcJCRP/xspxtGw+5FIUlMgwHaeW/bPVsai8JIlaOKycrgObxHvLC0PUujSpOhU
         AQS1hxguGpKesLVOkMQeiVE1o8bqeJtT7I0XlYCNtjhbRAQuKAZp58RBMjkMnrwszCiB
         xUUhNoAEK3T2hrkqu6V5g/jCwnEWgxd+LcgOxSy2lHAQ5qv3e/K86/c6edV0KkDBDpbO
         QGTeLVPhaBOrcoTEM63//2rL/c85WAfVKxSPNPoCSBh1DYwG1rg7ALt965BbySYren3o
         NwWA==
X-Gm-Message-State: AOJu0YzkPNhrCZPtDY/3VXgtJJDCcRZCaoskWDisuUGSYfQoncUeYcuv
        FQfCL8FFSKQlGfE7qeUtO7l0clqaxvOwz34miEqdd1JS
X-Google-Smtp-Source: AGHT+IFI9TiZjVGMFZPVkBKTWEAU+WH9RBf56ef197qBf4vp7fXFG3d6HLBpD1iIFchsLguN5jQZLw==
X-Received: by 2002:a2e:891a:0:b0:2c5:3339:71d6 with SMTP id d26-20020a2e891a000000b002c5333971d6mr5538968lji.19.1700078862726;
        Wed, 15 Nov 2023 12:07:42 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id p20-20020a2eba14000000b002bcbb464a28sm1808511lja.59.2023.11.15.12.07.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 12:07:42 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-507be298d2aso33808e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 12:07:41 -0800 (PST)
X-Received: by 2002:ac2:488d:0:b0:509:4c7b:c734 with SMTP id
 x13-20020ac2488d000000b005094c7bc734mr9119876lfc.20.1700078861508; Wed, 15
 Nov 2023 12:07:41 -0800 (PST)
MIME-Version: 1.0
References: <202311061616.cd495695-oliver.sang@intel.com> <3865842.1700061614@warthog.procyon.org.uk>
 <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
 <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com>
 <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com>
 <20231115190938.GGZVUXcuUjI3i1JRAB@fat_crate.local> <CAHk-=whFW+uWOmOtRNh0What_fu8Xo8KF2+EeUH1kn4qFxGAhA@mail.gmail.com>
In-Reply-To: <CAHk-=whFW+uWOmOtRNh0What_fu8Xo8KF2+EeUH1kn4qFxGAhA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Nov 2023 15:07:24 -0500
X-Gmail-Original-Message-ID: <CAHk-=whrc-ruKs4Kt90EGzKd+pYhZFKs6bgBVCV=55BK+p1nzg@mail.gmail.com>
Message-ID: <CAHk-=whrc-ruKs4Kt90EGzKd+pYhZFKs6bgBVCV=55BK+p1nzg@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 at 14:15, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So my patch really is broken. It might happen to work when everything
> else goes right, and it's small, but it is very much a "proof of
> concept" rather than something that is actually acceptable.

More breakage details

 (a) need to not do this with the boot code and EFI stub code that
doesn't handle alternatives.

     It's not a huge deal in that obviously both alternatives work,
but it causes build issues:

      ld: error: unplaced orphan section `.altinstructions' from
`arch/x86/boot/compressed/misc.o'
      ld: error: unplaced orphan section `.altinstr_replacement' from
`arch/x86/boot/compressed/misc.o'
      ...

     etc

 - our current "memcpy_orig" fallback does unrolled copy loops, and
the rep_movs_alternative fallback obviously doesn't.

It's not clear that the unrolled copy loops matter for the in-kernel
kinds of copies, but who knows. The memcpy_orig code is definitely
trying to be smarter in some other ways too. So the fallback should
try a *bit* harder than I did, and not just with the whole "don't try
to handle exceptions" issue I mentioned.

              Linus
