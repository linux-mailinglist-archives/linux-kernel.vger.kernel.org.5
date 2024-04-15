Return-Path: <linux-kernel+bounces-145539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8D98A578C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E0F31F21592
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752A27FBBE;
	Mon, 15 Apr 2024 16:20:40 +0000 (UTC)
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEE129414
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198040; cv=none; b=n82Df8oDNvow3W73DRMLBfIi/9hoGSCrsMRyDnRe+v3CLWXaqzAerCzVZ0PVpl/vo4eNpEAvwvOEv3UC6yAfTV6PAozcxBrt/EMN2ywYRCd4cNu1MNyWioDxR1bu2WivVEwPgGRnu5TZfwQffZIOaNNPy9HKj7Nnbg3swIGdOTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198040; c=relaxed/simple;
	bh=nehaG3kH+wDxDtXRMwBWASBfjnqJiOasYYhEKGLsIMU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kibVmnZlnNeLHAn9dkt4r03/dSDWP0WazIKnUMEfIzvrb14CLBnCPFfwU1vgQ3uyy94ClYox41MXIqDzij9o0Qc3zCbI5TsBeNKVWJFvLIBQRp0JAMgZ45ouqnulF2KDYPXOhslY2oiqK2biQS/P5V5aVVEERxY9dUpegC5BE48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id EA2D140AB5; Mon, 15 Apr 2024 09:20:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id E97B04037C;
	Mon, 15 Apr 2024 09:20:29 -0700 (PDT)
Date: Mon, 15 Apr 2024 09:20:29 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Jianfeng Wang <jianfeng.w.wang@oracle.com>
cc: Vlastimil Babka <vbabka@suse.cz>, 
    "linux-mm@kvack.org" <linux-mm@kvack.org>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "penberg@kernel.org" <penberg@kernel.org>, 
    "rientjes@google.com" <rientjes@google.com>, 
    "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>, 
    "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
    Junxiao Bi <junxiao.bi@oracle.com>
Subject: Re: [PATCH] slub: limit number of slabs to scan in count_partial()
In-Reply-To: <5552D041-8549-4E76-B3EC-03C76C117077@oracle.com>
Message-ID: <bb1d4c3e-0c1a-0868-5c1f-9a1de8692db1@linux.com>
References: <20240411164023.99368-1-jianfeng.w.wang@oracle.com> <e0222219-eb2d-5e1e-81e1-548eeb5f73e0@linux.com> <38ef26aa-169b-48ad-81ad-8378e7a38f25@suse.cz> <a8e208fb-7842-4bca-9d2d-3aae21da030c@oracle.com> <1207c5d7-8bb7-4574-b811-0cd5f7eaf33d@suse.cz>
 <e348dfcd-6944-4500-bf84-c58b8c2e657f@oracle.com> <5552D041-8549-4E76-B3EC-03C76C117077@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-810623552-1713198029=:146654"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-810623552-1713198029=:146654
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 13 Apr 2024, Jianfeng Wang wrote:

>>>>>> kmem_cache_shrink() will explicitly sort the partial lists to put the
>>>>>> partial pages in that order.
>>>>>>
>
> Realized that I’d do "echo 1 > /sys/kernel/slab/dentry/shrink” to sort the list explicitly.
> After that, the numbers become:
> N = 10000 -> diff = 7.1 %
> N = 20000 -> diff = 5.7 %
> N = 25000 -> diff = 5.4 %
> So, expecting ~5-7% difference after shrinking.

That still looks ok to me.

--8323329-810623552-1713198029=:146654--

