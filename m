Return-Path: <linux-kernel+bounces-136632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCA189D64C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52C5EB23942
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5EE81723;
	Tue,  9 Apr 2024 10:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="udKLd3O5"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99F280BE3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 10:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657243; cv=none; b=GBO3JPl/GHygdRKYYCwDwsIsk5zOzFh9b3jlSl4i5rkoiprWHJN7D1DhItqrP7lcVSPBo+gtTXaHPsEE3UlCCyEQt+52E+eLjKC1mWFcCO2PZVgrt6ibX5mC8u8/cDKGd7bRlTMQ7xEnL5cSGJx5HFHqf3euKs2SZuBYI1unmCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657243; c=relaxed/simple;
	bh=0sI7hcjkaSbVWAwLMG7V7QsSlukyMgg9ADBguolBVDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u6LOJQ3LYWDZVhuUeq3fEwYnol1tY85vbRQxB4ifU9ZOwKLCfi5q+BVb3csgHTXdNgh7QhZ+7JlmBzKLIEu8VJ/FVzjuapoIT1b9jEgKZVGArUvbbzY7YKsE7hygFzBWvpWBen7quOGtGJPHBf1MmyG100uVzUe8vCLN0Vf83+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=udKLd3O5; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712657240;
	bh=0sI7hcjkaSbVWAwLMG7V7QsSlukyMgg9ADBguolBVDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=udKLd3O53APlQguYXNCB/Hc582PYyqL+m6R6U1ht+dfXjaVLIDc5CDPUE+szmWf6Z
	 fAi69iSdDTrBfkiAZ+MmHHWbPoXysEss8U8Imb/C+LDeKFXg3ol+EWrpyrF/+UQ94u
	 p5tvc113EHToX0N5PKSbpJhiAmdgPK0fIWNdvo7BeATOgTfnLGn5Z6GFaPHNGudDaF
	 BEu8io60TYPK9pNjhYa9tKBntO0sMnMkXxqGiR6FrlwfsTnDqsswRc1xsCY/fYg1FS
	 M4F7mUmdBFChHn9mSHfyWdd9hQiRMyFaLoxCZlXFci2dU1A05qhhEMM8k3AAAISbYW
	 SPgwk64zo1RjA==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 89A7537800DE;
	Tue,  9 Apr 2024 10:07:19 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: tglx@linutronix.de
Cc: kernel@collabora.com,
	laura.nao@collabora.com,
	linux-kernel@vger.kernel.org,
	regressions@leemhuis.info,
	regressions@lists.linux.dev,
	x86@kernel.org
Subject: Re: [REGRESSION] mainline boot regression on AMD Stoney Ridge Chromebooks
Date: Tue,  9 Apr 2024 12:07:36 +0200
Message-Id: <20240409100736.139489-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87r0fg6ioe.ffs@tglx>
References: <87r0fg6ioe.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Thomas,

On 4/8/24 16:19, Thomas Gleixner wrote:
> Laura!
> 
> On Mon, Apr 08 2024 at 13:06, Laura Nao wrote:
>> Just tried that and it doesn't boot, nothing on the serial console (I
>> kept earlyprintk=ttyS0,115200 in the cmdline).
> 
> Thanks for trying. Now let's take a small step back.
> 
> Please reset the tree to:
> 
>        ace278e7eca6 ("x86/smpboot: Teach it about topo.amd_node_id")
> 
> That's the commit right before switching over and according to your
> bisect it works. Now apply the patch below, which just runs the new
> topology scan function but discards the result.
> 

The ace278e7eca6 revision with the patch you provided boots correctly.

Reference test job: https://lava.collabora.dev/scheduler/job/13311035#L1894

Thanks,

Laura


