Return-Path: <linux-kernel+bounces-86103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BC586BFA1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0AA81C22AD7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D02376F1;
	Thu, 29 Feb 2024 03:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rne5CSNE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CD5376E1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 03:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709178758; cv=none; b=sxU/BPunK7INjv1e8HnwvwdCg7+wDwPUZDnt9h+f0oTPIzG9XWT24YHhlUslSGM+g+ZbN/i5VWwedTAGaqZdGUxWFwAX7A2OnkzOPMRd/YlZGtx6Rz7iCTuGZto4TytF7royxdbdB50URSB2MII7njVIZHJ5C2f6K1zku0PK4sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709178758; c=relaxed/simple;
	bh=yH4w3KkVCaD1LzUfUcTHguk7T7n3tQ9C/jrL4yRKV2Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V+F+vm+ltCSTex5OwOVM8BuiPtQYgUcYmGv33WKfXggAryBdGNpT5KnXVwsApC8aB/r0deGP++QpA8mg/qsxvfwCb99uxy4VDkavPpVTYlKO05VMuodxZDgKD8Vmco9BqJj5oRyqOV+5qcmxz0XQcH8xMT/wbQobal2IiAPvc+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rne5CSNE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FEC1C433C7;
	Thu, 29 Feb 2024 03:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709178757;
	bh=yH4w3KkVCaD1LzUfUcTHguk7T7n3tQ9C/jrL4yRKV2Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rne5CSNEbrCuAvMIy9L8aj3RaP76gvIKhcvYyEDQnfSvXYeE44McntiUxD2ZxjCSI
	 ahRfHcLZ5L3tOwkI+nrW/SslxK2n8ZMl97MF9S6fc7z3ci2+1z/iJ5dWkAjM+G/rJk
	 Az8XmkafDYhn101oldaQWz3ds74I5TsJL0pqHFAhrX9PRTi0OvrCa/mgLNgiKO7ptj
	 rgwgHVLSHvSzw02KdSAzfoA4Z31LzyE1eGe/BaI7F/yn+hoEx6dL3k3AP9YJBypUsa
	 zjvdsQjAKc8UdNwAw2V4oX47MEDyc6CwJXOLB1RdSeOdr0drpGkqueWnltKYWH2ngH
	 eYnXrUvUbJ0Tw==
X-Mailer: emacs 29.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Kunwu Chan <chentao@kylinos.cn>,
	npiggin@gmail.com, christophe.leroy@csgroup.eu,
	naveen.n.rao@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/mm: Code cleanup for __hash_page_thp
In-Reply-To: <87jzmq5tjr.fsf@mail.lhotse>
References: <20240125092624.537564-1-chentao@kylinos.cn>
 <87h6hva4b0.fsf@mail.lhotse>
 <f3b53f0e-58ce-4b2d-ba91-f347da73f9f3@kylinos.cn>
 <87jzmq5tjr.fsf@mail.lhotse>
Date: Thu, 29 Feb 2024 09:22:30 +0530
Message-ID: <87bk80kjup.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Ellerman <mpe@ellerman.id.au> writes:

> Kunwu Chan <chentao@kylinos.cn> writes:
>> Thanks for the reply.
>>
>> On 2024/2/26 18:49, Michael Ellerman wrote:
>>> Kunwu Chan <chentao@kylinos.cn> writes:
>>>> This part was commented from commit 6d492ecc6489
>>>> ("powerpc/THP: Add code to handle HPTE faults for hugepages")
>>>> in about 11 years before.
>>>>
>>>> If there are no plans to enable this part code in the future,
>>>> we can remove this dead code.
>>> 
>>> I agree the code can go. But I'd like it to be replaced with a comment
>>> explaining what the dead code was trying to say.
>
>> Thanks, i'll update a new patch with the following comment:
>>      /*
>>      * No CPU has hugepages but lacks no execute, so we
>>      * don't need to worry about cpu no CPU_FTR_COHERENT_ICACHE feature case
>>      */
>
> Maybe wait until we can get some input from Aneesh. I'm not sure the
> code/comment are really up to date.
>
> cheers

How about?

modified   arch/powerpc/mm/book3s64/hash_hugepage.c
@@ -58,17 +58,13 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 		return 0;
 
 	rflags = htab_convert_pte_flags(new_pmd, flags);
+	/*
+	 * THPs are only supported on platforms that can do mixed page size
+	 * segments (MPSS) and all such platforms have coherent icache. Hence we
+	 * don't need to do lazy icache flush (hash_page_do_lazy_icache()) on
+	 * noexecute fault.
+	 */
 
-#if 0
-	if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE)) {
-
-		/*
-		 * No CPU has hugepages but lacks no execute, so we
-		 * don't need to worry about that case
-		 */
-		rflags = hash_page_do_lazy_icache(rflags, __pte(old_pte), trap);
-	}
-#endif
 	/*
 	 * Find the slot index details for this ea, using base page size.
 	 */


