Return-Path: <linux-kernel+bounces-136113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BD689D023
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EED41F22EE9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0804EB58;
	Tue,  9 Apr 2024 02:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="js+/vL6f"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BC84EB2B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 02:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712628097; cv=none; b=Hfh+j5d8GagJElfzbFkKClA/zVhRTlnn/lElN/jbR04j0XZtzj9C4w7FaT4sGYzVFsAl77F4xqG7HlViomrx2Eik0fIv8P3fiqQ8net/ktt4jP+SU9tz9Kk5Uo/KmJGQU9AUZzlkOQvgSxEVrQPKYhDdoZhwKoAQYl1CCpLgD4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712628097; c=relaxed/simple;
	bh=sm/kJHlwnGkxq+r3r+WnQ4vu7gf2HJ259P+aphQyMUM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MbFtIx3MPeY24kJa/N4DJEhQGMO23A4BKHKLyQuXvbjv75JWE35Xyp24Jxo7dqXvMvYF+E3/Kz2StqV0ZpPyQIU3ZvzE2n78Dv2gNNtFQCMPMgJnxbTi5lX7SP56nlE7RguhaQtrYFUfOIyeguyMTFAJ367KTBaL/fEa04Txj1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=js+/vL6f; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6ecea48eb37so4578825b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 19:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712628096; x=1713232896; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gSUZDkTRN8Lf9eVIN9/jjFC+upw3wKsPHOurrDIqp1Y=;
        b=js+/vL6fmf+wlZL4Bfxq+VxSWwYSUeQCdiTrgNFNV0rG5tptzKbFAudqE3ktfg/rOT
         cjuQdtk3e2g/BLAZrZTThTq72OgQVgsyJw2tnp6B8+koEpypDHx6Kqk2oYgAwHPmDDPe
         8Q5W0dUWEJAK+IL/xuwWglIsOfQbf5I+WEHQbwebELsqqoioMuQ31JUaJEvsk0qaok+Y
         N9vbxGJR8IvcF6WdCNQZO0i0T/PKIcnM+NBrGJ/rW8v0t8JcRbd7uWEOtEbyL64OzqOz
         nUHw3F8jaP6DjJHIaRjpxZIkzPi4ldLhDkR90OG4KvAD42WL1TZG51x2AtCxqgTaO7eq
         PUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712628096; x=1713232896;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gSUZDkTRN8Lf9eVIN9/jjFC+upw3wKsPHOurrDIqp1Y=;
        b=FJOpbfX5FHBsxhVJlEg7/q5ET9eAozqy62pG+7pcrNA4ge7v0KlbeBjNd8xCsYGFzo
         IYXgw+cqpVBm0XE6lAuC5SP6UGAIKHGmnMoiT7Otyxv3y2Fe3Ha36hc2N98RNqLr50UU
         +q79OZbSOJ5tqhn2KlJYbeBA5O5BxKVJCjxmUnuo0pci9pZYlSWli/L3h+iku2kSj5T8
         sFDGfcpID6yTGTMv0BUhRU8gS/k6ZMDlNLXIDOgCXXpHu/QyTY6IBntiN5lhOBfBntM4
         ixKClRaYFyXTXbgs1J3y9rAuA2hNZ6UBrjiV7Zz9cFjl56YokAPIZZjLh4rVzlFv8im/
         jV8w==
X-Gm-Message-State: AOJu0YwU2TZU6RoM6WI9JXkntthA81LDOC/l2UcrmePDozcPiEbTgGrJ
	UVqen0g6qvs7zGrh0TfIU9Ow9l8DCeJWoEj/fKlZKuhF0S8xdgDFzeA7uF/xEiT11VAUuA7jIUz
	LAA==
X-Google-Smtp-Source: AGHT+IE6nR2DC5wdy64yV/43loYGn3aGmMN2LEIwaDNnYU0U8x24E0N5tzdwMWkKyO5QuQqHxkxQHk1i5Vg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:92a6:b0:6ea:b073:bb60 with SMTP id
 jw38-20020a056a0092a600b006eab073bb60mr1084247pfb.5.1712628095580; Mon, 08
 Apr 2024 19:01:35 -0700 (PDT)
Date: Mon,  8 Apr 2024 19:01:23 -0700
In-Reply-To: <20240315143507.102629-1-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240315143507.102629-1-mlevitsk@redhat.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <171262713897.1419961.5139969748119275014.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: fix max_guest_memory_test with more that
 256 vCPUs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>
Cc: linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Fri, 15 Mar 2024 10:35:07 -0400, Maxim Levitsky wrote:
> max_guest_memory_test uses ucalls to sync with the host, but
> it also resets the guest RIP back to its initial value in between
> tests stages.
> 
> This makes the guest never reach the code which frees the ucall struct
> and since a fixed pool of 512 ucall structs is used, the test starts
> to fail when more that 256 vCPUs are used.
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: selftests: fix max_guest_memory_test with more that 256 vCPUs
      https://github.com/kvm-x86/linux/commit/0ef2dd1f4144

--
https://github.com/kvm-x86/linux/tree/next

