Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5EE801111
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378628AbjLARC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjLARCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:02:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DDDC1
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:03:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE76C433C8;
        Fri,  1 Dec 2023 17:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701450181;
        bh=sXjXaBvFhx+/CtKXYxToECUN8YYuv4D897MDwp3vLf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jh1ch6A6+kAKLnu3qBATlucOO4fbgwy9c//Zu5vQ8sGKG1C+vvz2n1sOkJsJ0KKIv
         sJQfE20WLnP3sG5ler/x4cqKkn7ZgOsBOs8C/ksyvebxieGtKwsgqwELYZ5x+JrD7o
         724kbJ8agY4F8yupZUTdHvx9hNRCF3qj6nExJLRLpxjDF+tDhBeTId4TNoWs0zdXyc
         LQXv9N0KTsOHllIYclzm2GT/dOkLgAX95zHafoxGcoWhq2Sz76Qez78AUShA1/6cN5
         JjXwG/Iyjpw6JYPb4jC0SyPC9IvLngfkdtZjq9YG3h2O9DZIvJ9KD93UnsCkwj3VPg
         +PmjGYG+PbL9A==
Date:   Fri, 1 Dec 2023 18:02:55 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Cc:     Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        James Morris <jmorris@namei.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, audit@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 07/16] fs: add inode operations to get/set/remove fscaps
Message-ID: <20231201-drohnen-ausverkauf-61e5c94364ca@brauner>
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
 <20231129-idmap-fscap-refactor-v1-7-da5a26058a5b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231129-idmap-fscap-refactor-v1-7-da5a26058a5b@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 03:50:25PM -0600, Seth Forshee (DigitalOcean) wrote:
> Add inode operations for getting, setting and removing filesystem
> capabilities rather than passing around raw xattr data. This provides
> better type safety for ids contained within xattrs.
> 
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---
>  include/linux/fs.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 98b7a7a8c42e..a0a77f67b999 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2002,6 +2002,11 @@ struct inode_operations {
>  				     int);
>  	int (*set_acl)(struct mnt_idmap *, struct dentry *,
>  		       struct posix_acl *, int);
> +	int (*get_fscaps)(struct mnt_idmap *, struct dentry *,
> +			  struct vfs_caps *);
> +	int (*set_fscaps)(struct mnt_idmap *, struct dentry *,
> +			  const struct vfs_caps *, int flags);

If it's really a flags argument, then unsigned int, please,
Reviewed-by: Christian Brauner <brauner@kernel.org>

> +	int (*remove_fscaps)(struct mnt_idmap *, struct dentry *);
>  	int (*fileattr_set)(struct mnt_idmap *idmap,
>  			    struct dentry *dentry, struct fileattr *fa);
>  	int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);

Ofc we managed to add get/set_foo() and bar_get/set().
