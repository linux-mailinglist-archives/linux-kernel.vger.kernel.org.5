Return-Path: <linux-kernel+bounces-163052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4C38B6448
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09F011C2158C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1057117B4F3;
	Mon, 29 Apr 2024 21:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bJCE/hbG"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B8F17B4F1
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 21:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714424555; cv=none; b=LbQsLv6yWPfaIJOfnQ86KnDYprq8VuocH1rYMZVvI4N5eP4Habb3Q/5793N0K2+B3MyfYwNqmPZaEL9JxwOFiA0QQcvdZzcwuZtECp0nXh7EM7uEhnvErSbxXo6IvvnmZheoFeQMWOz3KK3b5xhBXV0pBcfi4Ci+JycDiMbbJvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714424555; c=relaxed/simple;
	bh=cs85e2r4NJuUFXJ/ldnOg8vnp9GecWksd3tK2JQDKYI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qdIpSH9C3MuAbHjSow+ieCPvJjyKbhRts+lSgsi8PmrCwQDNmO9Loyrx3opZpbtUiTi9IO7dRe+YwRmx+5VmbApOm1PcGOLQZxMNeZHPLe8XvThVvpndbLSepi30FYSiDTsSXlNZCdPg8EQBsUxwu8kZPjrELSsc0yKnMaJc2Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bJCE/hbG; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5e4df21f22dso4241574a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714424553; x=1715029353; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SX25Rd2lbFP13Ouj4hjSpg1j1YlpURzrsvt1/pd7SEw=;
        b=bJCE/hbGf7LCkQvt6kZFmwcD5JhaYP+0i4oaXMbOFcfr0WSapye4XOt7+ySE5595nC
         atT+luuKncc1AtsHJiskqxa6bGzjUoJHyOFR2rigunpsitbB7x1FaXpyAU5JXv0zrY46
         UAZmajliXieFSHxnxLf7/5720sccRVlgOANE729LMcQi9NHJI57hgZFtSBWoZ0iLPy5V
         Qm1ZTlp0xPbtdkHm4FXPk4XgiZqURU3c6CrMOf3R8pJXrQsCx94stkn9RuJsaO8O+oYC
         1oGzzj2jiRlPjRLly5slP0JWXQqZo4BiLSFa7peldGRNLD0Ix94sp+3ZXNoFD3b8nszk
         EYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714424553; x=1715029353;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SX25Rd2lbFP13Ouj4hjSpg1j1YlpURzrsvt1/pd7SEw=;
        b=JWhFRZV4wOZQ6+dyQ5gvu7N4dLN0UsbJCQW6PwcFDeq7Ffo5NuueFk8jywIQZ4Q9Dk
         jnc35AMHh2wMZJJd4s4vGMgAGVByURo0ptEzhE+AQQV7cFYvF+r2y4yfy4YCvfr6JXT+
         fX5dKGIehf55CMk8lgw5yKa7/8IVeSQX1P5ewjU+VzpmV12csLHdWGMXFxY0+KKEg0En
         udWi2RoPw0avRqHI7exnvTZgMS839W5O1hW9+SExi7Ozcd2fpOpmptW0Be56W8sfrQzn
         pXovEXkt/35ueS+TqigopVRw09S7CR884FYCtt8yzNeQdGB8+46fevb7aBD/RgCC2PEk
         zw5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWM3/AEuVAvOvbSf6y97rlNd0qJzQYelqfELQx1PT6NBwUlhNtugekaAFQOHDHtFrwvOXnfj85fVkyO+o49g282Ly4Urbkx1mFMq3KD
X-Gm-Message-State: AOJu0YxfCct2w9xzYcCihK2eAcbRbDlfMwAHJmnP+sxogeOjwg6L1InG
	tzhK6sQmd70VJ/RvOAhDaktJP82CbDIepboHnNxIyVKPcGRoZ3aj5xt1eHPxrJGlsTE4GZrmSmQ
	jnA==
X-Google-Smtp-Source: AGHT+IFMZmLPYd3OCdFQUIxyCcTMBThyalheYS1duqyNYxxDIfX1rQU6Ae0fjGk9raqmcxnsGbT5WX6Vz9g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:36c9:0:b0:5e8:65ae:1142 with SMTP id
 d192-20020a6336c9000000b005e865ae1142mr2278pga.4.1714424553453; Mon, 29 Apr
 2024 14:02:33 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:45:23 -0700
In-Reply-To: <20240314185459.2439072-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314185459.2439072-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <171442342393.161664.6093030957550923677.b4-ty@google.com>
Subject: Re: [PATCH 0/5] KVM: selftests: Introduce vcpu_arch_put_guest()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, 14 Mar 2024 11:54:53 -0700, Sean Christopherson wrote:
> The end goal of this series is to add a regression test for commit
> 910c57dfa4d1 ("KVM: x86: Mark target gfn of emulated atomic instruction
> as dirty"), *without* polluting the common dirty_log_test.c code with
> gory x86 details.
> 
> The regression test requires forcing KVM to emulate a guest atomic RMW
> access, which is done via a magic instruction prefix/opcode that is
> guarded by an off-by-default KVM module param.
> 
> [...]

Applied to kvm-x86 selftests_utils, thanks!

[1/5] KVM: selftests: Provide a global pseudo-RNG instance for all tests
      https://github.com/kvm-x86/linux/commit/cb6c6914788f
[2/5] KVM: selftests: Provide an API for getting a random bool from an RNG
      https://github.com/kvm-x86/linux/commit/73369acd9fbd
[3/5] KVM: selftests: Add global snapshot of kvm_is_forced_emulation_enabled()
      https://github.com/kvm-x86/linux/commit/e1ff11525d3c
[4/5] KVM: selftests: Add vcpu_arch_put_guest() to do writes from guest code
      https://github.com/kvm-x86/linux/commit/2f2bc6af6aa8
[5/5] KVM: selftests: Randomly force emulation on x86 writes from guest code
      https://github.com/kvm-x86/linux/commit/87aa264cd89d

--
https://github.com/kvm-x86/linux/tree/next

