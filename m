Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2762B7FA47A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbjK0P27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbjK0P25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:28:57 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24121183;
        Mon, 27 Nov 2023 07:29:00 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 631811BE6B3;
        Mon, 27 Nov 2023 10:28:59 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=rNBAVfaX9ctZ4ii/4kyKzGuefYpJB4VqiJgPY8
        WPzqk=; b=cHcVaYGmjCo8DBEc0yXUKmQZF15X0FNCKHgV35JbEAO0r7qYdvC0cp
        vrWnWJp19UMAnlDLeASJ/Rd1sN2VizWhI8nJOnfqTuFiuDeFKdO1RUbkZc2roVKh
        +8IOs8jfCz2f47l0L+UpRnWISiuddhkymWYMVQCNhXsJo078UUvpM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 597FC1BE6B1;
        Mon, 27 Nov 2023 10:28:59 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=rNBAVfaX9ctZ4ii/4kyKzGuefYpJB4VqiJgPY8WPzqk=; b=fy0XjToO+L9LJ+IBXt/kVcmQoLiVPpN+G0Xc4nOLER3sgFdSfSouMaXB3nJNnvvr8fH0w93C7TLBPM7WZ88aGrxAa2UflPkEfXTQCugXnRHMt2vSU5wksCxSRcWB4tm3DOlRzxFjOnpCbA6hS9h3KsL75RJKVbPYaREQvkDQQKE=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BC2741BE6AE;
        Mon, 27 Nov 2023 10:28:58 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
        by yoda.fluxnic.net (Postfix) with ESMTPSA id A9833A27F2B;
        Mon, 27 Nov 2023 10:28:57 -0500 (EST)
Date:   Mon, 27 Nov 2023 10:28:57 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Yu Kuai <yukuai1@huaweicloud.com>
cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH block/for-next v2 09/16] cramfs: use new helper to get
 inode from block_device
In-Reply-To: <20231127062116.2355129-10-yukuai1@huaweicloud.com>
Message-ID: <srnpr4p2-qns9-rorp-7886-175105485062@syhkavp.arg>
References: <20231127062116.2355129-1-yukuai1@huaweicloud.com> <20231127062116.2355129-10-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: AF4021C4-8D39-11EE-A368-25B3960A682E-78420484!pb-smtp2.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023, Yu Kuai wrote:

> From: Yu Kuai <yukuai3@huawei.com>
> 
> Which is more efficiency, and also prepare to remove the field
> 'bd_inode' from block_device.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Nicolas Pitre <nico@fluxnic.net>

> ---
>  fs/cramfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
> index 60dbfa0f8805..e9ed1e24c9e4 100644
> --- a/fs/cramfs/inode.c
> +++ b/fs/cramfs/inode.c
> @@ -183,7 +183,7 @@ static int next_buffer;
>  static void *cramfs_blkdev_read(struct super_block *sb, unsigned int offset,
>  				unsigned int len)
>  {
> -	struct address_space *mapping = sb->s_bdev->bd_inode->i_mapping;
> +	struct address_space *mapping = bdev_inode(sb->s_bdev)->i_mapping;
>  	struct file_ra_state ra = {};
>  	struct page *pages[BLKS_PER_BUF];
>  	unsigned i, blocknr, buffer;
> -- 
> 2.39.2
> 
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
> 
