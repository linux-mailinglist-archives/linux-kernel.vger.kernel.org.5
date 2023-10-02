Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952A27B4B8D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 08:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbjJBGjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 02:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235526AbjJBGjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 02:39:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69350B4
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 23:39:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 236111F459;
        Mon,  2 Oct 2023 06:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696228748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1b28O+1HdP7zBm5Va68Sub1YqNw2PsSIhYwPg/smpco=;
        b=N8abNTS1AQoP49aYj7JgBKDLIGNGgG9l0eUL+NueYeLnJF7FdrvGxt8yM52Iq0Z1aLJIWH
        rTT6lkSL9FYVdgV2u5HBrApckT8voIw7MS+DV7W6rUFlS7qU9gdjBGnVV/jsQJiYnPnmnE
        FWI3ouq5E47qo5JbPyxvwZQxtK+hEkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696228748;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1b28O+1HdP7zBm5Va68Sub1YqNw2PsSIhYwPg/smpco=;
        b=R0k6Tl3XtkCRqoZSu5Thcev5csG7tVkZzaSiwd9eNhIAEd22r86ShJHqX3uHIizNY8B+oA
        kVbEOzbcIaO/fCDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB02913456;
        Mon,  2 Oct 2023 06:39:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id l7u1LItlGmWhawAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 02 Oct 2023 06:39:07 +0000
Message-ID: <a610eab7-4651-27e0-7283-b7ac4ea34cf3@suse.cz>
Date:   Mon, 2 Oct 2023 08:39:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] mm/filemap: clarify filemap_fault() comments for not
 uptodate case
To:     Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Joe Perches <joe@perches.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
References: <20230930231029.88196-1-lstoakes@gmail.com>
 <ZRpiiq/pUB6hGTl/@infradead.org>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZRpiiq/pUB6hGTl/@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/23 08:26, Christoph Hellwig wrote:
>> +		 * If the invalidate lock is not held, the folio was in cache and
>> +		 * uptodate and now it is not. Strange but possible since we
> 
> Please don't spill block comments ôver the 80 charater limit, that makes
> them impossible to read nicely.

Joe, can we revert the default to 80 to avoid everyone having to alias
--max-line-length=80 locally?


