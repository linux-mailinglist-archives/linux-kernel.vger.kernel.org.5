Return-Path: <linux-kernel+bounces-52756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9842E849C54
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5446C28693D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6271B24B26;
	Mon,  5 Feb 2024 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nd/eHhZV"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDDE20DF7;
	Mon,  5 Feb 2024 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141293; cv=none; b=p6w8wDbrwiowMlLYUaB/7pWrP3vKjeMpafSThhcuevSBBpTaKe88Ej+7jngrzgb+Kq3L1fK01cEyk6nbw+PurryhvH8aTQMtW802t6G04xwh1ewqZlYic7rgBC54IZNn/bsPND7ZdFF4kg2BjE+kCFcYxTtZRWvp15JVxrfyoK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141293; c=relaxed/simple;
	bh=acweT+i277382WZB+wyUx+MhWf5O3le9YAhJ7llTVi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NyZFaKo6omkRcFCfE48SQ2cexSYAlaYrv8K4Ts17lKH/drUOfX19DosTs5Z9RfIRL02tB/hMj5r6y4ypN+QXdnnfzHVg0MO1LmtDECkH/kvXsNPHvhWQBBg2Qy3OGEntJFEA4EzdW6gyoAAzll+nJZCqMtbvjh3HwF9e/XxMCPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nd/eHhZV; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5dc20645871so296626a12.1;
        Mon, 05 Feb 2024 05:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707141291; x=1707746091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zqgzJpnAG+g5K7FixWrk7l6k12DPaioO4UV8OexrcUs=;
        b=nd/eHhZV9jhJMg/83AB3KgsC1bNW80bYNnxTBxhZe1femcuxbx2l4uJgHs2IuY+jjG
         7f4XZM0gEdJ/9qqhUD1o+sLr5bkoNwl/GSQA5XRJwcJgSfntOIKZ45ggqsPM2B7I576x
         yvFaLf8zCV+4Lti+9QqoBos5vTwgbvQfuBtr/bH3ObZU5KYUHr53U0a1OnAeC5ZVBkcs
         atFS60QHNShZlxlgdFVKcpMCT+pJZupqaXKmCwojJeHQ9rGc0IAUWWxdD1bCxSg5lKj9
         tnc8PRi2o7z5BV+ntOcXMmNRQjY1o4HXNak1ov05NszX3sk7zlnx3soHYVaZHNVsQEtD
         Hj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707141291; x=1707746091;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zqgzJpnAG+g5K7FixWrk7l6k12DPaioO4UV8OexrcUs=;
        b=GOdnA/Gp6XqvOrZProm7sDWKq7r4yQyPhVcXcFA5fbHVIJxRkbdmjk4lPLjDk820lT
         ss9lItZaKaKIgbT1oww71jGvNzeu8+dsBxdK21mx1H+I96/4XjiUq/LaXl+8bVjDEewE
         64Dd+XPFvndNMH01xs7RbiRsM11EGwtgswFRUNCOwJsG6e1/bUm0ObzSrFnvDYtHBgaH
         cikg/FVNAszJxvZ8pWFqelHBcOdTOq2alqaLX76pfCG5XsDjdkl7UTVLxghG23eY68zd
         FiOOklSR5kiu7FuHo8JMLauA3BsimFvVIQgFoDG2U8nswXX9TsEPoJLtBTF3MHrGJZy1
         cXdg==
X-Gm-Message-State: AOJu0Yxe9Zt/qrfhLX3PDpmX4Yi+omEaDQng7mVWfg93EE/c5Rlb9Rlz
	s1uQQPRxu/wAdqCefrn/Gr72xJgZrjwzk/psgkyormaiseuJS3iX
X-Google-Smtp-Source: AGHT+IGvpmKs9/mfmPUkr/W3IRXOB/PX4g3TCkNnfbnDeQ4REtbj408dyIcPpxU6UxsT304yDwEUSg==
X-Received: by 2002:a05:6a20:e117:b0:19e:3373:d726 with SMTP id kr23-20020a056a20e11700b0019e3373d726mr7904207pzb.2.1707141291463;
        Mon, 05 Feb 2024 05:54:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVxzqLBig94psI5YkJIkSai/nTpU/RgYd8pSaveuWqr8lRZhI0Zg2WPwJv69LLUC1Mj8dYFaLb8/fVwvK91Lxc+c9gFdFzoBHJSeRmSTnaU3JUFmLmdOKdOqQIxWs/skYizBhRJKhW9eGpO+C90+CXj3bD30Nnc1K52EdT2c0WL66aiDFTFaqWbWfIXjdDIBkFlAx8gpNwUHtD3Uq/Qwe3nTEfQYCtPkVx3CyLmPUt52hXoG3hoD7GMpz3veTyJc39e5CkPrlTIPB2U4cYNNvBuh3gKxWg2F5vJeNnHfIO7+a/jGsa0mcu0XSGu/uIlwQ==
Received: from [192.168.54.105] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id x18-20020a634a12000000b005d64d09acffsm6929232pga.72.2024.02.05.05.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 05:54:51 -0800 (PST)
Message-ID: <db41f2bc-05ac-40ca-b007-de607dc3886e@gmail.com>
Date: Mon, 5 Feb 2024 10:54:46 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: stop using ptr_metadata feature
Content-Language: en-US
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240205091842.2858516-1-aliceryhl@google.com>
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20240205091842.2858516-1-aliceryhl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/5/24 06:18, Alice Ryhl wrote:
> The `byte_sub` method was stabilized in Rust 1.75.0. By using that
> method, we no longer need the unstable `ptr_metadata` feature for
> implementing `Arc::from_raw`.
> 
> This brings us one step closer towards not using unstable compiler
> features.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

