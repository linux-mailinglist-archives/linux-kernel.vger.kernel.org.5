Return-Path: <linux-kernel+bounces-35770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A6A839643
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37EA21F22385
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6E37FBC8;
	Tue, 23 Jan 2024 17:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hd3TQznf"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1444E7F7DE;
	Tue, 23 Jan 2024 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706030594; cv=none; b=gcv4geG33jRSO2KffXrlGDx8WoVLRFHN9vTN+0RbV2eGbCMO6PUXdcrtk4tVevLlNZm3hEvZUUGeOwYGRZEPBzSFz/UguAlpipGTR9GWjftWEsopQosP+MwCmmoTRHavEFqsNzTyH6qu+xEOyLcRjR33NecEjiC70l4xdLiWeSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706030594; c=relaxed/simple;
	bh=VjOCCRvjZlcp3HeswXG7ccqi11RQB5jbqUpjgpCOhJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mSNQH9bSsLV3F6wxyk5aSWPSze34Ms0lNKXxovQ7N8swVUaeS5fJrts/4XtfPxMD4Add6XRGyNfkoPXDuzQmfN/VrFzbVMwjIEmx7pB33flUYsoDOmOQLlSyrzNGztlL/Vj1eiC2q7k1jisCpobN8WDuopiaFzvwO2b/RY7vKTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hd3TQznf; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-466fb179334so1043965137.1;
        Tue, 23 Jan 2024 09:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706030592; x=1706635392; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6xcKiR/+YbtLA6pfdjopUwXRfL0HZKEeurjCoSWtgW0=;
        b=Hd3TQznfcMl1x5aCBOaDnxFTeTXKitPy3f/KxBsjB1lSXdUJ2wZH5f29xG4Vg1zm/j
         x24qfPXTgA9/DPTZSBf+IQDoHPxs9uub3Ryten+4/yB9Rk5t4bGB5IYCQgmWCw8sJgR8
         9/UuBsofTbS1qUzWJWBkq8CL5rkrB+POa+Oht6EKSdvwuaDeLMkefqvRtQDEgmwgApPq
         4IXvrHPgki9MyxjW4/LQ7OUBvPLTyIjKXMJec6q4sA0/AUigUgAAofpgv+IdAzzDUdCJ
         atHyZKySPmPqmJwSPKI1njc30N2Fj4tctwJYSMWcexCi3i4CpW6z2fNG0WMootUuOPnx
         tiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706030592; x=1706635392;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6xcKiR/+YbtLA6pfdjopUwXRfL0HZKEeurjCoSWtgW0=;
        b=dKROVlcMfapiai6noylpX6N4qMYilZ+o1ZMe3rTeU+Dsz03DQ/PE9uXwfkhK5c/mxS
         L638qqU+HIFfrDd69o75iy+ys4RnxRkwvit8fwS9wNDrCYLC+fUSfT7fUY/pYn4yO9K7
         0uuLLzxVoqqMoBlyNINMuOGWIupvBuqMmLTX7GfO4TK9uPfdRIKVhC3tgZJd+jF107vv
         l7tXX9nVeuv8G/3kjtfTzTmMl9B2J7ESbWZhin2Xy+xhkrJxkvJisun4lvnx39h6LIkx
         8YAjtn/+8Rth03jP4vRyYXQ2oIEPl9AP7Icr+9pnTQCmIrNK1IJkrz9uL3fRRIgsKdOk
         YaVQ==
X-Gm-Message-State: AOJu0YwOtpBv1W01vY/8Ex4RFBQuPENEYZUeLsTujwdeNLzNKBFE+Vgu
	aM3Oo/GZtO2dyyBCe7eUY2dm2E3p1A4bH4+vkhWuFOX2Et/UEfO47kCYx7Ts9L7DCJYACf6wkfg
	RAyI0tN5mI0HoSbFjvX3engG6RaI=
X-Google-Smtp-Source: AGHT+IHjgo3cj9PLdsHSv0ggSy4V8ICI051ObNLrpQ237v0h/6xIeo/EGJSigc7wW4w2VNylO9y3DQOcCC238V/AJu0=
X-Received: by 2002:a05:6102:52a:b0:469:4f37:8a10 with SMTP id
 m10-20020a056102052a00b004694f378a10mr3397622vsa.11.1706030591931; Tue, 23
 Jan 2024 09:23:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122235812.238724226@linuxfoundation.org>
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Tue, 23 Jan 2024 09:23:00 -0800
Message-ID: <CAOMdWSKRaYnYDf4Jgf0fsBXhCfhuf1Jnj3S3Vd59TsQKw-35CA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/583] 6.6.14-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.6.14 release.
> There are 583 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 24 Jan 2024 23:56:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.14-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

