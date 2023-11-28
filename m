Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FE57FB68A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343911AbjK1KBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjK1KBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:01:13 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55F1DE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:01:18 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 623C521904;
        Tue, 28 Nov 2023 10:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1701165677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b0MjlIE5+pSQxzqkC8I7wOjiha8vGuuRwI00+7CVoNo=;
        b=Std/ba/oUYZ6nwnpUkxVkPN1odNxP+SlbOGfRn+ACrFB2uDr9iQ8DQO8/siTX0+jxulPC4
        pQMkOQNZCAVww7AnkLJz2LTe9dTkOQV1UI72px6ev5OANzWzrhf7jduONBUv/RZtFgNujo
        a+EYPv8x3pS3AtfxzboEQnz/9l/VNW4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42B1D1343E;
        Tue, 28 Nov 2023 10:01:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id 0sw8DW26ZWU4aQAAD6G6ig
        (envelope-from <mhocko@suse.com>); Tue, 28 Nov 2023 10:01:17 +0000
Date:   Tue, 28 Nov 2023 11:01:16 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH 2/7] mm: shrinker: Add a .to_text() method for shrinkers
Message-ID: <ZWW6bInvMA2x3mHC@tiehlicka>
References: <20231122232515.177833-1-kent.overstreet@linux.dev>
 <20231122232515.177833-3-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122232515.177833-3-kent.overstreet@linux.dev>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Score: 3.24
X-Spamd-Result: default: False [3.24 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_SPAM(3.84)[96.50%];
         TO_DN_SOME(0.00)[];
         RCPT_COUNT_FIVE(0.00)[6];
         RCVD_COUNT_THREE(0.00)[3];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_TLS_ALL(0.00)[]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-11-23 18:25:07, Kent Overstreet wrote:
[...]
> +void shrinkers_to_text(struct seq_buf *out)
> +{
> +	struct shrinker *shrinker;
> +	struct shrinker_by_mem {
> +		struct shrinker	*shrinker;
> +		unsigned long	mem;
> +	} shrinkers_by_mem[10];
> +	int i, nr = 0;
> +
> +	if (!mutex_trylock(&shrinker_mutex)) {
> +		seq_buf_puts(out, "(couldn't take shrinker lock)");
> +		return;
> +	}
> +
> +	list_for_each_entry(shrinker, &shrinker_list, list) {
> +		struct shrink_control sc = { .gfp_mask = GFP_KERNEL, };

This seems to be global reclaim specific. What about memcg reclaim?
-- 
Michal Hocko
SUSE Labs
