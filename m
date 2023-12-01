Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74DE801170
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378790AbjLARJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378820AbjLARJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:09:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF8FF3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:09:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30F9C433C9;
        Fri,  1 Dec 2023 17:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701450582;
        bh=uEyHckuH85mFToap34E21cKoNiYKQu7WvLyHdU6m5Mk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jticPDpkXPNXiHfum1CiK44sgJUxDUnC/w4iHEXmx2Xh1ucb6e2kv1iB+0JN1lOR3
         AGgJVmd0mTbNI0ZGlCw8dwv0wOAd7IHSkr4nIgg4fdAezdcg0EgJEPJhoij4nUGOOj
         ey+JiEvigeCyf3MJ2PJ9j60r2zbSAgOJUMfagG+WBB0ZPw/erAcUg89RUU0LMrBupr
         dKm85sjvxIm6eM9BHPpFOebQkA6sS2/RcIal4nfGMhcojMIWP9eMz+ZiJc65xPRN4l
         feH/Iuax6lcUsuMVTlZzXcl1S8qNdS/iNleYZXlhxBCYFnEeTWU6TS9vesMSYvJt8/
         Ph6eLHgPRM/0Q==
Date:   Fri, 1 Dec 2023 18:09:36 +0100
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
Subject: Re: [PATCH 08/16] fs: add vfs_get_fscaps()
Message-ID: <20231201-wodurch-holen-ce9c44d8aaf5@brauner>
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
 <20231129-idmap-fscap-refactor-v1-8-da5a26058a5b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231129-idmap-fscap-refactor-v1-8-da5a26058a5b@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 03:50:26PM -0600, Seth Forshee (DigitalOcean) wrote:
> Provide a type-safe interface for retrieving filesystem capabilities and
> a generic implementation suitable for most filesystems. Also add an
> internal interface, __vfs_get_fscaps(), which skips security checks for
> later use from the capability code.
> 
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---
>  fs/xattr.c         | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h |  4 ++++
>  2 files changed, 70 insertions(+)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 09d927603433..3abaf9bef0a5 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -181,6 +181,72 @@ xattr_supports_user_prefix(struct inode *inode)
>  }
>  EXPORT_SYMBOL(xattr_supports_user_prefix);
>  
> +static int generic_get_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
> +			      struct vfs_caps *caps)
> +{
> +	struct inode *inode = d_inode(dentry);
> +	struct vfs_ns_cap_data *nscaps = NULL;
> +	int ret;
> +
> +	ret = (int)vfs_getxattr_alloc(idmap, dentry, XATTR_NAME_CAPS,

I don't think you need that case here.

> +				      (char **)&nscaps, 0, GFP_NOFS);
> +
> +	if (ret >= 0)
> +		ret = vfs_caps_from_xattr(idmap, i_user_ns(inode), caps, nscaps, ret);
> +
> +	kfree(nscaps);
> +	return ret;
> +}
> +
> +/**
> + * __vfs_get_fscaps - get filesystem capabilities without security checks
> + * @idmap: idmap of the mount the inode was found from
> + * @dentry: the dentry from which to get filesystem capabilities
> + * @caps: storage in which to return the filesystem capabilities
> + *
> + * This function gets the filesystem capabilities for the dentry and returns
> + * them in @caps. It does not perform security checks.
> + *
> + * Return: 0 on success, a negative errno on error.
> + */
> +int __vfs_get_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
> +		     struct vfs_caps *caps)

I would rename that to vfs_get_fscaps_nosec(). We do that for
vfs_getxattr_nosec() as well. It's not pretty but it's better than just
slapping underscores onto it imo.
