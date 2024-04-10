Return-Path: <linux-kernel+bounces-138845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE20089FB7A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BBECB28C4B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0227316DEDC;
	Wed, 10 Apr 2024 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gyujga+H"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B852A16D9D6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712761800; cv=none; b=EZHmY7evIN7XywZUMvIEbI79PdHiNfIkd4SiB6j4MOK5uOb465UTrBiN4kQgCfaS/P5GwQQIoZkGCLHQOCGwLsYDLkZoBmBI01cWXqU0j+tjv6WjYyvTR5Dyxr5a7yRn7Df3uI6tqN4v1GxTYi7uaSMm4HGQREswte4ldQtk0FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712761800; c=relaxed/simple;
	bh=JBToPHsKyA1IBRYoalpk1N7HunyLQxVk5LEZ5W4MlOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qg0xXNRnKVRQ7jbShKsAjC05aBjce7U6Y/n948udiblO0CM4TY+8VA261xYEq0/4jBw4sF4D5NMuKlzBGPatuLCNVFcRru+wkSkCT+e6aGRrjIANhMFRMzHgEF5LQl3ee0XiJjXC0Pdl2g9KyMffdKfZ/0emnNxHPenIOGycpP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gyujga+H; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4bfc3494-a3e9-4b4c-9d93-fa1049a10235@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712761795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cy4xebQzWg8ALuOLJMZcZOAIDsJ9HQugVvvvnFO1U9g=;
	b=gyujga+HaZvsTQ7G3DmgTeft/hcI9fL/iS3AKqRtU5+stijNTdql8qDujHFNsjLn8ti84u
	LaATm+Wy2MzAHhA6g3V5ezs1I5QHVmJxvhUjpyeVBtlJdHU/Q2ueaMlrY+dJMoldGCfTYB
	ojlT6FDWBvgWlw+0ANXTkxkOOiKzkc8=
Date: Wed, 10 Apr 2024 08:09:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: strnchr not suitable for getting NUL-terminator
Content-Language: en-GB
To: Edward Adam Davis <eadavis@qq.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev,
 sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com
References: <tencent_EC72CD3879FA6F102FC56E4495F0E822EC0A@qq.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <tencent_EC72CD3879FA6F102FC56E4495F0E822EC0A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/9/24 5:33 PM, Edward Adam Davis wrote:
> The strnchr() is not suitable for obtaining the end of a string with a length
> exceeding 1 and ending with a NUL character.

Could you give more detailed explanation with specific examples? I think
strnchr() does the right thing here. Note that if fmt is not NULL,
strnchrnul() never returns NULL pointer so in the change below,
'if (!fmt_end)' will be always false.

>
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>   kernel/bpf/helpers.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 449b9a5d3fe3..07490eba24fe 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -826,7 +826,7 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
>   	u64 cur_arg;
>   	char fmt_ptype, cur_ip[16], ip_spec[] = "%pXX";
>   
> -	fmt_end = strnchr(fmt, fmt_size, 0);
> +	fmt_end = strnchrnul(fmt, fmt_size, 0);
>   	if (!fmt_end)
>   		return -EINVAL;
>   	fmt_size = fmt_end - fmt;

