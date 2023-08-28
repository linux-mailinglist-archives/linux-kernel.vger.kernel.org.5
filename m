Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1400478A672
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 09:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjH1H12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 03:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjH1H1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 03:27:07 -0400
Received: from out-245.mta0.migadu.com (out-245.mta0.migadu.com [91.218.175.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3025122
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:27:01 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693207620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R1NgD96YxNwdzL2uCYD5ii12GD63NiBnFyl1V0bsWgU=;
        b=xYURmCqpYKQ/TGhAscQnpBu2bh393iIT8QyTNNADMi/WngXPFauXxYtw7a5Vlm5Q29PkBL
        B0sR0f4Uo63hrhbvdWHmEqzSpORP1AfbMOzXluG3n3fCUGzTg+5fG7yqNTZ3IdR+sykPLn
        bKpspdsF703MZlI5OCpFhWRe4ZL7MLU=
Mime-Version: 1.0
Subject: Re: [v3 3/4] memblock: introduce MEMBLOCK_RSRV_NOINIT_VMEMMAP flag
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230825111836.1715308-4-usama.arif@bytedance.com>
Date:   Mon, 28 Aug 2023 15:26:17 +0800
Cc:     Linux-MM <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <357EEE41-1898-4430-BCC7-73F591CE8749@linux.dev>
References: <20230825111836.1715308-1-usama.arif@bytedance.com>
 <20230825111836.1715308-4-usama.arif@bytedance.com>
To:     Usama Arif <usama.arif@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 25, 2023, at 19:18, Usama Arif <usama.arif@bytedance.com> =
wrote:
>=20
> For reserved memory regions marked with this flag,
> reserve_bootmem_region is not called during =
memmap_init_reserved_pages.
> This can be used to avoid struct page initialization for
> regions which won't need them, for e.g. hugepages with
> HVO enabled.
>=20
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

One nit below.

> ---
> include/linux/memblock.h | 10 ++++++++++
> mm/memblock.c            | 32 +++++++++++++++++++++++++++-----
> 2 files changed, 37 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index f71ff9f0ec81..6d681d053880 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -40,6 +40,8 @@ extern unsigned long long max_possible_pfn;
>  * via a driver, and never indicated in the firmware-provided memory =
map as
>  * system RAM. This corresponds to IORESOURCE_SYSRAM_DRIVER_MANAGED in =
the
>  * kernel resource tree.
> + * @MEMBLOCK_RSRV_NOINIT_VMEMMAP: memory region for which struct =
pages are
> + * not initialized (only for reserved regions).

We have a more detailed explanation here.

>  */
> enum memblock_flags {
> 	MEMBLOCK_NONE =3D 0x0, /* No special request */
> @@ -47,6 +49,8 @@ enum memblock_flags {
> 	MEMBLOCK_MIRROR =3D 0x2, /* mirrored region */
> 	MEMBLOCK_NOMAP =3D 0x4, /* don't add to kernel direct mapping */
> 	MEMBLOCK_DRIVER_MANAGED =3D 0x8, /* always detected via a driver =
*/
> +	/* don't initialize struct pages associated with this reserver =
memory block */

Those comments right after the macros here seem like a brief =
explanation.
To keep the consistent with others, maybe "don't initialize struct =
pages"
is enough? At least, a detailed one is redundant and repetitive compared
with the above one.

> +	MEMBLOCK_RSRV_NOINIT_VMEMMAP =3D 0x10,
> };

