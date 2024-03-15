Return-Path: <linux-kernel+bounces-104923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E0787D5E1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D8A1F2699A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE6A1EB2C;
	Fri, 15 Mar 2024 20:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J3jUyH26"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C3217BC1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 20:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710536146; cv=none; b=RdTEtxpx0i+ZVuvMH1rv74aW2XeZI2UgrE/mQPkWLA7m2XAGguu1PIK5OErILT7XYginw48a8wR2Th+J3O5/8+Nv6Qsi76f5iS29ZR+n8yZ5SMSIOxFnZ78Vb5BJKHLpZHehOIMdT5ULSRLaqEcv3r9zdqupIykh/Db3bXgay2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710536146; c=relaxed/simple;
	bh=vFIp47eyFRkJebC1ZTewSggLavBg2Uy67QVKRb0Dbew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZkvijB8+LKWRY8Pp2PpXSPP7N+rX2Gx3B2A/rPaSopdYDH9vmzcmYne4h4u6M0L7QzMFTZnB2HPwXHWAuFr0QEZocMYlbdb9kOOg+6gmMIGYfH/o9fRFCM0PyRj/PXgqMHEMOZ97XBiqzO88JH/HrwI2Y09IXbuFJEy4OYR1Cf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J3jUyH26; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <55151dc9-8edf-4c75-b1d0-1cc0437816c3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710536142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyzThqt9i5s0vy//kTuZWuEk52yZJ8/vTj4lH/P0htw=;
	b=J3jUyH265uaTN1J5HV2QzzZ3Rc1/Hjngokhg0IU25RHmZHGDyVwRGMMQnlVv8ZANumhzVa
	0NB+qBe4kRS47x9Ms5CL3oLceFevwb3SKk+AGKiHIJJWsSvU26s6L5e7sV/mV49JiSoRhn
	2dlDTGf87BNLs1yv4vzFs6kYkW2h6Zw=
Date: Fri, 15 Mar 2024 13:55:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/2] bpf: Check return from set_memory_rox()
Content-Language: en-US
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Kui-Feng Lee <thinker.li@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Kees Cook <keescook@chromium.org>
References: <2b9fdb119ef73cfa4516572026ba4936e86aedca.1710522112.git.christophe.leroy@csgroup.eu>
 <4d7cc25e937403ac61ae61be06f998f27e631a65.1710522112.git.christophe.leroy@csgroup.eu>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <4d7cc25e937403ac61ae61be06f998f27e631a65.1710522112.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/15/24 10:06 AM, Christophe Leroy wrote:
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 43356faaa057..ca1d9b87c475 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -742,8 +742,11 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   		if (err)
>   			goto reset_unlock;
>   	}
> -	for (i = 0; i < st_map->image_pages_cnt; i++)
> -		arch_protect_bpf_trampoline(st_map->image_pages[i], PAGE_SIZE);
> +	for (i = 0; i < st_map->image_pages_cnt && !err; i++)
> +		err = arch_protect_bpf_trampoline(st_map->image_pages[i], PAGE_SIZE);
> +
> +	if (err)
> +		goto reset_unlock;

This part does not look right. The "if (err)" check should be inside the for loop.

pw-bot: cr

