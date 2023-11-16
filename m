Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63627EE0E5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 13:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345163AbjKPMwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 07:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344966AbjKPMwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 07:52:32 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86216193
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 04:52:28 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4249D22917;
        Thu, 16 Nov 2023 12:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1700139147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZVDDhjRstd/kU/0OqghBmhN2HaoOfhbkDnF6K+OWoms=;
        b=CJrsqk56sxOYEro5aDypNUHOVOSoMMi1i5G9GzGkaKu5HexSd3PoU8yUA/+l3+aVcRQs7X
        +Q2wWwWK5tVt2kpxGhXhzYd3Ih9PGrdBzwgLmczAWQhu6BJixLUqi9R73BKECsJhQp5LQ5
        i2HOCJeMm0MQyhW6aL5bONn4GYzomjk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0AC161377E;
        Thu, 16 Nov 2023 12:52:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nkJKAIsQVmW7egAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 16 Nov 2023 12:52:27 +0000
Date:   Thu, 16 Nov 2023 13:52:26 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Charan Teja Kalla <quic_charante@quicinc.com>,
        akpm@linux-foundation.org, david@redhat.com, vbabka@suse.cz,
        hannes@cmpxchg.org, quic_pkondeti@quicinc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/3] mm: page_alloc: correct high atomic reserve
 calculations
Message-ID: <ZVYQihO8lsI5_JJc@tiehlicka>
References: <cover.1699104759.git.quic_charante@quicinc.com>
 <905d99651423ee85aeb7a71982b95ee9bb05ee99.1699104759.git.quic_charante@quicinc.com>
 <20231116095901.72oqtjoiqzt3tfhj@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116095901.72oqtjoiqzt3tfhj@techsingularity.net>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -7.76
X-Spamd-Result: default: False [-7.76 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[9];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-2.96)[99.82%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16-11-23 09:59:01, Mel Gorman wrote:
[...]
> This patch in isolation seems fine with the caveat that such a small
> system may find the atomic reserves to be borderline useless.

Yes, exactly what I had in mind. Would it make sense to reserve the the
pageblock only if it really is less than 1% of available memory?
-- 
Michal Hocko
SUSE Labs
