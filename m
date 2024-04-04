Return-Path: <linux-kernel+bounces-132116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C9B898FD0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5710B26011
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8A813AA3F;
	Thu,  4 Apr 2024 20:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGqnXMba"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EAE13A86C;
	Thu,  4 Apr 2024 20:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712263999; cv=none; b=WRql5aKHfpJFzOQn+vRYpaWJUlp+eAoMhAJmT1+IPFgKTRdcywKhZ+fpAkPN3Cbka9NOlhRnz27cIU3JbxSY3BTNaR7AySlFwrwsLU14yRXCrPowyIq0Roz7P8Z3bQToT3mK/z9otUQvt4KBQOqrtpNyIYdzKUP+4v4HvjZdmHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712263999; c=relaxed/simple;
	bh=79EbGGcMilIPSFWp29qONSiDSrfGUrEeUc5MeNDPoss=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=u++qNWh5LmIPw1MqbhceThRngjhESnJTzl28pd7Wk8clFuiQc3hVIGlJCWaNXMSZHEHkY/MmzCjM1H0YMJLBbcKoR8woFbJmXsrrBA6MhneeGcRO9bmoTRWDcvJw0M/YmgoxvO7kjwgesgJOZ/UlHANg1+9hRdzeFfqz/X8djq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGqnXMba; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4156c4fe401so10037945e9.1;
        Thu, 04 Apr 2024 13:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712263996; x=1712868796; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79EbGGcMilIPSFWp29qONSiDSrfGUrEeUc5MeNDPoss=;
        b=kGqnXMbaocCs6wVledVZABnzJsxs2ojoMARSkqL5Wbx/6nOv7HHT0TxSzgBra3P5tV
         9L2O7JSYOzyq3XNhvOPFJ+4Bg0Yr+496fOVFm38202JdEtfD7v2T+IloempSaUv1SNQ9
         ZQ6QD91MpZKWke3fUIQVhYEEzhkzaQiNIpqLy6wuFHzU7dkrL9I8Rvmp5N1tc96QQZgu
         XyoCNI2xmQ8n80TQIKxpyMbhyp5NF9Nr+Dqn4Ji1bSDLhO5fa+CCg/WEJhSOJnHjHKai
         p01Co6KA0GYW1A1i9XhEJLVOZzoTX2ZE2e52zKS2hGRONDq0sOBm4sblYw++LH/x4dXY
         Ar6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712263996; x=1712868796;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=79EbGGcMilIPSFWp29qONSiDSrfGUrEeUc5MeNDPoss=;
        b=CncsOfOiXTY0rA4g76StvJUlWHRYu1IzhTojLP+Bq1nAYYVFsQnPISsF74hxgFd4Gk
         4ITxTrVfDc8x0ExsiL1dLk0qvxCB7Gty1VPoGO7pz4qlXeNOXl6kzsDwSujqo0fdFJAN
         eWGcQ99yqH0kIK5nyhsajIYECq66RV+p+uCLWgHGmkdumoEr+8jYVxyvmOeEarjso+EQ
         I+PIDxRHjlhxrJYBnB7rJJeMrn4Kt6rcWXs8FZfEvxw/IY3nIat5M1uBvp4KZe+//DLN
         1ydB+9c/ehsSc/x2HUZc6DfWmiGbQbD9R725APyq6z8RAEvMHKwAoAuW2JoXCdZaXmC7
         n7Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWxLBtAvzV9nlA9HmhHGvqJkxMA+Cmu2xM2mFpNJNFhd9sFb++FzviML350uAgDjcEDCsI1d2EKDBVCPlGzsDVxKQ/0J4VaDW7qPxyE9XNR/UG18KpCvUwNjMqJjNqUYqIZLHQ0
X-Gm-Message-State: AOJu0YwFUtkae2DnCqf829ANSD1Ekk1jocFjeBj2ARByTgDllnDJmP13
	P3r3jC5vP37URkVPxI1MAukTL3GwdaKdG1r4zgktqEjXN9zcVnx+
X-Google-Smtp-Source: AGHT+IEz0MnSXgExH1bvoYeVVs1IxxSUCB11rweGGLoFJ3aCI11XeUPgIPCwmdiqJEw+LLUaht8XmQ==
X-Received: by 2002:a1c:4b0f:0:b0:414:809f:8ff8 with SMTP id y15-20020a1c4b0f000000b00414809f8ff8mr3053112wma.12.1712263996341;
        Thu, 04 Apr 2024 13:53:16 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id u12-20020a05600c19cc00b0041469869d11sm3867506wmq.47.2024.04.04.13.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 13:53:15 -0700 (PDT)
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
To: Jason Gunthorpe <jgg@nvidia.com>, Andrew Lunn <andrew@lunn.ch>
Cc: David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christoph Hellwig <hch@infradead.org>, Saeed Mahameed <saeed@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Leon Romanovsky <leonro@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
 Itay Avraham <itayavr@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Aron Silverton <aron.silverton@oracle.com>, linux-kernel@vger.kernel.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>
 <Zf2n02q0GevGdS-Z@C02YVCJELVCG> <20240322135826.1c4655e2@kernel.org>
 <e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
 <20240322154027.5555780a@kernel.org>
 <1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
 <0ea32dd4-f408-5870-77eb-f18899f1ad44@gmail.com>
 <20240402184055.GP946323@nvidia.com>
 <83025203-fefb-d828-724d-259e5df7c1b2@gmail.com>
 <b8f2f824-e8da-4767-a378-b20bc42d4e8f@lunn.ch>
 <20240404202536.GN1723999@nvidia.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <f1110157-868e-3e2f-6593-6a219ac5e96b@gmail.com>
Date: Thu, 4 Apr 2024 21:53:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240404202536.GN1723999@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 04/04/2024 21:25, Jason Gunthorpe wrote:
> For instance there is a bunch that configure the UEFI option
> rom. Various devices can PXE boot, iSCSI boot and so on.

Sounds like a perfect example of something that should have a
 standardised cross-vendor configuration mechanism, rather than
 every vendor having its own special tool as is sadly the case
 today.

