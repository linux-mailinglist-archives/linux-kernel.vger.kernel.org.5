Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905278061C5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 23:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346514AbjLEWdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 17:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346259AbjLEWdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 17:33:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D24196;
        Tue,  5 Dec 2023 14:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=PaxZkLLx0jxzIbcOPDTCZy8j45AuGDflCXboembxXDQ=; b=v/olVTT4L++PZOFWqMtE88KMip
        2EqgzAkRcEL4VV0Xh9PDEdLyq19Uc4IeTpFgOdwceLpfv0J7hJhUZf8hQYU4Cu2mHvMH38WXBef0+
        h4F2/MkMhCCiXIX94WdZFIBX/rtwuyiWDtq7GJL7B7JuhaoM2pr8s+O6JGPqmY9OPd+RkTQK/IbSn
        luWLVLten9V9arZv5euLBno80sx9FJVnXohP8nmgl/n2sAWwc1+p6GHSp1Lbr2isSotmUDC9TnPr9
        wxUF1Qx5x/yGum6b9RqP1BowU1SS+fli2TAMT6CJR1qkcKS4LPJijqSt+P4lrgHjwRIiQDfOA3JYB
        GExdSYMw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rAdz1-008WZd-01;
        Tue, 05 Dec 2023 22:33:39 +0000
Date:   Tue, 5 Dec 2023 14:33:38 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Granados <j.granados@samsung.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 13/18] sysctl: move sysctl type to ctl_table_header
Message-ID: <ZW+lQqOSYFfeh8z2@bombadil.infradead.org>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
 <20231204-const-sysctl-v2-13-7a5060b11447@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231204-const-sysctl-v2-13-7a5060b11447@weissschuh.net>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 08:52:26AM +0100, Thomas Weißschuh wrote:
> @@ -231,7 +231,8 @@ static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
>  		return -EROFS;
>  
>  	/* Am I creating a permanently empty directory? */
> -	if (sysctl_is_perm_empty_ctl_header(header)) {
> +	if (header->ctl_table == sysctl_mount_point ||
> +	    sysctl_is_perm_empty_ctl_header(header)) {
>  		if (!RB_EMPTY_ROOT(&dir->root))
>  			return -EINVAL;
>  		sysctl_set_perm_empty_ctl_header(dir_h);

While you're at it.

This just made me cringe, and curious if some other changes
could be done to make this obviously clear during patch review
that this is safe.

  Luis
