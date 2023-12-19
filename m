Return-Path: <linux-kernel+bounces-4640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB2F818032
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1E701C231F2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056105393;
	Tue, 19 Dec 2023 03:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtd1wPkX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8D046A5;
	Tue, 19 Dec 2023 03:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7b783ee6d73so171238139f.2;
        Mon, 18 Dec 2023 19:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702956117; x=1703560917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zoV9GqduPrVGm8r75cHOkBWSja9eINizeXsgtnG0uG4=;
        b=mtd1wPkX3TgIALfsZsTc2Lwesm2b0hoqYyIUfCIKC/6U4m+zUi61bFu9/nU+5TWHgE
         LfQrHwQmOqz4szJk1CWnYu4C4y+Jdj3/LD6Ys4FXh4hCiv+BiTzYka1i8x1FL3EinMH1
         aRj4CY+/oJFTksA0T5bDvpcMxzr/hRpxe6yLpT5Pf0pyrGGiuxpymcoZ0NOakyC9J46A
         pKoGyAK4g6B6eHEHE8M8i5/An3UbjHkUrFwdy1UNYu+LWNE8LXYUOR+GLyFb37hGTN6V
         TCcHGqc3L991w/3eIy+LpnxaJYOa72Yck3KK+DJ/iEWskEY9cq+xQeTw5lvRsjNO/4XN
         pepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702956117; x=1703560917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoV9GqduPrVGm8r75cHOkBWSja9eINizeXsgtnG0uG4=;
        b=m5GK5wck8xJsyVu/th97gtxJ/IU4u9Yh8YF82aPqThLGpqEAJzqpmn8a2Txz8HFa6u
         VW5HbOHQLMIvsCJkmhkADhtmTBRTzaY/cjGs8KqlJ9ajSorPGt8G7fpAfUBAdl0tQ5Mq
         pajsKCgoa06qEjQ2KVVzg+hLeGG83yYv/2+QEIxg7RfO2WK//mYUhIgdN8Haxh2xJ7Lg
         rWbk9pzA2EDoWmfuJmPmLLEy7MPLyFuUm3Q49khFwDcvv7mNwoYzNs/n70ff1414SQyA
         +yj4OMM7jyzEVmoByZLwi7EXYEculElseHd4FhS5v6Vgom7H7TAaTWaLJL2X7vb36UV7
         rbzw==
X-Gm-Message-State: AOJu0YxFWXoUz1hO0XSrWV7e99D7ltSIQZ5MIGC2V9KyABrQKKyFJOD3
	znCmf1MqiXKOx1L/yh0f6xk=
X-Google-Smtp-Source: AGHT+IE2jR79j0vPZNn/aP7SsfnghxZOh1HIZ40/PouucYaYoNdNb1JkSy1KnWl1m/i12RdwOEJUxQ==
X-Received: by 2002:a05:6e02:33a0:b0:35f:a493:86bc with SMTP id bn32-20020a056e0233a000b0035fa49386bcmr6438950ilb.63.1702956117070;
        Mon, 18 Dec 2023 19:21:57 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id iw19-20020a170903045300b001d37bdc4934sm5711561plb.110.2023.12.18.19.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 19:21:56 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 7A77A10211E9D; Tue, 19 Dec 2023 10:21:53 +0700 (WIB)
Date: Tue, 19 Dec 2023 10:21:53 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/166] 6.6.8-rc1 review
Message-ID: <ZYEMUZKX9uPO7mpq@archie.me>
References: <20231218135104.927894164@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231218135104.927894164@linuxfoundation.org>

On Mon, Dec 18, 2023 at 02:49:26PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.8 release.
> There are 166 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara

