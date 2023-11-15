Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C71D7EC4CC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344150AbjKOOJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjKOOJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:09:51 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDB7188
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 06:09:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0C395218B2;
        Wed, 15 Nov 2023 14:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1700057386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ziC0owFfoL33apf8R/x/Rrhz8VjbOAJrdvgUnGBfRxk=;
        b=rjdJ/xwYpj17GNAvoaf1I7+UTjDrp7xW5/P0GpOIXXSJBpZcqsKcbvRushWCo+rQmA9FBP
        hqxWZG5qLNaeKPC8PGkWC08FzxWtd4EPPaOccGLuowqfRZqRVd1tvwk6XESEpoRTEaOb4T
        CnfYdxfY5m3Iym86FkSiLgbDB0F60R8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D68F313587;
        Wed, 15 Nov 2023 14:09:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6t+6LSnRVGXgVAAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 15 Nov 2023 14:09:45 +0000
Date:   Wed, 15 Nov 2023 15:09:45 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        david@redhat.com, vbabka@suse.cz, hannes@cmpxchg.org,
        quic_pkondeti@quicinc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 3/3] mm: page_alloc: drain pcp lists before oom kill
Message-ID: <ZVTRKTi2QCoMiv50@tiehlicka>
References: <cover.1699104759.git.quic_charante@quicinc.com>
 <a8e16f7eb295e1843f8edaa1ae1c68325c54c896.1699104759.git.quic_charante@quicinc.com>
 <ZUy1dNvbvHc6gquo@tiehlicka>
 <5c7f25f9-f86b-8e15-8603-e212b9911cac@quicinc.com>
 <ZVNQdQKQAMjgOK9y@tiehlicka>
 <342a8854-eef5-f68a-15e5-275de70e3f01@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342a8854-eef5-f68a-15e5-275de70e3f01@quicinc.com>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -8.98
X-Spamd-Result: default: False [-8.98 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[9];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-1.38)[90.73%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 14-11-23 22:06:45, Charan Teja Kalla wrote:
> Thanks Michal!!
> 
> On 11/14/2023 4:18 PM, Michal Hocko wrote:
> >> At least in my particular stress test case it just delayed the OOM as i
> >> can see that at the time of OOM kill, there are no free pcp pages. My
> >> understanding of the OOM is that it should be the last resort and only
> >> after doing the enough reclaim retries. CMIW here.
> > Yes it is a last resort but it is a heuristic as well. So the real
> > questoin is whether this makes any practical difference outside of
> > artificial workloads. I do not see anything particularly worrying to
> > drain the pcp cache but it should be noted that this won't be 100%
> > either as racing freeing of memory will end up on pcp lists first.
> 
> Okay, I don't have any practical scenario where this helped me in
> avoiding the OOM.  Will comeback If I ever encounter this issue in
> practical scenario.
> 
> Also If you have any comments on [PATCH V2 2/3] mm: page_alloc: correct
> high atomic reserve calculations will help me.

I do not have a strong opinion on that one to be honest. I am not even
sure that reserving a full page block (4MB) on small systems as
presented is really a good use of memory.
-- 
Michal Hocko
SUSE Labs
