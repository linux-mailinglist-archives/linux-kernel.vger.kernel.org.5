Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E907CB7B1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 02:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbjJQA5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 20:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbjJQA5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 20:57:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DA292
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 17:57:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1663C433C7;
        Tue, 17 Oct 2023 00:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697504267;
        bh=JV3a9WavpKRxzuKlWmqQJg+YqvaB3sDwZIIEHKP8u0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZUUuzPit1KoxCtDPpasaR7GJ1ViDLCByCip7UH8Qe/tim4SLVGcz09pYkUWe0bHGk
         TD4f2G9LympQs5T5ZYbV3MrpuqAkzkg0VGYKO2LqKqKZFjirbcUJL/mNhCNgh5ovIj
         ylVntVcMw63UfOMo9wLSGg9S5jmYjkf6+x4Celobo94t+VneVjrfCjjdrG/UY8y6aV
         JZdwBTVvMSiFXYHsjQ6YmpT3SMyXM90XRfcLqJXK/wQavkUsqeuLX9iXc/qGODnDuF
         wJ7Wptu6UXM9nhoClw7IiIIQuvE6IVEZS3fSoWwRkr5n2dMJyBWdn+5wTIAgfPM05R
         ZeWj+VSzwEdXw==
Date:   Mon, 16 Oct 2023 17:57:47 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     cheng.lin130@zte.com.cn
Cc:     brauner@kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, jiang.yong5@zte.com.cn,
        wang.liang82@zte.com.cn, liu.dong3@zte.com.cn
Subject: Re: [RFC PATCH] fs: introduce check for drop/inc_nlink
Message-ID: <20231017005747.GB11424@frogsfrogsfrogs>
References: <20231013-tyrannisieren-umfassen-0047ab6279aa@brauner>
 <202310131740571821517@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310131740571821517@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 05:40:57PM +0800, cheng.lin130@zte.com.cn wrote:
> > On Fri, Oct 13, 2023 at 03:27:30PM +0800, cheng.lin130@zte.com.cn wrote:
> > > From: Cheng Lin <cheng.lin130@zte.com.cn>
> > >
> > > Avoid inode nlink overflow or underflow.
> > >
> > > Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
> > > ---
> > I'm very confused. There's no explanation why that's needed. As it
> > stands it's not possible to provide a useful review.
> > I'm not saying it's wrong. I just don't understand why and even if this
> > should please show up in the commit message.
> In an xfs issue, there was an nlink underflow of a directory inode. There
> is a key information in the kernel messages, that is the WARN_ON from
> drop_nlink(). However, VFS did not prevent the underflow. I'm not sure
> if this behavior is inadvertent or specifically designed. As an abnormal
> situation, perhaps prohibiting nlink overflow or underflow is a better way
> to handle it.
> Request for your comment.

I was trying to steer you towards modifying vfs_rmdir and vfs_unlink to
check that i_nlink of the files involved aren't somehow already zero
and returning -EFSCORRUPTED if they are.  Not messing around with
drop_nlink.

--D
