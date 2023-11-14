Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BFD7EAD31
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 10:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjKNJnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 04:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjKNJnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 04:43:21 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB61194;
        Tue, 14 Nov 2023 01:43:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E139721898;
        Tue, 14 Nov 2023 09:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1699954994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mgQsT0odT754L8z+3U8Ly6+wQgAtpd/CnwwQT/eWbGI=;
        b=NNhnrtvLg8PfB8mUbc7N/HdOLXsPh/5OQiu6/44DHFXkC0f2rDOShtPI6i8AmkRnyQkfkf
        f/FD25+V3Qbkqh+Rngko70mZD/q5bcV7E8Z+PLl24rZAadbP5r4k3qo3OaXj7tnRDRRtQU
        OSy2FoNjadPlXc0Mxlo3tWXRjXaEQfg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A731313416;
        Tue, 14 Nov 2023 09:43:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mqVVJzJBU2UgGAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 14 Nov 2023 09:43:14 +0000
Date:   Tue, 14 Nov 2023 10:43:13 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Gregory Price <gregory.price@memverge.com>
Cc:     "tj@kernel.org" <tj@kernel.org>, John Groves <john@jagalactic.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "muchun.song@linux.dev" <muchun.song@linux.dev>,
        "jgroves@micron.com" <jgroves@micron.com>
Subject: Re: [RFC PATCH v4 0/3] memcg weighted interleave mempolicy control
Message-ID: <ZVNBMW8iJIGDyp0y@tiehlicka>
References: <20231109002517.106829-1-gregory.price@memverge.com>
 <klhcqksrg7uvdrf6hoi5tegifycjltz2kx2d62hapmw3ulr7oa@woibsnrpgox4>
 <0100018bb64636ef-9daaf0c0-813c-4209-94e4-96ba6854f554-000000@email.amazonses.com>
 <ZU6pR46kiuzPricM@slm.duckdns.org>
 <ZU6uxSrj75EiXise@memverge.com>
 <ZU7vjsSkGbRLza-K@slm.duckdns.org>
 <ZU74L9oxWOoTTfpM@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZU74L9oxWOoTTfpM@memverge.com>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -3.86
X-Spamd-Result: default: False [-3.86 / 50.00];
         ARC_NA(0.00)[];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         RCVD_TLS_ALL(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         CLAM_VIRUS_FAIL(0.00)[failed to scan and retransmits exceed];
         BAYES_HAM(-1.76)[93.55%];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[18];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         FREEMAIL_CC(0.00)[kernel.org,jagalactic.com,gmail.com,vger.kernel.org,kvack.org,intel.com,linux-foundation.org,bytedance.com,cmpxchg.org,lwn.net,linux.dev,google.com,micron.com];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 10-11-23 22:42:39, Gregory Price wrote:
[...]
> If I can ask, do you think it would be out of line to propose a major
> refactor to mempolicy to enable external task's the ability to change a
> running task's mempolicy *as well as* a cgroup-wide mempolicy component?

No, I actually think this is a reasonable idea. pidfd_setmempolicy is a
generally useful extension. The mempolicy code is heavily current task
based and there might be some challenges but I believe this will a)
improve the code base and b) allow more usecases.

That being said, I still believe that a cgroup based interface is a much
better choice over a global one. Cpusets seem to be a good fit as the
controller does control memory placement wrt NUMA interfaces.
-- 
Michal Hocko
SUSE Labs
