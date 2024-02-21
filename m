Return-Path: <linux-kernel+bounces-74154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 865ED85D08D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B0F61F24518
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FFB2E400;
	Wed, 21 Feb 2024 06:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hXMmRKNK"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB71A35
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708497559; cv=none; b=m4LqLU9y96NZeaXdM4WWKYUTbb3fIX0iHAUbSC9VwxWGawDhtrW2N5i4TsPO8PZLwx0vpPopPbWZErFb191YkMcJN/Pv/GYvmpBtIgB2rMx5DanifpVjP4L8g9omr473FoBxtv7ztyUBLFn1XbEls2kWOKRBfWuPjHz3hKuARB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708497559; c=relaxed/simple;
	bh=f0HDwa1vf5SRBb3ZPUrzmRhDIF3eBxQOxuTRSxuw4UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRe4agxVoi99nvWvYAkzSf7ckzEMfvRA6Yn1yJwO18jKEkdz5BjYOTrs8jChwAAYau1e/hp0CXm0LpfjKHk/DMW66NFpmO64/cqmfcfKCupIcdwPbcGcGy86H+dhpdPvzoYFdAOCYohBHELRaJRIaRrtetoJgiRL7bTMwqWSXi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hXMmRKNK; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so6716982276.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708497556; x=1709102356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C/kx0MMgzpebCxflYE7VD+ZZKlLv7LbIjirao9DRCq0=;
        b=hXMmRKNKO+o4LWqDRkIDLFmWIWac90Q7TlXzX6G0HZaryly4v0BZKVFcHIF+MHE+zc
         4qj0+Ansbrxd0xUPKBPV+x5sAdpJsOz+iW70xaxxbVV7++cqMp8HD9RxcixWNHGBkhvV
         aJwKnK/kzobZWD/e6ofJ4aza19zs6jh2ZDdCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708497556; x=1709102356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/kx0MMgzpebCxflYE7VD+ZZKlLv7LbIjirao9DRCq0=;
        b=QBblvhOqG77+pLRkfAwVr0VPrTWivqGak28PG5kYYHbPC3mf9mt/Eaa5BrhMAfj3RW
         doQCntduhmIAe/fZkEVUuF8mgkaQuNepGCbm95iMG7aaWtPyCg+GY1vybAZ5ifSXxPk5
         TbvZUCHsvibuEWhggKuhxoEu+ebyFxnKC1xAONHS/XlD7+dxP4t0pOm42CgLiVgldue+
         3MnJHRtVnXCwaYL2rqtbPcF/YHpgWevdoijqb3DoI9iB+vx3HNytKn0wGNQSA5G1u7g3
         Ek4rH9dzNpH34W4kA2bYAyYkdR1TjGqpUyCAeLv/uV8wkdzcWLUqUsUdIQKX0bhDq6L7
         o4aw==
X-Forwarded-Encrypted: i=1; AJvYcCXzEdo+jT5bxVkO3S2GWRkI1SuXwoLENIy3/ZVfIRoLtWF+swrH2EKQKeYEVFQiJOcjqtw0QVNjP+iS6CoUG9X5KYR9IfoWoMIMjJUE
X-Gm-Message-State: AOJu0Ywy4rKq2IGFXOTb4FvrUacK0TTQqiqvrP5M08m3bZxpSVfFJkYl
	W7HBjKtL6EGn5Cvyuam3Wp+U8cdFwf/VEl+xDielO9h5Ejk5rtYUOZzB+HTkqQ==
X-Google-Smtp-Source: AGHT+IEDBNlgi9fOUdqyWnl61n6BJWPOOAV7EQV0qVdwgnub+GBgpaz0jIe8FwPV8Mtvha7IwXR11Q==
X-Received: by 2002:a25:ab27:0:b0:dcb:c0ea:6abc with SMTP id u36-20020a25ab27000000b00dcbc0ea6abcmr13836899ybi.64.1708497556402;
        Tue, 20 Feb 2024 22:39:16 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i5-20020a639d05000000b005dc4829d0e1sm7729634pgd.85.2024.02.20.22.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 22:39:16 -0800 (PST)
Date: Tue, 20 Feb 2024 22:39:15 -0800
From: Kees Cook <keescook@chromium.org>
To: Russell King <linux@armlinux.org.uk>
Cc: Mark Brown <broonie@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Wang Kefeng <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Hutchings <ben@decadent.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ARM: fault: Implement copy_from_kernel_nofault_allowed()
Message-ID: <202402202235.A77C9AD@keescook>
References: <20240123011238.work.301-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123011238.work.301-kees@kernel.org>

On Mon, Jan 22, 2024 at 05:12:38PM -0800, Kees Cook wrote:
> Under PAN emulation when dumping backtraces from things like the
> LKDTM EXEC_USERSPACE test[1], a double fault (which would hang a CPU)
> would happen because of dump_instr() attempting to read a userspace
> address. Make sure copy_from_kernel_nofault() does not attempt this
> any more.
> 
> Reported-by: Mark Brown <broonie@kernel.org>
> Link: https://lore.kernel.org/all/202401181125.D48DCB4C@keescook/ [1]
> Suggested-by: "Russell King (Oracle)" <linux@armlinux.org.uk>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Wang Kefeng <wangkefeng.wang@huawei.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ben Hutchings <ben@decadent.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Russell, do you mind if I carry in my tree the 3 ARM patches I sent?
They're mostly pretty trivial, and they've been in "Incoming"[1] for 2
weeks but haven't shown up in -next yet. I'd really like them to get
some soak time, and for them to reach the v6.9 merge window in time.

Please let me know what you think. :) Thanks!

-Kees

[1] https://www.arm.linux.org.uk/developer/patches/section.php?section=0

-- 
Kees Cook

