Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAA47F9C1A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbjK0Iur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbjK0Iun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:50:43 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD47188
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:50:48 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9283D2027A;
        Mon, 27 Nov 2023 08:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1701075046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LRi9ngSxggQud/fxmQYL6ll8RoVr5MrBgBUE8mAhwc8=;
        b=bC/rzYW0p69DtNQ9EhPXDxwhoOXYLaA0FIwA1DhE1yPE06UiXrAd26ZocYd/ZozXD9cDxM
        MYO9z66qvyp1McAmidq2m3TuEXiAOvUo+HnI68oVbm4HHA7K1ZHflxi5YMV9/xCHt1Z9cF
        tQ9YnC+5k2KPUEJZHIazYl8qZjuvUMU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8958D1367B;
        Mon, 27 Nov 2023 08:50:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id doDqHGZYZGWVMQAAD6G6ig
        (envelope-from <mhocko@suse.com>); Mon, 27 Nov 2023 08:50:46 +0000
Date:   Mon, 27 Nov 2023 09:50:46 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Dmytro Maluka <dmaluka@chromium.org>
Cc:     Liu Shixin <liushixin2@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        huang ying <huang.ying.caritas@gmail.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kemi Wang <kemi.wang@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH -next v2] mm, proc: collect percpu free pages into the
 free pages
Message-ID: <ZWRYZmulV0B-Jv3k@tiehlicka>
References: <20220822023311.909316-1-liushixin2@huawei.com>
 <20220822033354.952849-1-liushixin2@huawei.com>
 <20220822141207.24ff7252913a62f80ea55e90@linux-foundation.org>
 <YwSGqtEICW5AlhWr@dhcp22.suse.cz>
 <6b2977fc-1e4a-f3d4-db24-7c4699e0773f@huawei.com>
 <YwTYMGtcS4/F/xQO@dhcp22.suse.cz>
 <ZWDjbrHx6XNzAtl_@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWDjbrHx6XNzAtl_@google.com>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Score: 0.70
X-Spam-Level: 
X-Spamd-Result: default: False [0.70 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_THREE(0.00)[3];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         BAYES_HAM(-0.00)[35.72%];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         RCPT_COUNT_TWELVE(0.00)[13];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         MID_RHS_NOT_FQDN(0.50)[];
         FREEMAIL_CC(0.00)[huawei.com,linux-foundation.org,linuxfoundation.org,gmail.com,intel.com,redhat.com,suse.cz,vger.kernel.org,kvack.org];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 24-11-23 18:54:54, Dmytro Maluka wrote:
[...]
> But looking at the code in __alloc_pages() and around, I see you are
> right: we don't try draining other CPUs' PCP lists *before* resorting to
> direct reclaim, compaction etc.
> 
> BTW, why not? Shouldn't draining PCP lists be cheaper than pageout() in
> any case?

My guess would be that draining remote pcp caches is quite expensive on
its own. This requires IPIs, preempting whatever is running there and
wait for the all the cpus with pcp caches to be done. On the other hand
reclaiming a mostly clean page cache could be much less expensive. 

Also consider that refilling those pcp caches is not free either (you
might hit zone lock contetion and who knows what else).

Last but not least also consider that many systems could be just on the
edge of low/min watermark with a lot of cached data. If we drained all
pcp caches whenever we reclaim this could just make the cache pointless.

All that being said, I do not remember any actual numbers or research
about this.
-- 
Michal Hocko
SUSE Labs
