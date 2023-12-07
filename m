Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F648094C4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 22:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444016AbjLGVi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 16:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444025AbjLGViW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 16:38:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5284C3B;
        Thu,  7 Dec 2023 13:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AWfjo1FCG0zNp8yVCNT7ypjhavVj3uaSeJIY6fXZW/Q=; b=HTuLP32YvRPL+oDE1a2yf5CShL
        ZnbMwPGwoi+NE6tA3HShRYkj/nFemjITFmj5Ox2jNRUaliUFlLDv9SObg0rJ5oT1WvP7zsjxun+um
        1n3KXNVINV0TCPAQxQN4czj4sTVT9Of4N8CX4cSkmDyuAKQVEgGkD44HDRPlI7QwkZdWumu+qgxyR
        4Q0V0xPz3VUXOTkIqALZfgsxEDxeNab4xoQyhQsDoX1YlLarOB5VF88kzf1zLdrTvw3UPcsPbwiq3
        gQ2O1DcxXwjjfagYLU32Q7kUgRaotlnTsgr99KIFU7JUjVCyTwfXDfsYjgLIdajtZG/qiOgqqpm8d
        CB99jGig==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1rBM1H-004PV4-3e; Thu, 07 Dec 2023 21:34:55 +0000
Date:   Thu, 7 Dec 2023 21:34:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Steve French <smfrench@gmail.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Paulo Alcantara <pc@manguebit.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 23/59] netfs: Prep to use folio->private for write
 grouping and streaming write
Message-ID: <ZXI6fyO1xJbLNXFg@casper.infradead.org>
References: <20231207212206.1379128-1-dhowells@redhat.com>
 <20231207212206.1379128-24-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207212206.1379128-24-dhowells@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 09:21:30PM +0000, David Howells wrote:
> +#define NETFS_FOLIO_INFO	0x1UL	/* OR'd with folio->private. */
> +
> +static inline struct netfs_folio *netfs_folio_info(struct folio *folio)
> +{
> +	void *priv = folio_get_private(folio);
> +
> +	if ((unsigned long)priv & NETFS_FOLIO_INFO)
> +		return (struct netfs_folio *)((unsigned long)priv & ~NETFS_FOLIO_INFO);

Often one gets better code by using '-' instead of '& ~', and that's
because 'subtract one, then load four bytes from offset 12' can be
optimised into 'load four bytes from offset 11' in a way that 'clear
the bottom bit, then load four bytes from offset 12' can't be.

