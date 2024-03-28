Return-Path: <linux-kernel+bounces-123420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DABC2890869
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C4D292562
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68546137740;
	Thu, 28 Mar 2024 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i9fZwUTH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2222D1CF9A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 18:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711650996; cv=none; b=RUhXy1tDoiFH0/0ajHdkSSH594TisO9iTH1dBStXzdo8pAABDl1/CX9NMPgvFqWfn/hvKXNEVJgykerfx5HRjDPwHRPDmZpj5w7F6+dTyGM0aCel4/uqr9QTZBvwJX6nx/uLs1jL7HqOQ4H/PYATdDmrtN+sl0bpa5o7flYAP/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711650996; c=relaxed/simple;
	bh=Sp5jvlLKNP32D8rGHjbzJDshNB/ON9laKdFiq1xs/3c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GuQ5LTD4F5f+ZJRNzWUlPt7GC8gxriypRCzpalq/EKwF208DHPzAGmDLiKno+nmTpTjwPY7rPF+PijS03MhHfR5h4HOjTrjFEu9lsHToZHDhTQupvHmC6OL6ORvQOT8wPD/cD2cC4HmRFzLho58VmGjymiVyFKTmxAo+QvdnvUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i9fZwUTH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711650993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JEF8L6USQ1hLDps3RdI620BNw20PF30fu98tAKwws1U=;
	b=i9fZwUTHM3wam8d90AtaMXnVYLNwZPxyMKenkg7JLRYR/jjUvSmYi7Y6gzWWRv0IZCGhg+
	CP3L78hsrJPvNP+aFArO+mXOWHUp42oxa9S1lkzOURvihH25pF4gKzvL12dQMqIbAr7acm
	Dk3deK/Yx0kU7W1VgXJS5cxbNrtuf+c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-02DqlTmTObS6YAizG9d5GQ-1; Thu, 28 Mar 2024 14:36:29 -0400
X-MC-Unique: 02DqlTmTObS6YAizG9d5GQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0899785A58C;
	Thu, 28 Mar 2024 18:36:29 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id ED25C1121312;
	Thu, 28 Mar 2024 18:36:28 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id D729B30BFEC2; Thu, 28 Mar 2024 18:36:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id D355E3FB53;
	Thu, 28 Mar 2024 19:36:28 +0100 (CET)
Date: Thu, 28 Mar 2024 19:36:28 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Arnd Bergmann <arnd@kernel.org>
cc: linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>, 
    Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev, 
    Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
    Nick Desaulniers <ndesaulniers@google.com>, 
    Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
    Eric Biggers <ebiggers@google.com>, llvm@lists.linux.dev
Subject: Re: [PATCH 1/9] dm integrity: fix out-of-range warning
In-Reply-To: <20240328143051.1069575-2-arnd@kernel.org>
Message-ID: <3573cc6-9a74-4eab-92aa-e66afe18cbf@redhat.com>
References: <20240328143051.1069575-1-arnd@kernel.org> <20240328143051.1069575-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3



On Thu, 28 Mar 2024, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> Depending on the value of CONFIG_HZ, clang compares about a pointless
> comparison:
> 
> drivers/md/dm-integrity.c:4085:12: error: result of comparison of constant 42949672950 with expression of type 'unsigned int' is always false [-Werror,-Wtautological-constant-out-of-range-compare]
>                         if (val >= (uint64_t)UINT_MAX * 1000 / HZ) {
> 
> As the check remains useful for other configurations, shut up the
> warning by adding a second type cast to uint64_t.
> 
> Fixes: 468dfca38b1a ("dm integrity: add a bitmap mode")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Mikulas Patocka <mpatocka@redhat.com>

> ---
>  drivers/md/dm-integrity.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
> index 37b9f8f1ae1a..7f3dc8ee6ab8 100644
> --- a/drivers/md/dm-integrity.c
> +++ b/drivers/md/dm-integrity.c
> @@ -4221,7 +4221,7 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned int argc, char **argv
>  		} else if (sscanf(opt_string, "sectors_per_bit:%llu%c", &llval, &dummy) == 1) {
>  			log2_sectors_per_bitmap_bit = !llval ? 0 : __ilog2_u64(llval);
>  		} else if (sscanf(opt_string, "bitmap_flush_interval:%u%c", &val, &dummy) == 1) {
> -			if (val >= (uint64_t)UINT_MAX * 1000 / HZ) {
> +			if ((uint64_t)val >= (uint64_t)UINT_MAX * 1000 / HZ) {
>  				r = -EINVAL;
>  				ti->error = "Invalid bitmap_flush_interval argument";
>  				goto bad;
> -- 
> 2.39.2
> 


