Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BA0784103
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235759AbjHVMmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjHVMmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:42:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524451B2;
        Tue, 22 Aug 2023 05:42:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 08ED021AAD;
        Tue, 22 Aug 2023 12:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692708130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bl4w0YrPfeUaazlfAoPqb1iTebmgbNrFsUloPCpKEbA=;
        b=Yv8RD8Qp1U780EK841QDvxNV1Ae2V7Icd6Pj28Nwq6yo2vNkCiCzGXZHD7WaajnddMnJIc
        itPR2MVzvCRmFRgjXXoBZb4L37mg7/qiLyQT4BoS32sABp6Xe3Bi+cRTouO5tDJuSRyzTP
        WhA0aZnlXS52q4YHzUFFoG7mTsWmuRY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DEF3A13919;
        Tue, 22 Aug 2023 12:42:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8KAUNCGt5GSpawAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 22 Aug 2023 12:42:09 +0000
Date:   Tue, 22 Aug 2023 14:42:09 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Chuyi Zhou <zhouchuyi@bytedance.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>, hannes@cmpxchg.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        muchun.song@linux.dev, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, wuyun.abel@bytedance.com,
        robin.lu@bytedance.com
Subject: Re: [RFC PATCH 1/2] mm, oom: Introduce bpf_select_task
Message-ID: <ZOStIZsF5rfGkvbJ@dhcp22.suse.cz>
References: <ZMzhDFhvol2VQBE4@dhcp22.suse.cz>
 <dfbf05d1-daff-e855-f4fd-e802614b79c4@bytedance.com>
 <ZMz+aBHFvfcr0oIe@dhcp22.suse.cz>
 <866462cf-6045-6239-6e27-45a733aa7daa@bytedance.com>
 <ZNCXgsZL7bKsCEBM@dhcp22.suse.cz>
 <ZNEpsUFgKFIAAgrp@P9FQF9L96D.lan>
 <ZNH6X/2ZZ0quKSI6@dhcp22.suse.cz>
 <ZNK2fUmIfawlhuEY@P9FQF9L96D>
 <ZNNGFzwlv1dC866j@dhcp22.suse.cz>
 <78648d96-8899-6ac6-62d4-9e5b34ac004e@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78648d96-8899-6ac6-62d4-9e5b34ac004e@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Still catching up with older threads. Sorry for the late reply]
On Mon 14-08-23 19:25:08, Chuyi Zhou wrote:
> Hello,
> 
> 在 2023/8/9 15:53, Michal Hocko 写道:
> > On Tue 08-08-23 14:41:17, Roman Gushchin wrote:
[...]
> > > It would be also nice to come up with some practical examples of bpf programs.
> > > What are meaningful scenarios which can be covered with the proposed approach
> > > and are not covered now with oom_score_adj.
> > 
> Just like Abel said, the oom_score_adj only adjusts the memory usage-based
> decisions, and it's hard to be translated into other semantics. We see that
> some userspace oom-killer like oomd has implemented policies based on other
> semantics(e.g., memory growth, priority, psi pressure, ect.) which can be
> useful in some specific scenario.

Sure, I guess we do not really need to discuss that oom_score_adj is not
a great fit ;) We want to have practical (read no-toy) oom policies that
are useful as a PoC though.

> > Agreed here as well. This RFC serves purpose of brainstorming on all of
> > this.
> > 
> > There is a fundamental question whether we need BPF for this task in the
> > first place. Are there any huge advantages to export the callback and
> > allow a kernel module to hook into it?
> 
> If we export the callback to a kernel module and hook into it,
> We still have the same problems (e.g., allocating much memory). Just like
> Martin saied, at least BPF supports some basic running context and some
> unsafe behavior is restricted.

I do not follow. Kernel module has access to any existing kernel
interfaces without any need to BPF them. So what exactly is the strength
of the BPF over kernel module hook? I am pretty sure there are some
(many?) but it is really important to be explicit about those before we
make any decision.

-- 
Michal Hocko
SUSE Labs
