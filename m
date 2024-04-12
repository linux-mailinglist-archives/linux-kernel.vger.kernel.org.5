Return-Path: <linux-kernel+bounces-143185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB3F8A3574
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CCBE1C215A2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC69114E2FE;
	Fri, 12 Apr 2024 18:16:19 +0000 (UTC)
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B80014D70E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 18:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712945779; cv=none; b=PrwObrjgjLH7DuR7VJyJbU/aR3tmHxckJDb4noUQ4ZrtZNF4JXkvEaTjbE0JnITNYQZo2MZctYcBSAEScnA4nD/vUoOmldoEqqzMBrsZFruu4480pxOfaYuBb/tk2QgBkOIWehKBZrFtOFyCtl3dwBdYpRzepC2Mu4uEMD3gFaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712945779; c=relaxed/simple;
	bh=WWXEsl0DDy0E7PW+5dOmtMA8fTtGxsREx4qh4SvPSKA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tx/VOGJurR10rLeGGKBltigwLC05UeolLWT/D6eIlotUc/hPNPBnnmyo9JYans1pbAa5m7sGe/eEgaxD9sZ3YOtDLe0V1PChvjpROROqZ/IdJxTk0hVzjJ7o/6bzTT+Q3LZV+fa2sukDpB7iHoNn1vpKPsCoZxkZXBi+hEGFXf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id 7593640A96; Fri, 12 Apr 2024 11:16:10 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 72EDE40A8D;
	Fri, 12 Apr 2024 11:16:10 -0700 (PDT)
Date: Fri, 12 Apr 2024 11:16:10 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Jianfeng Wang <jianfeng.w.wang@oracle.com>
cc: Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, penberg@kernel.org, rientjes@google.com, 
    iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, junxiao.bi@oracle.com
Subject: Re: [PATCH] slub: limit number of slabs to scan in count_partial()
In-Reply-To: <a8e208fb-7842-4bca-9d2d-3aae21da030c@oracle.com>
Message-ID: <bb2cb21b-0a5e-0154-2a7d-7e630b50aa4a@linux.com>
References: <20240411164023.99368-1-jianfeng.w.wang@oracle.com> <e0222219-eb2d-5e1e-81e1-548eeb5f73e0@linux.com> <38ef26aa-169b-48ad-81ad-8378e7a38f25@suse.cz> <a8e208fb-7842-4bca-9d2d-3aae21da030c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 12 Apr 2024, Jianfeng Wang wrote:

>>> Can you run some tests showing the difference between the estimation and
>>> the real count?
>
> Yes.
> On a server with one NUMA node, I create a case that uses many dentry objects.
> For "dentry", the length of partial slabs is slightly above 250000. Then, I
> compare my approach of scanning N slabs from the list's head v.s. the original
> approach of scanning the full list. I do it by getting both results using
> the new and the original count_partial() and printing them in /proc/slabinfo.
>
> N = 10000
> my_result = 4741651
> org_result = 4744966
> diff = (org_result - my_result) / org_result = 0.00069 = 0.069 %
>
> Increasing N further to 25000 will only slight improve the accuracy:
> N = 15000 -> diff =  0.02 %
> N = 20000 -> diff =  0.01 %
> N = 25000 -> diff = -0.017 %
>
> Based on the measurement, I think the difference between the estimation and
> the real count is very limited (i.e. less than 0.1% for N = 10000). The
> benefit is significant: shorter execution time for get_slabinfo(); no more
> soft lockups or crashes caused by count_partial().

Wow. That is good. Maybe decrease N to 1000 instead?


