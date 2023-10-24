Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BC57D4C38
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbjJXJ2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbjJXJ2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:28:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DBF172A
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:27:50 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 091282189E;
        Tue, 24 Oct 2023 09:27:49 +0000 (UTC)
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7DBA82CB0D;
        Tue, 24 Oct 2023 09:27:48 +0000 (UTC)
Date:   Tue, 24 Oct 2023 11:27:48 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>,
        Zhang Zhiyu <zhiyuzhang999@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, secalert@redhat.com
Subject: Re: KASAN: slab-use-after-free Read in radix_tree_lookup in&after
 Linux Kernel 6.4-rc6
Message-ID: <ZTeOFKSXMRhgWYi6@alley>
References: <CALf2hKtDJGqmsiSykbX8EEfbthwt6a4Bs98m60dUkS7URW-C8g@mail.gmail.com>
 <CALf2hKucyJjmgE8Ry50RvytMtWz8gVXGXwoECvoVYph7xkEDEQ@mail.gmail.com>
 <ZTI5tzh_tgCBnr35@alley>
 <ZTJz4/hddcv1J6pJ@casper.infradead.org>
 <ad7f2b88-d483-47d9-9f62-12b55805e1a3@bytedance.com>
 <ZTKVfoQZplpB8rki@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTKVfoQZplpB8rki@casper.infradead.org>
X-Spamd-Bar: +++++++++++++++
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
        spf=fail (smtp-out1.suse.de: domain of pmladek@suse.com does not designate 149.44.160.134 as permitted sender) smtp.mailfrom=pmladek@suse.com
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [15.00 / 50.00];
         ARC_NA(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
         RCPT_COUNT_FIVE(0.00)[6];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         VIOLATED_DIRECT_SPF(3.50)[];
         MX_GOOD(-0.01)[];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MID_RHS_NOT_FQDN(0.50)[];
         R_DKIM_NA(0.20)[];
         RCVD_COUNT_TWO(0.00)[2];
         MIME_TRACE(0.00)[0:+];
         BAYES_HAM(-3.00)[100.00%];
         FREEMAIL_CC(0.00)[bytedance.com,gmail.com,vger.kernel.org,linux-foundation.org,redhat.com]
X-Spam-Score: 15.00
X-Rspamd-Queue-Id: 091282189E
X-Spam: Yes
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-10-20 15:58:06, Matthew Wilcox wrote:
> On Fri, Oct 20, 2023 at 09:51:18PM +0800, Qi Zheng wrote:
> > On 2023/10/20 20:34, Matthew Wilcox wrote:
> > > On Fri, Oct 20, 2023 at 10:26:31AM +0200, Petr Mladek wrote:
> > > > Adding Matthew into Cc in the hope that he is still familiar with the
> > > > code. Also adding Andrew who accepts patches.
> > > 
> > > oh joy.  i love dealing with cves.
> > > 
> > > > > > I agree, this issue looks to be in kernel-core radix tree code in ./lib/radix-tree.c in two of any places.
> > > 
> > > the radix tree code is the victim here.  maybe also the perpetrator, but
> > > it's rather hard to say.
> > > 
> > > shrink_slab_memcg()
> > > 	down_read_trylock(&shrinker_rwsem)
> > > 	shrinker = idr_find(&shrinker_idr, i);
> > > 
> > > i assume is the path to this bug.  the reporter didn't run the
> > > stacktrace through scripts/decode_stacktrace.sh so it's less useful than
> > > we might want.
> > > 
> > > prealloc_memcg_shrinker() calls idr_alloc and idr_remove under
> > > shrinker_rwsem in write mode, so that should be fine.
> > > 
> > > unregister_memcg_shrinker() calls idr_remove after asserting &shrinker_rwsem
> > > is held (although not asserting that it's held for write ... hmm ... but
> > > both callers appear to hold it for write anyway)
> > > 
> > > so i don't see why we'd get a UAF here.
> > > 
> > > anyway, adding Qi Zheng to the cc since they're responsible for the
> > > shrinker code.
> > 
> > Thanks for CC'ing me, I'd be happy to troubleshoot any issues that may
> > be shrinker related.
> > 
> > Between v6.4-rc1 and v6.4 versions, we briefly implemented lockless slab
> > shrink using the SRCU method. In these versions, we call idr_alloc and
> > idr_remove under shrinker_mutex, and idr_find under srcu_read_lock.
> 
> So I think the CVE is inappropriately issued.  The SRCU code was added in
> v6.4-rc1 and removed before v6.4.  I don't think CVEs are appropriate for
> bugs which only existed in development kernels.  How do we revoke CVEs?

I am not sure about the process. Anyway, I have updated the bug
tracking this CVE in SUSE's bugzilla[1] and asked our security team
to dispute the CVE.

[1] https://bugzilla.suse.com/show_bug.cgi?id=1215932

Best Regards,
Petr
