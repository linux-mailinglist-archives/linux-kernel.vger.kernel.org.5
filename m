Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73247759297
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjGSKST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjGSKSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:18:12 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C611FCB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:18:04 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-993d1f899d7so939130566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1689761883; x=1692353883;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3NsOzwLbyHagOj0RUJh6oS60oUKmYlB8RPkDGxAGY18=;
        b=O2pnEuPln44glMdeg60thEUz2OpSqZ/q0d5NCNBMcNGZ3PPVNAri3R+01Ku599baiT
         iW+V/lvASTxjNqKmCemBNSYN1Dhb+8BVv36AOBGTTn+bUHhTq8tfW0SW4HfF55T1cxR9
         hVVjk7uLRDQdZ14Tg9GhicKs6HPVRmQjK3hE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689761883; x=1692353883;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3NsOzwLbyHagOj0RUJh6oS60oUKmYlB8RPkDGxAGY18=;
        b=WC410mzeWfiHx1tUUzhqRFDAfeiKZSSQYtFcaqEsjcebWRQWHVGY2/iPiXfx3fkG7l
         DTcjmXq3XMGE/2DKqo/kzkM/C6WvBDiOqwVwcVW3uO6+bs1lHJQp3KNaVRCbeIOnlfMj
         /4NedEpX74ONcQnRLLWCgDtEIK4Yt8ZKuBI8VcxpHvsLfKafS5x8ZbVgAhI4zpLx2rMT
         acsw/JI7iVUovX0TdIIEBTfWPievidKI7AdnSLiOzPkqCCUQRMoXPBmfSfnX+hLInoVr
         nS4I3xHlGkGfmgVh5rLhZpYpE4dd55BouPQDSSzzrffXF77itwETKJzT2eF76sJ7nvge
         /Y+w==
X-Gm-Message-State: ABy/qLZJUSPiqDMDi9VS5gNaS/56MO4g3N0HiSiCRm0L7eexcYW2+pNP
        CKUyuNiE4WLl/HKDWY5RUStqlNVA9/4X5DncOjOgYQ==
X-Google-Smtp-Source: APBJJlGoD/VxR3BbFv+ImtFMoe6c5kQO9wv+u3g62HEJx8HqwwhtWvu3lLeGD/sLRyF77FLO7GXKEdXGcjmXqyU+fkQ=
X-Received: by 2002:a17:906:2213:b0:974:1ef1:81ad with SMTP id
 s19-20020a170906221300b009741ef181admr2102985ejs.4.1689761883028; Wed, 19 Jul
 2023 03:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230629155433.4170837-1-dhowells@redhat.com> <20230629155433.4170837-2-dhowells@redhat.com>
In-Reply-To: <20230629155433.4170837-2-dhowells@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 19 Jul 2023 12:17:51 +0200
Message-ID: <CAJfpegsJuvXJDcXpo9T19Gw0tDuvyOJdv44Y2bt04MEf1JLxGg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] splice: Fix corruption of spliced data after
 splice() returns
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Matt Whitlock <kernel@mattwhitlock.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@kvack.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023 at 17:56, David Howells <dhowells@redhat.com> wrote:
>
> Splicing data from, say, a file into a pipe currently leaves the source
> pages in the pipe after splice() returns - but this means that those pages
> can be subsequently modified by shared-writable mmap(), write(),
> fallocate(), etc. before they're consumed.

What is this trying to fix?   The above behavior is well known, so
it's not likely to be a problem.

Besides, removing spliced pages from the cache is basically guaranteed
to result in a performance regression for any application using
splice.

Thanks,
Miklos
