Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7803E807EBC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 03:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443109AbjLGCkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 21:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443075AbjLGCkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 21:40:21 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DFF10C3;
        Wed,  6 Dec 2023 18:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7Kr8Ezb2xuew2jHJ0pSoPm3iIPJWSiNf9VwLm+WjuhE=; b=MbtfN9I4spoF8CXhWoiDpU2a+h
        2VIGym8MrZwJwkE594adbia1RMiZUGqWB7Vh55Jl7IWjc4ODy8eNU1YJUHCY+5eUgPrtO/rbPgdgD
        zC8bvUGrnISTSmiDHop2Ia+XHL1+lqLA2QUmt46cEq/8E4I18TKnpk1uSPT7dFq+uqYP860xGLnqf
        fGXdhvkc2vH9ZjEjVXB9a85QwvT059eDGw0VNZ8tz3Ht97Ufua+nF5ab6PiERWRrOdTLsfau4x3MZ
        LlLf9bm0HB/6fUQorv0FFLfXiFWRLsbnbvf1Edn9zzYj8dshqN30Mwjkd4n3BWyWm9ZbLAG7003kv
        O2RbsqaA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rB4JM-0083Qf-16;
        Thu, 07 Dec 2023 02:40:24 +0000
Date:   Thu, 7 Dec 2023 02:40:24 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-cachefs@redhat.com, dhowells@redhat.com,
        gfs2@lists.linux.dev, dm-devel@lists.linux.dev,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] vfs: Use dlock list for superblock's inode list
Message-ID: <20231207024024.GU1674809@ZenIV>
References: <20231206060629.2827226-1-david@fromorbit.com>
 <20231206060629.2827226-4-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206060629.2827226-4-david@fromorbit.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 05:05:32PM +1100, Dave Chinner wrote:

> @@ -303,6 +303,7 @@ static void destroy_unused_super(struct super_block *s)
>  	super_unlock_excl(s);
>  	list_lru_destroy(&s->s_dentry_lru);
>  	list_lru_destroy(&s->s_inode_lru);
> +	free_dlock_list_heads(&s->s_inodes);
>  	security_sb_free(s);
>  	put_user_ns(s->s_user_ns);
>  	kfree(s->s_subtype);

Umm...  Who's going to do that on normal umount?

