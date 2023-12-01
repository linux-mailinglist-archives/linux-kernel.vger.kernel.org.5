Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6DD801125
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378714AbjLARJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378728AbjLARJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:09:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC361F3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:09:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0D3C433C7;
        Fri,  1 Dec 2023 17:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701450567;
        bh=QPXBVj4TJXcwgh5JQIm8/8CeXHqLYOmq91L3eBH7lKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MgiYJarF6GT2hfQJOsq2zcMv/cDXYXR7VqdCVW/LOYEVHSRy1ciy3Q1ZaPXa2K6ty
         NQ88FLXRt2/G5sh5suPfanyPaSBmFgNd3UOxa3EL4PyLgbfC2DXqfiXQvY3RnCaUH8
         5YkVE8LxfXd69BorkbZ8JckNHPU3PpfhE44ch4Jfo1Kdkd9GscM3Qa3qynTzJ9JlBa
         +2WHfFLIjbEvTfaEjMa+e3OkE4stvlEP2N0COFBtdNJX0bCtKHu+tN6q+XnTWxNimC
         xVxPnqeexVmDX0KgtyLh7sdw3J1K1x05dpn3lSzl2QUvIeIfEIY1bpYJn0669n87F0
         d9EIGgu4buptQ==
Date:   Fri, 1 Dec 2023 11:09:26 -0600
From:   "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        James Morris <jmorris@namei.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, audit@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 05/16] capability: provide helpers for converting between
 xattrs and vfs_caps
Message-ID: <ZWoTRsbZLSRkXbrd@do-x1extreme>
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
 <20231129-idmap-fscap-refactor-v1-5-da5a26058a5b@kernel.org>
 <20231201-gefahndet-biogas-ee3669edc96c@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201-gefahndet-biogas-ee3669edc96c@brauner>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 05:41:19PM +0100, Christian Brauner wrote:
> >  /**
> > - * get_vfs_caps_from_disk - retrieve vfs caps from disk
> > + * vfs_caps_from_xattr - convert raw caps xattr data to vfs_caps
> >   *
> > - * @idmap:	idmap of the mount the inode was found from
> > - * @dentry:	dentry from which @inode is retrieved
> > - * @cpu_caps:	vfs capabilities
> > + * @idmap:      idmap of the mount the inode was found from
> > + * @src_userns: user namespace for ids in xattr data
> > + * @vfs_caps:   destination buffer for vfs_caps data
> > + * @data:       rax xattr caps data
> > + * @size:       size of xattr data
> >   *
> > - * Extract the on-exec-apply capability sets for an executable file.
> > + * Converts a raw security.capability xattr into the kernel-internal
> > + * capabilities format.
> >   *
> > - * If the inode has been found through an idmapped mount the idmap of
> > - * the vfsmount must be passed through @idmap. This function will then
> > - * take care to map the inode according to @idmap before checking
> > - * permissions. On non-idmapped mounts or if permission checking is to be
> > - * performed on the raw inode simply pass @nop_mnt_idmap.
> > + * If the xattr is being read or written through an idmapped mount the
> > + * idmap of the vfsmount must be passed through @idmap. This function
> > + * will then take care to map the rootid according to @idmap.
> > + *
> > + * Return: On success, return 0; on error, return < 0.
> >   */
> > -int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
> > -			   const struct dentry *dentry,
> > -			   struct vfs_caps *cpu_caps)
> > +int vfs_caps_from_xattr(struct mnt_idmap *idmap,
> > +			struct user_namespace *src_userns,
> > +			struct vfs_caps *vfs_caps,
> > +			const void *data, int size)
> >  {
> > -	struct inode *inode = d_backing_inode(dentry);
> >  	__u32 magic_etc;
> > -	int size;
> > -	struct vfs_ns_cap_data data, *nscaps = &data;
> > -	struct vfs_cap_data *caps = (struct vfs_cap_data *) &data;
> > +	const struct vfs_ns_cap_data *ns_caps = data;
> 
> The casting here is predicated on the compatibility of these two structs
> and I'm kinda surprised to see no static assertions about their layout.
> So I would recommend to add some to the header:
> 
> diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
> index 5bb906098697..0fd75aab9754 100644
> --- a/include/uapi/linux/capability.h
> +++ b/include/uapi/linux/capability.h
> @@ -16,6 +16,10 @@
> 
>  #include <linux/types.h>
> 
> +#ifdef __KERNEL__
> +#include <linux/build_bug.h>
> +#endif
> +
>  /* User-level do most of the mapping between kernel and user
>     capabilities based on the version tag given by the kernel. The
>     kernel might be somewhat backwards compatible, but don't bet on
> @@ -100,6 +104,15 @@ struct vfs_ns_cap_data {
>  #define _LINUX_CAPABILITY_VERSION  _LINUX_CAPABILITY_VERSION_1
>  #define _LINUX_CAPABILITY_U32S     _LINUX_CAPABILITY_U32S_1
> 
> +#else
> +
> +static_assert(offsetof(struct vfs_cap_data, magic_etc) ==
> +             offsetof(struct vfs_ns_cap_data, magic_etc));
> +static_assert(offsetof(struct vfs_cap_data, data) ==
> +             offsetof(struct vfs_ns_cap_data, data));
> +static_assert(sizeof(struct vfs_cap_data) ==
> +             offsetof(struct vfs_ns_cap_data, rootid));
> +
>  #endif

It's a little orthogonal to the changes, but I can certainly add a patch
for this.

> > +/**
> > + * vfs_caps_to_xattr - convert vfs_caps to raw caps xattr data
> > + *
> > + * @idmap:       idmap of the mount the inode was found from
> > + * @dest_userns: user namespace for ids in xattr data
> > + * @vfs_caps:    source vfs_caps data
> > + * @data:        destination buffer for rax xattr caps data
> > + * @size:        size of the @data buffer
> > + *
> > + * Converts a kernel-interrnal capability into the raw security.capability
> 
> s/interrnal/internal/
> 
> > + * xattr format.
> > + *
> > + * If the xattr is being read or written through an idmapped mount the
> > + * idmap of the vfsmount must be passed through @idmap. This function
> > + * will then take care to map the rootid according to @idmap.
> > + *
> > + * Return: On success, return 0; on error, return < 0.
> > + */
> > +int vfs_caps_to_xattr(struct mnt_idmap *idmap,
> > +		      struct user_namespace *dest_userns,
> > +		      const struct vfs_caps *vfs_caps,
> > +		      void *data, int size)
> > +{
> > +	struct vfs_ns_cap_data *caps = data;
> > +	int ret;
> > +
> > +	ret = __vfs_caps_to_xattr(idmap, dest_userns, vfs_caps, data, size);
> > +	if (ret > 0 &&
> > +	    (vfs_caps->magic_etc & VFS_CAP_REVISION_MASK) == VFS_CAP_REVISION_3 &&
> > +	     le32_to_cpu(caps->rootid) == (uid_t)-1)
> > +		return -EOVERFLOW;
> 
> I think the return value situation of these two helper is a bit
> confusing. So if they return the size or a negative error pointer the
> return value of both functions should likely be ssize_t.
> 
> But unless you actually later use the size in the callers of these
> helpers it would be easier to just stick with 0 on success, negative
> errno on failure. Note that that's what vfs_caps_from_xattr() is doing.
> 
> I'll see whether that becomes relevant later in the series though.

Size is relevant since the different versions have different xattr
sizes, and callers need to know how much data to write to disk or copy
to userspace. ssize_t probably is better though, so I'll change it.

