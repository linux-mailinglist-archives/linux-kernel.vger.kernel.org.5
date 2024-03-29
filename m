Return-Path: <linux-kernel+bounces-123928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA64890FE0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45A7B1C252B3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C88D1173F;
	Fri, 29 Mar 2024 00:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnSq8QSf"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A710A920;
	Fri, 29 Mar 2024 00:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711673649; cv=none; b=q2yk6zhXtQpcPqfR/iQSl+JWo9imDhH3NrKgqbnGJKYgEkWQXRZH7OKrZ31U7cMzo17/A3ojJX1kZ5gb339x+ZPlxDZF4riPydAIibDKA/0oR2wL4EUNsBBOtq/AHsCNMmhTD1IA0z4RnXxHz9z24sqRe8ZqktnVvOe7K+9qEU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711673649; c=relaxed/simple;
	bh=ha+IHRghmbAVHSvcjd0HLzolZG/4JiB44D53GUrh8og=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aVSV3x9hnHAYWlij8xcserM4OzAFoFlj8VKkncciKPEfaxfLw3XJYCBP/P80EKq+r6dtsRFigRVond39YktZmpV8uf921fTT7Ryb0h9LLpbd+TYU3YfEX7jPO8KMVZPKCI3BMYz0U8WtH4Wrmfvrn8zIr3cZln/Me7sR26d6jlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnSq8QSf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1def81ee762so3425165ad.0;
        Thu, 28 Mar 2024 17:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711673648; x=1712278448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V6Z90te2upQq9sDfDoIBzJzmTKxSiCcWRlQTQbXGLBM=;
        b=gnSq8QSfjiMpBCnqbSPOrfeAMqz7+rZ2mX/1Au2KQ1JTknULFzZfzALHD/XZ54hWaa
         7QCAtwT04eNOuX9azcb9Zqls5uPcKhbbLs3UV5Iwr1W4U2SClA/7EgseEFFgooekMx3K
         596ynBefB+pHISCkNYanv/d9Jy7xaYgpQHphUnym4P3DTpnbhsZv0nsGmrfBu0apC1Dk
         Dqu32bhspC+uBvUAN3vjbM/RjStg/RisEHBr9sPR5F4SgppIx1kJpPlxk+Zx2tnPa0b1
         ZgsFOocYNYRdWLpbCK7O7Og+yD1+URN4TTdGasFI2vWSwZct0pT8n+gOV/IOm3Ol8FXV
         dvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711673648; x=1712278448;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V6Z90te2upQq9sDfDoIBzJzmTKxSiCcWRlQTQbXGLBM=;
        b=oLZfVSMvA2XAolVM5MAgaOd18T4ZnQQ1VTk3E3hcqvlflj1OiRdJTUZBEJ2GpWLvQr
         Y2THDFV3SWUEKGCvfb4Jw6NbCf6E3jLsSVYyRPJyZAPXm4K2bE+HFIRoLtO2LtafAdgH
         /tWC4MtZwdYLAyt/YzD3LZHY6tcvDY/LzEZ5EWNAQGPvDciqDp5AftZ8VmxucPYNB4qr
         90AZTlg4tKhmxzCwme9pP70jOG5mF3kCfBO9aXpEUK/togw4Bv3J5EtjAtMUB+yVmsNB
         0aVYR4g8AQGCNYNIF5M9QvMh43GAaeCU3SF7Z3OEwQJPSul9xVZI+xT5H+Zqflhd8E47
         CJZA==
X-Forwarded-Encrypted: i=1; AJvYcCXMAgy58JyOAbDjxScAT4hhqNZqLD8glEQHBh4jfEibVLSfG2pJcf1VxbeFi6FNTGCgO/9aEotbsZ9YVEKVG1Y6F0NoXl/3/9UVvQJrcAljDo24+zir7nGJYeALi6jIRWVCxWFB
X-Gm-Message-State: AOJu0Yxbz8qxeIWcTEQWlS5AaLc4OHMD0GgDtiaTLz2LAMYehD45gTBi
	dpDyWB6+aRZ/GezKRzUKY1MqUvs+3LinCGMQZHDckdNG6OPd1n0J
X-Google-Smtp-Source: AGHT+IEAOaM11FjDkEs4q9ICaVo9MrNcaHs709SammXWmp+vHQYZAxADnYGWldFyt+DhtKffjciASQ==
X-Received: by 2002:a17:903:503:b0:1db:ce31:96b1 with SMTP id jn3-20020a170903050300b001dbce3196b1mr1071512plb.6.1711673647644;
        Thu, 28 Mar 2024 17:54:07 -0700 (PDT)
Received: from localhost (p4309189-ipxg22801hodogaya.kanagawa.ocn.ne.jp. [153.172.233.189])
        by smtp.gmail.com with ESMTPSA id w4-20020a1709029a8400b001d8f111804asm2266659plp.113.2024.03.28.17.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 17:54:07 -0700 (PDT)
Date: Fri, 29 Mar 2024 00:53:52 +0000 (UTC)
Message-Id: <20240329.005352.498033770146111357.fujita.tomonori@gmail.com>
To: wedsonaf@gmail.com
Cc: rust-for-linux@vger.kernel.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com,
 aliceryhl@google.com, linux-kernel@vger.kernel.org,
 walmeida@microsoft.com, fujita.tomonori@gmail.com, tmgross@umich.edu,
 netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/5] rust: phy: implement `Send` for `Registration`
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20240328195457.225001-2-wedsonaf@gmail.com>
References: <20240328195457.225001-1-wedsonaf@gmail.com>
	<20240328195457.225001-2-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

On Thu, 28 Mar 2024 16:54:53 -0300
Wedson Almeida Filho <wedsonaf@gmail.com> wrote:

> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> In preparation for requiring `Send` for `Module` implementations in the
> next patch.
> 
> Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Cc: Trevor Gross <tmgross@umich.edu>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>  rust/kernel/net/phy.rs | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> index 96e09c6e8530..265d0e1c1371 100644
> --- a/rust/kernel/net/phy.rs
> +++ b/rust/kernel/net/phy.rs
> @@ -640,6 +640,10 @@ pub struct Registration {
>      drivers: Pin<&'static mut [DriverVTable]>,
>  }
>  
> +// SAFETY: The only action allowed in a `Registration` instance is dropping it, which is safe to do
> +// from any thread because `phy_drivers_unregister` can be called from any thread context.
> +unsafe impl Send for Registration {}
> +
>  impl Registration {
>      /// Registers a PHY driver.
>      pub fn register(

After the following discussion, I dropped Send for Registration:

https://lore.kernel.org/netdev/8f476b7c-4647-457b-ab45-d6a979da4e78@lunn.ch/T/

If you guys think that Send can be added here, it's fine by me.


Once this In-place module series are merged, I'll revisit the phy
module initialization to remove `static mut DRIVERS`.

