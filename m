Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3864D7B4C81
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbjJBH0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235696AbjJBH0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:26:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0F78E;
        Mon,  2 Oct 2023 00:26:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AE47221846;
        Mon,  2 Oct 2023 07:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696231563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LYcUk7eapL0u7BOO7YlNH4OBXGFayR53WAp/OvFIzcY=;
        b=US5bw17J+0Iki685lLs7lp6J+ensi9UDi2MWyWSMHSaFrtyKOUAhyknJnT7V/cQ0geUM94
        TyfWOgmnizPgyN840e9v9o3dWqZvLsZVmj4pxbZVES1GP9gRW2ObhjuPJQOmFxNRT8M9zI
        z9v0VY/w+uIEmFZEzPDd7bb0e3EtzNE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696231563;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LYcUk7eapL0u7BOO7YlNH4OBXGFayR53WAp/OvFIzcY=;
        b=yPe7Cw+SZkaGLF5b5L5kWkoRpXulmIWu00NLTcP3sBUCbdEDS3Ln2L1g1U39vcpit6DlQr
        KMr+FqozU9dk54AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B2BE13434;
        Mon,  2 Oct 2023 07:26:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id z6EnIYtwGmX+fwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 02 Oct 2023 07:26:03 +0000
Message-ID: <db77d8e7-4b29-2348-c034-3a2cf120b7b2@suse.cz>
Date:   Mon, 2 Oct 2023 09:26:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/3] mmap: Fix error paths with dup_anon_vma()
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org
References: <20230929183041.2835469-1-Liam.Howlett@oracle.com>
 <20230929183041.2835469-3-Liam.Howlett@oracle.com>
 <843f059f-dd54-4481-b46a-e87e56274db3@lucifer.local>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <843f059f-dd54-4481-b46a-e87e56274db3@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/23 00:28, Lorenzo Stoakes wrote:
> On Fri, Sep 29, 2023 at 02:30:40PM -0400, Liam R. Howlett wrote:
>> When the calling function fails after the dup_anon_vma(), the
>> duplication of the anon_vma is not being undone.  Add the necessary
>> unlink_anon_vma() call to the error paths that are missing them.
>>
>> This issue showed up during inspection of the error path in vma_merge()
>> for an unrelated vma iterator issue.
>>
>> Users may experience increased memory usage, which may be problematic as
>> the failure would likely be caused by a low memory situation.
>>
>> Fixes: d4af56c5c7c6 ("mm: start tracking VMAs with maple tree")
>> Cc: stable@vger.kernel.org
>> Cc: Jann Horn <jannh@google.com>
>> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>> ---
>>  mm/mmap.c | 30 ++++++++++++++++++++++--------
>>  1 file changed, 22 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index acb7dea49e23..f9f0a5fe4db4 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -583,11 +583,12 @@ static inline void vma_complete(struct vma_prepare *vp,
>>   * dup_anon_vma() - Helper function to duplicate anon_vma
>>   * @dst: The destination VMA
>>   * @src: The source VMA
>> + * @dup: Pointer to the destination VMA when successful.
>>   *
>>   * Returns: 0 on success.
> 
> Being a bit nitpicky/refactory here, but anon_vma_clone() appears to have
> two possible return values - 0 for success, and -ENOMEM.
> 
> As a result, it's not really gaining us much passing through this value.
> 
> It'd be nice if dup_anon_vma() and anon_vma_clone() were therefore updated
> to instead return NULL on ENOMEM and the dst otherwise.

But we also need to represent that dup_anon_vma() had nothing to do, because
"(src->anon_vma && !dst->anon_vma)" was false, and in that case we should
not be returning dst from there?

So maybe we could return NULL for that case and ERR_PTR(ret) for the -ENOMEM
from anon_vma_clone() ?

> Then we could de-clunk this whole code path, and the quite natural fact of
> 'thing didn't return a pointer therefore had no memory to allocate it' fals
> out.
> 
> But this isn't exactly an earth-shattering concern :)
> 

