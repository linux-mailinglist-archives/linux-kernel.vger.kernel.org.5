Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C48C8017DD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 00:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441887AbjLAXiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 18:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjLAXiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 18:38:54 -0500
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5BE1A6;
        Fri,  1 Dec 2023 15:39:00 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1r9D5s-005xu4-QL; Sat, 02 Dec 2023 07:38:49 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 02 Dec 2023 07:38:58 +0800
Date:   Sat, 2 Dec 2023 07:38:58 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Edward Adam Davis <eadavis@qq.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, olivia@selenic.com,
        syzbot+c52ab18308964d248092@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] hwrng: core - fix task hung in hwrng_fillfn
Message-ID: <ZWpukgSDlA6UFR6e@gondor.apana.org.au>
References: <ZWnGV39HJr9uUB2/@gondor.apana.org.au>
 <tencent_B2D2C5864C49BDAEE0AEC1CC9627E3C6CF06@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_B2D2C5864C49BDAEE0AEC1CC9627E3C6CF06@qq.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 08:34:12PM +0800, Edward Adam Davis wrote:
>
> According to splat, after a page fault occurred, the attempt to retrieve 
> rcu_read_lock() failed, resulting in a timeout of 143s. This is my speculation.

Oh I see what's going on.  The reproducer is mapping /dev/hwrng, so
the write to user-space is then triggering another read which then
dead-locks.

Let me think about this.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
