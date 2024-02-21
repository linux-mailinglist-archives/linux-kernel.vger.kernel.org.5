Return-Path: <linux-kernel+bounces-73860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE48585CCB0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F9C2816BE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB57ECC;
	Wed, 21 Feb 2024 00:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bdJIQrr5"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3D51FBF
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 00:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708475077; cv=none; b=tXST7xKOZNaJ1JhBWwfzDo8/IDVkR1cPZRyWFMklwIFAq9hJ4SBRpisWmlbyC2J0RwrhLuFPWyIA73Avt+Ab+458KyDlnPaioCIbNw948x0wBBPhDZTnZ1/c83q2xiKG/ZtsUwM0j6tm55F/fO8mIz482CKu5SOnSDC3rMn+JfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708475077; c=relaxed/simple;
	bh=zsiqJVD8oee1LKgxlDnHQs9RnisiRpL2ecY5NmMQxOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VCIwodDNajSw52CKfR3fgQj67E8pZOEf83X0POO41ov9Vfv9Ynlg2EEYMDEfPhdua7QuXB26FzF6Ij1YMK5ZZFS+/NgYVqdyKIg9BOL5HjtEeymwm1nlzR0KoqfyuwsP0NUPETJZfn7M/UWgn6Qq4hY2c38EkJhdCKucIP69JC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bdJIQrr5; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-363acc3bbd8so5719005ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708475075; x=1709079875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sOLRAEsEthL2VkcOa5sVWiNqOGf453ZXNU0bFPj6SWs=;
        b=bdJIQrr5yR0VtuRNOGu3RlXAI0YFw2K0YKF/2JH1slb0K6b7i/HBf2LigUvdICJlWb
         ZgHi1PogfebfF6Ooc8YQy13rbtZl3kf/WJp6+UQRattiaOnxKsJxeSVDF2/O8ORv0Qou
         xoX7lI/0jn8Zwa2mz/EgUY511hPEV/3aEZa74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708475075; x=1709079875;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sOLRAEsEthL2VkcOa5sVWiNqOGf453ZXNU0bFPj6SWs=;
        b=wvnX4U9SXrE/dEbaeqc1FcSui5p0eyVmqEChQb6uf1wNQ+iM6VtMMpkCOOr0aCmnyQ
         9bnFLTwGDCge5tluhsWPHQuU9R9Y+ICztxAwO23C8GdGL+bCv2k9QiWvMhTKLUFSBeA7
         4L+FgPZk03unM3XKVx349MR65juNGfaSzc1HcZltbbZ3F+GPpRFjjJdfjk5w3OYuRkpx
         6hiLL5OgoifJUACfSZCfwhEJdJjK3C5B9lrL86bK8dnk69UJYy9fg0bg+SGHlXCH+hIC
         jJshBGLb3lgRYL25U1IsNRtBRHBllG3y+6WfLgANPiHGeLfJZyS8jKKPj46C3BvW+M8C
         69LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLTH9GF53lVC+oJJDfKrZOr7nQMpd790Q9jEDR0LsRF51suD/S3uNbAIonE5ru7tgfnhgIWzwjuXBq7aFc/VkbWnxaWOR+dtnIXfMV
X-Gm-Message-State: AOJu0YzPt2yaKdZxlmiRaevc1VsFYKFZkHk7yZjWnIzcCuIlxwzmQoQy
	0UZxJv5X4VCo0LK90H8Y/T/6NIqIDCHW5NqoIE3x3xb3ygozIVirvS4DstVo1ls=
X-Google-Smtp-Source: AGHT+IElgvmFms2RUxC0f+WggghxFIAH9xb37cmGwTuvln1obru77PAXe5n3hv/3FSNOhGNNjOkskA==
X-Received: by 2002:a6b:c844:0:b0:7c7:224e:ae90 with SMTP id y65-20020a6bc844000000b007c7224eae90mr12520260iof.0.1708475075513;
        Tue, 20 Feb 2024 16:24:35 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id u25-20020a02cb99000000b0047158a50c8csm2402736jap.133.2024.02.20.16.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 16:24:35 -0800 (PST)
Message-ID: <ab3e1d41-f3e7-406c-8de5-426bcd2ba602@linuxfoundation.org>
Date: Tue, 20 Feb 2024 17:24:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] selftests: sched: Fix spelling mistake "hiearchy"
 -> "hierarchy"
Content-Language: en-US
To: Colin Ian King <colin.i.king@gmail.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240220092323.2677156-1-colin.i.king@gmail.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240220092323.2677156-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/24 02:23, Colin Ian King wrote:
> There is a spelling mistake in a printed message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   tools/testing/selftests/sched/cs_prctl_test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
> index 7ba057154343..62fba7356af2 100644
> --- a/tools/testing/selftests/sched/cs_prctl_test.c
> +++ b/tools/testing/selftests/sched/cs_prctl_test.c
> @@ -276,7 +276,7 @@ int main(int argc, char *argv[])
>   	if (setpgid(0, 0) != 0)
>   		handle_error("process group");
>   
> -	printf("\n## Create a thread/process/process group hiearchy\n");
> +	printf("\n## Create a thread/process/process group hierarchy\n");
>   	create_processes(num_processes, num_threads, procs);
>   	need_cleanup = 1;
>   	disp_processes(num_processes, procs);

Applied to linux-kselftest next for Linux 6.9-rc1

thanks,
-- Shuah

