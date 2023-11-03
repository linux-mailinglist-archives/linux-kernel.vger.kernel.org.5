Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D527E0985
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 20:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377111AbjKCThQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 15:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377583AbjKCThO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 15:37:14 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94834D75;
        Fri,  3 Nov 2023 12:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i0KUcHlFUhWeXHp6OMFIQFv23yDUyIxA3jyyhwS5c0c=; b=Mdmg2DuKO+sc8DsT+tqPAJXmq3
        DGYMePLeSY8IqQTg7Y00/p2bfXpiocx/8dk5Lf/+tMhZkxY4kRpor3gooJ+CmlBf8Hy7aGBCdjvCV
        EsQE03OeyFni1UxoV4qf1SPAvb/5WbxovqTIBAJR8n4XazAncqur7TjKn4dd4EUiWEDJCc7CbI9ez
        q9EKvDhvIv19qfdpJ/gq2zMCiFhEETfOna6G0WGMkNABMfsITmXF8wp2ue89Jk2uzSwcGSNHmiiRH
        lCh6vx3C7Qd/SveFeapLfYW+rEXPgAeTI8NgtscyF3vJaQkV9Ijv/SbldkULGOiMM3TkUsyypMbog
        qn8i7tzQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qyzyX-00ATmK-22;
        Fri, 03 Nov 2023 19:37:01 +0000
Date:   Fri, 3 Nov 2023 19:37:01 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Nick Piggin <npiggin@kernel.dk>,
        Waiman Long <Waiman.Long@hp.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] dcache: remove unnecessary NULL check in dget_dlock()
Message-ID: <20231103193701.GP1957730@ZenIV>
References: <20231022164520.915013-1-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231022164520.915013-1-vegard.nossum@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2023 at 06:45:20PM +0200, Vegard Nossum wrote:

> @@ -1707,7 +1701,7 @@ static enum d_walk_ret find_submount(void *_data, struct dentry *dentry)
>  {
>  	struct dentry **victim = _data;
>  	if (d_mountpoint(dentry)) {
> -		__dget_dlock(dentry);
> +		dget_dlock(dentry);
>  		*victim = dentry;

		*victim = dget_dlock(dentry);

>  		return D_WALK_QUIT;
>  	}
> @@ -1853,7 +1847,7 @@ struct dentry *d_alloc(struct dentry * parent, const struct qstr *name)
>  	 * don't need child lock because it is not subject
>  	 * to concurrency here
>  	 */
> -	__dget_dlock(parent);
> +	dget_dlock(parent);
>  	dentry->d_parent = parent;

	dentry->d_parent = dget_dlock(parent);

> - *	Given a dentry or %NULL pointer increment the reference count
> - *	if appropriate and return the dentry. A dentry will not be 
> - *	destroyed when it has references.
> + *	Given a dentry, increment the reference count and return the
> + *	dentry.
> + *
> + *	Context: @dentry->d_lock must be held.

... and dentry must be alive.  There are many ways the caller could
use to guarantee that - any of the "it's hashed", "it's positive",
"its ->d_lockref.count is not negative" would suffice under ->d_lock.
