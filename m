Return-Path: <linux-kernel+bounces-45303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BE5842E47
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E838A287A96
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F5471B56;
	Tue, 30 Jan 2024 20:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bnt6HHBr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FB06E2AA;
	Tue, 30 Jan 2024 20:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706648304; cv=none; b=GnZzj2kJju1vYclrOdHMzbjEYWgPCrc5QfDwIvctujB6E7qXet9+HvgMOKI+7ht+tbQYhkWv9w8fUUseVz74xGdyOmZtG8bLFFkmE68Ht/EUgehVuf52lGtsStKBGHbK/MaSUVuKRndEwIp4Tz17mlDdb4TcFcargAFDtPhfdII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706648304; c=relaxed/simple;
	bh=9UZiNX1ogTG54dY4oqALo68Do/m+ZrjV3ORgvb9uQPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNM47rFg/rqg2gvVzf4cTOsMycXYsOAg7AohW/eHjURs5sg9zFB+mfm58Wvr1d4knb9bgkpyO00tl7OAKUNHVX9JBZ/kj1ROE14ibPL1Q+7K4WW0Nb44TjZu7HVVe9Mb3qlSGkOujmd97IJVXPJpdLLOBYVy6PoQmJJuk1aNFZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bnt6HHBr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4885BC433C7;
	Tue, 30 Jan 2024 20:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706648303;
	bh=9UZiNX1ogTG54dY4oqALo68Do/m+ZrjV3ORgvb9uQPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bnt6HHBr3uaRcd2uD017LUys7iMuT7ppaB00f9hdAngoF+PngNrGy2AZGWc4KiJ6M
	 PBmjVSlO+FUFdM//y2hJUS/OjO+CgnAbrjfURH1vc0DQStBxRgTtIHL+i/NV3KFgvO
	 /XNIgarGOXDR9U1ts/51mq5hGn9A699RDjsXG4U6QzFAzKvQ49ZxYzsI5PorYykCma
	 qKbQp9mfDEU+a7C+r/yVYhe4TTWfuVkdsXen7Bi/xdyAN3D55L11ewcyTINZ+OuGV/
	 O7fqlGp0t8aWK1AOq7WMLOl/leM5AyokOshYcD8BtINCxYZO7Jqid+bW4XQXDIfSIf
	 MyrEq0xvnsRaw==
Date: Tue, 30 Jan 2024 15:58:21 -0500
From: Sasha Levin <sashal@kernel.org>
To: Pavel Machek <pavel@denx.de>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	"Borislav Petkov (AMD)" <bp@alien8.de>, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
	puwen@hygon.cn, seanjc@google.com, kim.phillips@amd.com,
	reinette.chatre@intel.com, babu.moger@amd.com, jmattson@google.com,
	peterz@infradead.org, ashok.raj@intel.com,
	rick.p.edgecombe@intel.com, brgerst@gmail.com, mjguzik@gmail.com,
	jpoimboe@kernel.org, nik.borisov@suse.com, aik@amd.com,
	vegard.nossum@oracle.com, daniel.sneddon@linux.intel.com,
	acdunlap@google.com
Subject: Re: [PATCH AUTOSEL 5.10 09/10] x86/barrier: Do not serialize MSR
 accesses on AMD
Message-ID: <Zbli7QIGVFT8EtO4@sashalap>
References: <20240115232818.210010-1-sashal@kernel.org>
 <20240115232818.210010-9-sashal@kernel.org>
 <ZabqkZ2vXaicy3pZ@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZabqkZ2vXaicy3pZ@duo.ucw.cz>

On Tue, Jan 16, 2024 at 09:44:01PM +0100, Pavel Machek wrote:
>Hi!
>
>> From: "Borislav Petkov (AMD)" <bp@alien8.de>
>>
>> [ Upstream commit 04c3024560d3a14acd18d0a51a1d0a89d29b7eb5 ]
>>
>> AMD does not have the requirement for a synchronization barrier when
>> acccessing a certain group of MSRs. Do not incur that unnecessary
>> penalty there.
>...
>> Performance captured using an unmodified ipi-bench using the 'mesh-ipi' option
>> with and without weak_wrmsr_fence() on a Zen4 system also showed significant
>> performance improvement without weak_wrmsr_fence(). The 'mesh-ipi' option ignores
>> CCX or CCD and just picks random vCPU.
>>
>>   Average throughput (10 iterations) with weak_wrmsr_fence(),
>>         Cumulative throughput: 4933374 IPI/s
>>
>>   Average throughput (10 iterations) without weak_wrmsr_fence(),
>>         Cumulative throughput: 6355156 IPI/s
>>
>> [1] https://github.com/bytedance/kvm-utils/tree/master/microbenchmark/ipi-bench
>
>Speed improvement, not a bugfix. Please drop.

Dropped, thanks!

-- 
Thanks,
Sasha

