Return-Path: <linux-kernel+bounces-52024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA13C8492F7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 05:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2547B1C211B9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 04:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD430B642;
	Mon,  5 Feb 2024 04:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="B6huAXMf"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A534DAD22
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 04:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707107977; cv=none; b=CsF2JIgdE5/gZg+H3yH1zFSQe1fyF5qImnnW6boDwdUTZXgK8ijusK3aAMKFIOpcUoVPh9NylyRgJZhb9EXkLRbeT6tu3+JMeTBbCCJBjVO2RBSklMnZYfq92AZasMzMzbf6tL7QAK5r9E/O/226vK1YuLwCGU6SoubDuVn6hm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707107977; c=relaxed/simple;
	bh=EzIN7nse2+iXsoiqY4oUsxNHg0EhknccQ9F6GIrDsv0=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=eh9E9pE6WKa5H5xqarW79rUU0ziDqIJYkWyHWyxSuzmb5k3ZyO5dLUB9rYoVIMtHpNqJhrKQHTsKXr6FtfYRwa60qvlMAa2fzS4UD2WDf9///zHE5NJgGC2qSL8GMS43se6E6RHmGxnYVjssvG5SkDfTgm/v+4vfJpgCD7DMN2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=B6huAXMf; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Content-Type:From:Mime-Version:Subject:Date:
	Message-Id; bh=2LFTVn7WS/MIzy0KcPbm4wL9w8tNkmOOp85qZt/+6+Y=; b=B
	6huAXMfAUSL0i8SUCNvsiF55dWx/TGNSCcOgnfYlUGVMImVeSO8eeamlXU2aatbv
	Hotas5yzDXrGWQK4I9NYaX3cxlfr+qKdIFQ4Fui1h3ihMzX+8uUDwDfWei56fBGc
	8RMHZtJOqAKLQwj5F3I5steBj8Qfk3hcIsnLDF79uA=
Received: from smtpclient.apple (unknown [175.2.42.150])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wD3X8bOYsBlQ2pUAw--.1130S2;
	Mon, 05 Feb 2024 12:23:43 +0800 (CST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Hao Ge <gehao618@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] fs/inode: Make too_many_isolated return bool
Date: Mon, 5 Feb 2024 12:23:32 +0800
Message-Id: <02CFAD55-0733-4765-9160-153409AE050F@163.com>
References: <20240205022825.99061-1-gehao@kylinos.cn>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240205022825.99061-1-gehao@kylinos.cn>
To: Hao Ge <gehao@kylinos.cn>
X-Mailer: iPhone Mail (21D50)
X-CM-TRANSID:_____wD3X8bOYsBlQ2pUAw--.1130S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWruw1kWw48WFWDCF17ZFb_yoWktFXEvF
	W0kFsa9r98GF92kFn8Cw1UXF4rWF4q9r17Xr9YqFWaya4rC34ktrykKr9rCrWUXa15Gay3
	C3ZxuryFkr1IvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_eHq3UUUUU==
X-CM-SenderInfo: 5jhkt0qwryqiywtou0bp/xtbBdRB7FmVOAkGY8QABsI

Sorry, please ignore this patch due to an incorrect title. I will resend the=
 correct one

> On Feb 5, 2024, at 10:28, Hao Ge <gehao@kylinos.cn> wrote:
>=20
> =EF=BB=BFtoo_many_isolated should return bool which with the same name and=

> similar functions in mm/compaction.c already returned bool
>=20
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---
> mm/vmscan.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 4f9c854ce6cc..143e4b8e8821 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1744,17 +1744,17 @@ bool folio_isolate_lru(struct folio *folio)
>  * the LRU list will go small and be scanned faster than necessary, leadin=
g to
>  * unnecessary swapping, thrashing and OOM.
>  */
> -static int too_many_isolated(struct pglist_data *pgdat, int file,
> +static bool too_many_isolated(struct pglist_data *pgdat, int file,
>        struct scan_control *sc)
> {
>    unsigned long inactive, isolated;
>    bool too_many;
>=20
>    if (current_is_kswapd())
> -        return 0;
> +        return false;
>=20
>    if (!writeback_throttling_sane(sc))
> -        return 0;
> +        return false;
>=20
>    if (file) {
>        inactive =3D node_page_state(pgdat, NR_INACTIVE_FILE);
> --
> 2.25.1


