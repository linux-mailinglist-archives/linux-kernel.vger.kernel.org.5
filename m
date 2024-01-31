Return-Path: <linux-kernel+bounces-45561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F0F843269
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66457289B63
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C83E7EF0F;
	Wed, 31 Jan 2024 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cdUAI+zP"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D5826AE4
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706662829; cv=none; b=lMEOW840Fo7litx0IYmeM1JcF2W4PXPtgazpOWmie5MXaK4Vj+d4LZoIBxEkGZmibpfbkbou+jBXAYUPwWKD+m1zyIxxZl+Fo0NLFUfEx2XazUQ6d0gmH/Fcl8lyq/3DE1Ujv/AIlKOXZ83HZuxAbdgh4X1aLrVfm017mVzJ2kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706662829; c=relaxed/simple;
	bh=M2m2EaZ+9NFvyeLuSQwqejAbGxKoskBFusmjz1XzU/w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=miOtLZ9njZZOqCTihZh/fzIdkJ8YGk8Eqs4t2tg7jyCQ383aHvL6D2ehaXddnfBTBsL71SZMm7aeOqirVEM2cI9OxxMC7+sYCup6jF1+AvTVjaXvwWswZX6ck175fmAiaQMIyBW4UtRGyc1zo1s5Z2jvovkHNy813A54ASBrZG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cdUAI+zP; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b269b172so514994276.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 17:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706662827; x=1707267627; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LbsDkXJuyzJxRYJgMytBqEAoItpNg8kmvZ5iaWrBezY=;
        b=cdUAI+zPb9Vy2pksG8Qd7wBbeMQGmz00sek8U+XqsaxK+F0zOA++i6UDhKsVYbXIzp
         WZzuPTxl+5DMrad7UFAa2aIRIip5Ce/bvbceahgrdwY9w/dt/tBRDJ0yHBNUJ0pFeXOZ
         HcrSkVrJNnccpPsJEz7bFrrsu1kXCR6ZqKoNqjZzRoqof+hhj48h6USC3hA3oXIqg1Sh
         WTEfVp8Pzt4AjBceAyIeoF5rUtRNAXWKjKX+Qvc+dsctcW/84zlswJsZXSXtS4mhtEJ7
         IUHkNdwAV6FqIoCPEad/wqxbhgalEQ59ijxA2auoiykB+2KjI4F7BNLjGwHd2k6vQhkO
         Hz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706662827; x=1707267627;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LbsDkXJuyzJxRYJgMytBqEAoItpNg8kmvZ5iaWrBezY=;
        b=JridWjGVErPNry4XFF1xIp5+kY3IumsbKtXj9eQHBNKu3Jt8WvU4p5XzPBR6QpxKV7
         fwqiqHqwyggFcDYFLdbNv55knGVb4UK4GQBL3cqFdA8q/e93RST7j8rLAWH0AdB+C88E
         li0+Mnna1vQWaU5n4W0MxSDDDIT5fPGri/yGDRS/aMthXh9sVljEUUDFx/4bzUfTH9lL
         B7IJKNThaPhu1xBw3cMJ19t0eWdtv0FGcY/Ivia12mWgq9ruwLZsuqZPKwTD0gDj8C4Y
         vPJMZhP7Lh95EPFJRLG+ecwe+5agZrOxmtxM09gIVxxqSSIGiV9ttSamPhw0jMIILhn9
         CPoA==
X-Gm-Message-State: AOJu0YwzUjwr1cGWR/ZqNUFb7Djk0sqcHJd/G7FA2IWHV14yPJqirK0J
	/XP1LFPGRj1H184wpXrgFu266WpfNNdSx2gv7mMt9kIxMTiBjmr7toBX7eqvD7Aq4f4UwR2kYlb
	C4A==
X-Google-Smtp-Source: AGHT+IEcJONh5VDgZXwOu8LR7Hpe3rHFqJT8zDReRvglswNuSMXYt8ETOvJ36uwnDabQ6VhXABO8k1kOICo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:dc2:b0:dbf:62da:11ba with SMTP id
 de2-20020a0569020dc200b00dbf62da11bamr565339ybb.5.1706662827411; Tue, 30 Jan
 2024 17:00:27 -0800 (PST)
Date: Tue, 30 Jan 2024 16:59:25 -0800
In-Reply-To: <20231129224042.530798-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231129224042.530798-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <170629076246.3095338.13348438934778239969.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: Reword the NX hugepage test's skip
 message to be more helpful
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, 29 Nov 2023 14:40:41 -0800, Sean Christopherson wrote:
> Rework the NX hugepage test's skip message regarding the magic token to
> provide all of the necessary magic, and to very explicitly recommended
> using the wrapper shell script.
> 
> Opportunistically remove an overzealous newline; splitting the
> recommendation message across two lines of ~45 characters makes it much
> harder to read than running out a single line to 98 characters.
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: Reword the NX hugepage test's skip message to be more helpful
      https://github.com/kvm-x86/linux/commit/02add85a9eef

--
https://github.com/kvm-x86/linux/tree/next

