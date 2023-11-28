Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DA77FCAA3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 00:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376422AbjK1XPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 18:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK1XPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 18:15:50 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49330197
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 15:15:56 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cff3a03d8eso11643365ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 15:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701213356; x=1701818156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vykgSREbRTVKJqK+hnuQjRVRJhDGB/oVqFtrAotKoXw=;
        b=mLx43ofIVFbBporVjlY/pQViCYGaHNO4DZGfYsubkQoSQBmcRuY91QSolDwm/CUmwP
         sYz1/FI+f0cR9WoTOIGcyUGmzyeGE9/CVn6/BIvWRluSh7VuP9h+zcHqfmsTZrJOAy2t
         PTu61K0nS4QICRMOaXJiYb20aZKpmKGCnz1EJENlg4zpSuZamfLs1IGpGTZbEDuIBSn3
         clinHMmCe+D52xg8DiGqDJWuXnYB2c57BYMzG2jjFFvcRFt4qHprlp4J9CvwCYE6GIaV
         nJxNqKIvzszCUQv4KHHkdWdRXrNhnoh6Pr+2ERIgIOd9ft4igzteC4cU/xKxTQYhgivs
         W/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701213356; x=1701818156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vykgSREbRTVKJqK+hnuQjRVRJhDGB/oVqFtrAotKoXw=;
        b=i1UBFulVxmR9VrIut3hEwtxIsFVEhMPxHO2oGRdOkE31BlyXhRVXvEekpXegKqyQkS
         lEFZBh/WcCgF3Q49pONKxv5/6tKx3XXnexFCj1Qe/pnhvz2p8oSUNDERwgW4Kp7dyjgZ
         N7LROPgrry13IHwfuB3m5klj2r1iK2TG/BPIxs1fWKiCE2HEJG2HkwUkf4nY9SMge8QL
         4KgVd/R9KPW8S+c3akX2+TGJU6+ZjxNTr1qW1a66GUA1aI36CN5zs2wCaTWlzuEX9Nld
         kxQIVgjWQWNTBG2QzG1k/wnIY8BhKPYMeXu+yZHhozbvr972cVYbZ067xK+4PwtK376M
         KPIA==
X-Gm-Message-State: AOJu0Ywil+Td+eWV0RflrBgB1ZaZFxDtiMXSi45xiSW1pzA9sQ0Ui0u1
        YtLIpwIJzxYe5ibjv33Ss+odZQ==
X-Google-Smtp-Source: AGHT+IFmgkDZJXwzoQcBnbJp2dNu2TZ0q9C2VhemNfLY9uei3jQ4nEdjbFj2dj73X4kdRfPHaOmxyQ==
X-Received: by 2002:a17:903:183:b0:1cf:68a3:d908 with SMTP id z3-20020a170903018300b001cf68a3d908mr19841471plg.24.1701213355501;
        Tue, 28 Nov 2023 15:15:55 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902d2c600b001cfcf3dd317sm4399757plc.61.2023.11.28.15.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 15:15:55 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1r87J2-001GLK-1l;
        Wed, 29 Nov 2023 10:15:52 +1100
Date:   Wed, 29 Nov 2023 10:15:52 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Cc:     Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Zhang Tianci <zhangtianci.1997@bytedance.com>,
        Brian Foster <bfoster@redhat.com>, Ben Myers <bpm@sgi.com>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xieyongji@bytedance.com, me@jcix.top
Subject: Re: [PATCH 2/2] xfs: update dir3 leaf block metadata after swap
Message-ID: <ZWZ0qGWpBTW6Iynt@dread.disaster.area>
References: <20231128053202.29007-1-zhangjiachen.jaycee@bytedance.com>
 <20231128053202.29007-3-zhangjiachen.jaycee@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128053202.29007-3-zhangjiachen.jaycee@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 01:32:02PM +0800, Jiachen Zhang wrote:
> From: Zhang Tianci <zhangtianci.1997@bytedance.com>
> 
> xfs_da3_swap_lastblock() copy the last block content to the dead block,
> but do not update the metadata in it. We need update some metadata
> for some kinds of type block, such as dir3 leafn block records its
> blkno, we shall update it to the dead block blkno. Otherwise,
> before write the xfs_buf to disk, the verify_write() will fail in
> blk_hdr->blkno != xfs_buf->b_bn, then xfs will be shutdown.
> 
> We will get this warning:
> 
>   XFS (dm-0): Metadata corruption detected at xfs_dir3_leaf_verify+0xa8/0xe0 [xfs], xfs_dir3_leafn block 0x178
>   XFS (dm-0): Unmount and run xfs_repair
>   XFS (dm-0): First 128 bytes of corrupted metadata buffer:
>   00000000e80f1917: 00 80 00 0b 00 80 00 07 3d ff 00 00 00 00 00 00  ........=.......
>   000000009604c005: 00 00 00 00 00 00 01 a0 00 00 00 00 00 00 00 00  ................
>   000000006b6fb2bf: e4 44 e3 97 b5 64 44 41 8b 84 60 0e 50 43 d9 bf  .D...dDA..`.PC..
>   00000000678978a2: 00 00 00 00 00 00 00 83 01 73 00 93 00 00 00 00  .........s......
>   00000000b28b247c: 99 29 1d 38 00 00 00 00 99 29 1d 40 00 00 00 00  .).8.....).@....
>   000000002b2a662c: 99 29 1d 48 00 00 00 00 99 49 11 00 00 00 00 00  .).H.....I......
>   00000000ea2ffbb8: 99 49 11 08 00 00 45 25 99 49 11 10 00 00 48 fe  .I....E%.I....H.
>   0000000069e86440: 99 49 11 18 00 00 4c 6b 99 49 11 20 00 00 4d 97  .I....Lk.I. ..M.
>   XFS (dm-0): xfs_do_force_shutdown(0x8) called from line 1423 of file fs/xfs/xfs_buf.c.  Return address = 00000000c0ff63c1
>   XFS (dm-0): Corruption of in-memory data detected.  Shutting down filesystem
>   XFS (dm-0): Please umount the filesystem and rectify the problem(s)
> 
> From the log above, we know xfs_buf->b_no is 0x178, but the block's hdr record
> its blkno is 0x1a0.
> 
> Fixes: 24df33b45ecf ("xfs: add CRC checking to dir2 leaf blocks")
> Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> ---
>  fs/xfs/libxfs/xfs_da_btree.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_da_btree.c b/fs/xfs/libxfs/xfs_da_btree.c
> index e576560b46e9..35f70e4c6447 100644
> --- a/fs/xfs/libxfs/xfs_da_btree.c
> +++ b/fs/xfs/libxfs/xfs_da_btree.c
> @@ -2318,8 +2318,18 @@ xfs_da3_swap_lastblock(
>  	 * Copy the last block into the dead buffer and log it.
>  	 */
>  	memcpy(dead_buf->b_addr, last_buf->b_addr, args->geo->blksize);
> -	xfs_trans_log_buf(tp, dead_buf, 0, args->geo->blksize - 1);
>  	dead_info = dead_buf->b_addr;
> +	/*
> +	 * Update the moved block's blkno if it's a dir3 leaf block
> +	 */
> +	if (dead_info->magic == cpu_to_be16(XFS_DIR3_LEAF1_MAGIC) ||
> +	    dead_info->magic == cpu_to_be16(XFS_DIR3_LEAFN_MAGIC) ||
> +	    dead_info->magic == cpu_to_be16(XFS_ATTR3_LEAF_MAGIC)) {

a.k.a.

	if (xfs_has_crc(mp)) {

i.e. this is not specific to the buffer type being processed, it's
specific to v4 vs v5 on-disk format. Hence it's a fs-feature check,
not a block magic number check.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
