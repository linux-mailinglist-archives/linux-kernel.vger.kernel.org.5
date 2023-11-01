Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D727DDE9C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 10:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjKAJl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 05:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjKAJlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 05:41:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758FEE4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 02:41:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 35A9E21A34;
        Wed,  1 Nov 2023 09:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698831706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gNzKW+x1c0UZzbPukaEOwSLPVJ3mDtKgT9KmOp+APUs=;
        b=mATHxiyl0jyzlQq1mEMQ1Vf9cG7e8R78/0Fg62j2oA5mxSItZFmh+/2+y/MO0xxPhK7If8
        1NU2e1kMm0UsMXYdbehYvMYQa4Ugff/Vxvghqsv6zUabsZ929/4TUaOwcex51GQ9UbxOZO
        sJQlpgZZ6t7pvksUd25n1OoZLxCNkiM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0FB8013460;
        Wed,  1 Nov 2023 09:41:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PRrnAFodQmU9DAAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 01 Nov 2023 09:41:46 +0000
Date:   Wed, 1 Nov 2023 10:41:45 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        david@redhat.com, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: page_alloc: unreserve highatomic page blocks before
 oom
Message-ID: <azi6v2uipdazwmczihmc4hutsw74r3mfxs6tgxkdmweb6bo4dr@c43f7ixoydpd>
References: <1698669590-3193-1-git-send-email-quic_charante@quicinc.com>
 <gtya2g2pdbsonelny6vpfwj5vsxdrzhi6wzkpcrke33mr3q2hf@j4ramnjmfx52>
 <2a0d2dd8-562c-fec7-e3ac-0bd955643e16@quicinc.com>
 <37c58833-1953-42c3-98c6-ee0ac75508ce@quicinc.com>
 <ca6093e6-fc85-9ce8-71a1-77d8996c9fd6@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca6093e6-fc85-9ce8-71a1-77d8996c9fd6@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01-11-23 12:23:24, Charan Teja Kalla wrote:
[...]
> > Also, add below Fixes tag if it makes sense.
> > 
> > Fixes: 04c8716f7b00 ("mm: try to exhaust highatomic reserve before the OOM")
> I should be adding this.

I do not think this Fixes tag is really correct. 04c8716f7b00 was rather
an incomplete fix than something that has caused this situation. I think
we would need to reference the commit which adds highatomic reserves.

-- 
Michal Hocko
SUSE Labs
