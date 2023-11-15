Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810487EBB4F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 03:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbjKOCpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 21:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjKOCpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 21:45:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D14ACC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 18:45:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B81C433C8;
        Wed, 15 Nov 2023 02:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700016336;
        bh=hbFaoKrrau1TpP4IwIq1+TY/rzzsU2L4DzKpodehWpg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A50UAOsb/rtVZ8idJO87j5hiPsCfJlrRsPR6AvaX2XEGzsGYCF63M9cGvThZLDYKu
         V636IxpxOe7gXWSi9eIL2EoyWLvxUYJXoCiaHQO46oZWWuI2uQeU93vzg2cv6HPu28
         pK7i2Bod8syCnwd2143yj+DC2duQA1UWByf+yYIkaoDJ+HHJdvdpJeZGkVSzEF5QUy
         BRDGJxfy9/3egRvboN2pXjS36CpdDJjARI0Whb71mZ0yxskYfZRYLeREpUEN43D5Jr
         R70uyZXB0UQvf0ni/Zkb+ofzNApH0y6aGeWDiG7yq8ltiEOgzh1CpEJL07Z/7ywYs3
         GSQ1m0xr9G+rw==
Date:   Tue, 14 Nov 2023 18:45:35 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: skip adding a discard command if exists
Message-ID: <ZVQwz5ubx9LojzEf@google.com>
References: <20231114212414.3498074-1-jaegeuk@kernel.org>
 <4a0e1c6f-12c4-f3dd-bb26-4bf0aee6be4b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a0e1c6f-12c4-f3dd-bb26-4bf0aee6be4b@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15, Chao Yu wrote:
> On 2023/11/15 5:24, Jaegeuk Kim wrote:
> > When recovering zoned UFS, sometimes we add the same zone to discard multiple
> > times. Simple workaround is to bypass adding it.
> 
> What about skipping f2fs_bug_on() just for zoned UFS case? so that the check
> condition can still be used for non-zoned UFS case.

Hmm, I've never seen this bug_on before, but even this really happens, it does
not make sense to move forward to create duplicate commands resulting in a loop.

So, the question is, do we really need to check this? Have we hit this before?

> 
> Thanks,
> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >   fs/f2fs/segment.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 727d016318f9..f4ffd64b44b2 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -1380,7 +1380,8 @@ static void __insert_discard_cmd(struct f2fs_sb_info *sbi,
> >   			p = &(*p)->rb_right;
> >   			leftmost = false;
> >   		} else {
> > -			f2fs_bug_on(sbi, 1);
> > +			/* Let's skip to add, if exists */
> > +			return;
> >   		}
> >   	}
