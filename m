Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3707EAE4E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 11:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjKNKs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 05:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKNKs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 05:48:27 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83B9185
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 02:48:23 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8AF341F86A;
        Tue, 14 Nov 2023 10:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1699958902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BrjlFQJPB430Xww/Nj/QXjsT479LtYaL6hPDX+DNKB8=;
        b=JU5lArdPfGDm1DJ0lLlBDaFe4KTYtNY9VHXm9Kaug+gC/56aa9A1dVvwPPk+nhO8OkfSjQ
        S4CBlurK4XNTVsJ8ugJTPfcvHPx8vtwK5Y5ehIPfyEO0gVD2J3t/BTef+rLN3KWeWg7fwr
        Z3TelnIsPf2HVChfLPNxFv9K7xlrPj8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 62C6C13460;
        Tue, 14 Nov 2023 10:48:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gpsLFXZQU2W2OQAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 14 Nov 2023 10:48:22 +0000
Date:   Tue, 14 Nov 2023 11:48:21 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        david@redhat.com, vbabka@suse.cz, hannes@cmpxchg.org,
        quic_pkondeti@quicinc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 3/3] mm: page_alloc: drain pcp lists before oom kill
Message-ID: <ZVNQdQKQAMjgOK9y@tiehlicka>
References: <cover.1699104759.git.quic_charante@quicinc.com>
 <a8e16f7eb295e1843f8edaa1ae1c68325c54c896.1699104759.git.quic_charante@quicinc.com>
 <ZUy1dNvbvHc6gquo@tiehlicka>
 <5c7f25f9-f86b-8e15-8603-e212b9911cac@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c7f25f9-f86b-8e15-8603-e212b9911cac@quicinc.com>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -4.78
X-Spamd-Result: default: False [-4.78 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[9];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-1.18)[88.99%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 10-11-23 22:06:22, Charan Teja Kalla wrote:
> Thanks Michal!!
> 
> On 11/9/2023 4:03 PM, Michal Hocko wrote:
> >> VM system running with ~50MB of memory shown the below stats during OOM
> >> kill:
> >> Normal free:760kB boost:0kB min:768kB low:960kB high:1152kB
> >> reserved_highatomic:0KB managed:49152kB free_pcp:460kB
> >>
> >> Though in such system state OOM kill is imminent, but the current kill
> >> could have been delayed if the pcp is drained as pcp + free is even
> >> above the high watermark.
> > TBH I am not sure this is really worth it. Does it really reduce the
> > risk of the OOM in any practical situation?
> 
> At least in my particular stress test case it just delayed the OOM as i
> can see that at the time of OOM kill, there are no free pcp pages. My
> understanding of the OOM is that it should be the last resort and only
> after doing the enough reclaim retries. CMIW here.

Yes it is a last resort but it is a heuristic as well. So the real
questoin is whether this makes any practical difference outside of
artificial workloads. I do not see anything particularly worrying to
drain the pcp cache but it should be noted that this won't be 100%
either as racing freeing of memory will end up on pcp lists first.

-- 
Michal Hocko
SUSE Labs
