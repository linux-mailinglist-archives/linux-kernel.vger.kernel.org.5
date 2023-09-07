Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC63797A7A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245337AbjIGRku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245388AbjIGRkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:40:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB13A1990;
        Thu,  7 Sep 2023 10:40:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A4F471F891;
        Thu,  7 Sep 2023 08:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694076247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TaIrKih/1UaL5AGAPhF8FC1Y34lUPfyWoj+9lSGj67Q=;
        b=qyu9rlubG2rVfuQbAXQYy5pq+nBSr/N7egV1ktFMCxFBDHVHm0IhdiZXAXo8uvU474q6RG
        nA0EjrOh4vaBdLj94JYPa+nFWp3ma/2dWwqQJO6d4yqjPuS6KXUF2UQ2ynXQDNUydCUX+s
        fbJSMBTCW7aWaUJ7Er/0V/f6fDL0yNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694076247;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TaIrKih/1UaL5AGAPhF8FC1Y34lUPfyWoj+9lSGj67Q=;
        b=1dB1ft8F8pVkbluEfisok+8dwk+dFq1iAYonu4TubD5uHTcMNXx20gvWRq/GtqgrrNYswy
        IBc6i+Ces9PUxSAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2DD0E138FA;
        Thu,  7 Sep 2023 08:44:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZkQWCFeN+WQsIQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 07 Sep 2023 08:44:07 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 3c599eea;
        Thu, 7 Sep 2023 08:44:06 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Milind Changire <mchangir@redhat.com>
Subject: Re: [PATCH] ceph: add support for encrypted snapshot names
In-Reply-To: <7b40af9d-2543-d4f8-afb2-3bc34e53972f@redhat.com> (Xiubo Li's
        message of "Thu, 7 Sep 2023 08:25:42 +0800")
References: <87tts7beo0.fsf@suse.de>
        <20230906134711.4707-1-lhenriques@suse.de>
        <7b40af9d-2543-d4f8-afb2-3bc34e53972f@redhat.com>
Date:   Thu, 07 Sep 2023 09:44:06 +0100
Message-ID: <87wmx2fk4p.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xiubo Li <xiubli@redhat.com> writes:

> On 9/6/23 21:47, Lu=C3=ADs Henriques wrote:
>> Since filenames in encrypted directories are encrypted and shown as
>> a base64-encoded string when the directory is locked, make snapshot
>> names show a similar behaviour.
>>
>> When creating a snapshot, .snap directories for every subdirectory will
>> show the snapshot name in the "long format":
>>
>>    # mkdir .snap/my-snap
>>    # ls my-dir/.snap/
>>    _my-snap_1099511627782
>>
>> Encrypted snapshots will need to be able to handle these by
>> encrypting/decrypting only the snapshot part of the string ('my-snap').
>>
>> Also, since the MDS prevents snapshot names to be bigger than 240
>> characters it is necessary to adapt CEPH_NOHASH_NAME_MAX to accommodate
>> this extra limitation.
>>
>> [ idryomov: drop const on !CONFIG_FS_ENCRYPTION branch too ]
>>
>> Cc: Dan Carpenter <dan.carpenter@linaro.org>
>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>> Reviewed-by: Xiubo Li <xiubli@redhat.com>
>> Reviewed-by: Milind Changire <mchangir@redhat.com>
>> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
>> ---
>> As reported by Dan Carpenter, the initial version of this patch wasn't
>> dealing correctly with the ceph_get_inode() return value: it never retur=
ns
>> NULL.  Simply dropped the code that handled the case where a NULL was
>> being returned.
>>
>> Xiubo, can you please pick this new revision, if you think it's correct?
>
> Hi Luis,
>
> Please generate a new patch to fix this, the fscrypt corresponding commit=
s have
> been merged already.

Yeah, I just realised it was too late for it.  Which is great, I'm glad it
was too late, actually! :-)

Anyway, I'll send out a separate fix for this, so that it can be included
in -rc2.

Cheers,
--=20
Lu=C3=ADs

>
> Thanks
>
> - Xiubo
>
>> And thanks, Dan!
>>
>> Cheers,
>> --
>> Lu=C3=ADs
>>
>>   fs/ceph/crypto.c | 195 +++++++++++++++++++++++++++++++++++++++--------
>>   fs/ceph/crypto.h |  12 +--
>>   fs/ceph/inode.c  |  33 +++++++-
>>   3 files changed, 199 insertions(+), 41 deletions(-)
>>
>> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
>> index 9494bf485f6a..7d0b9b5ccfc6 100644
>> --- a/fs/ceph/crypto.c
>> +++ b/fs/ceph/crypto.c
>> @@ -193,17 +193,99 @@ void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_re=
quest *req,
>>   	swap(req->r_fscrypt_auth, as->fscrypt_auth);
>>   }
>>   -int ceph_encode_encrypted_dname(const struct inode *parent,
>> -				struct qstr *d_name, char *buf)
>> +/*
>> + * User-created snapshots can't start with '_'.  Snapshots that start w=
ith this
>> + * character are special (hint: there aren't real snapshots) and use the
>> + * following format:
>> + *
>> + *   _<SNAPSHOT-NAME>_<INODE-NUMBER>
>> + *
>> + * where:
>> + *  - <SNAPSHOT-NAME> - the real snapshot name that may need to be decr=
ypted,
>> + *  - <INODE-NUMBER> - the inode number (in decimal) for the actual sna=
pshot
>> + *
>> + * This function parses these snapshot names and returns the inode
>> + * <INODE-NUMBER>.  'name_len' will also bet set with the <SNAPSHOT-NAM=
E>
>> + * length.
>> + */
>> +static struct inode *parse_longname(const struct inode *parent,
>> +				    const char *name, int *name_len)
>>   {
>> +	struct inode *dir =3D NULL;
>> +	struct ceph_vino vino =3D { .snap =3D CEPH_NOSNAP };
>> +	char *inode_number;
>> +	char *name_end;
>> +	int orig_len =3D *name_len;
>> +	int ret =3D -EIO;
>> +
>> +	/* Skip initial '_' */
>> +	name++;
>> +	name_end =3D strrchr(name, '_');
>> +	if (!name_end) {
>> +		dout("Failed to parse long snapshot name: %s\n", name);
>> +		return ERR_PTR(-EIO);
>> +	}
>> +	*name_len =3D (name_end - name);
>> +	if (*name_len <=3D 0) {
>> +		pr_err("Failed to parse long snapshot name\n");
>> +		return ERR_PTR(-EIO);
>> +	}
>> +
>> +	/* Get the inode number */
>> +	inode_number =3D kmemdup_nul(name_end + 1,
>> +				   orig_len - *name_len - 2,
>> +				   GFP_KERNEL);
>> +	if (!inode_number)
>> +		return ERR_PTR(-ENOMEM);
>> +	ret =3D kstrtou64(inode_number, 10, &vino.ino);
>> +	if (ret) {
>> +		dout("Failed to parse inode number: %s\n", name);
>> +		dir =3D ERR_PTR(ret);
>> +		goto out;
>> +	}
>> +
>> +	/* And finally the inode */
>> +	dir =3D ceph_find_inode(parent->i_sb, vino);
>> +	if (!dir) {
>> +		/* This can happen if we're not mounting cephfs on the root */
>> +		dir =3D ceph_get_inode(parent->i_sb, vino, NULL);
>> +	}
>> +	if (IS_ERR(dir))
>> +		dout("Can't find inode %s (%s)\n", inode_number, name);
>> +
>> +out:
>> +	kfree(inode_number);
>> +	return dir;
>> +}
>> +
>> +int ceph_encode_encrypted_dname(struct inode *parent, struct qstr *d_na=
me,
>> +				char *buf)
>> +{
>> +	struct inode *dir =3D parent;
>> +	struct qstr iname;
>>   	u32 len;
>> +	int name_len;
>>   	int elen;
>>   	int ret;
>> -	u8 *cryptbuf;
>> +	u8 *cryptbuf =3D NULL;
>> +
>> +	iname.name =3D d_name->name;
>> +	name_len =3D d_name->len;
>> +
>> +	/* Handle the special case of snapshot names that start with '_' */
>> +	if ((ceph_snap(dir) =3D=3D CEPH_SNAPDIR) && (name_len > 0) &&
>> +	    (iname.name[0] =3D=3D '_')) {
>> +		dir =3D parse_longname(parent, iname.name, &name_len);
>> +		if (IS_ERR(dir))
>> +			return PTR_ERR(dir);
>> +		iname.name++; /* skip initial '_' */
>> +	}
>> +	iname.len =3D name_len;
>>   -	if (!fscrypt_has_encryption_key(parent)) {
>> +	if (!fscrypt_has_encryption_key(dir)) {
>>   		memcpy(buf, d_name->name, d_name->len);
>> -		return d_name->len;
>> +		elen =3D d_name->len;
>> +		goto out;
>>   	}
>>     	/*
>> @@ -212,19 +294,23 @@ int ceph_encode_encrypted_dname(const struct inode=
 *parent,
>>   	 *
>>   	 * See: fscrypt_setup_filename
>>   	 */
>> -	if (!fscrypt_fname_encrypted_size(parent, d_name->len, NAME_MAX, &len))
>> -		return -ENAMETOOLONG;
>> +	if (!fscrypt_fname_encrypted_size(dir, iname.len, NAME_MAX, &len)) {
>> +		elen =3D -ENAMETOOLONG;
>> +		goto out;
>> +	}
>>     	/* Allocate a buffer appropriate to hold the result */
>>   	cryptbuf =3D kmalloc(len > CEPH_NOHASH_NAME_MAX ? NAME_MAX : len,
>>   			   GFP_KERNEL);
>> -	if (!cryptbuf)
>> -		return -ENOMEM;
>> +	if (!cryptbuf) {
>> +		elen =3D -ENOMEM;
>> +		goto out;
>> +	}
>>   -	ret =3D fscrypt_fname_encrypt(parent, d_name, cryptbuf, len);
>> +	ret =3D fscrypt_fname_encrypt(dir, &iname, cryptbuf, len);
>>   	if (ret) {
>> -		kfree(cryptbuf);
>> -		return ret;
>> +		elen =3D ret;
>> +		goto out;
>>   	}
>>     	/* hash the end if the name is long enough */
>> @@ -243,13 +329,31 @@ int ceph_encode_encrypted_dname(const struct inode=
 *parent,
>>     	/* base64 encode the encrypted name */
>>   	elen =3D ceph_base64_encode(cryptbuf, len, buf);
>> -	kfree(cryptbuf);
>>   	dout("base64-encoded ciphertext name =3D %.*s\n", elen, buf);
>> +
>> +	/* To understand the 240 limit, see CEPH_NOHASH_NAME_MAX comments */
>> +	WARN_ON(elen > 240);
>> +	if ((elen > 0) && (dir !=3D parent)) {
>> +		char tmp_buf[NAME_MAX];
>> +
>> +		elen =3D snprintf(tmp_buf, sizeof(tmp_buf), "_%.*s_%ld",
>> +				elen, buf, dir->i_ino);
>> +		memcpy(buf, tmp_buf, elen);
>> +	}
>> +
>> +out:
>> +	kfree(cryptbuf);
>> +	if (dir !=3D parent) {
>> +		if ((dir->i_state & I_NEW))
>> +			discard_new_inode(dir);
>> +		else
>> +			iput(dir);
>> +	}
>>   	return elen;
>>   }
>>   -int ceph_encode_encrypted_fname(const struct inode *parent,
>> -				struct dentry *dentry, char *buf)
>> +int ceph_encode_encrypted_fname(struct inode *parent, struct dentry *de=
ntry,
>> +				char *buf)
>>   {
>>   	WARN_ON_ONCE(!fscrypt_has_encryption_key(parent));
>>   @@ -274,29 +378,42 @@ int ceph_encode_encrypted_fname(const struct ino=
de
>> *parent,
>>   int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_s=
tr *tname,
>>   		      struct fscrypt_str *oname, bool *is_nokey)
>>   {
>> -	int ret;
>> +	struct inode *dir =3D fname->dir;
>>   	struct fscrypt_str _tname =3D FSTR_INIT(NULL, 0);
>>   	struct fscrypt_str iname;
>> -
>> -	if (!IS_ENCRYPTED(fname->dir)) {
>> -		oname->name =3D fname->name;
>> -		oname->len =3D fname->name_len;
>> -		return 0;
>> -	}
>> +	char *name =3D fname->name;
>> +	int name_len =3D fname->name_len;
>> +	int ret;
>>     	/* Sanity check that the resulting name will fit in the buffer */
>>   	if (fname->name_len > NAME_MAX || fname->ctext_len > NAME_MAX)
>>   		return -EIO;
>>   -	ret =3D ceph_fscrypt_prepare_readdir(fname->dir);
>> -	if (ret < 0)
>> -		return ret;
>> +	/* Handle the special case of snapshot names that start with '_' */
>> +	if ((ceph_snap(dir) =3D=3D CEPH_SNAPDIR) && (name_len > 0) &&
>> +	    (name[0] =3D=3D '_')) {
>> +		dir =3D parse_longname(dir, name, &name_len);
>> +		if (IS_ERR(dir))
>> +			return PTR_ERR(dir);
>> +		name++; /* skip initial '_' */
>> +	}
>> +
>> +	if (!IS_ENCRYPTED(dir)) {
>> +		oname->name =3D fname->name;
>> +		oname->len =3D fname->name_len;
>> +		ret =3D 0;
>> +		goto out_inode;
>> +	}
>> +
>> +	ret =3D ceph_fscrypt_prepare_readdir(dir);
>> +	if (ret)
>> +		goto out_inode;
>>     	/*
>>   	 * Use the raw dentry name as sent by the MDS instead of
>>   	 * generating a nokey name via fscrypt.
>>   	 */
>> -	if (!fscrypt_has_encryption_key(fname->dir)) {
>> +	if (!fscrypt_has_encryption_key(dir)) {
>>   		if (fname->no_copy)
>>   			oname->name =3D fname->name;
>>   		else
>> @@ -304,7 +421,8 @@ int ceph_fname_to_usr(const struct ceph_fname *fname=
, struct fscrypt_str *tname,
>>   		oname->len =3D fname->name_len;
>>   		if (is_nokey)
>>   			*is_nokey =3D true;
>> -		return 0;
>> +		ret =3D 0;
>> +		goto out_inode;
>>   	}
>>     	if (fname->ctext_len =3D=3D 0) {
>> @@ -313,12 +431,11 @@ int ceph_fname_to_usr(const struct ceph_fname *fna=
me, struct fscrypt_str *tname,
>>   		if (!tname) {
>>   			ret =3D fscrypt_fname_alloc_buffer(NAME_MAX, &_tname);
>>   			if (ret)
>> -				return ret;
>> +				goto out_inode;
>>   			tname =3D &_tname;
>>   		}
>>   -		declen =3D ceph_base64_decode(fname->name, fname->name_len,
>> -					    tname->name);
>> +		declen =3D ceph_base64_decode(name, name_len, tname->name);
>>   		if (declen <=3D 0) {
>>   			ret =3D -EIO;
>>   			goto out;
>> @@ -330,9 +447,25 @@ int ceph_fname_to_usr(const struct ceph_fname *fnam=
e, struct fscrypt_str *tname,
>>   		iname.len =3D fname->ctext_len;
>>   	}
>>   -	ret =3D fscrypt_fname_disk_to_usr(fname->dir, 0, 0, &iname, oname);
>> +	ret =3D fscrypt_fname_disk_to_usr(dir, 0, 0, &iname, oname);
>> +	if (!ret && (dir !=3D fname->dir)) {
>> +		char tmp_buf[CEPH_BASE64_CHARS(NAME_MAX)];
>> +
>> +		name_len =3D snprintf(tmp_buf, sizeof(tmp_buf), "_%.*s_%ld",
>> +				    oname->len, oname->name, dir->i_ino);
>> +		memcpy(oname->name, tmp_buf, name_len);
>> +		oname->len =3D name_len;
>> +	}
>> +
>>   out:
>>   	fscrypt_fname_free_buffer(&_tname);
>> +out_inode:
>> +	if ((dir !=3D fname->dir) && !IS_ERR(dir)) {
>> +		if ((dir->i_state & I_NEW))
>> +			discard_new_inode(dir);
>> +		else
>> +			iput(dir);
>> +	}
>>   	return ret;
>>   }
>>   diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
>> index 6afa6d888fe0..47e0c319fc68 100644
>> --- a/fs/ceph/crypto.h
>> +++ b/fs/ceph/crypto.h
>> @@ -102,10 +102,10 @@ int ceph_fscrypt_prepare_context(struct inode *dir=
, struct inode *inode,
>>   				 struct ceph_acl_sec_ctx *as);
>>   void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req,
>>   				struct ceph_acl_sec_ctx *as);
>> -int ceph_encode_encrypted_dname(const struct inode *parent,
>> -				struct qstr *d_name, char *buf);
>> -int ceph_encode_encrypted_fname(const struct inode *parent,
>> -				struct dentry *dentry, char *buf);
>> +int ceph_encode_encrypted_dname(struct inode *parent, struct qstr *d_na=
me,
>> +				char *buf);
>> +int ceph_encode_encrypted_fname(struct inode *parent, struct dentry *de=
ntry,
>> +				char *buf);
>>     static inline int ceph_fname_alloc_buffer(struct inode *parent,
>>   					  struct fscrypt_str *fname)
>> @@ -194,14 +194,14 @@ static inline void ceph_fscrypt_as_ctx_to_req(stru=
ct ceph_mds_request *req,
>>   {
>>   }
>>   -static inline int ceph_encode_encrypted_dname(const struct inode *par=
ent,
>> +static inline int ceph_encode_encrypted_dname(struct inode *parent,
>>   					      struct qstr *d_name, char *buf)
>>   {
>>   	memcpy(buf, d_name->name, d_name->len);
>>   	return d_name->len;
>>   }
>>   -static inline int ceph_encode_encrypted_fname(const struct inode *par=
ent,
>> +static inline int ceph_encode_encrypted_fname(struct inode *parent,
>>   					      struct dentry *dentry, char *buf)
>>   {
>>   	return -EOPNOTSUPP;
>> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
>> index 054fd66609b7..83c420646f90 100644
>> --- a/fs/ceph/inode.c
>> +++ b/fs/ceph/inode.c
>> @@ -91,9 +91,15 @@ struct inode *ceph_new_inode(struct inode *dir, struc=
t dentry *dentry,
>>   	if (err < 0)
>>   		goto out_err;
>>   -	err =3D ceph_fscrypt_prepare_context(dir, inode, as_ctx);
>> -	if (err)
>> -		goto out_err;
>> +	/*
>> +	 * We'll skip setting fscrypt context for snapshots, leaving that for
>> +	 * the handle_reply().
>> +	 */
>> +	if (ceph_snap(dir) !=3D CEPH_SNAPDIR) {
>> +		err =3D ceph_fscrypt_prepare_context(dir, inode, as_ctx);
>> +		if (err)
>> +			goto out_err;
>> +	}
>>     	return inode;
>>   out_err:
>> @@ -159,6 +165,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
>>   	};
>>   	struct inode *inode =3D ceph_get_inode(parent->i_sb, vino, NULL);
>>   	struct ceph_inode_info *ci =3D ceph_inode(inode);
>> +	int ret =3D -ENOTDIR;
>>     	if (IS_ERR(inode))
>>   		return inode;
>> @@ -184,6 +191,24 @@ struct inode *ceph_get_snapdir(struct inode *parent)
>>   	ci->i_rbytes =3D 0;
>>   	ci->i_btime =3D ceph_inode(parent)->i_btime;
>>   +#ifdef CONFIG_FS_ENCRYPTION
>> +	/* if encrypted, just borrow fscrypt_auth from parent */
>> +	if (IS_ENCRYPTED(parent)) {
>> +		struct ceph_inode_info *pci =3D ceph_inode(parent);
>> +
>> +		ci->fscrypt_auth =3D kmemdup(pci->fscrypt_auth,
>> +					   pci->fscrypt_auth_len,
>> +					   GFP_KERNEL);
>> +		if (ci->fscrypt_auth) {
>> +			inode->i_flags |=3D S_ENCRYPTED;
>> +			ci->fscrypt_auth_len =3D pci->fscrypt_auth_len;
>> +		} else {
>> +			dout("Failed to alloc snapdir fscrypt_auth\n");
>> +			ret =3D -ENOMEM;
>> +			goto err;
>> +		}
>> +	}
>> +#endif
>>   	if (inode->i_state & I_NEW) {
>>   		inode->i_op =3D &ceph_snapdir_iops;
>>   		inode->i_fop =3D &ceph_snapdir_fops;
>> @@ -197,7 +222,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
>>   		discard_new_inode(inode);
>>   	else
>>   		iput(inode);
>> -	return ERR_PTR(-ENOTDIR);
>> +	return ERR_PTR(ret);
>>   }
>>     const struct inode_operations ceph_file_iops =3D {
>>
>
