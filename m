Return-Path: <linux-kernel+bounces-79644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CF886252D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C361F21E77
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DEB405CE;
	Sat, 24 Feb 2024 13:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fIOWso8E"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D5810A3C
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782291; cv=none; b=NxAK053dBKUdZ/0Nk6yBg7kJ4dTUydvSNwqE5bntdXZwPdni2n8b0Obo3SBXF9NfFmhrxyK4UJm8iTEdZQh4xbJVvV6UgTD5wh0EJtmx3+rXXX+w3/AHAkgX11EmemeMbIVHu3RscsNRCdR4eU9LC0C0iOH3N+LBR3ZmqP0QiSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782291; c=relaxed/simple;
	bh=nG+obRKdw0yvvqlnDsaNozeboGfRgpCdGMDN11jV5B0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=phS98vsKsKiRb2h4YBDdjUMcIcbeOiBhFapP6OI9QZ9mv0K75Q7HUT4aLAvMxuCXNAWZSu6JWdcXO3zpHlnJ/gi0PHqBnJFPODo5VYDLsAzmCLwT6RJXGMiKImLzxJFDfRGOuWyQ6tAtX3vPADoAZ+8BXKS0TJdNN4bPfQy+oms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fIOWso8E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708782288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pqRcbBAqvfSKnUOk9c3d+4kL/52c1/J+n8W594i5WY8=;
	b=fIOWso8ENpp8u6jHyqNrYkIBiwh/Phf4lobsndt4QaMszoUWnD0M5nGD0zAN1LkHxwlJAD
	1Nsw7b5vDnY7JO7yYfSAiB+gAbmffN6Le3jBjzK5dqHC2lNPTFAiST/L2av2PQctRkodru
	zhxGl+ewzQhg3G3oKI3PLOeBt5rh+m4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-22GyvL7FPbqby95jzhAIBA-1; Sat, 24 Feb 2024 08:44:47 -0500
X-MC-Unique: 22GyvL7FPbqby95jzhAIBA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A483E85A58A;
	Sat, 24 Feb 2024 13:44:46 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5576E10800;
	Sat, 24 Feb 2024 13:44:46 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 373DF30C1B8F; Sat, 24 Feb 2024 13:44:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 328893FB4E;
	Sat, 24 Feb 2024 14:44:46 +0100 (CET)
Date: Sat, 24 Feb 2024 14:44:46 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Arnd Bergmann <arnd@kernel.org>
cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    dm-devel@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>, 
    Eric Biggers <ebiggers@google.com>, Yu Zhe <yuzhe@nfschina.com>, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dm-integrity: reduce stack usage for recheck
In-Reply-To: <20240224121228.1904859-1-arnd@kernel.org>
Message-ID: <b36796cd-e6f-b964-fe0-5a77114aa710@redhat.com>
References: <20240224121228.1904859-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Hi


On Sat, 24 Feb 2024, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added integrity_recheck() function has another larger stack
> allocation, just like its caller integrity_metadata(). When it gets
> inlined, the combination of the two exceeds the warning limit for 32-bit
> architectures and possibly risks an overflow when this is called from
> a deep call chain through a file system:
> 
> drivers/md/dm-integrity.c:1767:13: error: stack frame size (1048) exceeds limit (1024) in 'integrity_metadata' [-Werror,-Wframe-larger-than]
>  1767 | static void integrity_metadata(struct work_struct *w)
> 
> Since the caller at this point is done using its checksum buffer,
> just reuse the same buffer in the new function to avoid the double
> allocation.

OK, thanks.

But, the function integrity_recheck shouldn't be inlined at all, because 
it is only called on authentication error. So, I'll post your patch with 
"noinline" being added.

Mikulas

> Fixes: c88f5e553fe3 ("dm-integrity: recheck the integrity tag after a failure")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/md/dm-integrity.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
> index 143f6c223b0e..82023f1f3df0 100644
> --- a/drivers/md/dm-integrity.c
> +++ b/drivers/md/dm-integrity.c
> @@ -1691,14 +1691,13 @@ static void integrity_sector_checksum(struct dm_integrity_c *ic, sector_t sector
>  	get_random_bytes(result, ic->tag_size);
>  }
>  
> -static void integrity_recheck(struct dm_integrity_io *dio)
> +static void integrity_recheck(struct dm_integrity_io *dio, char *checksum)
>  {
>  	struct bio *bio = dm_bio_from_per_bio_data(dio, sizeof(struct dm_integrity_io));
>  	struct dm_integrity_c *ic = dio->ic;
>  	struct bvec_iter iter;
>  	struct bio_vec bv;
>  	sector_t sector, logical_sector, area, offset;
> -	char checksum_onstack[max_t(size_t, HASH_MAX_DIGESTSIZE, MAX_TAG_SIZE)];
>  	struct page *page;
>  	void *buffer;
>  
> @@ -1735,8 +1734,8 @@ static void integrity_recheck(struct dm_integrity_io *dio)
>  			}
>  
>  			integrity_sector_checksum(ic, logical_sector, buffer,
> -						  checksum_onstack);
> -			r = dm_integrity_rw_tag(ic, checksum_onstack, &dio->metadata_block,
> +						  checksum);
> +			r = dm_integrity_rw_tag(ic, checksum, &dio->metadata_block,
>  						&dio->metadata_offset, ic->tag_size, TAG_CMP);
>  			if (r) {
>  				if (r > 0) {
> @@ -1851,7 +1850,7 @@ static void integrity_metadata(struct work_struct *w)
>  						checksums_ptr - checksums, dio->op == REQ_OP_READ ? TAG_CMP : TAG_WRITE);
>  			if (unlikely(r)) {
>  				if (r > 0) {
> -					integrity_recheck(dio);
> +					integrity_recheck(dio, checksums);
>  					goto skip_io;
>  				}
>  				if (likely(checksums != checksums_onstack))
> -- 
> 2.39.2
> 


