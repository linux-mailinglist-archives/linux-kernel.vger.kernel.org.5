Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9125751A2F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjGMHpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjGMHo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:44:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3772108;
        Thu, 13 Jul 2023 00:44:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D125721E4E;
        Thu, 13 Jul 2023 07:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689234292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DKzxp2+bTU0RvBuftCWUrTE4tMrCxaPuXQY51bUYZiM=;
        b=zBJPqBqyxXjNscb7x/Yf/G4VtsLZ2NVhZG6IOxIVFS2DV/CkumU6+dj1ybx+k18ptW/r0h
        3wdAvlJ756/G9Ttcd7jXZWm/faXYgWkwvM5IACm8g3Q/t246HeEn1sXUpyCrRa8DRTwQYa
        q+FyXURvjRvUhRXVGzxSaTv/ymYx9yU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689234292;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DKzxp2+bTU0RvBuftCWUrTE4tMrCxaPuXQY51bUYZiM=;
        b=q44zqzJx+W+qYfd2okwpXCikpwguziJByksUibC8w5/+2ZQX8A1uC0ue1FNPt7jspHm0/4
        YKLWP+UZHuD8x2Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C6BA133D6;
        Thu, 13 Jul 2023 07:44:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9qF4IXSrr2QVFgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 13 Jul 2023 07:44:52 +0000
Message-ID: <b18ca2ce-5ebc-1a38-bb9d-a8bb9070cdb1@suse.cz>
Date:   Thu, 13 Jul 2023 09:44:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] mm/slub: remove freelist_dereference()
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Matteo Rizzo <matteorizzo@google.com>,
        Jann Horn <jannh@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org
References: <20230711134623.12695-3-vbabka@suse.cz>
 <20230711134623.12695-4-vbabka@suse.cz> <202307110917.DEED145F0@keescook>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <202307110917.DEED145F0@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/23 18:21, Kees Cook wrote:
> On Tue, Jul 11, 2023 at 03:46:25PM +0200, Vlastimil Babka wrote:
>>  
>>  #ifndef CONFIG_SLUB_TINY
>> -- 
>> 2.41.0
>> 
> 
> I like reducing the complexity here, but I find dropping the "object"
> reassignment makes this a bit harder to read. What about:

Alright.

> 	object = kasan_reset_tag(object);
> 	unsigned long ptr_addr = (unsigned long)object + s->offset;
> 	freeptr_t p = *(freeptr_t *)(ptr_addr);

Are we really so benevolent with declaration-after-statement now? :)

> 	return freelist_ptr_decode(s, p, ptr_addr);
> 
> ?
> 
> They're the same result, so either way:
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> 

