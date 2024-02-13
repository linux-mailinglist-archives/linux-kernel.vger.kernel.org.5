Return-Path: <linux-kernel+bounces-62879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E8E852738
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 03:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1545287369
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFB71FCC;
	Tue, 13 Feb 2024 02:03:19 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D757317CD
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 02:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707789799; cv=none; b=rdKSRo8qUrEEzLhCa4wVnKX2wjhaXfGtpe8PNcLPrlm4E8piICf97eKrvYSn1FO4FaONlGWo4xqYdR/o4f+WRqYrT0k106gcl6S3061EuyAILz7pz/2FTDwy4+x5IFW5m/7cmqHw8zpuZCr+/8nRGKcyFnPg08PFNk9Plp/qiL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707789799; c=relaxed/simple;
	bh=TrndH2YEXm9cuhg5WiMMAjXYVFYGXVdqHqKueUif6IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LW8IGOgwnsHxJC2TtTVRinHB8BEpNf2RBwXRyw76qmoOnb7Ii2yLuE4Nvgmkq+wkDw5FKt3ELQFs43xkK4QXwCfUBDP85Lz32RXkun7xhM3EKY/DPvWW1Ot7yrT8GDAVDW4UDTNcYL0N3D1nCoJS0inU5Yt3TH0hMSEcJ/O16sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-87-65cacde0032d
Date: Tue, 13 Feb 2024 11:03:07 +0900
From: Byungchul Park <byungchul@sk.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, ying.huang@intel.com, namit@vmware.com,
	vernhao@tencent.com, mgorman@techsingularity.net, hughd@google.com,
	willy@infradead.org, david@redhat.com, peterz@infradead.org,
	luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, rjgolo@gmail.com
Subject: Re: [RESEND PATCH v7 6/8] mm: Add APIs to free a folio directly to
 the buddy bypassing pcp
Message-ID: <20240213020307.GC4147@system.software.com>
References: <20240208062608.44351-1-byungchul@sk.com>
 <20240208062608.44351-7-byungchul@sk.com>
 <20240208124919.a0e1707fefc29c2f4213e509@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208124919.a0e1707fefc29c2f4213e509@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsXC9ZZnoe6Ds6dSDW5vVraYs34Nm8XnDf/Y
	LF5saGe0+Lr+F7PF0099LBaXd81hs7i35j+rxflda1ktdizdx2Rx6cACJovrux4yWhzvPcBk
	Mf/eZzaLzZumMlscnzKV0eL3D6COk7MmszgIenxv7WPx2DnrLrvHgk2lHptXaHks3vOSyWPT
	qk42j02fJrF7vDt3jt3jxIzfLB7zTgZ6vN93lc1j6y87j8ap19g8Pm+S83g3/y1bAH8Ul01K
	ak5mWWqRvl0CV0b7jo2sBZ/YKk4vfsLUwLiDtYuRk0NCwERi9eoNjDD29AttzCA2i4CqxLq/
	z9lAbDYBdYkbN36CxUUEdCVWPd8FZHNxMAt8YZK4cOs4WEJYIFVi65P5YEN5BcwlHj3+xQRS
	JCSwiFFi17ubUAlBiZMzn7CA2MwCWhI3/r0EKuIAsqUllv/jADE5Bbwljm3UB6kQFVCWOLDt
	ONgYCYFd7BIdc46yQxwqKXFwxQ2WCYwCs5BMnYVk6iyEqQsYmVcxCmXmleUmZuaY6GVU5mVW
	6CXn525iBEbnsto/0TsYP10IPsQowMGoxMOboHIqVYg1say4MvcQowQHs5II76UZJ1KFeFMS
	K6tSi/Lji0pzUosPMUpzsCiJ8xp9K08REkhPLEnNTk0tSC2CyTJxcEo1MHZ02q6uOvVX2un9
	vd9pHpkTWi4l/vcu1tB4fvborZygf1NPRPi9LVgyUdf2qu6G3aHR36Z90HkT8pYnKf8ucwWb
	xR+9U3vuC2TwpLn9dLVRu6j0Y7/9UxZdvQNmHucbsv7cPxbNfVQ/lbn+05kUlgXV1cIz7/8u
	beLaVamicVKddXr93sx7Z5VYijMSDbWYi4oTAX3wjSjKAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsXC5WfdrPvg7KlUg8W3xSzmrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XhuSdZLS7vmsNmcW/Nf1aL87vWslrsWLqPyeLSgQVMFtd3PWS0
	ON57gMli/r3PbBabN01ltjg+ZSqjxe8fQB0nZ01mcRDy+N7ax+Kxc9Zddo8Fm0o9Nq/Q8li8
	5yWTx6ZVnWwemz5NYvd4d+4cu8eJGb9ZPOadDPR4v+8qm8fiFx+YPLb+svNonHqNzePzJjmP
	d/PfsgUIRHHZpKTmZJalFunbJXBltO/YyFrwia3i9OInTA2MO1i7GDk5JARMJKZfaGMGsVkE
	VCXW/X3OBmKzCahL3LjxEywuIqArser5LiCbi4NZ4AuTxIVbx8ESwgKpElufzAcbxCtgLvHo
	8S8mkCIhgUWMErve3YRKCEqcnPmEBcRmFtCSuPHvJVARB5AtLbH8HweIySngLXFsoz5IhaiA
	ssSBbceZJjDyzkLSPAtJ8yyE5gWMzKsYRTLzynITM3NM9YqzMyrzMiv0kvNzNzECY21Z7Z+J
	Oxi/XHY/xCjAwajEw5ugcipViDWxrLgy9xCjBAezkgjvpRknUoV4UxIrq1KL8uOLSnNSiw8x
	SnOwKInzeoWnJggJpCeWpGanphakFsFkmTg4pRoYjzfwbYwPFZ/6f//fKcUGc14/VVgVcEZ+
	9+nrs41Mbnul/kle6iVy7OAyDke9ZlGdJdomTf1S0Q+E3LYJGsod4tYuswhudJ4sVz9n4bEO
	bZdtGiUht7un97AcUtv1M6r+1bWiBc9F50ufz7K6mZm5oSkosSH5RsCqoir7RSezUuxd/u9f
	VPJTiaU4I9FQi7moOBEAUNF3KrECAAA=
X-CFilter-Loop: Reflected

On Thu, Feb 08, 2024 at 12:49:19PM -0800, Andrew Morton wrote:
> On Thu,  8 Feb 2024 15:26:06 +0900 Byungchul Park <byungchul@sk.com> wrote:
> 
> > This is a preparation for migrc mechanism that frees folios at a better
> 
> The term "migrc" appears in various places but I don't think we're told
> what is actually means?
> 
> > time later, rather than the moment migrating folios. The folios freed by
> > migrc are too old to keep in pcp.
> 
> How do we define "too old" and what causes you to believe this is the case?

Migrc defers folio_put() for source folios of migration that would be
unlikely used and frees a bunch of folios at once later. However, it
pollutes pcp, which means fresher folios might get free_pcppages_bulk()ed
and makes the effort to keep the best amount of pcp get unstable. So I
didn't want to make this situation happen.

	Byungchul

