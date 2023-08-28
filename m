Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C08178A8A4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjH1JSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjH1JSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:18:52 -0400
Received: from out-246.mta1.migadu.com (out-246.mta1.migadu.com [IPv6:2001:41d0:203:375::f6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA5E109
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 02:18:48 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693214327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=buZYlyaxKu/C9OL0nNFM3MPhLtLG4qaJ48AbO6+0Ah8=;
        b=km0Fx9Pw6KmvkCyJGPCqk99LALi3czvA3VZk+a0s3mdsbeBoExzb2wlFRlMI4latt24AmW
        nrxXERp0y1qvC+DJ0ek8uNIznyI5WmDyjtAAhj6T1iE6OKwbuH6Xv/fnXM/G5W7N2leo+F
        DZWd526Q/BjbYwl3jBMjqFUU8fYcXCI=
Mime-Version: 1.0
Subject: Re: [v3 3/4] memblock: introduce MEMBLOCK_RSRV_NOINIT_VMEMMAP flag
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230828090941.GD3223@kernel.org>
Date:   Mon, 28 Aug 2023 17:18:23 +0800
Cc:     Usama Arif <usama.arif@bytedance.com>,
        Linux-MM <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <AAF485D2-508B-4F96-862F-3658104E8F76@linux.dev>
References: <20230825111836.1715308-1-usama.arif@bytedance.com>
 <20230825111836.1715308-4-usama.arif@bytedance.com>
 <20230828074729.GC3223@kernel.org>
 <2be1ab83-f047-245f-68ad-62c4478914a5@linux.dev>
 <20230828090941.GD3223@kernel.org>
To:     Mike Rapoport <rppt@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 28, 2023, at 17:09, Mike Rapoport <rppt@kernel.org> wrote:
>=20
> On Mon, Aug 28, 2023 at 04:52:10PM +0800, Muchun Song wrote:
>>=20
>>=20
>> On 2023/8/28 15:47, Mike Rapoport wrote:
>>> On Fri, Aug 25, 2023 at 12:18:35PM +0100, Usama Arif wrote:
>>>> For reserved memory regions marked with this flag,
>>>> reserve_bootmem_region is not called during =
memmap_init_reserved_pages.
>>>> This can be used to avoid struct page initialization for
>>>> regions which won't need them, for e.g. hugepages with
>>>> HVO enabled.
>>>>=20
>>>> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
>>>> ---
>>>>  include/linux/memblock.h | 10 ++++++++++
>>>>  mm/memblock.c            | 32 +++++++++++++++++++++++++++-----
>>>>  2 files changed, 37 insertions(+), 5 deletions(-)
>>>>=20
>>>> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>>>> index f71ff9f0ec81..6d681d053880 100644
>>>> --- a/include/linux/memblock.h
>>>> +++ b/include/linux/memblock.h
>>>> @@ -40,6 +40,8 @@ extern unsigned long long max_possible_pfn;
>>>>   * via a driver, and never indicated in the firmware-provided =
memory map as
>>>>   * system RAM. This corresponds to =
IORESOURCE_SYSRAM_DRIVER_MANAGED in the
>>>>   * kernel resource tree.
>>>> + * @MEMBLOCK_RSRV_NOINIT_VMEMMAP: memory region for which struct =
pages are
>>>> + * not initialized (only for reserved regions).
>>>>   */
>>>>  enum memblock_flags {
>>>>   MEMBLOCK_NONE =3D 0x0, /* No special request */
>>>> @@ -47,6 +49,8 @@ enum memblock_flags {
>>>>   MEMBLOCK_MIRROR =3D 0x2, /* mirrored region */
>>>>   MEMBLOCK_NOMAP =3D 0x4, /* don't add to kernel direct mapping */
>>>>   MEMBLOCK_DRIVER_MANAGED =3D 0x8, /* always detected via a driver =
*/
>>>> + /* don't initialize struct pages associated with this reserver =
memory block */
>>>> + MEMBLOCK_RSRV_NOINIT_VMEMMAP =3D 0x10,
>>> The flag means that struct page shouldn't be initialized, it may be =
used
>>> not only by vmemmap optimizations.
>>> Please drop _VMEMMAP.
>>=20
>> The area at where the struct pages located is vmemmap, I think the
>> "vmemap" suffix does not mean that it is for "vmemmap optimization",
>> it could specify the target which will not be initialized. For me,
>> MEMBLOCK_RSRV_NOINIT does not tell me what should not be initialized,
>> memblock itself or its struct page (aka vmemmap pages)? So maybe
>> the suffix is better to keep?
> In general case the area is memmap rather than vmemmap, so a better =
suffix

Right. memmap

> then would be _MEMMAP. I'm not too fond of that either, but I cannot =
think
> of better name.

I have no strong opinion, if we cannot think a better name, just drop =
the
suffix as you suggested and let the comments more specified. :-)

Thanks.

