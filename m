Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36A57B1630
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjI1Iiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjI1Iin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:38:43 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46377AC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:38:42 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9adca291f99so1588354566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695890321; x=1696495121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lb4cyvqd0iAUyTrfY0hZMXZEe3oz5M4w0wG/5J0ePNo=;
        b=Dh6XG/AxUatbqIwrm/B8KC/fs3t5Hww35d+/qDoihEzTJ3XOrQjtFlEG8/goUJyaSh
         seGD099B0DEXRIKbPdafIuU+AIz/a+ihIHUyevJkDReRf3sTVFkaaieKw4YNBdj9DkoQ
         623/rt+6a2CNnN4OOjkOr6P8UVapa4rnKBHbk6yKBrWjV4v8SMV1GYyD9QrshdPTpJ5m
         8xdGzPT/TOuOAhpB+0NDGEW2lasirmTkeHJ6oNrUWPRstMpRN1+bCl2NTrI9FwQRYKv6
         pIvq6/ot6Sp8mmGwWAzgyP17nNdERY1G+zOuFZEjxbPhq84Ifij4194/4hSX8ZGQ9y9z
         CVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695890321; x=1696495121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lb4cyvqd0iAUyTrfY0hZMXZEe3oz5M4w0wG/5J0ePNo=;
        b=Dn3BqLKfPBVF1IyfPqnk9Cd1RjaT4TenwHnPsWvqCipx9+V0BF0FHabMnnixOi8i4h
         L8MAkSh3drxfGqSkGK48lEO7eJfnB1mWdOHeOraRC3OGjaMpSeD1kt6dMEIFe+ixGlT5
         Tph7yUgiX7d9hd/zorC77upRvvRNOoSJSYXy8jZIMy5fJukP//VMCNu0QSPDG3WFhtQZ
         /mLkClC/HZGh8zMVjo1Cf1qYBFyoyF+q6Wu/tanHjSSdlmC79o14CwPQzK0VbSpG+M2W
         +FM01vUWedtpfltK8ljrUb95Us8060mqGDkIEfn+Wf1639O6oCAVDexSIvps0fKzGA7i
         AppQ==
X-Gm-Message-State: AOJu0YwNBBfxS/wA68IDt4qpm4z2FCFiv2wpYkAb8sDyMTsGrXffIXXE
        KdzOcGGRPNcgzU/1r9jYe723i2OYxw==
X-Google-Smtp-Source: AGHT+IGAihYLxLQ3ut7ge+nGhB9GTR63CrzwKjUhYUkgAcSFRJfU3ZW8q95y2SAd9KOH0HhC2lVYXg==
X-Received: by 2002:a17:907:75e5:b0:9a1:c2fe:41d9 with SMTP id jz5-20020a17090775e500b009a1c2fe41d9mr494168ejc.47.1695890320460;
        Thu, 28 Sep 2023 01:38:40 -0700 (PDT)
Received: from p183 ([46.53.254.83])
        by smtp.gmail.com with ESMTPSA id d19-20020a17090692d300b009ae69c303aasm10020484ejx.137.2023.09.28.01.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 01:38:39 -0700 (PDT)
Date:   Thu, 28 Sep 2023 11:38:38 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Laight <david.laight@aculab.com>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Jason@zx2c4.com, hch@infradead.org,
        andriy.shevchenko@linux.intel.com, akpm@linux-foundation.org
Subject: Re: + minmax-add-umina-b-and-umaxa-b.patch added to
 mm-nonmm-unstable branch
Message-ID: <b1198988-b60e-41e2-99bf-6af145e1d201@p183>
References: <20230927173033.AF86DC433C7@smtp.kernel.org>
 <d74a3644-1d03-42c7-b258-4d5d63416ee0@p183>
 <ZRSJ5QMNGV7ObfrL@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZRSJ5QMNGV7ObfrL@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 09:00:37PM +0100, Matthew Wilcox wrote:
> On Wed, Sep 27, 2023 at 10:21:41PM +0300, Alexey Dobriyan wrote:
> > On Wed, Sep 27, 2023 at 10:30:33AM -0700, Andrew Morton wrote:
> > > +#define umin(x, y)	\
> > > +	__careful_cmp((x) + 0u + 0ul + 0ull, (y) + 0u + 0ul + 0ull, <)
> > 
> > kmin() and kmax() are (of course!) much better names.
> 
> it's unsigned, not user.

Yes, but the same idea applies to signed types:

min, max require identical types
min_t force type
kmin, kmax are relaxed min/max versions if signednesses match.
