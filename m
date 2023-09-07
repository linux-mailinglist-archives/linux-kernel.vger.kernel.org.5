Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344E3796DFC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 02:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbjIGA0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 20:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjIGA0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 20:26:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B940919A2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 17:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694046349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ooLstZtj/SztSdWsgcLCVQSyrelGnn1fmz32G2omYJc=;
        b=Ea63hrooyidruhmCfmltXP+PX0aCyYThtnFiO86o3HOFuyscX+Ms9MqhqMnMS/3N7VUDzZ
        K9vxCekkoSfu8adr6iOg6oHzlBEhWi2WLS01cPW2FI0HDE79ukekNd0/fsBlUWeYHFr11o
        o+NO6aWnWu7XSina6f29/5eiD9rsYA8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-GZvtTqgMMES69iB8GDPCOQ-1; Wed, 06 Sep 2023 20:25:48 -0400
X-MC-Unique: GZvtTqgMMES69iB8GDPCOQ-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-56f75e70190so549781a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 17:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694046348; x=1694651148;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ooLstZtj/SztSdWsgcLCVQSyrelGnn1fmz32G2omYJc=;
        b=deGVJE2RNfRbERzp5uNPMukfOQ57vV3GTf+b2doN2NXW5FMpEqeuoV7Ie1uIrwixVX
         SymXx8R91cW6kWLgSGeoRMEzzFKQwPC6/MDWe8GIUsPhZ3qiZBIQ/coB6jbyYsePbveB
         FXi8u4v3LBVmJs33ovF0NhMLEYrhWoD7kxOUtXMAIraLv65jhxkpcSESa54Q6irmwS1t
         TtGraJqbTmlPxLnkXvpt1cCg+tLIJcoVPC6Y3AsIlHR3mKRtQtSh9d34kNppv6YYRalr
         nSz+xH2WKmW1iQ2kV7LknPHk+IHsZipfHMpL/Y1lqb0WE0uxHjwzQtIm/SYPAIaLCc9V
         2J/Q==
X-Gm-Message-State: AOJu0YxMORZjsu1RBOvOw0wFkKhJ4BbUtHV/iC0RtUnzlnPTQQE+LrA+
        BzrT16i/t1V95mAh4Xyl9SJai8cb6fWY9vDGNtMOR8Ycb6cGQAtbvCbaHbf28zx6+D+69qXhiht
        QgGfV5bB+VmDkJd4nywqIXcZH
X-Received: by 2002:a05:6a20:5495:b0:13b:b4bb:8b18 with SMTP id i21-20020a056a20549500b0013bb4bb8b18mr18788511pzk.1.1694046347618;
        Wed, 06 Sep 2023 17:25:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IES5jJYKC7OV9Zn4Q71c4duup84RF2GGMThuHxZ4vrdu71+TjugMxuDyGDe11lW6eTkCliBwQ==
X-Received: by 2002:a05:6a20:5495:b0:13b:b4bb:8b18 with SMTP id i21-20020a056a20549500b0013bb4bb8b18mr18788494pzk.1.1694046347244;
        Wed, 06 Sep 2023 17:25:47 -0700 (PDT)
Received: from [10.72.112.106] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q15-20020a62e10f000000b00687ce7c6540sm11716383pfh.99.2023.09.06.17.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 17:25:46 -0700 (PDT)
Message-ID: <7b40af9d-2543-d4f8-afb2-3bc34e53972f@redhat.com>
Date:   Thu, 7 Sep 2023 08:25:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ceph: add support for encrypted snapshot names
Content-Language: en-US
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Milind Changire <mchangir@redhat.com>
References: <87tts7beo0.fsf@suse.de>
 <20230906134711.4707-1-lhenriques@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230906134711.4707-1-lhenriques@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/6/23 21:47, Luís Henriques wrote:
> Since filenames in encrypted directories are encrypted and shown as
> a base64-encoded string when the directory is locked, make snapshot
> names show a similar behaviour.
>
> When creating a snapshot, .snap directories for every subdirectory will
> show the snapshot name in the "long format":
>
>    # mkdir .snap/my-snap
>    # ls my-dir/.snap/
>    _my-snap_1099511627782
>
> Encrypted snapshots will need to be able to handle these by
> encrypting/decrypting only the snapshot part of the string ('my-snap').
>
> Also, since the MDS prevents snapshot names to be bigger than 240
> characters it is necessary to adapt CEPH_NOHASH_NAME_MAX to accommodate
> this extra limitation.
>
> [ idryomov: drop const on !CONFIG_FS_ENCRYPTION branch too ]
>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Reviewed-by: Xiubo Li <xiubli@redhat.com>
> Reviewed-by: Milind Changire <mchangir@redhat.com>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
> As reported by Dan Carpenter, the initial version of this patch wasn't
> dealing correctly with the ceph_get_inode() return value: it never returns
> NULL.  Simply dropped the code that handled the case where a NULL was
> being returned.
>
> Xiubo, can you please pick this new revision, if you think it's correct?

Hi Luis,

Please generate a new patch to fix this, the fscrypt corresponding 
commits have been merged already.

Thanks

- Xiubo

> And thanks, Dan!
>
> Cheers,
> --
> Luís
>
>   fs/ceph/crypto.c | 195 +++++++++++++++++++++++++++++++++++++++--------
>   fs/ceph/crypto.h |  12 +--
>   fs/ceph/inode.c  |  33 +++++++-
>   3 files changed, 199 insertions(+), 41 deletions(-)
>
> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> index 9494bf485f6a..7d0b9b5ccfc6 100644
> --- a/fs/ceph/crypto.c
> +++ b/fs/ceph/crypto.c
> @@ -193,17 +193,99 @@ void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req,
>   	swap(req->r_fscrypt_auth, as->fscrypt_auth);
>   }
>   
> -int ceph_encode_encrypted_dname(const struct inode *parent,
> -				struct qstr *d_name, char *buf)
> +/*
> + * User-created snapshots can't start with '_'.  Snapshots that start with this
> + * character are special (hint: there aren't real snapshots) and use the
> + * following format:
> + *
> + *   _<SNAPSHOT-NAME>_<INODE-NUMBER>
> + *
> + * where:
> + *  - <SNAPSHOT-NAME> - the real snapshot name that may need to be decrypted,
> + *  - <INODE-NUMBER> - the inode number (in decimal) for the actual snapshot
> + *
> + * This function parses these snapshot names and returns the inode
> + * <INODE-NUMBER>.  'name_len' will also bet set with the <SNAPSHOT-NAME>
> + * length.
> + */
> +static struct inode *parse_longname(const struct inode *parent,
> +				    const char *name, int *name_len)
>   {
> +	struct inode *dir = NULL;
> +	struct ceph_vino vino = { .snap = CEPH_NOSNAP };
> +	char *inode_number;
> +	char *name_end;
> +	int orig_len = *name_len;
> +	int ret = -EIO;
> +
> +	/* Skip initial '_' */
> +	name++;
> +	name_end = strrchr(name, '_');
> +	if (!name_end) {
> +		dout("Failed to parse long snapshot name: %s\n", name);
> +		return ERR_PTR(-EIO);
> +	}
> +	*name_len = (name_end - name);
> +	if (*name_len <= 0) {
> +		pr_err("Failed to parse long snapshot name\n");
> +		return ERR_PTR(-EIO);
> +	}
> +
> +	/* Get the inode number */
> +	inode_number = kmemdup_nul(name_end + 1,
> +				   orig_len - *name_len - 2,
> +				   GFP_KERNEL);
> +	if (!inode_number)
> +		return ERR_PTR(-ENOMEM);
> +	ret = kstrtou64(inode_number, 10, &vino.ino);
> +	if (ret) {
> +		dout("Failed to parse inode number: %s\n", name);
> +		dir = ERR_PTR(ret);
> +		goto out;
> +	}
> +
> +	/* And finally the inode */
> +	dir = ceph_find_inode(parent->i_sb, vino);
> +	if (!dir) {
> +		/* This can happen if we're not mounting cephfs on the root */
> +		dir = ceph_get_inode(parent->i_sb, vino, NULL);
> +	}
> +	if (IS_ERR(dir))
> +		dout("Can't find inode %s (%s)\n", inode_number, name);
> +
> +out:
> +	kfree(inode_number);
> +	return dir;
> +}
> +
> +int ceph_encode_encrypted_dname(struct inode *parent, struct qstr *d_name,
> +				char *buf)
> +{
> +	struct inode *dir = parent;
> +	struct qstr iname;
>   	u32 len;
> +	int name_len;
>   	int elen;
>   	int ret;
> -	u8 *cryptbuf;
> +	u8 *cryptbuf = NULL;
> +
> +	iname.name = d_name->name;
> +	name_len = d_name->len;
> +
> +	/* Handle the special case of snapshot names that start with '_' */
> +	if ((ceph_snap(dir) == CEPH_SNAPDIR) && (name_len > 0) &&
> +	    (iname.name[0] == '_')) {
> +		dir = parse_longname(parent, iname.name, &name_len);
> +		if (IS_ERR(dir))
> +			return PTR_ERR(dir);
> +		iname.name++; /* skip initial '_' */
> +	}
> +	iname.len = name_len;
>   
> -	if (!fscrypt_has_encryption_key(parent)) {
> +	if (!fscrypt_has_encryption_key(dir)) {
>   		memcpy(buf, d_name->name, d_name->len);
> -		return d_name->len;
> +		elen = d_name->len;
> +		goto out;
>   	}
>   
>   	/*
> @@ -212,19 +294,23 @@ int ceph_encode_encrypted_dname(const struct inode *parent,
>   	 *
>   	 * See: fscrypt_setup_filename
>   	 */
> -	if (!fscrypt_fname_encrypted_size(parent, d_name->len, NAME_MAX, &len))
> -		return -ENAMETOOLONG;
> +	if (!fscrypt_fname_encrypted_size(dir, iname.len, NAME_MAX, &len)) {
> +		elen = -ENAMETOOLONG;
> +		goto out;
> +	}
>   
>   	/* Allocate a buffer appropriate to hold the result */
>   	cryptbuf = kmalloc(len > CEPH_NOHASH_NAME_MAX ? NAME_MAX : len,
>   			   GFP_KERNEL);
> -	if (!cryptbuf)
> -		return -ENOMEM;
> +	if (!cryptbuf) {
> +		elen = -ENOMEM;
> +		goto out;
> +	}
>   
> -	ret = fscrypt_fname_encrypt(parent, d_name, cryptbuf, len);
> +	ret = fscrypt_fname_encrypt(dir, &iname, cryptbuf, len);
>   	if (ret) {
> -		kfree(cryptbuf);
> -		return ret;
> +		elen = ret;
> +		goto out;
>   	}
>   
>   	/* hash the end if the name is long enough */
> @@ -243,13 +329,31 @@ int ceph_encode_encrypted_dname(const struct inode *parent,
>   
>   	/* base64 encode the encrypted name */
>   	elen = ceph_base64_encode(cryptbuf, len, buf);
> -	kfree(cryptbuf);
>   	dout("base64-encoded ciphertext name = %.*s\n", elen, buf);
> +
> +	/* To understand the 240 limit, see CEPH_NOHASH_NAME_MAX comments */
> +	WARN_ON(elen > 240);
> +	if ((elen > 0) && (dir != parent)) {
> +		char tmp_buf[NAME_MAX];
> +
> +		elen = snprintf(tmp_buf, sizeof(tmp_buf), "_%.*s_%ld",
> +				elen, buf, dir->i_ino);
> +		memcpy(buf, tmp_buf, elen);
> +	}
> +
> +out:
> +	kfree(cryptbuf);
> +	if (dir != parent) {
> +		if ((dir->i_state & I_NEW))
> +			discard_new_inode(dir);
> +		else
> +			iput(dir);
> +	}
>   	return elen;
>   }
>   
> -int ceph_encode_encrypted_fname(const struct inode *parent,
> -				struct dentry *dentry, char *buf)
> +int ceph_encode_encrypted_fname(struct inode *parent, struct dentry *dentry,
> +				char *buf)
>   {
>   	WARN_ON_ONCE(!fscrypt_has_encryption_key(parent));
>   
> @@ -274,29 +378,42 @@ int ceph_encode_encrypted_fname(const struct inode *parent,
>   int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
>   		      struct fscrypt_str *oname, bool *is_nokey)
>   {
> -	int ret;
> +	struct inode *dir = fname->dir;
>   	struct fscrypt_str _tname = FSTR_INIT(NULL, 0);
>   	struct fscrypt_str iname;
> -
> -	if (!IS_ENCRYPTED(fname->dir)) {
> -		oname->name = fname->name;
> -		oname->len = fname->name_len;
> -		return 0;
> -	}
> +	char *name = fname->name;
> +	int name_len = fname->name_len;
> +	int ret;
>   
>   	/* Sanity check that the resulting name will fit in the buffer */
>   	if (fname->name_len > NAME_MAX || fname->ctext_len > NAME_MAX)
>   		return -EIO;
>   
> -	ret = ceph_fscrypt_prepare_readdir(fname->dir);
> -	if (ret < 0)
> -		return ret;
> +	/* Handle the special case of snapshot names that start with '_' */
> +	if ((ceph_snap(dir) == CEPH_SNAPDIR) && (name_len > 0) &&
> +	    (name[0] == '_')) {
> +		dir = parse_longname(dir, name, &name_len);
> +		if (IS_ERR(dir))
> +			return PTR_ERR(dir);
> +		name++; /* skip initial '_' */
> +	}
> +
> +	if (!IS_ENCRYPTED(dir)) {
> +		oname->name = fname->name;
> +		oname->len = fname->name_len;
> +		ret = 0;
> +		goto out_inode;
> +	}
> +
> +	ret = ceph_fscrypt_prepare_readdir(dir);
> +	if (ret)
> +		goto out_inode;
>   
>   	/*
>   	 * Use the raw dentry name as sent by the MDS instead of
>   	 * generating a nokey name via fscrypt.
>   	 */
> -	if (!fscrypt_has_encryption_key(fname->dir)) {
> +	if (!fscrypt_has_encryption_key(dir)) {
>   		if (fname->no_copy)
>   			oname->name = fname->name;
>   		else
> @@ -304,7 +421,8 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
>   		oname->len = fname->name_len;
>   		if (is_nokey)
>   			*is_nokey = true;
> -		return 0;
> +		ret = 0;
> +		goto out_inode;
>   	}
>   
>   	if (fname->ctext_len == 0) {
> @@ -313,12 +431,11 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
>   		if (!tname) {
>   			ret = fscrypt_fname_alloc_buffer(NAME_MAX, &_tname);
>   			if (ret)
> -				return ret;
> +				goto out_inode;
>   			tname = &_tname;
>   		}
>   
> -		declen = ceph_base64_decode(fname->name, fname->name_len,
> -					    tname->name);
> +		declen = ceph_base64_decode(name, name_len, tname->name);
>   		if (declen <= 0) {
>   			ret = -EIO;
>   			goto out;
> @@ -330,9 +447,25 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
>   		iname.len = fname->ctext_len;
>   	}
>   
> -	ret = fscrypt_fname_disk_to_usr(fname->dir, 0, 0, &iname, oname);
> +	ret = fscrypt_fname_disk_to_usr(dir, 0, 0, &iname, oname);
> +	if (!ret && (dir != fname->dir)) {
> +		char tmp_buf[CEPH_BASE64_CHARS(NAME_MAX)];
> +
> +		name_len = snprintf(tmp_buf, sizeof(tmp_buf), "_%.*s_%ld",
> +				    oname->len, oname->name, dir->i_ino);
> +		memcpy(oname->name, tmp_buf, name_len);
> +		oname->len = name_len;
> +	}
> +
>   out:
>   	fscrypt_fname_free_buffer(&_tname);
> +out_inode:
> +	if ((dir != fname->dir) && !IS_ERR(dir)) {
> +		if ((dir->i_state & I_NEW))
> +			discard_new_inode(dir);
> +		else
> +			iput(dir);
> +	}
>   	return ret;
>   }
>   
> diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
> index 6afa6d888fe0..47e0c319fc68 100644
> --- a/fs/ceph/crypto.h
> +++ b/fs/ceph/crypto.h
> @@ -102,10 +102,10 @@ int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
>   				 struct ceph_acl_sec_ctx *as);
>   void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req,
>   				struct ceph_acl_sec_ctx *as);
> -int ceph_encode_encrypted_dname(const struct inode *parent,
> -				struct qstr *d_name, char *buf);
> -int ceph_encode_encrypted_fname(const struct inode *parent,
> -				struct dentry *dentry, char *buf);
> +int ceph_encode_encrypted_dname(struct inode *parent, struct qstr *d_name,
> +				char *buf);
> +int ceph_encode_encrypted_fname(struct inode *parent, struct dentry *dentry,
> +				char *buf);
>   
>   static inline int ceph_fname_alloc_buffer(struct inode *parent,
>   					  struct fscrypt_str *fname)
> @@ -194,14 +194,14 @@ static inline void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req,
>   {
>   }
>   
> -static inline int ceph_encode_encrypted_dname(const struct inode *parent,
> +static inline int ceph_encode_encrypted_dname(struct inode *parent,
>   					      struct qstr *d_name, char *buf)
>   {
>   	memcpy(buf, d_name->name, d_name->len);
>   	return d_name->len;
>   }
>   
> -static inline int ceph_encode_encrypted_fname(const struct inode *parent,
> +static inline int ceph_encode_encrypted_fname(struct inode *parent,
>   					      struct dentry *dentry, char *buf)
>   {
>   	return -EOPNOTSUPP;
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 054fd66609b7..83c420646f90 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -91,9 +91,15 @@ struct inode *ceph_new_inode(struct inode *dir, struct dentry *dentry,
>   	if (err < 0)
>   		goto out_err;
>   
> -	err = ceph_fscrypt_prepare_context(dir, inode, as_ctx);
> -	if (err)
> -		goto out_err;
> +	/*
> +	 * We'll skip setting fscrypt context for snapshots, leaving that for
> +	 * the handle_reply().
> +	 */
> +	if (ceph_snap(dir) != CEPH_SNAPDIR) {
> +		err = ceph_fscrypt_prepare_context(dir, inode, as_ctx);
> +		if (err)
> +			goto out_err;
> +	}
>   
>   	return inode;
>   out_err:
> @@ -159,6 +165,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
>   	};
>   	struct inode *inode = ceph_get_inode(parent->i_sb, vino, NULL);
>   	struct ceph_inode_info *ci = ceph_inode(inode);
> +	int ret = -ENOTDIR;
>   
>   	if (IS_ERR(inode))
>   		return inode;
> @@ -184,6 +191,24 @@ struct inode *ceph_get_snapdir(struct inode *parent)
>   	ci->i_rbytes = 0;
>   	ci->i_btime = ceph_inode(parent)->i_btime;
>   
> +#ifdef CONFIG_FS_ENCRYPTION
> +	/* if encrypted, just borrow fscrypt_auth from parent */
> +	if (IS_ENCRYPTED(parent)) {
> +		struct ceph_inode_info *pci = ceph_inode(parent);
> +
> +		ci->fscrypt_auth = kmemdup(pci->fscrypt_auth,
> +					   pci->fscrypt_auth_len,
> +					   GFP_KERNEL);
> +		if (ci->fscrypt_auth) {
> +			inode->i_flags |= S_ENCRYPTED;
> +			ci->fscrypt_auth_len = pci->fscrypt_auth_len;
> +		} else {
> +			dout("Failed to alloc snapdir fscrypt_auth\n");
> +			ret = -ENOMEM;
> +			goto err;
> +		}
> +	}
> +#endif
>   	if (inode->i_state & I_NEW) {
>   		inode->i_op = &ceph_snapdir_iops;
>   		inode->i_fop = &ceph_snapdir_fops;
> @@ -197,7 +222,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
>   		discard_new_inode(inode);
>   	else
>   		iput(inode);
> -	return ERR_PTR(-ENOTDIR);
> +	return ERR_PTR(ret);
>   }
>   
>   const struct inode_operations ceph_file_iops = {
>

