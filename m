Return-Path: <linux-kernel+bounces-129412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719F3896A6A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B97B288DB4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550557316D;
	Wed,  3 Apr 2024 09:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="OXXcioEY"
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814E45D731;
	Wed,  3 Apr 2024 09:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712136258; cv=none; b=tJ5Hb2YWZzLi7r8Z9kd+VglcLFI3rk6ORiqNRFa04zPJlil1QWTT0GlIBI15YY8J26MrW5PHqjeIvdeGI6fp0vslAzdzkEK+ZBfMnKXKT1fSJjAMcYmQ8/SsORPEe94m7vNm37fBF4OHHHWnzmXFHHlsvySEHV7wT0ik/REMt2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712136258; c=relaxed/simple;
	bh=3al6tDwI5lYdDTOMG5dHRvUWH7Kdpwnyp2UDmKmWL6w=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GQ5LhfI6vgQMONGgVNE+MPfzvQl712OuPW3PHnQwBdummFbrENGT3eFLqWh12WkWpXou2TOuBc878j7cAhrTRnzPseqDIiqJjdbCamRn6jgFetgbeplo928bJ8fH4ZiL2H0WNSy3qgK50nH9NwFzQ0ib/lDkSodQYc4SLbxrtwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=OXXcioEY; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=fFNSyki+Dgz7V/b1k4oyzhBUT89XBpD9mCte8VdggJ4=; b=OXXcioEYxBmZIcDa+w1dKhpXxa
	FtRL+g2c5eaj86MogF9DeEPpfGlAcGjCm2Vsi/NqeoBE9w73r301LM1Gg1ikoyjXeKkLBqJeEq1fv
	OIIiR9kYfaTdzGaUAbeGnkM1RmdMIGeVOFelkI0VRQ9sY9QaxrBLXKDAOamckFfK8cBHrOcb60bAF
	28FD5HfJBkM80lc0J7e4u4IlNL6QBmWvkBptT1b6JFkgw2Rc8n8R85/gGjb7bhBqwB7IHVlp1JgDm
	MdRdUeXNHOsrRWx8JAhRebrfqSI72bc2Q1Qh2+q5+dF7QtJFg68Wb/NEK1P0AsLSOq9fqhq2d8iGV
	IYNfxEtg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rrwY7-0009g5-O2; Wed, 03 Apr 2024 11:04:51 +0200
Received: from [178.197.248.12] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1rrwY7-000CJ1-0b;
	Wed, 03 Apr 2024 11:04:51 +0200
Subject: Re: [PATCH RESEND bpf v2 0/2] x86/bpf: Fixes for the BPF JIT with
 retbleed=stuff
To: Ingo Molnar <mingo@kernel.org>, Uros Bizjak <ubizjak@gmail.com>
Cc: patchwork-bot+netdevbpf@kernel.org, ast@kernel.org, x86@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240401185821.224068-1-ubizjak@gmail.com>
 <171203102833.24910.7566029980709800852.git-patchwork-notify@kernel.org>
 <Zg0EtEkIIA45cuPT@gmail.com>
 <CAFULd4Z0RmiWu4Kf0YFBMqA7YFMd65f3J760Do8-h83zWCx9oA@mail.gmail.com>
 <Zg0Mvb6kkHceEENb@gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <504a2e70-3bd5-a9f0-60ec-49c4b17566ae@iogearbox.net>
Date: Wed, 3 Apr 2024 11:04:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zg0Mvb6kkHceEENb@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27234/Wed Apr  3 10:25:27 2024)

On 4/3/24 10:01 AM, Ingo Molnar wrote:
> * Uros Bizjak <ubizjak@gmail.com> wrote:
> 
>>>> Here is the summary with links:
>>>>    - [RESEND,bpf,v2,1/2] x86/bpf: Fix IP after emitting call depth accounting
>>>>      https://git.kernel.org/bpf/bpf/c/9d98aa088386
>>>>    - [RESEND,bpf,v2,2/2] x86/bpf: Fix IP for relocating call depth accounting
>>>>      https://git.kernel.org/bpf/bpf/c/6a537453000a
>>>
>>> Just wondering, which kernel version is this targeted for?
>>
>> The whole series is intended for the current mainline (v6.9), this is
>> why it is developed against the bpf (*not* bpf-next) branch.
> 
> I see - so bpf.git:master are current-mainline BPF fixes - that's perfect.

Yes, correct, that is for mainline (v6.9).

Thanks,
Daniel

