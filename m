Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF118804D3E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjLEJJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjLEJJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:09:12 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DB1C9;
        Tue,  5 Dec 2023 01:09:18 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3A5081FB7F;
        Tue,  5 Dec 2023 09:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1701767357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=996m6VksQ1/RmEaCfF7b9eJa5BsDq/DzM1GoSO+OXZA=;
        b=nAHmiLmTQczrQWdDzaHxioEnVjob7Yn6quiIzUI+b47qERvBC2XtQj4xG7c9mHsUwEps2+
        1E/IXztBJ8o323JLT+FnvGm+nLzwlEovS+AbdozraY/kIlpYLHVNiezj2T7b0rqT46/R9w
        +VgnwILrJ0+8YnLaeD2p6YXXW4RRQtU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F124136CF;
        Tue,  5 Dec 2023 09:09:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id mcboBb3obmX9SQAAD6G6ig
        (envelope-from <mhocko@suse.com>); Tue, 05 Dec 2023 09:09:17 +0000
Date:   Tue, 5 Dec 2023 10:09:16 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
Cc:     aneesh.kumar@linux.ibm.com, linux-cxl@vger.kernel.org,
        linux-mm@kvack.org, dan.j.williams@intel.com, hannes@cmpxchg.org,
        hasanalmaruf@fb.com, haowang3@fb.com, ying.huang@intel.com,
        gregory.price@memverge.com, tj@kernel.org,
        hezhongkun.hzk@bytedance.com, fvdl@google.com, john@jagalactic.com,
        emirakhur@micron.com, vtavarespetr@micron.com,
        Ravis.OpenSrc@micron.com, Jonathan.Cameron@huawei.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [EXT] Re: [RFC PATCH 0/2] Node migration between memory tiers
Message-ID: <ZW7ovEIF-iCrMc7E@tiehlicka>
References: <20231130220422.2033-1-sthanneeru.opensrc@micron.com>
 <ZW3zl2Fke5FtQCv3@tiehlicka>
 <1db561a9-6984-418d-9305-a2a5ece93696@micron.com>
 <ZW7g4ExYF79gMEBU@tiehlicka>
 <2552828e-6865-4fa8-a9c4-8ed76dd85257@micron.com>
 <ZW7km-SED5oIGGnZ@tiehlicka>
 <8eae7d95-fc98-4ac7-8f83-d0caee00bc87@micron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8eae7d95-fc98-4ac7-8f83-d0caee00bc87@micron.com>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -3.60
X-Spamd-Result: default: False [-3.60 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         RCPT_COUNT_TWELVE(0.00)[20];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 05-12-23 14:32:20, Srinivasulu Thanneeru wrote:
> 
> 
> On 12/5/2023 2:21 PM, Michal Hocko wrote:
> > CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless you recognize the sender and were expecting this message.
> > 
> > 
> > On Tue 05-12-23 14:12:17, Srinivasulu Thanneeru wrote:
> > > 
> > > 
> > > On 12/5/2023 2:05 PM, Michal Hocko wrote:
> > > > CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless you recognize the sender and were expecting this message.
> > > > 
> > > > 
> > > > On Tue 05-12-23 01:26:07, Srinivasulu Thanneeru wrote:
> > > > > 
> > > > > 
> > > > > On 12/4/2023 9:13 PM, Michal Hocko wrote:
> > > > > > CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless you recognize the sender and were expecting this message.
> > > > > > 
> > > > > > 
> > > > > > On Fri 01-12-23 03:34:20, sthanneeru.opensrc@micron.com wrote:
> > > > > > > From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
> > > > > > > 
> > > > > > > The memory tiers feature allows nodes with similar memory types
> > > > > > > or performance characteristics to be grouped together in a
> > > > > > > memory tier. However, there is currently no provision for
> > > > > > > moving a node from one tier to another on demand.
> > > > > > 
> > > > > > Could you expand on why this is really needed/necessary? What is the
> > > > > > actual usecase?
> > > > > 
> > > > > Hi Michal Hock,
> > > > > 
> > > > > Following two use-cases we have observed.
> > > > > 1. It is not accurate to group similar memory types in the same tier,
> > > > >      because even similar memory types may have different speed grades.
> > > > 
> > > > Presumably they are grouped based on a HW configuration. Does that mean
> > > > that the configuration is wrong? Are you trying to workaround that by
> > > > this interface?
> > > > 
> > > > > 2. Some systems boots up with CXL devices and DRAM on the same memory-tier,
> > > > > we need a way to move the CXL nodes to the correct tier from the user space.
> > > > 
> > > > Again, could you expand a bit more and explain why this cannot be
> > > > configured automatically?
> > > 
> > > Yes, in both cases above, if hardware not automatically populated properly,
> > > in that case this interface would help to correct it from user space.
> > > 
> > > We had observed case-2 in our setups.
> > 
> > How hard it is to address this at the HW level?
> > 
> > Btw. this is really important piece of context that should be part of
> > the changelog. Quite honestly introducing user interfaces solely to
> > workaround HW issues seems a rather weak justification. Are there any
> > usecases you can think of where this would be useful?
> 
> I'm not sure how difficult to fix it in the hardware.

Please explore that. It is sad to see learn that CXL which is a really
new technology is already fighting with misconfigurations.

-- 
Michal Hocko
SUSE Labs
