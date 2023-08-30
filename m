Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBA678DF4F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239767AbjH3TX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242593AbjH3JKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:10:25 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7DDCCB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 02:10:20 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qbHDD-009BMg-6V; Wed, 30 Aug 2023 17:10:08 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 30 Aug 2023 17:10:08 +0800
Date:   Wed, 30 Aug 2023 17:10:08 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ardb@kernel.org, keescook@chromium.org, kees@kernel.org,
        linux-kernel@vger.kernel.org, enlin.mu@unisoc.com,
        ebiggers@google.com, gpiccoli@igalia.com, willy@infradead.org,
        yunlong.xing@unisoc.com, yuxiaozhang@google.com
Subject: Re: [GIT PULL] pstore updates for v6.6-rc1
Message-ID: <ZO8HcBirOZnX9iRs@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgaY2+_KyqVpRS+MrO6Y7bXQp69odTu7JT3XSpdUsgS=g@mail.gmail.com>
X-Newsgroups: apana.lists.os.linux.kernel
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> Of course, potentially even better would be to actually move this fix
> into our copy of zlib. Does the bug / misfeature still exist in
> upstream zlib?
> 
> Also, grepping around a bit, I note that btrfs, for example, just does
> that Z_SYNC_FLUSH, and then checks for Z_OK. None of this Z_STREAM_END
> stuff.
> 
> Similarly, going off to the debian code search, I find other code that
> just accepts either Z_OK or Z_STREAM_END.
> 
> So what's so magical about how pstore uses zlib? This is just very odd.

The Crypto API DEFLATE algorithm was added for IPComp (RFC 2394).
So there is a specific format required and to achieve that through
zlib, you must use raw mode.

Later on someone added "zlib-deflate" to the Crypto API which does
emit the zlib header/trailer.  It appears to be completely unused
and it was only added because certain hardware happened be able to
emit the same header/trailer.  We should remove zlib-defalte
and all the driver implementations of it from the Crypto API.

Normally, zlib will emit a header and a checksum trailer.  That's
why its implementation assumes that there will be at least one (or
in fact two) byte(s) after the end of the compressed data.  I haven't
checked the latest upstream but I would presume that it would still
make the same assumption as raw mode (or DEFLATE) is an undocumented
feature of zlib.

Coming back to pstore, for better or worse the original implementation
of pstore chose the Crypto API deflate algorithm so it produces
output that is equivalent to that of RFC 2394.  Therefore it relies
on zlib raw mode and it must supply an extra byte at the end of
the compressed data to ensure that decompression works properly.

The other in-kernel users of zlib appears to use it with a header and
trailer so they are unaffected by this.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
