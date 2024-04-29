Return-Path: <linux-kernel+bounces-163054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2048B644D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 716581C22052
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026B018410F;
	Mon, 29 Apr 2024 21:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d0cvUxCU"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0241B17BB1C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 21:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714424577; cv=none; b=mVUIl9C/fbG6hs6tH5EyKkCpK+zTLy9eX50MUU+zEzxpUSfOENLRRJg0F26/JRlLLd3141c+dWdF7/cwi+h4z2RNO+GWsYUrn13CjDBEiVJJ53wfAwLHKyUp13aElV/dVjYrPZrJMSgulCAjMzjX1s8RO4CRTl3/ucGw4/xUVKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714424577; c=relaxed/simple;
	bh=PPVNvn0DIhv6FGN+XyDmmtWyNnzYHJ1RnYM4N8RhC9c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oLzVMgmLKg474epmwBrfeF0ZfosQm38SNjgzupg/rVK4g7B6Bf11VZ8a5wgXDL43xxUDvNA13rack0ndijl7bBBWbbbQ/hcflGPKWtNx9l/u+50hs3ivnBtdjfIdMqpQ6u3XHXQBX7PG0pNTGXo32onKx6xqbgHubzhy/bFVzXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d0cvUxCU; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2a5c5e69461so5989208a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714424575; x=1715029375; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xw3vIJGY2NNuKaQ6MudNnqR6rpTRdltf5mCEUSFWvc4=;
        b=d0cvUxCUEqzsngCAPrB36e/r44+gq9tjbGqxxj3oQhk5/cAMIVHxxqzOhRduJhcr2/
         6UfwTs7WOqFCw0m5oKcS5uFMb17XVkNYWdhdntj3hYG73UMRP23sIS3WpM8M/udsy+HT
         ew8SoxkHyS3WJ90IlG4STUDHv3mYRnyYAxMuFj2+hEGz36GDTwidr3KYsKSkRRoXSEHI
         8cNjvasB/ODaWhd9KCy48VO+4kNgWC6AFYGI2bS/8eStafqDpsH4wqtza9Z0kYyFtdjU
         h8bnLiRGMdZYt2ijgiI3QX5FWYZWYb7bvh9zQ4x0PGIx8wuAwsxRsZdpfAXfWOOBxue+
         nCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714424575; x=1715029375;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xw3vIJGY2NNuKaQ6MudNnqR6rpTRdltf5mCEUSFWvc4=;
        b=IDndM9KgIz/tSq4WqBexR4z3n4/eOsn7qpCtFRYbbys56NWP+zvonqTKXu6UgeH4y5
         +t0rvTpjUsp9vIIwA0YuJnDMB9JruBJZ4bb6oqaNUx1fYTAQAUbAIR0qWWi0vi5h1uDX
         DDM0Pvep18lT46WssCLy8nSepN0aOfoUHUCth864lt+FZ0e3euhDzzPYrDMuxeyo3HlI
         IGJSvgNXLriOqfCoCvUL6ZKCefFH4SO4h5WzAMTh0O+4+gqTWmBUKirKnPjTWhv1ogjF
         YEjYw1K/Opvk9qDxNMI/+Xlz+ft9KmoBnRPeuDjkRznqoc2D6VLK+0t7qw8zLqQYaZX3
         cIJg==
X-Forwarded-Encrypted: i=1; AJvYcCW2Ykbvp3eHYZv6hrDo5tFDXdRJpy6bg7/YYAfhiHnHr+olKHKkaz9IdU8j8CMwHHUoAnDLwkwbx1eFVuGQQPLBdREttcBdy6pwNPEG
X-Gm-Message-State: AOJu0YySiTtL69zG3QrqdsBRpmpP4Xf9Mj5rUlyuBp3S7bBfuH5n7fiG
	MDEb3PYBIXdjl7SpW6KegHl6jtGSU8jyeQ1LnAiyQOSLl2Z28vUeQLwFhNtsphqI/Sx8OGi/17b
	SQQ==
X-Google-Smtp-Source: AGHT+IFAPa05P5Phibajkpgu95FpzO3FVIMmtbzX/atvNPTvVmV0SeqoPEqwME76DtqNEjJ0m8ryHAcldiI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d509:b0:1eb:7b9:4f7d with SMTP id
 b9-20020a170902d50900b001eb07b94f7dmr971010plg.11.1714424575332; Mon, 29 Apr
 2024 14:02:55 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:45:25 -0700
In-Reply-To: <20240423190308.2883084-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240423190308.2883084-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <171442341918.161544.2844726781684658994.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftest: Define _GNU_SOURCE for all selftests code
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="utf-8"

On Tue, 23 Apr 2024 12:03:08 -0700, Sean Christopherson wrote:
> Define _GNU_SOURCE is the base CFLAGS instead of relying on selftests to
> manually #define _GNU_SOURCE, which is repetitive and error prone.  E.g.
> kselftest_harness.h requires _GNU_SOURCE for asprintf(), but if a selftest
> includes kvm_test_harness.h after stdio.h, the include guards result in
> the effective version of stdio.h consumed by kvm_test_harness.h not
> defining asprintf():
> 
> [...]

Applied to kvm-x86 selftests_utils, thanks!

[1/1] KVM: selftest: Define _GNU_SOURCE for all selftests code
      https://github.com/kvm-x86/linux/commit/730cfa45b5f4

--
https://github.com/kvm-x86/linux/tree/next

