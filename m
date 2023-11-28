Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8397FB6BB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343988AbjK1KHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343991AbjK1KHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:07:14 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8231B8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:07:20 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0C9862198D;
        Tue, 28 Nov 2023 10:07:19 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3AD51343E;
        Tue, 28 Nov 2023 10:07:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id zBOZNNa7ZWXyagAAD6G6ig
        (envelope-from <mhocko@suse.com>); Tue, 28 Nov 2023 10:07:18 +0000
Date:   Tue, 28 Nov 2023 11:07:18 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH 4/7] mm: Centralize & improve oom reporting in show_mem.c
Message-ID: <ZWW71lfACwiHw3zk@tiehlicka>
References: <20231122232515.177833-1-kent.overstreet@linux.dev>
 <20231122232515.177833-5-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122232515.177833-5-kent.overstreet@linux.dev>
X-Spamd-Bar: +++++++++++++++
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
        spf=fail (smtp-out1.suse.de: domain of mhocko@suse.com does not designate 2a07:de40:b281:104:10:150:64:97 as permitted sender) smtp.mailfrom=mhocko@suse.com
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [15.00 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-0.99)[-0.987];
         MIME_GOOD(-0.10)[text/plain];
         MID_RHS_NOT_FQDN(0.50)[];
         DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
         RCPT_COUNT_FIVE(0.00)[6];
         SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
         RCVD_COUNT_THREE(0.00)[3];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         MX_GOOD(-0.01)[];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.10)[65.54%]
X-Spam-Score: 15.00
X-Rspamd-Queue-Id: 0C9862198D
X-Spam: Yes
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-11-23 18:25:09, Kent Overstreet wrote:
[...]
> 00177 Shrinkers:
> 00177 super_cache_scan: objects: 127
> 00177 super_cache_scan: objects: 106
> 00177 jbd2_journal_shrink_scan: objects: 32
> 00177 ext4_es_scan: objects: 32
> 00177 bch2_btree_cache_scan: objects: 8
> 00177   nr nodes:          24
> 00177   nr dirty:          0
> 00177   cannibalize lock:  0000000000000000
> 00177
> 00177 super_cache_scan: objects: 8
> 00177 super_cache_scan: objects: 1

It would be really great to provide an example on how these numbers are
useful for the oom evaluation.

[...]
> @@ -423,4 +426,21 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
>  #ifdef CONFIG_MEMORY_FAILURE
>  	printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
>  #endif
> +
> +	buf = kmalloc(4096, GFP_ATOMIC);

I really do not think we want to allow allocations from the OOM context.
Is there any reason why this cannot be a statically allocated buffer?

> +	if (buf) {
> +		struct seq_buf s;
> +
> +		printk("Unreclaimable slab info:\n");
> +		seq_buf_init(&s, buf, 4096);
> +		dump_unreclaimable_slab(&s);
> +		printk("%s", seq_buf_str(&s));
> +
> +		printk("Shrinkers:\n");
> +		seq_buf_init(&s, buf, 4096);
> +		shrinkers_to_text(&s);
> +		printk("%s", seq_buf_str(&s));
> +
> +		kfree(buf);
> +	}
>  }
-- 
Michal Hocko
SUSE Labs
