Return-Path: <linux-kernel+bounces-135247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E0689BDBA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9F7B1F225BE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836D164CCC;
	Mon,  8 Apr 2024 11:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kF/AwbdZ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A41533EA
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 11:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712574348; cv=none; b=oiENNILdnvU5xQgfz3U+iEl+XKtXk900IAF0JsvmL2B9qSBAFAA5fKh0UqMES8hMiVZBAO1+oFsf9lsPQL50F9Le9hauApnXLLq/54VGG52nSCcXCb9is+o9t5M1UdIhJGxgQCsv7L26UlE86JQKCUVHaVlbFVxaeWftJMc+Qts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712574348; c=relaxed/simple;
	bh=RadQCsKzg81Q1XqoXp12XBaKB24mRnrGDLMTm5uLssE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rEDjKwrCYOwBLdoPqmSzJsvwK1vRwEaYV36+4RBjdqCNIAYLe+8KMuuOA0XfFrCWZPHqXaG6BaYFt/aYPiwB47qNU1/vVG3y3aDiWjvIh45MFLXRHzDLYRvMFHFWrpOsAw+kNzYKpLkgJPdq/ECgMpnsNC44yOYLK4zKFW5HGbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kF/AwbdZ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712574345;
	bh=RadQCsKzg81Q1XqoXp12XBaKB24mRnrGDLMTm5uLssE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kF/AwbdZxLkRY+CHgg4PKjZ+ac7Ydb4psYIIb3HVXHJ46gI1yZzGR0r5XyfvqaZyx
	 4ckyodW+j7/RUxHGC/cuLDFy15Mi/1VXdPZoHVPk/3aFItHKJUH3cOAkYLpAzaRjvb
	 U7N2pT9GwZ9H80CIdQfl/Ut0GQgdrbkKA9lytrMZKBRtk8Krpq1C5UJZ/aXH9L1Phl
	 GasXgzWcmI8S5NTFLwbkdG8dIEuvW2icQiiQUU16emLMxQbLApyHg0rb6/agKZ/mFW
	 hNjXqXd7ZWMuOjQlYBKy4qS4vn9L5DaSvRXWKhS1LxNhLMB7fyFxMzctB2fu/hrtJe
	 y3Z44TRTfErvg==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CBB923781183;
	Mon,  8 Apr 2024 11:05:44 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: tglx@linutronix.de
Cc: kernel@collabora.com,
	laura.nao@collabora.com,
	linux-kernel@vger.kernel.org,
	regressions@leemhuis.info,
	regressions@lists.linux.dev,
	x86@kernel.org
Subject: Re: [REGRESSION] mainline boot regression on AMD Stoney Ridge Chromebooks
Date: Mon,  8 Apr 2024 13:06:05 +0200
Message-Id: <20240408110605.164608-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87zfu46zal.ffs@tglx>
References: <87zfu46zal.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Thomas,

On 4/8/24 10:20, Thomas Gleixner wrote:
> Laura!
> 
> On Fri, Apr 05 2024 at 16:59, Thomas Gleixner wrote:
>> On Fri, Apr 05 2024 at 15:58, Laura Nao wrote:
>>> On 4/5/24 15:38, Thomas Gleixner wrote:
>>>>
>>>> Can you please boot a working kernel and provide the output of:
>>>>
>>>> # rdmsr 0xc0011005
>>>
>>> # rdmsr 0xc0011005
>>> 2fabbfff2fd3fbff
>>
>> Ok. So the CPU does not advertise FEATURE_TOPOEXT which is consistent
>> with CPUID.
>>
>> Now I'm even more puzzled because then the patch I gave you should make
>> a difference. I need to run some errands now, I will provide a debug
>> patch later this evening.
> 
> Hmm. No real good idea yet.
> 
> Can you please checkout
> 
>      c749ce393b8f ("x86/cpu: Use common topology code for AMD")
> 
> and apply the patch further up in the thread and see whether that
> boots. We'll take it from there.
> 

Just tried that and it doesn't boot, nothing on the serial console (I
kept earlyprintk=ttyS0,115200 in the cmdline).

Test job for reference: https://lava.collabora.dev/scheduler/job/13297561

Thanks,

Laura

