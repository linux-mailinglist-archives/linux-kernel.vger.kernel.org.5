Return-Path: <linux-kernel+bounces-84939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B624486ADF0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F481C23071
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8C57353C;
	Wed, 28 Feb 2024 11:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ihaywTNP"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C2873507
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 11:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709120692; cv=none; b=KlInTTusLgqzTchFE9ViRqZVx7LBfzXBBZhvqcq65Wrv7qMuzIqGb8PJ+T8gpaIkNvvwl68rdSCubsxoknmMKzWPx9heB7NenPbcLzmQfxbEmylc9N+GPxtkXDLADCKp/UFZqOtcNVPm8jT/0EEUYuV0pXc8T3JolM2uO2YnTo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709120692; c=relaxed/simple;
	bh=3AozR5vgcT0JuDCW27IfqykajrZ2bfd3pQdSiw0Cft0=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=HqGGNociqi0ULjEPVTGWss9KAkd27Xn/tRJv7ZqO40UUmnl25w99xTcHuNz/vKX0mjK5ZptHWe6mvfkhLIB6mKSnkNgZ68sPAgvUD11iNEB5SbfdcyoNVnPEZ1HN/uyt9Z1xEJCl9LapkGmzM4OKHKpAbfFww+Tv/BJ5R5gXedI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ihaywTNP; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Content-Type:From:Mime-Version:Subject:Date:
	Message-Id; bh=VjKq+Ukh+01sMWuWGiG/7cL5r/H18SiycHisweLwLc0=; b=i
	haywTNP69rn3XOAbgkkn4MpG3so8jeJ84NicGK7s6SkIOZ5avx0VU7w3ZPxBOoYK
	N1ucBRewjCVM8JpPVIpbuFIW67X73g4pmi8mJII9HUwjPAETy7XtszC76IwFii1l
	QVycJoxyyquPaUWh9votg5n83CX/c+MW0xVp6gBBV4=
Received: from smtpclient.apple (unknown [223.148.13.239])
	by gzga-smtp-mta-g2-0 (Coremail) with SMTP id _____wBH4FmAHN9lO6xBBA--.7297S2;
	Wed, 28 Feb 2024 19:44:01 +0800 (CST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Hao Ge <gehao618@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/vmstat: Add order's information for extfrag_index and unusable_index
Date: Wed, 28 Feb 2024 19:43:49 +0800
Message-Id: <8805D07B-9F33-42DE-985B-83E0E5C056AC@163.com>
References: <20240228113332.358801-1-gehao@kylinos.cn>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240228113332.358801-1-gehao@kylinos.cn>
To: Hao Ge <gehao@kylinos.cn>
X-Mailer: iPhone Mail (21D61)
X-CM-TRANSID:_____wBH4FmAHN9lO6xBBA--.7297S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF18WFyDCr1UXw17ZryUtrb_yoW5ur13p3
	yYyF48tws5JFy7C3yxJF48Zw1aq3Z3JFykXF98XayrCw15Ar40yr17K34jvF4DK3ykG3y3
	tF4Ivr1DK3Wvq3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRbzVbUUUUU=
X-CM-SenderInfo: 5jhkt0qwryqiywtou0bp/xtbBdQOSFmVOA2v+EAABse

Please ignore this patch because I forgot to use checkpatch.pl to check for f=
ormatting issues. I will fix it and resend a new one,Sorry to bother you.

> On Feb 28, 2024, at 19:33, Hao Ge <gehao@kylinos.cn> wrote:
>=20
> =EF=BB=BFCurrent cat /sys/kernel/debug/extfrag/extfrag_index and
> /sys/kernel/debug/extfrag/unusable_index is not friendly to userspace.
>=20
> We should add order's information so that users can clearly understand
> the situation of each order at a glance like pagetypeinfo.
>=20
> befor:
> cat /sys/kernel/debug/extfrag/extfrag_index:
> Node 0, zone    DMA32 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 ...
> Node 0, zone   Normal -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 ...
>=20
> cat /sys/kernel/debug/extfrag/unusable_index:
> Node 0, zone    DMA32 0.000 0.000 0.000 0.000 0.001 0.003 0.007 ...
> Node 0, zone   Normal 0.000 0.053 0.106 0.159 0.205 0.244 0.265 ...
>=20
> after:
> cat /sys/kernel/debug/extfrag/extfrag_index:
> Extfrag index at order:      0      1      2      3      4      5 ...
> Node 0, zone        DMA -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 ...
> Node 0, zone     Normal -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 ...
>=20
> cat /sys/kernel/debug/extfrag/unusable_index:
> Unusable index at order:     0     1     2     3     4     5 ...
> Node 0, zone         DMA 0.000 0.030 0.059 0.085 0.096 0.102 ...
> Node 0, zone      Normal 0.000 0.225 0.427 0.569 0.776 0.827 ...
>=20
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---
> mm/vmstat.c | 18 ++++++++++++++++--
> 1 file changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index db79935e4a54..f604d91e904c 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -2178,7 +2178,7 @@ static void unusable_show_print(struct seq_file *m,
>    int index;
>    struct contig_page_info info;
>=20
> -    seq_printf(m, "Node %d, zone %8s ",
> +    seq_printf(m, "Node %d, zone %11s ",
>                pgdat->node_id,
>                zone->name);
>    for (order =3D 0; order < NR_PAGE_ORDERS; ++order) {
> @@ -2201,12 +2201,19 @@ static void unusable_show_print(struct seq_file *m=
,
>  */
> static int unusable_show(struct seq_file *m, void *arg)
> {
> +    int order;
>    pg_data_t *pgdat =3D (pg_data_t *)arg;
>=20
>    /* check memoryless node */
>    if (!node_state(pgdat->node_id, N_MEMORY))
>        return 0;
>=20
> +    /* Print header */
> +        seq_printf(m, "%s ", "Unusable index at order:");
> +        for (order =3D 0; order < NR_PAGE_ORDERS; ++order)
> +                seq_printf(m, "%5d ", order);
> +        seq_putc(m, '\n');
> +
>    walk_zones_in_node(m, pgdat, true, false, unusable_show_print);
>=20
>    return 0;
> @@ -2230,7 +2237,7 @@ static void extfrag_show_print(struct seq_file *m,
>    /* Alloc on stack as interrupts are disabled for zone walk */
>    struct contig_page_info info;
>=20
> -    seq_printf(m, "Node %d, zone %8s ",
> +    seq_printf(m, "Node %d, zone %10s ",
>                pgdat->node_id,
>                zone->name);
>    for (order =3D 0; order < NR_PAGE_ORDERS; ++order) {
> @@ -2247,8 +2254,15 @@ static void extfrag_show_print(struct seq_file *m,
>  */
> static int extfrag_show(struct seq_file *m, void *arg)
> {
> +    int order;
>    pg_data_t *pgdat =3D (pg_data_t *)arg;
>=20
> +    /* Print header */
> +    seq_printf(m, "%s ", "Extfrag index at order:");
> +    for (order =3D 0; order < NR_PAGE_ORDERS; ++order)
> +        seq_printf(m, "%6d ", order);
> +    seq_putc(m, '\n');
> +
>    walk_zones_in_node(m, pgdat, true, false, extfrag_show_print);
>=20
>    return 0;
> --=20
> 2.25.1


