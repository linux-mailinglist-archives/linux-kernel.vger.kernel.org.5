Return-Path: <linux-kernel+bounces-43663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE6C84175C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CF3DB22FA8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2E210942;
	Tue, 30 Jan 2024 00:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WB3a4FKE"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C05EC9;
	Tue, 30 Jan 2024 00:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706573601; cv=none; b=t4Yicm5gKCC29fyVthKrqAmc2yKXXwy9Dbiyoq8JYeAggvlXogNcUyx2fNqgvt23yPlmp3pLfMyvP+PkVOJxJrlP81mFR7DOM8cIyBk9SNn5/FtaiZ3Qrsh6hXgGvOv2IGdYJ0qQ885sO6TsAaKBfKN8KaDzQ7+okrdld9T2TL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706573601; c=relaxed/simple;
	bh=QyHmVHAC+TVUo1czRElW+MEYu+2WhF/0iDIr7Kq9EB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t2nttRFHwad6x1lnOeALNtvu2vO+TOC6KyivoRdJ7N/1vewO8PEWaBtdV7neCepM/xaHSVwe7XGbtWlhlkkQPQD14/+wajbvIz1ThX4fnrTI7qiI9OdXDI6oXfnWOKleTRAcqbIYt17naiA6oYvSsRceVtauPxgd7oyxBbAdbWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WB3a4FKE; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7d2e16b552dso1569011241.1;
        Mon, 29 Jan 2024 16:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706573598; x=1707178398; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/fWsHVtzrmK6enBrWP1Xfl/r1UntvZqZVjVd83aREbo=;
        b=WB3a4FKEk1jwVLdBhgVIRhfcBwEdYpp/aEytiZXwhT/kZ0lyjrNIe8ajZSBeLkkd2n
         cqsLEPG2PKncMwVnNLXkXDWFJJDd0M2ugzcsIAmHki96R8vZfCAf7tBJRIfMnaIrN6sG
         dImLn8WsJsskDrm6GUtmO37Ohh0Lr+Kjkg/Tdn4/pJH+8csCm+KL7Saa+SUKzC+ym+UE
         tPvxSk33CjaZwd8VBQjThqiMAaDM2sryEySKa9byObhgK75BMM1ZXt80+GQtlv1czV0o
         HYSEezqNJYi4PpifQ4HesT9KxNTA7EPsNvKDtPzXnL9xNQ0E+m8u8eKz6ghIcC2vaUZC
         ATIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706573598; x=1707178398;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/fWsHVtzrmK6enBrWP1Xfl/r1UntvZqZVjVd83aREbo=;
        b=MwUs3KebiNCUo+6tCvNsqKkG18bJEH0PjLF7K6MwLeQ24N1IqsPHKJNbkYA/UtiJ7a
         43TkSqDghYUqEVjVUH+MOzRPpftjm22EMshE6xQ/qZw9LWgAgob446eBNS8G3no0BoCR
         fBGOOu3sEjgOdClqBHVuWBkTxUQeUsPDo/OPCIW+3LS5ImtZsaBfvrS86lk+rQqISkcJ
         1IKSXAcGoQWT+dhDHsXcSOjJZ7vt6jLqjxqzG9q4i6UEIITA8dsdOO3gr38mI4sD5WJO
         YsgtjxCamO7c7H47DwBT0dJ9aW4z1V35FXZlahkSZcCYoL4k13kB1IdpJ89XQXo3W+VB
         tmig==
X-Gm-Message-State: AOJu0YyhZkDaSiRmZYLDOZKI3DutcFW6DCvX2XOsT8YlbVkW03qKdGXO
	iSfoVT8+0kuTrvfhDb2BNBdmMHifbO/2VEg4utzPj4sDa5fRISGTQVv4QQGAnjPzvd78zUEySGk
	0FJan4lfk7w8EtHk6C3+8If7Ntzc=
X-Google-Smtp-Source: AGHT+IH+1Y1YR5slTxNiShlCdeINyqEd3o3AwvXiOlyuarq/aHP544BQNXwdBe3II1geLtxR8QVLb2CAR+sB2ku7SE4=
X-Received: by 2002:a05:6102:a05:b0:468:2bf:6a91 with SMTP id
 t5-20020a0561020a0500b0046802bf6a91mr3722735vsa.35.1706573598609; Mon, 29 Jan
 2024 16:13:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129165958.589924174@linuxfoundation.org>
In-Reply-To: <20240129165958.589924174@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Mon, 29 Jan 2024 16:13:07 -0800
Message-ID: <CAOMdWSKCKXW5ho5PrRmMQJh_qk0hsSt=S7qSBS6pWZ3hrCfV=Q@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/185] 6.1.76-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.1.76 release.
> There are 185 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 31 Jan 2024 16:59:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.76-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

