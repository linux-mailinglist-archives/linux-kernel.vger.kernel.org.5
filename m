Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44877753DED
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236016AbjGNOo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236183AbjGNOow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:44:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521ED3594;
        Fri, 14 Jul 2023 07:44:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 091C01F45F;
        Fri, 14 Jul 2023 14:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689345882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IjeSCcUdkUyv6NElS0uC99+S/b+alHnEZdLYL9qlJ0k=;
        b=vzYYlG+Vfq0tK8FhWqoZVfaORtCNivOjGvTXl1VIA+V6mifrQhDK9YXjw8BYPll7ik0Wpl
        FUlKTUyhhsswir+xrAOSU1XDCS4phHKCz7zNzvY6+h+V1xHLenxNvkQ+ZtbmLf8XTEvWWC
        KQii4U05U3sV6IIo9BStDA9BTHbUaoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689345882;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IjeSCcUdkUyv6NElS0uC99+S/b+alHnEZdLYL9qlJ0k=;
        b=eT4qVabG6Evho8V8OIuzXvavbjAsmDfwHDdS7PLGZJOl070STVjNGHPyr/xihFErg/5d/h
        TJz7dIcxEcleK9Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DDAC513A15;
        Fri, 14 Jul 2023 14:44:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dkllNVlfsWQWJgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 14 Jul 2023 14:44:41 +0000
Message-ID: <f8177a33-f341-d285-ff9a-24fdd3936f9a@suse.cz>
Date:   Fri, 14 Jul 2023 16:44:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH stable v6.1] mm/mmap: Fix extra maple tree write
Content-Language: en-US
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hsu <John.Hsu@mediatek.com>, stable@vger.kernel.org,
        linux-mm@kvack.org
References: <20230706185135.2235532-1-Liam.Howlett@oracle.com>
 <2023070748-confiding-abnormal-b7e3@gregkh>
 <20230707164507.mfekysya2jyupghp@revolver>
 <20230712005442.r5ehzbkcxu73whvb@revolver>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230712005442.r5ehzbkcxu73whvb@revolver>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/23 02:54, Liam R. Howlett wrote:
> * Liam R. Howlett <Liam.Howlett@Oracle.com> [230707 12:45]:
>> * Greg KH <gregkh@linuxfoundation.org> [230707 11:55]:
>> > On Thu, Jul 06, 2023 at 02:51:35PM -0400, Liam R. Howlett wrote:
>> > > commit 0503ea8f5ba73eb3ab13a81c1eefbaf51405385a upstream.
>> > > 
>> > > This was inadvertently fixed during the removal of __vma_adjust().
>> > > 
>> > > When __vma_adjust() is adjusting next with a negative value (pushing
>> > > vma->vm_end lower), there would be two writes to the maple tree.  The
>> > > first write is unnecessary and uses all allocated nodes in the maple
>> > > state.  The second write is necessary but will need to allocate nodes
>> > > since the first write has used the allocated nodes.  This may be a
>> > > problem as it may not be safe to allocate at this time, such as a low
>> > > memory situation.  Fix the issue by avoiding the first write and only
>> > > write the adjusted "next" VMA.
>> > 
>> > Are you sure this is the same git id?  The one you reference above is
>> > _VERY_ different from your 2 line change below.
>> > 
>> > And the changelog text is not the same.
>> 
>> Yes, but I am not sure I've indicated what happened correctly.

"commit 0503ea8f5ba73eb3ab13a81c1eefbaf51405385a upstream." is indeed not
the best indication. For stable it would mean you're backporting said
commit, which is not the case.

>> The bug exists in the older __vma_adjust() function, but I removed
>> __vma_adjust() and inadvertently fixed the bug.  So the bug doesn't
>> exist upstream *because* of that commit:
>> 
>> 0503ea8f5ba7 ("mm/mmap: remove __vma_adjust()")
>> 
>> My comment after the commit id indicates what happened, but the
>> documentation wasn't clear to me on how to specify what happened.

I think it's because the process discourages stable-specific fixes. However
this is the case where such approach is much simpler than  backporting
several series with non-trivial vma_merge() cleanups and subsequent
follow-up fixes...

So I agree with the exceptional stable-specific fix. Can you pinpoint a
Fixes: tag? Some of the commits introducing the maple tree?

Vlastimil

>> Does this answer your question?
> 
> Friendly ping on this one?
> 
> Thanks,
> Liam
> 

