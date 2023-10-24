Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659B87D4FBF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbjJXMaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbjJXMaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:30:12 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B68D7D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=mueE/jomDCPZSA4DL8/H01C/6oFaLo6DG99uhgD42AQ=; b=vS05rz0ksq7vNfnDkNeZs7TxYo
        AijQqd+gnh49vK2EqGrRn52YnHy8o2rOBi2o5+L7N3Gssq6znbeio2SJ37R21wHIfPw8i3otFjezJ
        QoY3ffAAc4PjyWAbK4FiufvGYT0vrUV9xj9nn8CP5kZh0Kz4BR5UqOVx7TAmzacI+XxeMOyks5HHL
        3eQPdlhYcWgy/dpoP6ZR4FCZliSSeQpTxjTDGsGAQyJb5JDBUvU7V1Gy9fOYIG4XmXgL4x6EJ3vKN
        SUV18c38aUzFWZ+DnIyMckUqllBr9lX+WEB990zHkVvxmwM/JXz+4rJH9fBvfwU7wOYAjTIzn7tOn
        qlBegmElFTZ9kwWAMmH7tuYapoqJ4UREsjXFPvvZokREbbKK+/bZ4FzUg30gTbW/VZXUpsbcumF7g
        MGnaXNs8Iak6nz3UyN7G1vTXIbmwbOrqmS+xE4lJTHYIBbxtPym8+kZfKops7XLUKzTO3KqM2KXiq
        To32Ts06PHetv0xxIJ+4drPa8cWWlevUZF2DoFoZqbVKLBwvWxJ8SsVLFGzIIGHvz5mUb5M2eoKpk
        iJEqyrPHUuxNHwo6Ih/RCi2NTUi7mP3oxlyFGOKFrOzrKCdxLdcNkvYLmkLL/PKldrJeNs/Jw0TSB
        YukFhFDB89LSnZjAtAdQF/693usoysaOl/Mo2YQvo=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     v9fs@lists.linux.dev, ericvh@kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     lucho@ionkov.net, linux-kernel@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>,
        Su Hui <suhui@nfschina.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH 2/3] 9p: v9fs_listxattr: fix %s null argument warning
Date:   Tue, 24 Oct 2023 14:29:54 +0200
Message-ID: <2430862.CWyeMz6ufJ@silver>
In-Reply-To: <20231023233704.1185154-3-asmadeus@codewreck.org>
References: <20231023233704.1185154-1-asmadeus@codewreck.org>
 <20231023233704.1185154-3-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, October 24, 2023 1:37:03 AM CEST Dominique Martinet wrote:
> W=3D1 warns about null argument to kprintf:
> In file included from fs/9p/xattr.c:12:
> In function =E2=80=98v9fs_xattr_get=E2=80=99,
>     inlined from =E2=80=98v9fs_listxattr=E2=80=99 at fs/9p/xattr.c:142:9:
> include/net/9p/9p.h:55:2: error: =E2=80=98%s=E2=80=99 directive argument =
is null
> [-Werror=3Dformat-overflow=3D]
>    55 |  _p9_debug(level, __func__, fmt, ##__VA_ARGS__)
>       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Use an empty string instead of :
>  - this is ok 9p-wise because p9pdu_vwritef serializes a null string
> and an empty string the same way (one '0' word for length)
>  - since this degrades the print statements, add new single quotes for
> xattr's name delimter (Old: "file =3D (null)", new: "file =3D ''")
>=20
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> Link: https://lore.kernel.org/r/20231008060138.517057-1-suhui@nfschina.com
> Suggested-by: Su Hui <suhui@nfschina.com>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> I've checked this works as expected (getfattr listing all user.* xattrs
> after setting some), so let's fix this warning.
>=20
> As pointed out by Dan this makes the message les clear, so I added
> single quotes to make it clear we're dealing with an empty string; I
> think it's good enough.
> Su, I made you only Suggested-by because of the extra legwork and
> format changes, but happy to give you authorship if it's something you
> care about; I'd just like to get it out during the next merge window
> in a couple of weeks so please say the word.
>=20
> This makes fs/9p build warning-free with W=3D1 on gcc 12
>=20
>  fs/9p/xattr.c   | 4 ++--
>  net/9p/client.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
> index e00cf8109b3f..d29907c378fd 100644
> --- a/fs/9p/xattr.c
> +++ b/fs/9p/xattr.c
> @@ -68,7 +68,7 @@ ssize_t v9fs_xattr_get(struct dentry *dentry, const cha=
r *name,
>  	struct p9_fid *fid;
>  	int ret;
> =20
> -	p9_debug(P9_DEBUG_VFS, "name =3D %s value_len =3D %zu\n",
> +	p9_debug(P9_DEBUG_VFS, "name =3D '%s' value_len =3D %zu\n",
>  		 name, buffer_size);
>  	fid =3D v9fs_fid_lookup(dentry);
>  	if (IS_ERR(fid))
> @@ -139,7 +139,7 @@ int v9fs_fid_xattr_set(struct p9_fid *fid, const char=
 *name,
> =20
>  ssize_t v9fs_listxattr(struct dentry *dentry, char *buffer, size_t buffe=
r_size)
>  {
> -	return v9fs_xattr_get(dentry, NULL, buffer, buffer_size);
> +	return v9fs_xattr_get(dentry, "", buffer, buffer_size);
>  }

As from the previous discussions on this, it might be worth to add a short
comment here that the magical empty string in the subsequent 'Txattrwalk' 9p
request causes 9p server to return a list of xattrs instead of one specific
xattr.

Up to you though:

Acked-by: Christian Schoenebeck <linux_oss@crudebyte.com>

> =20
>  static int v9fs_xattr_handler_get(const struct xattr_handler *handler,
> diff --git a/net/9p/client.c b/net/9p/client.c
> index 86bbc7147fc1..9c2bc15e3cfa 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -1979,7 +1979,7 @@ struct p9_fid *p9_client_xattrwalk(struct p9_fid *f=
ile_fid,
>  		goto error;
>  	}
>  	p9_debug(P9_DEBUG_9P,
> -		 ">>> TXATTRWALK file_fid %d, attr_fid %d name %s\n",
> +		 ">>> TXATTRWALK file_fid %d, attr_fid %d name '%s'\n",
>  		 file_fid->fid, attr_fid->fid, attr_name);
> =20
>  	req =3D p9_client_rpc(clnt, P9_TXATTRWALK, "dds",
>=20


