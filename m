Return-Path: <linux-kernel+bounces-83878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C20D7869FEB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC5EEB2AA80
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C50651021;
	Tue, 27 Feb 2024 19:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXknHBeE"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C924151C34;
	Tue, 27 Feb 2024 19:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060424; cv=none; b=tb/iRCYQQJA1HKjLsTHp9bc4kaGfdpjJpFy+PDfI+GKm38jYR+GJEQEAE63EmBWaGR6xz3kqRMhM3UacqdnopNUKJOElrykEAYPLgkEmYbfcJ1XBrviRg2nKIKtVvLhzWMccgFZ0sWNGJWSB0Rs4vox0SIuIg373qpDdNfG3FLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060424; c=relaxed/simple;
	bh=yb4ZJgAhsQwDK7J4UE4iqKXCKtDiJ2GpqwQ8bXVuM1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J9ogKcvqfAeDZqxPIvHJRdDl8iaAgfMkuOup/E3r5KXDX4LYG2dgYCGtZHEZdBvdDlonMSuQ9OY0OVsYh01AWe5+j27ebT5vN9nBNWZj8ZlVnNU/5h8QnioUgLQ/qw/JwRu90FWwknRsqgyzzAJdygu123+/aDEOlh7Gh0iOCQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXknHBeE; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-47265631782so64554137.0;
        Tue, 27 Feb 2024 11:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709060422; x=1709665222; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9A/eIYvA6ALZ+iaMWd4UbzjIULitUS+U5SvdopkaaK0=;
        b=NXknHBeEE6LeTf7T15cbXiFI69eaq8NjOqNLKGJH/5nY7o3sOdBEp9yB3kkdjw6v7Q
         A3hy6q/Jduf8sYd5lUzU3RiSUolQ32wOxT4GzIlgRd6ToeHkHA7rHPVoTk00JQSpDz9C
         Te1/Wh8rvlkNLwZINHA/W06P6C8KECd3dmOGn5+X6xM1b+9kg0GU1kiAlEgZRHQGFREn
         Z8rUe4xLOjHtNhwJWXKIDmxoRW0sXnzC9qCxPMPZN7nYVqfafNGgzR3gV9ZS/cKSOPsS
         2MvGx2E4fdSgkrY1ZzIUmaBZrsLc3NqYHy+AwhaXvthGQGxcmGjypsyHU7cSHevydv4R
         HeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709060422; x=1709665222;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9A/eIYvA6ALZ+iaMWd4UbzjIULitUS+U5SvdopkaaK0=;
        b=nQjhORFeBzEn7v54dh/7GEy0U3lzs2QOmiRAw0QvqulNwS/EorRE3vJP0By2gCqka3
         /mTuK3DGHzsOoOD9kwY8CuXiAsdFPLL3NfQyz8RwuszzyDTnLv1Sp5ihBqEEx1I/GrGf
         VF7o+mt/xdMNfydIYQQSgVksPSFxULCp6qSGVU8sZxS9H9DN5q7aqsKdq3yPGHB+VYTn
         1V+jp5d/Ml6+fNSm+dg0BniWTObm3fdRuBLAfjuLwmto8lYGxUtCp+uKEnugdoFmVIP+
         yEkqMWCPhgKK3/p0jKcjKFnleqhEdBk0t2/1QKjDtDKehFJShetCFkIYmV/vlCQpqsnx
         SoMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkON9xzasTdkbVd5M61/Ju418zdNIKPCVZNyjkQtTa4CyrlFnVYIe8rZQEMU0kWbdDW3oLFNgL+80SZz+rwi2NWxO/X3nJHTVFU3AJ
X-Gm-Message-State: AOJu0Yzfx3sqUKi4ugStqHBxDKulipnmZrQKsjeKaCvP2FFaPx67wxLK
	Rks2InfOK+dey89HPd49F2thVaTPasRLXdW9zOsvc8fKldVRI5dcI/7dAFRGOW9nZR9xPYlA48l
	Ltu8dVmfor8/I0ZUSlgAEJLF4f+U=
X-Google-Smtp-Source: AGHT+IGYSAayHL4gQrXObG+dSg5xn81WzKhGIvJblI4551mBSqwvO66HfBdFsC9Ewqm9vM3xi+YcwPSJk4AGpT0kcTE=
X-Received: by 2002:a05:6102:3911:b0:471:f1a2:13c5 with SMTP id
 e17-20020a056102391100b00471f1a213c5mr7498683vsu.7.1709060421134; Tue, 27 Feb
 2024 11:00:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227131625.847743063@linuxfoundation.org>
In-Reply-To: <20240227131625.847743063@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Tue, 27 Feb 2024 11:00:09 -0800
Message-ID: <CAOMdWS+MHqpiVGCZDOU14SjdagLZoxxcbgg0tf8UtnSvCj5Qwg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/299] 6.6.19-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.6.19 release.
> There are 299 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.19-rc1.gz
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

