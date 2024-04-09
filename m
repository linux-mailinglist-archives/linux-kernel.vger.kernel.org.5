Return-Path: <linux-kernel+bounces-137224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D049189DF24
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F223D28B327
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1497013790B;
	Tue,  9 Apr 2024 15:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vgGlZyeP"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F59135A63
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676459; cv=none; b=S+D4TfUX8/V0L7ZizlwodTyFDuPywGVsDTycn/ZX4Y9BbY+8qQFrk4zHSYY3PaXo8QZ6ElpH2DAKBQBbAliB7XujOQywCz79xn3M13CDdzrogOnwTR5NlszdwgmmNTGJE460MWkmxPwfXht0frsLQ26x7L/ypjtmhRwBLeUm9oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676459; c=relaxed/simple;
	bh=dexzRqm21eeJSqWAVRHkad4KsYnd/kRt9kFG5xKBSjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hp9o19V5hSoP0CQF+ZWcgKLsk2HuGpM2+IYZWUE8W9atEi8REhhDdJPufoB7aSvhF5s22Ug5WvTG6dFsIiL9P6QiQZdoJxt7StAXx9+zQ6fxxefVD3FbUBbDUKgct3qnkRjyD3xKfBi8zP/Crpj1Db0ONrVzPqq6vjyz0VJM1Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vgGlZyeP; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-ddda842c399so5909962276.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 08:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712676457; x=1713281257; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HzNV5FXSliq8ZbIpw2zckFkXIRHoYFy5vQtp+aDf1/U=;
        b=vgGlZyePf8/N/SgxdlIuCMyh4udeQBpKLbEMjU5P6/iVGosShArql+UeLTBWQ49eHI
         LxAC9+VpyuClbcf8i9/vAk+pdipbvzUlhD2PEnANbOn96moZbqozvY7G5GHC5HEivAAM
         /lmJpvyLqyBZpBST3V4ktcetevk6iNBHLJpjI0XxAcBT0xp/u+wg60scmqJQ6ouxUVwR
         Xx0lTDFE7Qb6r7Lo2vWSmTTSPgfPRxnvw61Vy198ber6kKr1f04VrwvLxltZYepFeagP
         rBuhTtOwEgBNog7kobVax/qA7qeE5YMbxKgjNi524IzpaJb5sF3rt7BHbHG6Z0zRAs5S
         fioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712676457; x=1713281257;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HzNV5FXSliq8ZbIpw2zckFkXIRHoYFy5vQtp+aDf1/U=;
        b=tIGY6WdZ5peKXxmj3e/lYmLRAL9N5uxo7oKTRktoeCpN42bJcBwlNFeFNBTJMRRTc4
         djZMvjftzlK0KhsP7f5+poMwCDRwYnT16j2Lj4kCE6umhrD+E399j2b0ltEkGBDkZ9gj
         4r7yD5sGBAIgZFYvaMxufqFsZtrrphVSoBLF0vxb/Yz71cLoQBcH5GTk/uhah1dF/JE0
         6p6XWUioxAShk4lgauZhx8THa10ITW5yONX7rVHSpBt93a3VkUNCLCuw36NC2wYnSZpc
         8Ze2I0jxhT6YcW56RjkJJBvlbpuSJQtg4rdv6ANam4hIANdG/o44ZX/0Y2ck342cwpk0
         miSw==
X-Forwarded-Encrypted: i=1; AJvYcCX/7+yMFEhMFX0iZlxt8HD3aCw+uo6BdoJpxa55fcAZRzNdYBk9Op7MLsjUdEjCthj8WMFoAtvpQAgDJfyQ4AmOFUxMkflj1wbe9RqW
X-Gm-Message-State: AOJu0YwyIs/uNN1GlnlVCVmbJEf5rExYP3jSqQU2O7QfjdyjWATKe3DA
	vG1MESVQ3aIOwnnFqn9w7Y5sKVnwMqJUr02hnYwaQrn4PmWo1QBiOvsN2cCMr2o4U38c/wqfa2z
	X3P28SBmDIhaY+zXxiTvABJQxkRiDJRgREkPlgA==
X-Google-Smtp-Source: AGHT+IE6d+60UNgeFMm8vHhr5l4B78x85SmxpGyUIJbum81B9311rsAC2C/7nGWn32Skid9DOoxXv6B6TSLMxqYReBU=
X-Received: by 2002:a25:8005:0:b0:dcd:5187:a032 with SMTP id
 m5-20020a258005000000b00dcd5187a032mr66301ybk.43.1712676456879; Tue, 09 Apr
 2024 08:27:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408125309.280181634@linuxfoundation.org> <CADYN=9KoZSBy_sbKR9ZTzcUXuUgA+PwdhAMuA5BEHP-BHjdnNg@mail.gmail.com>
 <yq1cyqyo9o3.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1cyqyo9o3.fsf@ca-mkp.ca.oracle.com>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Tue, 9 Apr 2024 17:27:25 +0200
Message-ID: <CADYN=9+Ms-g6gJd43NKDTy9Sg1=P4x7Mv3FB7tL0cL-Bhw5Ayw@mail.gmail.com>
Subject: Re: [PATCH 6.8 000/273] 6.8.5-rc1 review
To: "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, bvanassche@acm.org, Alexander@wetzel-home.de
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Apr 2024 at 17:12, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Anders,

Martin,

>
> > Reverted this patch and I couldn't see the repoted warning.
> > scsi: sg: Avoid sg device teardown race
> > [ Upstream commit 27f58c04a8f438078583041468ec60597841284d ]
>
> Fix is here:
>
>   https://git.kernel.org/mkp/scsi/c/d4e655c49f47

By cherry picking the proposed patch
d4e655c49f47 ("scsi: sg: Avoid race in error handling & drop bogus warn")
onto v6.6.26-rc1 I couldn't see the reported warning.

I also tried to cherry pick it to v6.8.5-rc1 and I didn't see the
repoted warning.

Cheers,
Anders

