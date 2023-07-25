Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4B076187F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjGYMit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjGYMir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:38:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27818B0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hTZzIr8jWNTaVS3BF6QI6AWK6ZCAbJkhajZWcxOmn1s=; b=uen8mo+g2EhWqQgRQcHdO5Kvsf
        k/Sgt5Fe+dk0zYLIJi1VWtVL5TCeKf4TwFjiAViFXHzKJC4M7QeqkrVwNEtnUIqEo7bauUNhJYY7L
        ytH8wTGxf/cYpXiO/CD+E9rUN66EkVCxHNUexq1D2UjOS8WWZMFapU/mghAHXh9qW8tkorjnGv7AU
        oIEOgq4sAWutRAMm0Z+Zh8B80j9Y+ZhZxT877VVOQawe4YNnuuVf4lc0z0fUrVi82gps6jPJarhn2
        m7RecQQchX/7mPcWDBYKHTnCMDtT5LSKAeDoyUBMcybFb24HftBQKIN+0ftVnj9l/7UJbepS4lefv
        W/2c4/XA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qOHJK-005T0M-N3; Tue, 25 Jul 2023 12:38:42 +0000
Date:   Tue, 25 Jul 2023 13:38:42 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        'Christoph Hellwig' <hch@infradead.org>,
        "'Jason A. Donenfeld'" <Jason@zx2c4.com>
Subject: Re: [PATCH next resend 1/5] minmax: Add min_unsigned(a, b) and
 max_unsigned(a, b)
Message-ID: <ZL/CUuIhi6qmTK5+@casper.infradead.org>
References: <caa84582f9414de895ac6c4fe2b53489@AcuMS.aculab.com>
 <62d82a41b94c475bacceb0f6b11583a1@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62d82a41b94c475bacceb0f6b11583a1@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 11:48:14AM +0000, David Laight wrote:
> +#define min_unsigned(x, y)	\
> +	__careful_cmp((x) + 0u + 0ul + 0ull, (y) + 0u + 0ul + 0ull, <)

What is the point of "+ 0u + 0ul + 0ull"?  How is that any different
from "+ 0ull"?  And why force the compiler to do a 64-bit comparison
when it could do a 32-bit comparison?

