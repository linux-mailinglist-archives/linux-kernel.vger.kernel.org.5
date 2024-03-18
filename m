Return-Path: <linux-kernel+bounces-106314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB7687EC48
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB43C1C2131E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFC8524BB;
	Mon, 18 Mar 2024 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GuWJBPCO"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2041.outbound.protection.outlook.com [40.92.18.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981C1524A8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710776242; cv=fail; b=m/2UBtOvklXsImIaxBlTh8oWt/nYJ3+yr9AoCZdVYpHIh0Kpzlgs69NG9XqbeXCF8GCdsw7OXvLKrkJuzxV09OHFP08PpZYu2hcuwvpm1qYnsTfDxM7MCxhEN/6YWx5qnfwKlfl4wyEHNbRwHIGcWXLcAseFjKrPYprDyHiWeRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710776242; c=relaxed/simple;
	bh=hBftG82VzPW0ovMNu8cuJEM+C+w2T0hrj7hY4MkxFks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D4xyTeHh+7CITo7SyztjK7V4za8/0VVjqiCcFSVcCZPk4PBI/G2W2hynu7gWS6ISvRPrbgjmq0mdfgoRNFCoZZFxVwFq+TLq0uY+6x+WU1VUTaKMKL5qlt4vqaUUN4KNT4zwiJMM80MCE5gEwvrmwvT4hHiuyM2vkVnoJy5Cv+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GuWJBPCO; arc=fail smtp.client-ip=40.92.18.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kzz9lB7F1JR3/VlIJndhYgK42OjgVMLRAcx5a7c7U/Co1V6lxuLRkqgSubNM9t1vZlkD755+xFx1V4TQ2dW3ARZwPigo5zmNEzUke3RUGi8HPxAIZJjgyWXDBc1RkCML8DxqDtngWiPh/1tnNSG5HE82YfA3zQcwb1+apoL0IRHp4c945T8pjdlE0pYeKP4DvL2R9lBNqbOByWzoBXc1q6TsU+OS44+o3THbtaWuuKd2RgdxZt/OiaWM2rKdiu/fmebYXbI6khxRRdd7VLIQ55/lklQrgEuTVBXF6d4KSZrtYeETnBRovZAOHqfi4zyBjqYCBO9QxxAIyHJEPdpEfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xg05pKe6J7tWlhh0EtNIMF3kt5f0oDTS/dKPagN2K4w=;
 b=EsM0rxCUnju3Vu/x2901v7jOhSLPcKmnQLs7gkKWothHEAHCmeB8vtNMQ4S9SXCsiIh02PLeorHcsVSx1NGXfLeDP5WJVxeXVH6DHpxx3xQJfbAmO62BQbSmWWR9x8GrSOLE/mqYhqaoFfp24yhHUb09nBF0bfkG+CpX3RF8u/7K2EvvyPYmpRJt2hxL187OgHsZMyshhwz4P5gKsd54bQm6rm5Ad7s0spb3IjzBJWrgLwcmKUV89zyONQmL8cMQe8BOf6SG36sfaG/wKWPbjo+rhQgX+9/bMzbBd8Z1ITA9hQSfG/I80mUiuqad+7ESRtAU6RbWomKufuBgc/sB5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xg05pKe6J7tWlhh0EtNIMF3kt5f0oDTS/dKPagN2K4w=;
 b=GuWJBPCOp9ABOYVBuP6eEcdnY7pV0L1EstDSOCO93xxPM0t1zsAZax5yU2llh+6k54qRaXuzPLj2W3DWXd4JAaXCpNnORWSeXHAd0AVHed1R9dwE6P+nbqurwmn4fWPxQ+rTmaTSjZesiRwE5kvCK4Rk7S8YUEOucFbb7V2MxmhwJkRBX2sItV9FXsNMkWQkU0qbWcQ9gtzZWg2sLcvpkiqAs+ODmc5QEQzWHDb4vNnjY/emEyge0Ad3zszfPi6TdYYpMS0HUNZmtZLMRHD8hRHlHiO2GRlSUeDaZnhMq1C8epBYO83RHxcLG1A46BAPA3YE8Cn1AS2iCBu+597vPA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH7PR02MB8906.namprd02.prod.outlook.com (2603:10b6:510:212::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 15:37:16 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 15:37:16 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Petr Tesarik <petrtesarik@huaweicloud.com>, Christoph Hellwig
	<hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Will Deacon <will@kernel.org>, open list <linux-kernel@vger.kernel.org>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
CC: Roberto Sassu <roberto.sassu@huaweicloud.com>, Petr Tesarik
	<petr@tesarici.cz>
Subject: RE: [PATCH v2 1/2] swiotlb: extend buffer pre-padding to
 alloc_align_mask if necessary
Thread-Topic: [PATCH v2 1/2] swiotlb: extend buffer pre-padding to
 alloc_align_mask if necessary
Thread-Index: AQHaeTTv740XxW4sG0CetwBVyXSzY7E9ngKA
Date: Mon, 18 Mar 2024 15:37:16 +0000
Message-ID:
 <SN6PR02MB41571EBB261FA3B5FFCD9BAFD42D2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240318130447.594-1-petrtesarik@huaweicloud.com>
 <20240318130447.594-2-petrtesarik@huaweicloud.com>
In-Reply-To: <20240318130447.594-2-petrtesarik@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [/cqzLCFuLTd/F1J/23ghHWQtHczlvWrP]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH7PR02MB8906:EE_
x-ms-office365-filtering-correlation-id: 31080dff-a0ee-4b56-c68a-08dc47614a42
x-ms-exchange-slblob-mailprops:
 vuaKsetfIZmkhnbUKmHRkZIuvuoWr8wW1L0Sc1GaRdlxrW4PCD1fy6IDqLiJd9odsrL7irfFiN0c1pb/NbjUXD9NwmCou6memDwirmbUiCen3BbJ9y5r/QI+NM40q2gAC3qQsWcpNWhduYdZQi6co7uciWDYBpp0vCZnfLIEPrP/96MLKB9VJejm+/pRZ3PmSNW1Y3DXqY10foXfjzu/JhNWLIqwZgTyo2OclSS50KwE053pQatnf17bzeRcq50v8r3tSR1ruf8vv4XYhzsgq1VCGp/bVnsTcp5fgxKLU+UTQcAFFcKDZHOhhGVL6zbsa19zVDHBW26K4+cDAaoYfV1a0G/NVetnGjbTVOFeJLZ4McyOnAz0CUVUiNNpg5sPbhnY+icuKtSKfuD6sIAhgrazJDzUYaK3/asHPkxIyUH0uijGQpDxBVBRnxLgIEXUXf8KqO9czX1CZ0tVCxE/QOcfUKNEFTpspTwm4enA3+EpkauoKZWsbtJzSfuaGpghkXsSU1URKONEt7HD/Kn2bfBTxqvNsdEoD/oZRYhHd/1nW2yLbDeRX0hZGYsuOsGVZQQayIktMA0Vm+Cgxyqbkg/eQSpv5aj7JRYEXeiZrvYdzzRaSe81dIPx5MXrukcPwaNY5AFVELtp2PBi3COKwelK8OD2q+ujKkCOvFUSg+yal/qHluSe2IKEZffOk4sWqTWtNCKkwDUHDmcRJT4+dbBZ0uH6mUupzMTPywBibrxg44DLv7iy94EDQB2+Q01gN0adDk97rKTJFjlypmaN4xJxQK6PEjK4PsqbgoIL756hsn56wywX69+st1h8NRZW
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xz9TTbmwqbYxh19VdHshXr/P+/YbMByO77mwwHb+hNzjuNDpZV+8XNTRw+l9ySWBT4WD8id4iwEpILxTWVj4+j+VuW8f9RKfRtnDUJFOq47HmdeiBuiB1mQwRbgzW6rrbvDoO2tpOrSNPYKdwV19Yo+ZbKH/fUjAQ0C3zo0PZ/ydw8wUv/aa92sM20+BRSe0BekSUeWErkhFngkDtRc/G7I9epqW4HB5xAEMEN5s/9LfPV6+qcr781DS0AUDwZThqS8A0WrXC8oYL4nj8QcV41xizBYZRL3ppuMRpLguLaaEztwGg4q9QSTjLu4FG9CALXWlKUX9zY3dkW8gQGDM9yDtilFdmXOruEX59KrSJNR7z98Ga7hdSqCetyO+dkIUoNgrVH++CaydzngBuRT3txyQaDnoqUvuUW1nlJmZcmGCKdFqHS9A4eJTinxoYCaZ6fjiC45+m4pYcXxf14QPnzHP8V+KM2jqfW8IWrzw6rAsXjsCrRCEmbGWRInPB3ySy5HkTP2ArnLk5QNwTAVEa5fZD/1xEXvNqJU6FbW2o2+7lb7v9Igqlo4buePPn07uQZ/edzdzbk5qYgTrvfDugG0e9piunv7Z93aTlx99javHyejQ6fgRX2CBnEIzDKcgrGHOV/UwdydN/PZ5QFMW7w/pTCE3/0A8wZBPYetDJGk=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CgaUYrcue1rnsW2uzNlS+jEXF9B36b3RC5WcTZdtk7dMY2p3tLnlap8BIvdq?=
 =?us-ascii?Q?0bdRIeUXgn5HFr24vzWT0HO/kZROyTZS5nAQ9x+aSKdWAeGpBYSg9UGy2qoC?=
 =?us-ascii?Q?pvqwimV/teIJWCXES8Hs8q1CACmUlmMHA+mnUkYg68uhEQkYtDQVMFS3mo9j?=
 =?us-ascii?Q?JcOge1+Apn9SAcYqr0linECKbVIumqjQP/vTyeH6DOkfeqbk8ccLotFBxPrs?=
 =?us-ascii?Q?XjWPXUGfZeKrDAfZ2TZkyVCIJdhiz9eAIUsJFkrmSh49mLaklCB4nALhDCsM?=
 =?us-ascii?Q?JfH/Tki6oYIHpW/zDgcNSVajqRjAVuDCUkI/5C3Y5DMGKyCz+T6Pe+HrFFl5?=
 =?us-ascii?Q?KjgCyUIng+oL/HnOUzQ+hDoBIVrrBdVv/eaJ3FSIH41prz+Iz8H4EiCwseCS?=
 =?us-ascii?Q?LD0rM8Ajhz+Y7AyX2F1hlC4THWYFtrfzVeiCu4CJVP7ndKX/z5XGmSNkBFDp?=
 =?us-ascii?Q?7aNmizcwlB90utTFuaR6M78xzzzl402NLZ1NLgllcSCI3IC1jHjinVIaJC+U?=
 =?us-ascii?Q?g4jKdRkyLcLNXgDsO039kvfHgFCHPd7B4e3mk5r5/NknMXB7E2cFgGZ2CLJE?=
 =?us-ascii?Q?WEEbY7TohhwRYKHHxe828xREwNCvEkNmm/BBOlMto2olxHcRwcNG2WLBv7RX?=
 =?us-ascii?Q?65X4RT5R0Bp1pnO8Zo7IljnoeEG7pbVd8mtvIVKRnuQF5X6SDkqCTkT9nvw4?=
 =?us-ascii?Q?rBC2UPxbA6/07AHgUJFvo33QeESM9D+poEUhLoYxgQVrRca5EjHSzO7rThSx?=
 =?us-ascii?Q?pfFv7hXqPH5R+G5pbj2FQ0tDdj4bO4rK51SQAbMXSdEh4ZkID3Jqx49lnYHx?=
 =?us-ascii?Q?AFXu0sdbIPcA2Kcnu/r/hkGZYYy7MLvZAmWzzIH28vXWpB+nd6BnSA/eP0ln?=
 =?us-ascii?Q?SnfFsqCXZp/DBy8ys5+1gfwxmkZ/yLHOqkoeBeb2JI1NBus0vP+9bduWdsPR?=
 =?us-ascii?Q?cTDR21SPHejvCNDKmkmFmug1/BGrOUsaGPritxcmzRDDBRaCR3qOH29IC0YO?=
 =?us-ascii?Q?8FNajnCvUSqzf4o0aph5Ig8LhK0xaK2wRXFhm9jhcpll3XQWlKGTns8OHoWR?=
 =?us-ascii?Q?7XfO3ukbUyJCpZ0dwDpdP70F7z/vSHlPcquC0+OD5u3grlUs32QiEMG8woQI?=
 =?us-ascii?Q?Swl3EjrXAfw3EX5YVkGqRuRc6Krv/cvqxZKkWWWnWPIjcbrXwGU4Wfl40HJz?=
 =?us-ascii?Q?s5yuxe05wljpOxX5gGXKo9QLkWvN8XIZrir0aQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 31080dff-a0ee-4b56-c68a-08dc47614a42
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 15:37:16.2845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB8906

From: Petr Tesarik <petrtesarik@huaweicloud.com> Sent: Monday, March 18, 20=
24 6:05 AM
>=20
> Allow a buffer pre-padding of up to alloc_align_mask. If the allocation
> alignment is bigger than IO_TLB_SIZE and min_align_mask covers any non-ze=
ro
> bits in the original address between IO_TLB_SIZE and alloc_align_mask,
> these bits are not preserved in the swiotlb buffer address.
>=20
> To fix this case, increase the allocation size and use a larger offset
> within the allocated buffer. As a result, extra padding slots may be
> allocated before the mapping start address.
>=20
> Set the orig_addr in these padding slots to INVALID_PHYS_ADDR, because th=
ey
> do not correspond to any CPU buffer and the data must never be synced.

This paragraph is now obsolete.

>=20
> The padding slots should be automatically released when the buffer is
> unmapped. However, swiotlb_tbl_unmap_single() takes only the address of t=
he
> DMA buffer slot, not the first padding slot. Save the number of padding
> slots in struct io_tlb_slot and use it to adjust the slot index in
> swiotlb_release_slots(), so all allocated slots are properly freed.
>=20
> Fixes: 2fd4fa5d3fb5 ("swiotlb: Fix alignment checks when both allocation =
and DMA masks are present")
> Link: https://lore.kernel.org/linux-iommu/20240311210507.217daf8b@meshula=
m.tesarici.cz/
> Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> ---
>  kernel/dma/swiotlb.c | 35 +++++++++++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 6 deletions(-)
>=20
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 86fe172b5958..aefb05ff55e7 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -69,11 +69,14 @@
>   * @alloc_size:	Size of the allocated buffer.
>   * @list:	The free list describing the number of free entries available
>   *		from each index.
> + * @pad_slots:	Number of preceding padding slots. Valid only in the firs=
t
> + *		allocated non-padding slot.
>   */
>  struct io_tlb_slot {
>  	phys_addr_t orig_addr;
>  	size_t alloc_size;
> -	unsigned int list;
> +	unsigned short list;
> +	unsigned short pad_slots;
>  };
>=20
>  static bool swiotlb_force_bounce;
> @@ -287,6 +290,7 @@ static void swiotlb_init_io_tlb_pool(struct io_tlb_po=
ol *mem, phys_addr_t start,
>  					 mem->nslabs - i);
>  		mem->slots[i].orig_addr =3D INVALID_PHYS_ADDR;
>  		mem->slots[i].alloc_size =3D 0;
> +		mem->slots[i].pad_slots =3D 0;
>  	}
>=20
>  	memset(vaddr, 0, bytes);
> @@ -1328,11 +1332,12 @@ phys_addr_t swiotlb_tbl_map_single(struct device =
*dev, phys_addr_t orig_addr,
>  		unsigned long attrs)
>  {
>  	struct io_tlb_mem *mem =3D dev->dma_io_tlb_mem;
> -	unsigned int offset =3D swiotlb_align_offset(dev, orig_addr);
> +	unsigned int offset;
>  	struct io_tlb_pool *pool;
>  	unsigned int i;
>  	int index;
>  	phys_addr_t tlb_addr;
> +	unsigned short pad_slots;
>=20
>  	if (!mem || !mem->nslabs) {
>  		dev_warn_ratelimited(dev,
> @@ -1349,6 +1354,15 @@ phys_addr_t swiotlb_tbl_map_single(struct device *=
dev, phys_addr_t orig_addr,
>  		return (phys_addr_t)DMA_MAPPING_ERROR;
>  	}
>=20
> +	/*
> +	 * Calculate buffer pre-padding within the allocated space. Use it to
> +	 * preserve the low bits of the original address according to device's
> +	 * min_align_mask. Limit the padding to alloc_align_mask or slot size
> +	 * (whichever is bigger); higher bits of the original address are
> +	 * preserved by selecting a suitable IO TLB slot.
> +	 */
> +	offset =3D orig_addr & dma_get_min_align_mask(dev) &
> +		(alloc_align_mask | (IO_TLB_SIZE - 1));
>  	index =3D swiotlb_find_slots(dev, orig_addr,
>  				   alloc_size + offset, alloc_align_mask, &pool);
>  	if (index =3D=3D -1) {
> @@ -1364,6 +1378,10 @@ phys_addr_t swiotlb_tbl_map_single(struct device *=
dev, phys_addr_t orig_addr,
>  	 * This is needed when we sync the memory.  Then we sync the buffer if
>  	 * needed.
>  	 */
> +	pad_slots =3D offset / IO_TLB_SIZE;
> +	offset %=3D IO_TLB_SIZE;
> +	index +=3D pad_slots;
> +	pool->slots[index].pad_slots =3D i;

The above line should be:
	pool->slots[index].pad_slots =3D pad_slots;

>  	for (i =3D 0; i < nr_slots(alloc_size + offset); i++)
>  		pool->slots[index + i].orig_addr =3D slot_addr(orig_addr, i);
>  	tlb_addr =3D slot_addr(pool->start, index) + offset;
> @@ -1385,12 +1403,16 @@ static void swiotlb_release_slots(struct device *=
dev, phys_addr_t tlb_addr)
>  	struct io_tlb_pool *mem =3D swiotlb_find_pool(dev, tlb_addr);
>  	unsigned long flags;
>  	unsigned int offset =3D swiotlb_align_offset(dev, tlb_addr);
> -	int index =3D (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
> -	int nslots =3D nr_slots(mem->slots[index].alloc_size + offset);
> -	int aindex =3D index / mem->area_nslabs;
> -	struct io_tlb_area *area =3D &mem->areas[aindex];
> +	int index, nslots, aindex;
> +	struct io_tlb_area *area;
>  	int count, i;
>=20
> +	index =3D (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
> +	index -=3D mem->slots[index].pad_slots;
> +	nslots =3D nr_slots(mem->slots[index].alloc_size + offset);
> +	aindex =3D index / mem->area_nslabs;
> +	area =3D &mem->areas[aindex];
> +
>  	/*
>  	 * Return the buffer to the free list by setting the corresponding
>  	 * entries to indicate the number of contiguous entries available.
> @@ -1413,6 +1435,7 @@ static void swiotlb_release_slots(struct device *de=
v, phys_addr_t tlb_addr)
>  		mem->slots[i].list =3D ++count;
>  		mem->slots[i].orig_addr =3D INVALID_PHYS_ADDR;
>  		mem->slots[i].alloc_size =3D 0;
> +		mem->slots[i].pad_slots =3D 0;
>  	}
>=20
>  	/*
> --
> 2.34.1


