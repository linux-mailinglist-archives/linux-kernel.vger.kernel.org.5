Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97B67EF722
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 18:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346154AbjKQRlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 12:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjKQRlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 12:41:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2648A5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 09:41:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FED2C433C8;
        Fri, 17 Nov 2023 17:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700242899;
        bh=MER7uh+se/JwOjTPFGrER85ioNfg81q8jMULDAOSPNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cqy2H4wG/EgkVRNDWyWbR5qlXsCjjanoSmXnv2CXByhpNRQylp1+7r0Av16pM79TA
         LqTHgMtBZtNdILI6SggFyPhd6b46+v1zyfhTaR0Kcfee+CFK0bRclQv9axkOKnkgOf
         kx0j57oi5JxZvxc1spaoBOMxGkf2NwfxZQod47XD8wgajmq0qCOQB+Lchv1l+YEcaV
         6MPtqhCwkGTc+WAW4NbD5xOJ23ZNDpONRGk13uYnCIIyBdx4I7eiPUqCcBFECE1WRZ
         qoTR4FCP+APCZTDFPB8xv5Qb1Mwwn9kpjI1+CAkk37HbD8jaJUz7NnjGkxFT5Wrl5o
         F2LGQhKIMlpZA==
Date:   Fri, 17 Nov 2023 09:41:37 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: skip adding a discard command if exists
Message-ID: <ZVel0bHLlg4IizJ_@google.com>
References: <20231114212414.3498074-1-jaegeuk@kernel.org>
 <4a0e1c6f-12c4-f3dd-bb26-4bf0aee6be4b@kernel.org>
 <ZVQwz5ubx9LojzEf@google.com>
 <236866a2-41b0-2ad0-db77-4c377367c80e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <236866a2-41b0-2ad0-db77-4c377367c80e@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15, Chao Yu wrote:
> On 2023/11/15 10:45, Jaegeuk Kim wrote:
> > On 11/15, Chao Yu wrote:
> > > On 2023/11/15 5:24, Jaegeuk Kim wrote:
> > > > When recovering zoned UFS, sometimes we add the same zone to discard multiple
> > > > times. Simple workaround is to bypass adding it.
> > > 
> > > What about skipping f2fs_bug_on() just for zoned UFS case? so that the check
> > > condition can still be used for non-zoned UFS case.
> > 
> > Hmm, I've never seen this bug_on before, but even this really happens, it does
> 
> I've never seen it was been triggered as well.
> 
> > not make sense to move forward to create duplicate commands resulting in a loop.
> 
> Agreed.
> 
> It looks those codes were copied from extent_cache code base, do we need to fix
> all cases to avoid loop?

Not sure other cases yet.. let's do one by one, since I hit this in real.

> 
> > 
> > So, the question is, do we really need to check this? Have we hit this before?
> Not sure, just be worry about that flaw of newly developed feature can make
> code run into that branch.
> 
> Thanks,
> 
> > 
> > > 
> > > Thanks,
> > > 
> > > > 
> > > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > > ---
> > > >    fs/f2fs/segment.c | 3 ++-
> > > >    1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > > > index 727d016318f9..f4ffd64b44b2 100644
> > > > --- a/fs/f2fs/segment.c
> > > > +++ b/fs/f2fs/segment.c
> > > > @@ -1380,7 +1380,8 @@ static void __insert_discard_cmd(struct f2fs_sb_info *sbi,
> > > >    			p = &(*p)->rb_right;
> > > >    			leftmost = false;
> > > >    		} else {
> > > > -			f2fs_bug_on(sbi, 1);
> > > > +			/* Let's skip to add, if exists */
> > > > +			return;
> > > >    		}
> > > >    	}
