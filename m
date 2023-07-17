Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9FD7568F6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjGQQTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGQQTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:19:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB46129
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:19:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 19A841FDAC;
        Mon, 17 Jul 2023 16:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689610759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XY4N++ouOf9JpbfnfTNhYe0rv+OT6iZb3HZAx55/hBE=;
        b=qDsWDanx+QjaC0M9RCXYHIW0xMtOSLY67aiwJTsEgCDecPZrpOZ62iMYESeuhl/VlhXvC2
        cFkTPFG9OSwu1gBpHlUn4gqHBAUzHcd8bSDPkCEXcxhtpao8/hpXem1oK0N0+J7VI9D+Ni
        DWrz78xlQcdTkrKhFZNATX7YmMja+FI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689610759;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XY4N++ouOf9JpbfnfTNhYe0rv+OT6iZb3HZAx55/hBE=;
        b=mItGbQH1Q2d/vyi5aOfJG/V0uj7yIrvvBTv20aHMiBPE46bArtzpdCHdntMcnU93lKhcLZ
        AvbRZCHHZfJ8n0Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D045B138F8;
        Mon, 17 Jul 2023 16:19:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yh55MQZqtWSdJwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 17 Jul 2023 16:19:18 +0000
Message-ID: <399a6448-184b-1433-3f23-1a599656a713@suse.cz>
Date:   Mon, 17 Jul 2023 18:19:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: mprotect and hugetlb mappings
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20230705230808.GA41006@monkey>
 <ZKX7PerFpnoMT5Pc@casper.infradead.org> <20230705235322.GD41006@monkey>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230705235322.GD41006@monkey>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/23 01:53, Mike Kravetz wrote:
> On 07/06/23 00:22, Matthew Wilcox wrote:
>> On Wed, Jul 05, 2023 at 04:08:08PM -0700, Mike Kravetz wrote:
>> > I was recently asked about the behavior of mprotect on a hugetlb
>> > mapping where addr or addr+len is not hugetlb page size aligned.  As
>> > one might expect, EINVAL is returned in such cases.  However, the man
>> > page makes no mention of alignment requirements for hugetlb mappings.
>> > 
>> > I am happy to submit man page updates if people agree this is the correct
>> > behavior.  We might even want to check alignment earlier in the code
>> > path as we fail when trying to split the vma today.
>> > 
>> > An alternative behavior would be to operate on whole hugetlb pages within
>> > the range addr - addr+len.
>> 
>> After a careful re-reading of the mprotect() man page, I suggest the
>> following behaviour ...
>> 
>> addr must be a multiple of the hpage size.  Otherwise -EINVAL.
>> len should be rounded up to hpage size.
>> 
>> I wonder how likely this change would be to break userspace code.
>> Maybe some test cases.
> 
> My concern is that this is the approach I took with huegtlb MADV_DONTNEED,
> and this caused problems discussed and eventually modified here:
> https://lore.kernel.org/linux-mm/20221021154546.57df96db@imladris.surriel.com/
> 
> In the MADV_DONTNEED case we were throwing away data.  With mprotect we are
> only modifying access to data.

That can still confuse some userspace, no? I think realistically we can only
document the current implementation better, maybe improve it without
changing observed behavior as you suggested wrt the split vma fail. But
changing it would be dangerous.
