Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650837DE23D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 15:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjKANlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 09:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKANlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 09:41:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F7AC1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 06:40:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 512E82197D;
        Wed,  1 Nov 2023 13:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698846057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eWpcS2uNhl3MFqzBRWbq6Zb5rGtjCi2loLGa1UFEPgk=;
        b=xbtFy6iel8PYaNV+EqzMVoWQurwl2bwPRGBd4yRdQKH7Kwu8jDRdBDRvne6WvaFE+RxTmZ
        Rvbcn3ZrSqxfsoULg14IjQKUAJMIcH3AOIU1xno4V0ajL9OKfGadN0kNs8lxmB2FDtFBox
        OnIrtJ0I5c7qv6/VbUgsxsQeF5CKG6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698846057;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eWpcS2uNhl3MFqzBRWbq6Zb5rGtjCi2loLGa1UFEPgk=;
        b=VjaUd2dxcj+/Htqi+NaVKfY0CEzZEfBhwpek5rtlN1zA9HORtYcLvnvRMO+eBPyqdckZoX
        K4HjijtLUDd7RdCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1043713460;
        Wed,  1 Nov 2023 13:40:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sT23AmlVQmVTdQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 01 Nov 2023 13:40:57 +0000
Message-ID: <5e29c6bb-01a2-b010-df7d-525ed9fdbee4@suse.cz>
Date:   Wed, 1 Nov 2023 14:40:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v4 8/9] slub: Rename all *unfreeze_partials* functions
 to *put_partials*
Content-Language: en-US
To:     chengming.zhou@linux.dev, cl@linux.com, penberg@kernel.org,
        willy@infradead.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231031140741.79387-1-chengming.zhou@linux.dev>
 <20231031140741.79387-9-chengming.zhou@linux.dev>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231031140741.79387-9-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/23 15:07, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Since all partial slabs on the CPU partial list are not frozen anymore,
> we don't unfreeze when moving cpu partial slabs to node partial list,
> it's better to rename these functions.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

However I think put_partials_node() is not the best name as it's not
something specific to a single node. I think __put_partials() would be
better.
