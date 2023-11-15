Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619387EC81A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjKOQFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjKOQFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:05:01 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653B1195
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:04:56 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507973f3b65so9861878e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700064294; x=1700669094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jzZnZquzqfUk+KfrDds9CQaV555iZ1w7ZZ/4IXXyLOU=;
        b=B5jNO081WHszP07ZsBKM1CDWKnvz3FH9mmZUeIJOBeQ4RtSAnsgAlB/4zNCkcM4btj
         yDGuU/TQucx9vY2Jb0NlNiwMLl4aSHjmpEVeUYpX4EA5IB6tvF1LI2LIDmwHGCzJaKYX
         ClTQWQx89VcjPw2bT8IytM4QZ8n5qS0hVIvp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700064294; x=1700669094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jzZnZquzqfUk+KfrDds9CQaV555iZ1w7ZZ/4IXXyLOU=;
        b=MltM9roa4RItmC/7xkVyyyz6mzhe7TrK9UHtfyNRTo31ixwoQ9+8tWY6h8tTmxqTrP
         PpR4IFCCLEdC1GuQjdiso963F9ErJj20pf0YHUR/Hez0CtbmM7Cpa42RNM29I8C5VB+U
         dFStu7tbVMgMYjg/l5n6VuJO+jW/max2LlV5DE9dr1Sb0vcLJC9h0RCot8kOL+Ape/Ye
         9PYhjOKO8ZaLc8s74olr8SR5xBit8FLDcrshBXcrMdHEhZtCstUdMYvw78dTna4ex4MU
         rr1MRAaRot/gPuYYbvHh6EIjsubNPZJcQ/Zt6Bk8S4EqPxr0t9HWVzpnDb3smvVzuz4E
         2X2g==
X-Gm-Message-State: AOJu0YxdsPW2aLVQvAypf8Y4/hVQPwvguMJX9CxfJRZyNYEF/o+V2/gD
        /jg3b+drMZNPDuAT83UYrQUsuWhj8wgaCuNFtgbDcpTy
X-Google-Smtp-Source: AGHT+IHEViJ304NkQalKhSU9ufKcTNLK5IOFBzq0QCPVrkVbQzfPgADL4bVnvm1uER6CEqpy8CAOOQ==
X-Received: by 2002:a05:6512:3585:b0:507:9d71:2a77 with SMTP id m5-20020a056512358500b005079d712a77mr8358106lfr.17.1700064294298;
        Wed, 15 Nov 2023 08:04:54 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id ko14-20020a170907986e00b009dd701bb916sm7217056ejc.213.2023.11.15.08.04.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 08:04:53 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso10761256a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:04:53 -0800 (PST)
X-Received: by 2002:a05:6402:34f:b0:540:7a88:ac7c with SMTP id
 r15-20020a056402034f00b005407a88ac7cmr10183276edw.21.1700064293347; Wed, 15
 Nov 2023 08:04:53 -0800 (PST)
MIME-Version: 1.0
References: <20231115154946.3933808-1-dhowells@redhat.com>
In-Reply-To: <20231115154946.3933808-1-dhowells@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Nov 2023 11:04:36 -0500
X-Gmail-Original-Message-ID: <CAHk-=whTqzkep-RFMcr=S8A2bVx5u_Dgk+f2GXFK-e470jkKjA@mail.gmail.com>
Message-ID: <CAHk-=whTqzkep-RFMcr=S8A2bVx5u_Dgk+f2GXFK-e470jkKjA@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] iov_iter: kunit: Cleanup, abstraction and more tests
To:     David Howells <dhowells@redhat.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        David Laight <David.Laight@aculab.com>,
        Matthew Wilcox <willy@infradead.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
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

On Wed, 15 Nov 2023 at 10:50, David Howells <dhowells@redhat.com> wrote:
>
>  (3) Add a function to set up a userspace VM, attach the VM to the kunit
>      testing thread, create an anonymous file, stuff some pages into the
>      file and map the file into the VM to act as a buffer that can be used
>      with UBUF/IOVEC iterators.
>
>      I map an anonymous file with pages attached rather than using MAP_ANON
>      so that I can check the pages obtained from iov_iter_extract_pages()
>      without worrying about them changing due to swap, migrate, etc..
>
>      [?] Is this the best way to do things?  Mirroring execve, it requires
>      a number of extra core symbols to be exported.  Should this be done in
>      the core code?

Do you really need to do this as a kunit test in the kernel itself?

Why not just make it a user-space test as part of tools/testing/selftests?

That's what it smells like to me. You're doing user-level tests, but
you're doing them in the wrong place, so you need to jump through all
these hoops that you really shouldn't.

                Linus
