Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8617B4F4A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbjJBJnw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Oct 2023 05:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbjJBJnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:43:50 -0400
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B49E8
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 02:43:46 -0700 (PDT)
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id A4F13B389F;
        Mon,  2 Oct 2023 09:43:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id 32EC118;
        Mon,  2 Oct 2023 09:43:42 +0000 (UTC)
Message-ID: <6fb3fa0fe3e53d6e31c8ab6f96a9549da1d659f0.camel@perches.com>
Subject: Re: [PATCH] mm/filemap: clarify filemap_fault() comments for not
 uptodate case
From:   Joe Perches <joe@perches.com>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Date:   Mon, 02 Oct 2023 02:43:41 -0700
In-Reply-To: <a610eab7-4651-27e0-7283-b7ac4ea34cf3@suse.cz>
References: <20230930231029.88196-1-lstoakes@gmail.com>
         <ZRpiiq/pUB6hGTl/@infradead.org>
         <a610eab7-4651-27e0-7283-b7ac4ea34cf3@suse.cz>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 32EC118
X-Stat-Signature: b8cedzsf9hmbj85bmf9d5rtcxw1fuprd
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1927gKJYw892B+LAQerRFB3HJXUDRHeCwM=
X-HE-Tag: 1696239822-221708
X-HE-Meta: U2FsdGVkX19IapDL28MSH5TXRBy0nJUW3yFP7+EJNp5Tre3L6r0j4z7/1bxenjmZ2my0YL6N3YIykdfJRcreF+nhH2BkKDaKxLfAUkF9RVJWt9P8EbpoY3F3wYxQFmdVoCH17kwKtrIgRaYD235u6jVg4TwpAkcXBztUMN7WyURtxdb74OpqshPvL/pu5R+wopPdd6mFMRkMspS3klk9uQr4nrqqGuI+B4sRXXBNp2jDqdAYheF56Ds6uX8A6EReebhZLw1FCbo0ID4K1guF4FPpbh8VQKIoGMyLNR0NfS3kcq+1HaAJqFEimf44RFA/XNiOs2G481BLFd+QvVsJln66K3p325sRcrGqRHEgT0tqZ0mRE9wcWKMPKfM03obGmrgxYenxyTVnegsRSWfXHDfu63VXPMBnFZC0FRKy0xX6VLVhd0g2QA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-02 at 08:39 +0200, Vlastimil Babka wrote:
> On 10/2/23 08:26, Christoph Hellwig wrote:
> > > +		 * If the invalidate lock is not held, the folio was in cache and
> > > +		 * uptodate and now it is not. Strange but possible since we
> > 
> > Please don't spill block comments ôver the 80 charater limit, that makes
> > them impossible to read nicely.
> 
> Joe, can we revert the default to 80 to avoid everyone having to alias
> --max-line-length=80 locally?

Given the current --max-line-length default is 100,
and that was Linus' preference, I think not.

https://lore.kernel.org/lkml/CAHk-=wj3iGQqjpvc+gf6+C29Jo4COj6OQQFzdY0h5qvYKTdCow@mail.gmail.com/

and

https://lore.kernel.org/lkml/CAHk-=wjR0H3+2ba0UUWwoYzYBH0GX9yTf5dj2MZyo0xvyzvJnA@mail.gmail.com/


