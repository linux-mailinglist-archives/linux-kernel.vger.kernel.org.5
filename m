Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8027AF544
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 22:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbjIZUeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 16:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjIZUeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:34:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF58B120
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 13:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=amsgt90GLpsTEDNCAPObgIGpm3VGv61F2JwJ65wP1l4=; b=hrNhDVmNlk2GdYnWPgCVMrwflD
        5kloi5SYkU8dfkwMjcfrSyz0r0+tnpDoWXvpiESUZUXpDMgCrFxkYjwUSsAen2g/4FTEFQRjLYxOs
        tVYISXmHxCuj7iBiy9wewL0NhQfAY349FdlbZE0zPm/+G6cjTLbb18E8K0HXUauqoykUZvz3Q6LHd
        dCJbjtSMFcte7ZKLIcRydTf1CnHDlnyAb6EdSjsH84lnV0C+KrVOvJWz50/YxdJO2o5mvmQgk4QUe
        1o14H1tep3nKtRh3ktSKhpWZvLASQPGj4rGLz5N9Fuz40x65cIqSs/nard3bxsQdm4MW/o70r9CFU
        nPzdVR7w==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qlEkz-00H0J8-06;
        Tue, 26 Sep 2023 20:34:09 +0000
Message-ID: <c26c87e9-f9ca-4472-a1ca-e4a6674600af@infradead.org>
Date:   Tue, 26 Sep 2023 13:34:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] include/linux/dcache.h: fix warning in doc comment
Content-Language: en-US
To:     Nik Bune <n2h9z4@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        skhan@linuxfoundation.org, Jakub Kicinski <kuba@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20230926163631.116405-1-n2h9z4@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230926163631.116405-1-n2h9z4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[adding VFS folks]

On 9/26/23 09:36, Nik Bune wrote:
> When run make htmldocs there is a warning appears
> ./include/linux/dcache.h:311: warning: expecting prototype for dget, dget_dlock(). Prototype was for dget_dlock() instead
> 
> The comment over the dget_dlock function describes both dget_dlock and dget functions. dget goes right after dget_dlock.
> 
> Removed "dget" from dget_dlock function comment.
> Copied the same block to the dget function below.
> 
> 
> Signed-off-by: Nik Bune <n2h9z4@gmail.com>

I was working on this one also, but yours is good as far as it goes.

I was trying to differentiate between dget() and dget_dlock().
Something simple and short, like:

in get():

	dget() is used for the initial lockref on a dentry.

and in dget_dlock():

	dget_dlock() is used to increment the lockref count
	after the initial lockref is made.

but I don't know how correct those comments are or how they
should be improved.  :(

> ---
>  include/linux/dcache.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 6b351e009f59..47adb8dda4a9 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -300,7 +300,7 @@ extern char *dentry_path(const struct dentry *, char *, int);
>  /* Allocation counts.. */
>  
>  /**
> - *	dget, dget_dlock -	get a reference to a dentry
> + *	dget_dlock -	get a reference to a dentry
>   *	@dentry: dentry to get a reference to
>   *
>   *	Given a dentry or %NULL pointer increment the reference count
> @@ -314,6 +314,14 @@ static inline struct dentry *dget_dlock(struct dentry *dentry)
>  	return dentry;
>  }
>  
> +/**
> + *	dget -	get a reference to a dentry
> + *	@dentry: dentry to get a reference to
> + *
> + *	Given a dentry or %NULL pointer increment the reference count
> + *	if appropriate and return the dentry. A dentry will not be 
> + *	destroyed when it has references.
> + */
>  static inline struct dentry *dget(struct dentry *dentry)
>  {
>  	if (dentry)

-- 
~Randy
