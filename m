Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077A87DE71B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbjKAUxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 16:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbjKAUxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 16:53:17 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01A710C;
        Wed,  1 Nov 2023 13:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jr2IJpvzSamsXOQ8lXfBIM0+s8U3QePROmwmeYAD9Dw=; b=R83lvkNsHjCS4TcowK1Z86ucXU
        Es2gZG7fPpHuheWWpyon0W6eTYz92No6azsuQYBlel6aV+jF5sEu5LNO6xd3YGmzwypI5+ivIZc1i
        ZrINsBcOqffaqFC2fm8WMegcuIhciB/vhhp/sRF/zQjBDTljM7zfoDMMm2lhfwMq5nCrGTNx3aBav
        YS07/glanU8rebq7o/MwiegxK+pGs5LYWtNhfIO81GKl7V2sjRQZCvkIMaV0eRr/J19/4uxFxylQ3
        b0hl/+wBFJwAU3IXS0MbZ9UuoxOX0h44Qk5y9VL3nDbvpM1ShceZN6NNzkkxNrECzE7Rv9/O/3b3z
        zBDYF9PA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qyICc-009QIJ-0g;
        Wed, 01 Nov 2023 20:52:38 +0000
Date:   Wed, 1 Nov 2023 20:52:38 +0000
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
Message-ID: <20231101205238.GI1957730@ZenIV>
References: <20231027095842.GA30868@redhat.com>
 <1952182.1698853516@warthog.procyon.org.uk>
 <20231101202302.GB32034@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101202302.GB32034@redhat.com>
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

On Wed, Nov 01, 2023 at 09:23:03PM +0100, Oleg Nesterov wrote:

> Yes this is confusing. Again, even the documentation is wrong! That is why
> I am trying to remove the misuse of read_seqbegin_or_lock(), then I am going
> to change the semantics of need_seqretry() to enforce the locking on the 2nd
> pass.

What for?  Sure, documentation needs to be fixed, but *not* in direction you
suggested in that patch.

Why would you want to force that "switch to locked on the second pass" policy
on every possible caller?
