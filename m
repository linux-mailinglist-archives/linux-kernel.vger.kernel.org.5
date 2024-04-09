Return-Path: <linux-kernel+bounces-136120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAFF89D032
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431441C20D7E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7F451C45;
	Tue,  9 Apr 2024 02:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HFnE3gBV"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0031D51031
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 02:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712628192; cv=none; b=cXAO65Q6J9DTWecvGuI065HvI8rcU9f2xkZp8hn1EJaeNbI3WD3rseZGa3WBNaOCWnVLM3L9ctePZx2lM7/A0BhOs6eJX4RSKxmIZYeQXF4bXB91kBC/a2Sfwj8N3pF8WlEcWNuJ90rPU95F9hsPwZFi6bcqfcF3931dfyrBs0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712628192; c=relaxed/simple;
	bh=s6JCMHopGKvv+h6UvSK6+8Hj2XBavUOyse9O+LcG2qU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aVDX3PdwZhECNYynf2AgwuHWfcJDpZKdhOQI0LH4vrKWjlc2a8zCt9AEcBUtnybzzeMdGzUsBbHDXAkG/Hy+LyINvHJ5poE+D6zFDDMkc07IGMK2fs5kEG0YtaQmXRq31bOzxErVW/GclRGu+8Sp81EVvJEDmxxfAQzX84bATkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HFnE3gBV; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcdc3db67f0so7392506276.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 19:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712628190; x=1713232990; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+dYGiBB5WEe23eQKCk+AT9ArmcLUKHwTSwwrcv8shC4=;
        b=HFnE3gBVl/mU9wjEUWKjq/JG+yIuzC/Ep1bP4K4/4I4yGSqa7hhfcJUMxehygdlN2b
         K7oUNEOTXCQAwN2WSPdY6ApV8Urhp5QMbuHSSEfYhSzIZr+oCpHKuIX6G28fwakpi1+J
         +K4sFsRL7VelshO/Xfq5YuIOWUQt0v176Wk4Sku3Pex3NOXphjtMDBoXcV3YVumAMsvz
         DmLEMzce0FdPLGVPH8tjpcKrEUqHHFrFF6NIxxlObaKaL6Ihue9MfmjsTLUuBJ3gDYeF
         KjhTuF04jkK84hGe0tH4Mq5aofyKj8MqCVu3n1aYjqniXdAKq5IWlB8cfbq92RC5iWMB
         Gj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712628190; x=1713232990;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+dYGiBB5WEe23eQKCk+AT9ArmcLUKHwTSwwrcv8shC4=;
        b=LTagYGrgL3OY5tsCEYaI8ETHjDCe5MipEepsnGp7MP4MDr8tvbqWqOIo+FMDYsVxT5
         7VncW4pqy9PHjbzwiH0fj/Hb4nPFuYwoH7bAMyH7gEwa7nCbZoHVN8u2/n543RPBBOxo
         J8OcpJ/1Zx2OmKzwwlJpvWSHLT8GeaeVbfVbzQkCzM6PXPYP+Yz0lw88gihfz5SQENNO
         knEWITODT86ovbiS9ja3eCIGxLquJRQjmHY/M7Oof5zjA/jISIfoI884GC5BoyEHSp+p
         uS9cK/fRfBqjLwkjjarVqtj9oCc++c7H0s5MGxez0+3VZoA6IF/BysDE/rA34xiuPSzr
         SvoA==
X-Forwarded-Encrypted: i=1; AJvYcCVxCs4FZAL7NecXn79a3GyTSgWUie34vZ41CBEk+2PXVo7Sv9jSE9xc2ZYHR42J09AcHQtujPbu2s+yQ+lCjS/3IBxgV13nQtfpM17z
X-Gm-Message-State: AOJu0Yy1m34IySPJQINcxTGigwa2nGYkFA0Rp0u745vaLE98/65tLtdF
	bb5cKw8Kogj59BzP3a+0l+NySMAJiVxbBNUD9xKZWaNhTtJP364OwYCTd29Rvrp53Qu/fgy5HUL
	9SQ==
X-Google-Smtp-Source: AGHT+IHXUgDFD9+foe26N5SSBEEkmvNe2Y/m36FLIFGhNlsrXE2qb+7BnrYxDBtt06/NynQa5KXqx130Fhc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:8b88:0:b0:dc7:463a:46d2 with SMTP id
 j8-20020a258b88000000b00dc7463a46d2mr306086ybl.0.1712628190038; Mon, 08 Apr
 2024 19:03:10 -0700 (PDT)
Date: Mon,  8 Apr 2024 19:01:37 -0700
In-Reply-To: <20240307005833.827147-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307005833.827147-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <171262710736.1419672.15334456430797702599.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86/pmu: Disable support for adaptive PEBS
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Like Xu <like.xu.linux@gmail.com>, Mingwei Zhang <mizhang@google.com>, 
	Zhenyu Wang <zhenyuw@linux.intel.com>, Zhang Xiong <xiong.y.zhang@intel.com>, 
	Lv Zhiyuan <zhiyuan.lv@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="utf-8"

On Wed, 06 Mar 2024 16:58:33 -0800, Sean Christopherson wrote:
> Drop support for virtualizing adaptive PEBS, as KVM's implementation is
> architecturally broken without an obvious/easy path forward, and because
> exposing adaptive PEBS can leak host LBRs to the guest, i.e. can leak
> host kernel addresses to the guest.
> 
> Bug #1 is that KVM doesn't doesn't account for the upper 32 bits of
> IA32_FIXED_CTR_CTRL when (re)programming fixed counters, e.g
> fixed_ctrl_field() drops the upper bits, reprogram_fixed_counters()
> stores local variables as u8s and truncates the upper bits too, etc.
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: x86/pmu: Disable support for adaptive PEBS
      https://github.com/kvm-x86/linux/commit/9e985cbf2942

--
https://github.com/kvm-x86/linux/tree/next

