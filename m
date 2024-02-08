Return-Path: <linux-kernel+bounces-57394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F9F84D7E3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A23D1C22D8C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B031D52C;
	Thu,  8 Feb 2024 02:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qy0b7OPZ"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6911D524
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 02:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707359993; cv=none; b=uDxo1a2aLckqepjsmr7nbCadqG6I89a8zbfcGbldnzrUdBbgPLFfxsP1KvoezW4ZCUAp1j8zfav405lKjV5bRtwe28cgXc7P6eJbq6wpBtSA0xvdoWQueYY/Jww9YyzmozrDnFq92QkVyZflsbWlQlKRXYEZV34+JMXQ5F9Y/w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707359993; c=relaxed/simple;
	bh=iAOsapMZT7WscB3KOtE0CbtJvWu7mUbIYn8/aPsdH1U=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:Cc:To; b=lo3E8IqebZ9AHRMAoSasMHRE9nhR72T/g/bYeMSiTp4QQNXDPUjrHEvfcGlUUFYhnZf5ODWo3DxWfs3PkaDzFkneH5EcJTMdX6l2S0CL+EAuqkQrmZTTdOEHwUV7NY28VIsFhafbmo7+M418LdHwAm2l+zFbJbMcfMQ+MBzjL+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qy0b7OPZ; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707359989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iAOsapMZT7WscB3KOtE0CbtJvWu7mUbIYn8/aPsdH1U=;
	b=Qy0b7OPZXO/RA1651zuoBKcLO0Sr1tK05H98dZRQVNJHWeArnC7VjG6T+ZTPhcx+XIbkAp
	tOpxJrN69yEZ+CJtPC2f84KyGEXYa0LrP51+oDLXCUUe2WOwaP5DLeTEXDFq1N9uQi6OxV
	Rqf+tzkL14/7iGCRw83bvzuZ0AszKJE=
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH 1/1] hugetlb: fix CONFIG_PADATA dependency for non-SMP system
Message-Id: <86B96EE5-A51C-4F06-BB18-0B3B12DBCCEC@linux.dev>
Date: Thu, 8 Feb 2024 10:39:13 +0800
Cc: Gang Li <ligang.bdlg@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Randy Dunlap <rdunlap@infradead.org>,
 kernel test robot <lkp@intel.com>
To: Gang Li <gang.li@linux.dev>
X-Migadu-Flow: FLOW_OUT

=EF=BB=BF

> On Feb 5, 2024, at 16:08, Gang Li <gang.li@linux.dev> wrote:
>=20
> =EF=BB=BFOn 2024/2/5 15:37, Muchun Song wrote:
>> Actually, I did not get it. Why the above code cannot work? The above
>> code already make it serialized in one call, right? What do I miss here?
>> Thanks.
>=20
> PADATA consists of two distinct functionality:
>=20
> One part is `padata_do_multithreaded`, which disregards
> order and simply divides tasks into several groups for parallel
> execution. My patch use `padata_do_multithreaded`.

OK. Since all users of PADATA of non-SMP case currently only use padata_do_m=
ultithreaded, it=E2=80=99s possible and easy to implement a variant of that i=
n non-SMP case. It is not necessary to implement another functionality unles=
s the only user of crypto/pcrypt.c does not depend on SMP in the future, at l=
east now it=E2=80=99s dependent on SMP.

Thanks.

>=20
> The other part is composed of a set of APIs that, while handling data in
> an out-of-order parallel manner, can eventually return the data with
> ordered sequence. Only `crypto/pcrypt.c` use them. I guess these APIs
> are designed specifically for `crypto/pcrypt.c`.
> ```
> padata_alloc
> padata_alloc_shell
> padata_do_parallel
> padata_do_serial
> padata_free_shell
> padata_free
> ```

