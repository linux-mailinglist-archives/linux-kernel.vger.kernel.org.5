Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E72E7EE0ED
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 13:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345180AbjKPMzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 07:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345173AbjKPMzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 07:55:06 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DCA196
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 04:55:02 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DA2A320502;
        Thu, 16 Nov 2023 12:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1700139300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9DveYl2C6FfM3RZYlQpat22MNtL8btHRXeLgT2LqG/g=;
        b=Om8ErrW13Eo6bOTRo/nHkPzA4W+Kci4T6STNZsP/PldhsCbBL7WLPH/kSek8aTLS589+12
        nTPfTvhK6D4TFIQSo+ALEsNmd+NOw1iYSp5EIgpuPAtWStfjLUlipTIVBwt0Xa4RJa4egi
        Bx26t9zX4BgBWYssTE/sjmCC80ZXW4w=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF6391377E;
        Thu, 16 Nov 2023 12:55:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OzuxKyQRVmU9fAAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 16 Nov 2023 12:55:00 +0000
Date:   Thu, 16 Nov 2023 13:55:00 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        david@redhat.com, vbabka@suse.cz, hannes@cmpxchg.org,
        quic_pkondeti@quicinc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 3/3] mm: page_alloc: drain pcp lists before oom kill
Message-ID: <ZVYRJMUitykepLRy@tiehlicka>
References: <cover.1699104759.git.quic_charante@quicinc.com>
 <a8e16f7eb295e1843f8edaa1ae1c68325c54c896.1699104759.git.quic_charante@quicinc.com>
 <ZUy1dNvbvHc6gquo@tiehlicka>
 <5c7f25f9-f86b-8e15-8603-e212b9911cac@quicinc.com>
 <ZVNQdQKQAMjgOK9y@tiehlicka>
 <342a8854-eef5-f68a-15e5-275de70e3f01@quicinc.com>
 <ZVTRKTi2QCoMiv50@tiehlicka>
 <d531e69c-f0b4-f857-657f-48d981db3923@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d531e69c-f0b4-f857-657f-48d981db3923@quicinc.com>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -7.80
X-Spamd-Result: default: False [-7.80 / 50.00];
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
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16-11-23 11:30:04, Charan Teja Kalla wrote:
> Thanks Michal.
> 
> On 11/15/2023 7:39 PM, Michal Hocko wrote:
> >> Also If you have any comments on [PATCH V2 2/3] mm: page_alloc: correct
> >> high atomic reserve calculations will help me.
> > I do not have a strong opinion on that one to be honest. I am not even
> > sure that reserving a full page block (4MB) on small systems as
> > presented is really a good use of memory.
> 
> May be other way to look at that patch is comment is really not being
> reflected in the code. It says, " Limit the number reserved to 1
> pageblock or roughly 1% of a zone.", but the current code is making it 2
> pageblocks. So, for 4M block size, it is > 1%.
> 
> A second patch, that I will post, like not reserving the high atomic
> page blocks on small systems -- But how to define the meaning of small
> systems is not sure. Instead will let the system administrators chose
> this through either:
> a) command line param, high_atomic_reserves=off, on by default --
> Another knob, so admins may really not like this?
> b) CONFIG_HIGH_ATOMIC_RESERVES, which if not defined, will not reserve.

Please don't! I do not see any admin wanting to care about this at all.
It just takes a lot of understanding of internal MM stuff to make an
educated guess. This should really be auto-tuned. And as responded in
other reply my take would be to reserve a page block on if it doesn't
consume more than 1% of memory to preserve the existing behavior yet not
overconsume on small systems.
 
> Please lmk If you have any more suggestions here?
> 
> Also, I am thinking to request Andrew to pick [PATCH V2 1/3] patch and
> take these discussions separately in a separate thread.

That makes sense as that is a clear bug fix.
-- 
Michal Hocko
SUSE Labs
