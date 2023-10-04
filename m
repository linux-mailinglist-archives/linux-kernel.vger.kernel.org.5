Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32917B98F9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 01:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244136AbjJDXzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 19:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240836AbjJDXzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 19:55:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780A0D7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 16:55:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508CFC433C8;
        Wed,  4 Oct 2023 23:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696463713;
        bh=MleeiaAqgiqyp0slPvMHrGbe3LZ4PVPcbqFmsHInq1o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WUQD1uhqJdbp1DL+fDexe55XPnUwjMyjzExEYA+GaYLbjw6SHhgsFT9hnSPlkC/di
         YW8nF+JawSZvij+OiIl3fG7apa9tiD2+oLap4G/YTb1kGB5OuF52SiMjmCEr9+yJ74
         FlC3c4aeglAI0kdXWXgeraz4irl450EfQiXIRaP6aStqvu+z9d89V+g2cdVhIP//T8
         XgZYMOxd5q2NynxP8rtIlU65lCtktJloBTeNjsys+87aTFVVCvz+8IRWkc22Do8m0a
         9c4Sl9g/n1znh91amC12ApHZKPsVu36L+M7NEb/okTXd4Fq+whtORudeKkWDO4Wihi
         cIoh9TZX7sBDA==
Date:   Wed, 4 Oct 2023 16:55:11 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH] f2fs-tools: use proper address entry count for direct
 nodes
Message-ID: <ZR37Xyr9HcVuLqxx@google.com>
References: <20231003230155.355807-1-daeho43@gmail.com>
 <ZR30mNQEyRjzr0jm@google.com>
 <CACOAw_zSvAPTREb0dSv6srRuxuKxDZp4rMhLyWTk+uJ3WKSWKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACOAw_zSvAPTREb0dSv6srRuxuKxDZp4rMhLyWTk+uJ3WKSWKA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04, Daeho Jeong wrote:
> On Wed, Oct 4, 2023 at 4:26 PM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> >
> > On 10/03, Daeho Jeong wrote:
> > > From: Daeho Jeong <daehojeong@google.com>
> > >
> > > For direct nodes, we have to use DEF_ADDRS_PER_BLOCK.
> > >
> > > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > > ---
> > >  fsck/fsck.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/fsck/fsck.c b/fsck/fsck.c
> > > index 78ffdb6..56a7d31 100644
> > > --- a/fsck/fsck.c
> > > +++ b/fsck/fsck.c
> > > @@ -2894,7 +2894,7 @@ static void fsck_failed_reconnect_file_dnode(struct f2fs_sb_info *sbi,
> > >       fsck->chk.valid_blk_cnt--;
> > >       f2fs_clear_main_bitmap(sbi, ni.blk_addr);
> > >
> > > -     for (i = 0; i < ADDRS_PER_BLOCK(&node->i); i++) {
> > > +     for (i = 0; i < DEF_ADDRS_PER_BLOCK; i++) {
> >
> > It seems we need to use the inode block passing by fsck_failed_reconnect_file().
> 
> This function is for direct nodes. Is it correct to use inode block here?

 523 unsigned int addrs_per_block(struct f2fs_inode *i)
 524 {
 525         if (!LINUX_S_ISREG(le16_to_cpu(i->i_mode)) ||
 526                         !(le32_to_cpu(i->i_flags) & F2FS_COMPR_FL))
 527                 return DEF_ADDRS_PER_BLOCK;
 528         return ALIGN_DOWN(DEF_ADDRS_PER_BLOCK, 1 << i->i_log_cluster_size);
 529 }

If the inode is compressed, it seems it has to be aligned to cluster size.

> 
> >
> > >               addr = le32_to_cpu(node->dn.addr[i]);
> > >               if (!addr)
> > >                       continue;
> >
> > 3012                         fsck->chk.valid_blk_cnt--;
> > 3013                         if (addr == NEW_ADDR)
> >
> > And, we also need to skip if addr == COMPRESS_ADDR here?
> >
> > 3014                                 continue;
> > 3015                         f2fs_clear_main_bitmap(sbi, addr);
> > 3016                 }
> >
> > > --
> > > 2.42.0.582.g8ccd20d70d-goog
