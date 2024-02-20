Return-Path: <linux-kernel+bounces-73827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB3C85CC19
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACCE61C20D4A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C99F154C07;
	Tue, 20 Feb 2024 23:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ImT6RsLi"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4C4151CEB
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708471922; cv=none; b=frANiiM2m59qgzJmZntLD3QsD56oWO+ECrIdUnnQfpHMNfafDOe+iigFG+p7vZXnH4BQTT3iyI6snPfDGNxiRCru3NRUePGJOlK0eju1mpwYpaR42CcbGD9+IuHZyn3Envmmz4I/hZ/QVuCbCzSdAWwtgzAeQz/rujFAxNVhXyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708471922; c=relaxed/simple;
	bh=E85vTkhQf4PZXeuxb8z1H4QmYVNU2QtZ3O5D0Py5gso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lFtM3lzfYC6pSiXwI9LQ2Q1Z9msjs7fFwf+54recq6/98Zo6H9h1ETbdypq/glJ/A70GubEfbJvxZM2J7OiCpjbHzxWXjOosTNey6d2cveSVY9I6GZfJKV/dVZN6f4UrTmKBUMGfCgVQhFiZRZXG1zM8vbWmLvTTANf8sBTlIq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ImT6RsLi; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7c3d923f7cbso57409439f.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708471919; x=1709076719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MZnee7MP9kFtkR1jNN3IbBQu7vuP0eQNMigbVcKsoDE=;
        b=ImT6RsLiEcthQkYjWySg3siiclDFvzO4mG7IdVhgWbN+ji5ghgXRvMOrno5p2/Qc+k
         zxMMqkD71G+xhE1NfMZyfJuJOtJ9RVaa4uEoRTY9t/hjNoANjIyDeQNxDA88ftjh2pv+
         JB3c6RikzNt1AscM6JzbUy1gFrqcMHoKNyP8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708471919; x=1709076719;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MZnee7MP9kFtkR1jNN3IbBQu7vuP0eQNMigbVcKsoDE=;
        b=qFaJ6o4ODbhIpBm3eybSZ4Rp7tIW5/Co5LpqXWt+erWIYIJOk/qMipoblZMh6zPMaD
         hs6ZCkaROCQzppY9BTZq/MwNNPu0t64mlHB5SoK1DXDzCm7JqSZYiYaY/IdhFFi2BQZg
         DqG75WELs9COvuzpoe9UsDy2F5vr4Vx9rKAT4LRqCF69pHUm6RU9wF8f9K4P7YZi02+k
         9J52aktOkK/FaoSXY6Xs035BBqBJPK+2jGAD0Y+bdH34O1kjJwXU6O5Cq7DpbTBMPsCG
         M5Okt2L1Kr25ElyQmA+wK6AFPJv3PEHUcE2cHcrN9iNFlGWPc0HtnhGnoYRBKKcrOTqU
         tEpQ==
X-Gm-Message-State: AOJu0YzBgeCIbZNkPofQu12CwicR3NX0ODewBPrHgcqqej2s/9qfIR9S
	CS865V9170z11z0plW1eS0ojuuBuzhFB+0ehun/imbSLMxYAMXNLAUh1vODZb9hpO83e41Q2FVV
	O
X-Google-Smtp-Source: AGHT+IGMdZbjaSZvVj7VZUzsfmmIhzaAC0Vw5Ef9mFzx6xNO5QsUp+BiSXuzo28Nkev+cZ+JeX99GA==
X-Received: by 2002:a5d:9047:0:b0:7c4:c985:145a with SMTP id v7-20020a5d9047000000b007c4c985145amr13394541ioq.2.1708471919391;
        Tue, 20 Feb 2024 15:31:59 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id q10-20020a02c8ca000000b00474284a0228sm1357459jao.61.2024.02.20.15.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 15:31:59 -0800 (PST)
Message-ID: <78dd68bd-d5ed-4549-870e-7514b300fdc5@linuxfoundation.org>
Date: Tue, 20 Feb 2024 16:31:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] selftests: add missing gitignore files and include
 generated objects
Content-Language: en-US
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Shuah Khan <shuah@kernel.org>, SeongJae Park <sj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240214-selftest_gitignore-v4-0-857b39cef2fa@gmail.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240214-selftest_gitignore-v4-0-857b39cef2fa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/24 17:03, Javier Carrasco wrote:
> This series aims to keep the git status clean after building the
> selftests by adding some missing .gitignore files and object inclusion
> in existing .gitignore files. This is one of the requirements listed in
> the selftests documentation for new tests, but it is not always followed
> as desired.
> 
> After adding these .gitignore files and including the generated objects,
> the working tree appears clean again.
> 
> To: Shuah Khan <shuah@kernel.org>
> To: SeongJae Park <sj@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> 
> Changes in v4:
> - damon: remove from the series to apply it in mm separately.
> - Link to v3: https://lore.kernel.org/r/20240213-selftest_gitignore-v3-0-1f812368702b@gmail.com
> 
> Changes in v3:
> - General: base on mm-unstable to avoid conflicts.
> - damon: add missing Closes tag.
> - Link to v2: https://lore.kernel.org/r/20240212-selftest_gitignore-v2-0-75f0de50a178@gmail.com
> 
> Changes in v2:
> - Remove patch for netfilter (not relevant anymore).
> - Add patch for damon (missing binary in .gitignore).
> - Link to v1: https://lore.kernel.org/r/20240101-selftest_gitignore-v1-0-eb61b09adb05@gmail.com
> 
> ---
> Javier Carrasco (3):
>        selftests: uevent: add missing gitignore
>        selftests: thermal: intel: power_floor: add missing gitignore
>        selftests: thermal: intel: workload_hint: add missing gitignore
> 
>   tools/testing/selftests/thermal/intel/power_floor/.gitignore   | 1 +
>   tools/testing/selftests/thermal/intel/workload_hint/.gitignore | 1 +
>   tools/testing/selftests/uevent/.gitignore                      | 1 +
>   3 files changed, 3 insertions(+)
> ---
> base-commit: 7e90b5c295ec1e47c8ad865429f046970c549a66
> change-id: 20240101-selftest_gitignore-7da2c503766e
> 
> Best regards,


Applied to next for Linux 6.9-rc1

thanks,
-- Shuah


