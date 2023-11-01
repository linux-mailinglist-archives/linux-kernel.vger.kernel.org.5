Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34B07DE850
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 23:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346976AbjKAWtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 18:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347105AbjKAWtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 18:49:53 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F17D65;
        Wed,  1 Nov 2023 15:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Xo32g7hxYpv1bkgyx0yIq0WCh5UQYdpohhdrKedcg28=; b=m3A9bjaIsqcd/V0LsFFZuxeyo4
        Ua67vaTfb/bEA9+Ytrgn6Ycwb1mxw42ydBwMcKrxJITJXg7zUIf4iJrX5zzkMaQOkTgpdaEWeHkB+
        rOzKMkpEOBRxoWPpt2/xKXCFSN//yuKO43xb+CL5psrC0Umrh3Er0gauIQfpOIDaYHsW928LnxXbx
        DiOUbLcSlTlaYEfW1p2fHI9UrOI9Eur8M5u+HRC6dOknKaC440HUJB7qfZmSUN+B/9FgxTCb3ioLj
        SvzGq4yQEbIYnOCbiCTvN9bScQtiPmsxDqCF4RqNfq4TppRKbbsj9A75iGAxrA59iLAxORUCpBTXh
        yWW75LjA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qyK19-009SsA-36;
        Wed, 01 Nov 2023 22:48:56 +0000
Date:   Wed, 1 Nov 2023 22:48:55 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-afs@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rxrpc_find_service_conn_rcu: use read_seqbegin() rather
 than read_seqbegin_or_lock()
Message-ID: <20231101224855.GJ1957730@ZenIV>
References: <20231027095842.GA30868@redhat.com>
 <1952182.1698853516@warthog.procyon.org.uk>
 <20231101202302.GB32034@redhat.com>
 <20231101205238.GI1957730@ZenIV>
 <20231101215214.GD32034@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101215214.GD32034@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 10:52:15PM +0100, Oleg Nesterov wrote:

> > Why would you want to force that "switch to locked on the second pass" policy
> > on every possible caller?
> 
> Because this is what (I think) read_seqbegin_or_lock() is supposed to do.
> It should take the lock for writing if the lockless access failed. At least
> according to the documentation.

Not really - it's literally seqbegin or lock, depending upon what the caller
tells it...  IMO the mistake in docs is the insistence on using do-while
loop for its users.

Take a look at d_walk() and try to shoehorn that into your variant.  Especially
the D_WALK_NORETRY handling...
