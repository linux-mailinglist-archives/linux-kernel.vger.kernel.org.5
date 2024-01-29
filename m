Return-Path: <linux-kernel+bounces-43055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C40840AD0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4436F287DF5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A2A155319;
	Mon, 29 Jan 2024 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BozDoV/I"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C078A1552E9;
	Mon, 29 Jan 2024 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706544496; cv=none; b=jH3EuZYpiTsThj1YqBCNDn1M0XlOIXfJ1Tl09gaG9FdBQ3BZLXLZOmKXun1tm4MTXfvH25mEf14OFHSyn1o3KrkkDPa4QCLy2W3Ix/dcZjZbF9wmKZEffcb7ElOY9BkWQicy8cDgcisnpv46sdcftwIPrf1G6OwtIi8Qy89rsTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706544496; c=relaxed/simple;
	bh=G/7o3RY8/GJcuKSsVB/XuMg93tvi3vPHELzbiCSfYQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jIQlObiZQAhgMykd7MyBgKjfyTbxRH47XHWaUBtEb8GMAqnTdxmbTvHoq2F6Ytrgn217U1xwRam9fzmA+8rzoR7+bVHPAJydhx65L4t94erXJMQpYxjbsoV/PnltAy2Z81C3/Qepqrz9EDDaVSGWxON2RIiuh03Hu2Lk1zjdSLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BozDoV/I; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d70b0e521eso21025405ad.1;
        Mon, 29 Jan 2024 08:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706544494; x=1707149294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+mTgviTdKTzv7O9t1uhh10fi/5C9xiOYYQX+Aq99Kgg=;
        b=BozDoV/IC7x7rjCjJchYN+YDxh0YO45MkooWYVwl5aG8PorNJIR6Xg0GmhEU483Ber
         fQ8c9JhguAk81OpLibCnHM7xSW3kQrMXtoA1gZuh4kAWeGPUa32XGJ6xAajDmdIDZNMa
         Rsbc/8R1dj69UPiRz/UYjq8Moz/nGpHTTulPCfEKlpJDtLFCg9dfyGUHbIrej1ylGvkz
         FX6ITrcySLLQixjD7+gu9jV0bnoWOw7AYq7+GZS0mPBCApModciIjNVw51f5UXsgslOj
         PKJWarQZyEtbKxhYCXBVLpR05eOHVrCscfDr9R0WzJo6On/gxh8ZA8wvfPz5qrzHDInP
         HdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706544494; x=1707149294;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+mTgviTdKTzv7O9t1uhh10fi/5C9xiOYYQX+Aq99Kgg=;
        b=Fuv6YkKP7gpZ7PDoIMbt4+AQ4Gf3ESQ8d/ATbj7+uFA/NlZPUetjO+k8YAEkgBIIvx
         eHkFif8MkP5igejij4JmFxuCnq8wRCD7eowoEH5DjIS6EBxADaVg8RdvVCxxHwS3+9hm
         zAA8q/dH88GSG9x63BOqW7AhciiGSDglS2cm3KyjAfUZ81clfjbFbJjA0hGIMVgSTKv7
         KVWf2ymzxuwaFHE4MYNoXSAHBL2jqhpgVzVnk4dlt2p+Ti5xRAUAtYFYJdhz3CFn5Je8
         mOjIwMfYM2CeBIRj0eAMndqZ6YUwE/wciW4uO9ab2kKF8V7NZKvwM2vD1CVwSZOnSswq
         FIkw==
X-Gm-Message-State: AOJu0YzeaahFyyTGcfOiwOq2TzZkOfUyChH9g4wuXJoP79QvCz4e8Vqh
	3fiso0ZPZgYGmnXoEJaxzgXTOQUPLAniSsUXQYTxmFwyiVXZyE8u
X-Google-Smtp-Source: AGHT+IFWBhnCZHZTBl6rG3FxD0Qk5o79Qnc2x6sDjqzPIybRlsBxy2mW9eQ7Ct8G3M/SSwBJgGDrnA==
X-Received: by 2002:a17:90b:19ca:b0:294:404:2f93 with SMTP id nm10-20020a17090b19ca00b0029404042f93mr3576302pjb.43.1706544493838;
        Mon, 29 Jan 2024 08:08:13 -0800 (PST)
Received: from [192.168.54.105] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id fa13-20020a17090af0cd00b0029564dec437sm2871504pjb.6.2024.01.29.08.08.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 08:08:13 -0800 (PST)
Message-ID: <9bc2f661-e3eb-4a2f-8e4a-17b49eda28d7@gmail.com>
Date: Mon, 29 Jan 2024 13:08:10 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] rust: add reexports for macros
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240129145837.1419880-1-aliceryhl@google.com>
Content-Language: en-US
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20240129145837.1419880-1-aliceryhl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/29/24 11:58, Alice Ryhl wrote:
> Currently, all macros are reexported with #[macro_export] only, which
> means that to access `new_work!` from the workqueue, you need to import
> it from the path `kernel::new_work` instead of importing it from the
> workqueue module like all other items in the workqueue. By adding
> reexports of the macros, it becomes possible to import the macros from
> the correct modules.
> 
> It's still possible to import the macros from the root, but I don't
> think we can do anything about that.
> 
> There is no functional change. This is merely a code cleanliness
> improvement.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

