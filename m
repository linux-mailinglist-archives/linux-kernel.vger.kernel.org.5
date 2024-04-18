Return-Path: <linux-kernel+bounces-149347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A19F8A8FE8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C8CEB21D42
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1486E3D6D;
	Thu, 18 Apr 2024 00:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QNPOVqHK"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9874715A5
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 00:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713399317; cv=none; b=T0fBD4MyIlKpubxDjYph8L8JacAaCqcFXBxu8Hu9Sn6tGbZMi2hwmRFs02hPc8PX7vkgGlRrSnJDS6XD3z5lTw6Id6KgKYhsypoB9rhOMmF0f/GyHTgZIIQSg2z/0FKFEouksCZgiPkUstOg5u8S9T8q37ojiU6KHA2ao6zai4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713399317; c=relaxed/simple;
	bh=hyvG3v6XAKRWm3hH6ODN6kbZbNuRyM4HM33dcRdxujU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W65V7yPB+PZI+QIz7IbpFterDbiUWzx84Db5chQKfTzNXLWSfJpm7rKHuL06KXP2DVHjTIpYplOtW8Kb6/rNTnCqK08WvJCAiWvsfIDbo2U1TLwGc9UegL8YmYNWuT4uwSAhkDpmJH7akS4/OXCbM3AgSm+UV6ZmElAkhhmE9OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QNPOVqHK; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so291379a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 17:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1713399314; x=1714004114; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E+HEY7o6NmipJTF9VPab4N+W3wy3ABQnhFnH4fGACVM=;
        b=QNPOVqHKZtKRd0I9CLUYkbzzETC3erXf7309SHt9HlN5qRq4cND5ErBxL9hxebVBLs
         ggpRB75ptkwx5yE0m49ON0b6o3zVTf56fx0TsbT8Fx5R7Kwhvt30cNU2PJWHEiHwbB5i
         jENTNKNnsKeZ/pTixEs7S03kk1ec2b5fVhrxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713399314; x=1714004114;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+HEY7o6NmipJTF9VPab4N+W3wy3ABQnhFnH4fGACVM=;
        b=e5istiDqJNFJQ3Zbt2RBAdZ8Twv4AB4k86ckXl4VKrHcmI2GxR9a+u++n0unCVLWd9
         EQrTV/uevZCVz0EinNViEJEMTiB+8egDOrLDjmmYUl6hQ47pZrhWYoec5pGiI/ZgMouc
         gOaHFiQqDmvmr2DZKgdy+43vola6UU8VlcqS7DCEMls4FFG2l45V2+L4rFVTorFAFCuA
         Y3/p8rCrziInXei3Pc1CuKWc0K/dgo4EZ/MHE6ZJQFmeckm7ZdtzxlzWuG6RzcMx3t3M
         s5k/FCCEoCl3ztfcdMAAnSghg+y4xaGKp+23Gu/XsxmQ9SQHBmIxLudhufw5uZaz2j6h
         5SLA==
X-Forwarded-Encrypted: i=1; AJvYcCWbWXbt/W1xt4sV6ek62t/zI7i9kT3QKjJyZ3VfjUiTDKeEerMK21kKm1GBKunsn+vL8u5ZWP70+ysRp4RAf46gP3uRa+1K3mW8SIHr
X-Gm-Message-State: AOJu0Yyayq3X+IvqqSFBACPEXVS0EA7X2mldG/j6pjhEJhy9ZwPE4lag
	BHGnGmm4ByOnrmbuWYvEY8/ysgx33dalr0lOgydoTURVKvTPmKPCw6uDyepuFc389KQBoKBTD8C
	eG/U=
X-Google-Smtp-Source: AGHT+IF20VPIy6K/ODh1FK+vnftOA+2Gmltz3glYpZ9/UtYGqW25qiM4ttEdmLFCMaKtUZTjLYKPFg==
X-Received: by 2002:a50:8d1c:0:b0:56e:2aef:f92e with SMTP id s28-20020a508d1c000000b0056e2aeff92emr655462eds.17.1713399313719;
        Wed, 17 Apr 2024 17:15:13 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id q29-20020a50cc9d000000b0056ff4faa0b9sm197858edi.6.2024.04.17.17.15.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 17:15:13 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so291349a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 17:15:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUozO9UfTpOrmXhcEdZ5DlVtHorT5bxiR3aL11d6Rji+PGw4TqekXuzaeApMO29Pm11V3PZo6EwFBvMLG1VEpkTdPE1xTMMI+Ebb3hv
X-Received: by 2002:a17:906:32d2:b0:a51:c71b:e1df with SMTP id
 k18-20020a17090632d200b00a51c71be1dfmr570874ejk.47.1713399312874; Wed, 17 Apr
 2024 17:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713396900.git.dsterba@suse.com>
In-Reply-To: <cover.1713396900.git.dsterba@suse.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Apr 2024 17:14:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wirVv7e6r+UOe5Svjrkx-Cy_=1bNSigdYrWWwzfv_-4gA@mail.gmail.com>
Message-ID: <CAHk-=wirVv7e6r+UOe5Svjrkx-Cy_=1bNSigdYrWWwzfv_-4gA@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for 6.9-rc5
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Apr 2024 at 16:53, David Sterba <dsterba@suse.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.9-rc4-tag

Nol such tag. I see the branch 'for-6.9-rc4' with the right commit,
but not the signed tag. Forgot to push out?

               Linus

