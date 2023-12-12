Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A371680EFE9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376619AbjLLPSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376617AbjLLPSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:18:39 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA71AF2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:18:44 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-124-235.bstnma.fios.verizon.net [173.48.124.235])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3BCFGD14031942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 10:16:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1702394176; bh=DtgEPyOZ4y0NfYNH2YIubU5zH6WNkZa4uw9X/YrTYR4=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=Q5sj5B3tLr9igBweNwduA6PZT0jYBpf0QnbgLveixW6seItI++ZBFGLTSfMerXbHS
         p3Njc97PdcRGIf4TKVEIgxHBmronQjNXJXkrLeyzAbdW7GV1yA6oV2+VPV1gK1ydCA
         plr3+UqY8u6qAlN8rPtYydnRcIslVMIPw7x6+DKRYXPcipRYnF6o/Q/c+IcjyVQ1nz
         xX/twG+yBdGeDtIRnBvYz8ENuccCOYcaLXXX4fUlprrqCi9h59tRVipe7VYumU3kvK
         SwIQLaIYDR3Ok4/grND9PhvZx+JGOPReXUzLdYhTXSVb3FEptumR75NlyxpN2qeOgl
         1tSRfCDMZ1iaQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A517515C1422; Tue, 12 Dec 2023 10:16:13 -0500 (EST)
Date:   Tue, 12 Dec 2023 10:16:13 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     John Garry <john.g.garry@oracle.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        linux-ext4@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dchinner@redhat.com
Subject: Re: [RFC 0/7] ext4: Allocator changes for atomic write support with
 DIO
Message-ID: <20231212151613.GA142380@mit.edu>
References: <cover.1701339358.git.ojaswin@linux.ibm.com>
 <8c06c139-f994-442b-925e-e177ef2c5adb@oracle.com>
 <ZW3WZ6prrdsPc55Z@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <de90e79b-83f2-428f-bac6-0754708aa4a8@oracle.com>
 <ZXbqVs0TdoDcJ352@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <c4cf3924-f67d-4f04-8460-054dbad70b93@oracle.com>
 <ZXhb0tKFvAge/GWf@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXhb0tKFvAge/GWf@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 05:10:42AM -0800, Christoph Hellwig wrote:
> On Tue, Dec 12, 2023 at 07:46:51AM +0000, John Garry wrote:
> > It is assumed that the user will fallocate/dd the complete file before
> > issuing atomic writes, and we will have extent alignment and length as
> > required.
> 
> I don't think that's a long time maintainable usage model.

For databases that are trying to use this to significantly improve
their performance by eliminating double writes, the allocation and
writes are being done by a single process.  So for *that* use case, it
is quite maintainable.

Cheers,

						- Ted
