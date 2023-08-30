Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C6478D7FE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238767AbjH3GeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 02:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbjH3Gdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 02:33:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F84107
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 23:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wRGzirD/pbNMKYQh03dIBe/iW+yiXPUE4OYe0WqF7kY=; b=Ma80+8tmmfbpvy3TEkousI5DG0
        D/H2I8FgPjh9xuV1miXyzjgcAiRPSYWR0UlwfOdRwO0TyYWKvZOXMMC5ZJNVkij6pwC+uiqqmmdJg
        L56vxc0hwG4Z634E0fofjnj8LjAd/2vZaikFqLwzvEDqUTIktw2ZcJzLY8Lh/XXEDgK6HVXFkzGZu
        z4cnOlOq/zMzT6MgfENpkU3946OYjVKVgOWbt3A6SzMS2O3iwWKvxkji2R1ADNMfl7je4HEW75OeS
        niMixJbimYHKA25Z0aWd5TjZv9k0nO61iNKThSix0URg0vIP4D3GpthgCTtAUEPuV3h7/u/cd+zen
        G/JCZnOw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qbElv-00CvOx-2Q;
        Wed, 30 Aug 2023 06:33:47 +0000
Date:   Tue, 29 Aug 2023 23:33:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Yajun Deng <yajun.deng@linux.dev>
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.6
Message-ID: <ZO7iy/Ei+wZK0I/d@infradead.org>
References: <ZO4NUZ+k4Q4zPu6X@infradead.org>
 <CAHk-=wik9Df4Si7aYOqgyhf=io2OaP=7Yur-xpbNe6oHuxSFAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wik9Df4Si7aYOqgyhf=io2OaP=7Yur-xpbNe6oHuxSFAg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 08:54:43PM -0700, Linus Torvalds wrote:
> > Yajun Deng (2):
> >       dma-contiguous: support per-numa CMA for all architectures
> 
> What?
> 
> This commit seems entirely bogus and is actively misleading.
> 
> It claims to enable support for per-numa CMA for all architectures.
> 
> It does no such thing.

It actually does..

> All it does is to change the default value for a config option. It was
> perfectly available before, now it is - incorrectly - made 'default y'
> in case the config supports NUME at all.

It also changes the default, and maybe that shouldn't have been,
but that's not the meat of the change.  The big part of the change
is that the logic to actually reserve the per-node CMA area is now
called from common code instead of arm64 code.  Before you could have
enable the option, but it wouldn't have worked at all.

> 
> There seems to be no real reason to change the default value of this
> config option. The commit message most definitely doesn't argue for
> it, since it talks about something entirely different than what the
> code changes does.
> 
> I have taken this, but I protest these kinds of nonsensical changes.
> That commit is actively misleading and confused, and I think the
> default value for that config option should just be 'n' on all
> architectures.
> 
> Why is this option so important that it should be enabled just because
> some minimal NUMA support might be enabled?
> 
> Please don't add these kinds of hidden "default y" by making them
> default on some much more common option instead.

I think everyone including the maintainer was confused when the initial
arm64 only version was merged by adding the default, it should have
been a depends to start with.  So we'll change this to a depends in a
follow up.

