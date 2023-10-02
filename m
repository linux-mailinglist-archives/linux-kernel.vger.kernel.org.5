Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380AB7B4C4C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbjJBHLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235684AbjJBHLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:11:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBEA8E;
        Mon,  2 Oct 2023 00:11:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6FEE721853;
        Mon,  2 Oct 2023 07:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696230663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P0mFFbYawjhHJI/MVnVhD7eJbJDMhTOVCb9gruMN8Mo=;
        b=rZ41UYqhrcd8ECadWlH8Rnkr1zEiqXt/hPInCf1O+E1azyx6hnKeUVA/wA+GuapSurfKUh
        7WUFXtgDl/vzNsccAXHBHzWdSSvwmL4ym+VTsa+3SOJ+F4p3YxIl2P3TfNa1NDqPw0lLhm
        0VskMfhMVK4SE874zL7qR0Rh243XBwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696230663;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P0mFFbYawjhHJI/MVnVhD7eJbJDMhTOVCb9gruMN8Mo=;
        b=DQliiCU2cteEMe2Lt8fetDwWqgRgcP4yttY4lh4VwuGdtOu/Z8M9Jw0aPGS1KUKZjDfTOt
        WPrkUfC86Yh+JtCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E40F13456;
        Mon,  2 Oct 2023 07:11:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Rc9uEgdtGmVKeQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 02 Oct 2023 07:11:03 +0000
Message-ID: <eca412f9-b642-48c8-f0ba-b02c0b7cefad@suse.cz>
Date:   Mon, 2 Oct 2023 09:11:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/3] mmap: Fix error paths with dup_anon_vma()
Content-Language: en-US
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org
References: <20230929183041.2835469-1-Liam.Howlett@oracle.com>
 <20230929183041.2835469-3-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230929183041.2835469-3-Liam.Howlett@oracle.com>
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

On 9/29/23 20:30, Liam R. Howlett wrote:
> When the calling function fails after the dup_anon_vma(), the
> duplication of the anon_vma is not being undone.  Add the necessary
> unlink_anon_vma() call to the error paths that are missing them.
> 
> This issue showed up during inspection of the error path in vma_merge()
> for an unrelated vma iterator issue.
> 
> Users may experience increased memory usage, which may be problematic as
> the failure would likely be caused by a low memory situation.
> 
> Fixes: d4af56c5c7c6 ("mm: start tracking VMAs with maple tree")
> Cc: stable@vger.kernel.org
> Cc: Jann Horn <jannh@google.com>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

