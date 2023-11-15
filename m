Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9B37ED767
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 23:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbjKOWjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 17:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjKOWjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 17:39:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BECE197
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 14:39:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0A6C433C7;
        Wed, 15 Nov 2023 22:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1700087958;
        bh=Bc5QhrR2eaIlIZFKVsskxjM9tSbZCZUwJZ8vcOKwJMw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GJBh0WvPEs1GIJ2oTeRVZ0zcB6JPHJN5iz2KbLkXe9Ap8LGrvwe08UX+Vv88g/kJa
         3dQ4qxGh+0XhnPR0qBviHIEOs+AtQUSrFCkOb5k4I1syNBCwMb7LV1zvQt0F3mAFZM
         w5WMXpCCdprdxFmFu1iB9wr8sKE4xlAPDFvLsecc=
Date:   Wed, 15 Nov 2023 14:39:17 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Edward Adam Davis <eadavis@qq.com>
Cc:     syzbot+604424eb051c2f696163@syzkaller.appspotmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        phillip@squashfs.org.uk, squashfs-devel@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] squashfs: fix oob in squashfs_readahead
Message-Id: <20231115143917.fdec61135bf3436fc15d2d2c@linux-foundation.org>
In-Reply-To: <tencent_35864B36740976B766CA3CC936A496AA3609@qq.com>
References: <000000000000b1fda20609ede0d1@google.com>
        <tencent_35864B36740976B766CA3CC936A496AA3609@qq.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 12:05:35 +0800 Edward Adam Davis <eadavis@qq.com> wrote:

> Before performing a read ahead operation in squashfs_read_folio() and 
> squashfs_readahead(), check if i_size is not 0 before continuing.

I'll merge this for testing, pending Phillip's review.  One thing:

> --- a/fs/squashfs/block.c
> +++ b/fs/squashfs/block.c
> @@ -323,7 +323,7 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
>  	}
>  	if (length < 0 || length > output->length ||
>  			(index + length) > msblk->bytes_used) {
> -		res = -EIO;
> +		res = length < 0 ? -EIO : -EFBIG;
>  		goto out;
>  	}

Seems a bit ugly to test `length' twice for the same thing.  How about

	if (length < 0) {
		res = -EIO;
		got out;
	}
	if (length > output->length || (index + length) > msblk->bytes_used) {
		res = -EFBIG;
		goto out;
	}

?

