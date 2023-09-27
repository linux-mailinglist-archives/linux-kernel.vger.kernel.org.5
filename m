Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B672A7B0B14
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 19:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjI0RaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 13:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjI0RaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:30:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEC4A1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 10:30:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3FAC433C8;
        Wed, 27 Sep 2023 17:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1695835815;
        bh=Zg50glGvDdtglLFeZM0bVA5Rp7XkwmC5KIuofPJt15E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lUZuSpIbYG7fm1DmDBwneBunRiwwnO9n1D97Mot1zBcW074CD3Q87G6K4PT4+IM5/
         fFAso1btjJGuIqO5h0/Igolm70aJ45buEC5xNZW9JNUvGOstyFW+h5gZLnXhYJkae0
         1QpdlQithxVcio0X7UpkSGZZ+okn1dzuXX2RGIfA=
Date:   Wed, 27 Sep 2023 10:30:14 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        "'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
        'Christoph Hellwig' <hch@infradead.org>,
        "'Jason A. Donenfeld'" <Jason@zx2c4.com>
Subject: Re: [PATCH next v4 0/5] minmax: Relax type checks in min() and
 max().
Message-Id: <20230927103014.683e41b855cb2cd4ea163fa5@linux-foundation.org>
In-Reply-To: <b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com>
References: <b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sep 2023 08:14:40 +0000 David Laight <David.Laight@ACULAB.COM> wrote:

> A quick grep shows 5734 min() and 4597 min_t().
> Having the casts on almost half of the calls shows that something
> is clearly wrong.

My preferred approach to fixing min() warnings is "the types are wrong".
But often getting the types better is hard.

Is there a plan afoot to go around existing code doing some
min_t()->min() conversions?
