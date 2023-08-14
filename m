Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60D777BEB5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 19:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjHNRNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 13:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjHNRNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:13:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE0DE73;
        Mon, 14 Aug 2023 10:13:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9ED33625DB;
        Mon, 14 Aug 2023 17:13:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F495C433C8;
        Mon, 14 Aug 2023 17:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692033200;
        bh=6sB0MXEZJTc5MyRjUr5ZjTDTIyVe78Iq4SedpR4xA6c=;
        h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
        b=iHXE+B79VQw2Xu+svDx/uv1d0+6A1cL00Fi9RE726fiaEboN83Aw7MqXC2ysghAWk
         oRa6XKlaO+gITatZWz2ntX83ohQBteACnJ+ELPHxsiBLjuVltdnKIkooJZcf6mrn+P
         WuH354SsNnfg9xd9du8JSKV3Wnsdxv4lTB8LjdWfRjNhaV/T8mfovSA78MVxfbZqe7
         Wcm1d71t0hXuyBqtEAo1mB4eOTW6/ju8MFVRw7J32va0aW1hin/ZctA+qJSAvTP05y
         BrZnKgeN7IKpNPT9nZ2N9GahgUFIAGX8BerHZjMogu2+R0TLY/GPwzEGEjJ9Yi+a/0
         Fgpl9ez1OvULA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 14 Aug 2023 20:13:14 +0300
Message-Id: <CUSFPINBGDSS.DQ0I19Z9FNR4@suppilovahvero>
To:     "Roberto Sassu" <roberto.sassu@huaweicloud.com>, <corbet@lwn.net>,
        <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <bpf@vger.kernel.org>,
        <pbrobinson@gmail.com>, <zbyszek@in.waw.pl>, <hch@lst.de>,
        <mjg59@srcf.ucam.org>, <pmatilai@redhat.com>, <jannh@google.com>,
        "Roberto Sassu" <roberto.sassu@huawei.com>
Subject: Re: [RFC][PATCH v2 03/13] integrity/digest_cache: Add functions to
 populate and search
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.14.0
References: <20230812104616.2190095-1-roberto.sassu@huaweicloud.com>
 <20230812104616.2190095-4-roberto.sassu@huaweicloud.com>
In-Reply-To: <20230812104616.2190095-4-roberto.sassu@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Aug 12, 2023 at 1:46 PM EEST, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Add digest_cache_init_htable(), to size a hash table depending on the
> number of digests to be added to the cache.
>
> Add digest_cache_add() and digest_cache_lookup() to respectively add and
> lookup a digest in the digest cache.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/integrity/digest_cache.c | 131 ++++++++++++++++++++++++++++++
>  security/integrity/digest_cache.h |  24 ++++++
>  2 files changed, 155 insertions(+)
>
> diff --git a/security/integrity/digest_cache.c b/security/integrity/diges=
t_cache.c
> index 4201c68171a..d14d84b804b 100644
> --- a/security/integrity/digest_cache.c
> +++ b/security/integrity/digest_cache.c
> @@ -315,3 +315,134 @@ struct digest_cache *digest_cache_get(struct dentry=
 *dentry,
> =20
>  	return iint->dig_user;
>  }
> +
> +/**
> + * digest_cache_init_htable - Allocate and initialize the hash table
> + * @digest_cache: Digest cache
> + * @num_digests: Number of digests to add to the digest cache
> + *
> + * This function allocates and initializes the hash table. Its size is
> + * determined by the number of digests to add to the digest cache, known
> + * at this point by the parser calling this function.
> + *
> + * Return: Zero on success, a negative value otherwise.
> + */
> +int digest_cache_init_htable(struct digest_cache *digest_cache,
> +			     u64 num_digests)
> +{
> +	int i;
> +
> +	if (!digest_cache)
> +		return 0;
> +
> +	digest_cache->num_slots =3D num_digests / DIGEST_CACHE_HTABLE_DEPTH;
> +	if (!digest_cache->num_slots)
> +		digest_cache->num_slots =3D 1;
> +
> +	digest_cache->slots =3D kmalloc_array(num_digests,
> +					    sizeof(*digest_cache->slots),
> +					    GFP_KERNEL);
> +	if (!digest_cache->slots)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < digest_cache->num_slots; i++)
> +		INIT_HLIST_HEAD(&digest_cache->slots[i]);
> +
> +	pr_debug("Initialized %d hash table slots for digest list %s\n",
> +		 digest_cache->num_slots, digest_cache->path_str);
> +	return 0;
> +}
> +
> +/**
> + * digest_cache_add - Add a new digest to the digest cache
> + * @digest_cache: Digest cache
> + * @digest: Digest to add
> + *
> + * This function, invoked by a digest list parser, adds a digest extract=
ed
> + * from a digest list to the digest cache.
> + *
> + * Return: Zero on success, a negative value on error.

Nit: previous had a different phrasing "a negative value otherwise".

I would suggest "a POSIX error code otherwise" for both.

> + */
> +int digest_cache_add(struct digest_cache *digest_cache, u8 *digest)
> +{
> +	struct digest_cache_entry *entry;
> +	unsigned int key;
> +	int digest_len;
> +
> +	if (!digest_cache)
> +		return 0;
> +
> +	digest_len =3D hash_digest_size[digest_cache->algo];
> +
> +	entry =3D kmalloc(sizeof(*entry) + digest_len, GFP_KERNEL);
> +	if (!entry)
> +		return -ENOMEM;
> +
> +	memcpy(entry->digest, digest, digest_len);
> +
> +	key =3D digest_cache_hash_key(digest, digest_cache->num_slots);
> +	hlist_add_head(&entry->hnext, &digest_cache->slots[key]);
> +	pr_debug("Add digest %s:%*phN from digest list %s\n",
> +		 hash_algo_name[digest_cache->algo], digest_len, digest,
> +		 digest_cache->path_str);
> +	return 0;
> +}
> +
> +/**
> + * digest_cache_lookup - Searches a digest in the digest cache
> + * @digest_cache: Digest cache
> + * @digest: Digest to search
> + * @algo: Algorithm of the digest to search
> + * @pathname: Path of the file whose digest is looked up
> + *
> + * This function, invoked by IMA or EVM, searches the calculated digest =
of
> + * a file or file metadata in the digest cache acquired with
> + * digest_cache_get().
> + *
> + * Return: Zero if the digest is found, a negative value if not.
> + */
> +int digest_cache_lookup(struct digest_cache *digest_cache, u8 *digest,
> +			enum hash_algo algo, const char *pathname)
> +{
> +	struct digest_cache_entry *entry;
> +	unsigned int key;
> +	int digest_len;
> +	int search_depth =3D 0;
> +
> +	if (!digest_cache)
> +		return -ENOENT;
> +
> +	if (digest_cache->algo =3D=3D HASH_ALGO__LAST) {
> +		pr_debug("Algorithm not set for digest list %s\n",
> +			 digest_cache->path_str);
> +		return -ENOENT;
> +	}
> +
> +	digest_len =3D hash_digest_size[digest_cache->algo];
> +
> +	if (algo !=3D digest_cache->algo) {
> +		pr_debug("Algo mismatch for file %s, digest %s:%*phN in digest list %s=
 (%s)\n",
> +			 pathname, hash_algo_name[algo], digest_len, digest,
> +			 digest_cache->path_str,
> +			 hash_algo_name[digest_cache->algo]);
> +		return -ENOENT;
> +	}
> +
> +	key =3D digest_cache_hash_key(digest, digest_cache->num_slots);
> +
> +	hlist_for_each_entry_rcu(entry, &digest_cache->slots[key], hnext) {
> +		if (!memcmp(entry->digest, digest, digest_len)) {
> +			pr_debug("Cache hit at depth %d for file %s, digest %s:%*phN in diges=
t list %s\n",
> +				 search_depth, pathname, hash_algo_name[algo],
> +				 digest_len, digest, digest_cache->path_str);
> +			return 0;
> +		}
> +
> +		search_depth++;
> +	}
> +
> +	pr_debug("Cache miss for file %s, digest %s:%*phN in digest list %s\n",
> +		 pathname, hash_algo_name[algo], digest_len, digest,
> +		 digest_cache->path_str);
> +	return -ENOENT;
> +}
> diff --git a/security/integrity/digest_cache.h b/security/integrity/diges=
t_cache.h
> index ff88e8593c6..01cd70f9850 100644
> --- a/security/integrity/digest_cache.h
> +++ b/security/integrity/digest_cache.h
> @@ -66,6 +66,11 @@ static inline unsigned int digest_cache_hash_key(u8 *d=
igest,
>  void digest_cache_free(struct digest_cache *digest_cache);
>  struct digest_cache *digest_cache_get(struct dentry *dentry,
>  				      struct integrity_iint_cache *iint);
> +int digest_cache_init_htable(struct digest_cache *digest_cache,
> +			     u64 num_digests);
> +int digest_cache_add(struct digest_cache *digest_cache, u8 *digest);
> +int digest_cache_lookup(struct digest_cache *digest_cache, u8 *digest,
> +			enum hash_algo algo, const char *pathname);
>  #else
>  static inline void digest_cache_free(struct digest_cache *digest_cache)
>  {
> @@ -77,5 +82,24 @@ digest_cache_get(struct dentry *dentry, struct integri=
ty_iint_cache *iint)
>  	return NULL;
>  }
> =20
> +static inline int digest_cache_init_htable(struct digest_cache *digest_c=
ache,
> +					   u64 num_digests)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int digest_cache_add(struct digest_cache *digest_cache,
> +				   u8 *digest)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int digest_cache_lookup(struct digest_cache *digest_cache,
> +				      u8 *digest, enum hash_algo algo,
> +				      const char *pathname)
> +{
> +	return -ENOENT;
> +}
> +
>  #endif /* CONFIG_INTEGRITY_DIGEST_CACHE */
>  #endif /* _DIGEST_CACHE_H */
> --=20
> 2.34.1

Why all this complexity instead of using xarray?

https://docs.kernel.org/core-api/xarray.html

BR, Jarkko
