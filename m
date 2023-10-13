Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AC47C7F44
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjJMICx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjJMICv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:02:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2322D83
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:02:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F00C433C8;
        Fri, 13 Oct 2023 08:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697184169;
        bh=mJLa5c8eeNEwknytjJiX4Qjb797Erhab9cpet2X/9qs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NUAua533AvvYtx7YEw0FOGLg1MYJ2Yojvo9t7M4cNHppwp8s+NDkHwuZamHPcRLIc
         Aiw/XEiVglTNoCajTO2JwyPE6J+WPdkSC5G0LSw/ruNO1GTAHufbYeqMXOx/ze9jvm
         r/hfuy1zZ2LLPES+j9Q4YDMQWdINwd9RsQc5bmrU4phQROB3O4Q6Dsj11x95pwWP5l
         zv2PxzV0xpsqlpjhmfQXPMUDlK0E8EGQAAE8WzwdJ3oX5YLxx8UGxKYZYIrzSgcSY3
         vl6aL9W1dK/6qr5VrJm4Fu3VHioZDkSlLkK5t8Opd93bs+GDyxy6ENyl/Iq/Bks4qa
         CHBjbf2Z2ZLFQ==
Date:   Fri, 13 Oct 2023 10:02:39 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     cheng.lin130@zte.com.cn
Cc:     viro@zeniv.linux.org.uk, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, jiang.yong5@zte.com.cn,
        wang.liang82@zte.com.cn, liu.dong3@zte.com.cn
Subject: Re: [RFC PATCH] fs: introduce check for drop/inc_nlink
Message-ID: <20231013-tyrannisieren-umfassen-0047ab6279aa@brauner>
References: <202310131527303451636@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202310131527303451636@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 03:27:30PM +0800, cheng.lin130@zte.com.cn wrote:
> From: Cheng Lin <cheng.lin130@zte.com.cn>
> 
> Avoid inode nlink overflow or underflow.
> 
> Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
> ---

I'm very confused. There's no explanation why that's needed. As it
stands it's not possible to provide a useful review.

I'm not saying it's wrong. I just don't understand why and even if this
should please show up in the commit message.

>  fs/inode.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 67611a360..8e6d62dc4 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -328,6 +328,9 @@ static void destroy_inode(struct inode *inode)
>  void drop_nlink(struct inode *inode)
>  {
>  	WARN_ON(inode->i_nlink == 0);
> +	if (unlikely(inode->i_nlink == 0))
> +		return;
> +
>  	inode->__i_nlink--;
>  	if (!inode->i_nlink)
>  		atomic_long_inc(&inode->i_sb->s_remove_count);
> @@ -388,6 +391,9 @@ void inc_nlink(struct inode *inode)
>  		atomic_long_dec(&inode->i_sb->s_remove_count);
>  	}
>  
> +	if (unlikely(inode->i_nlink == ~0U))
> +		return;
> +
>  	inode->__i_nlink++;
>  }
>  EXPORT_SYMBOL(inc_nlink);
> -- 
> 2.18.1


