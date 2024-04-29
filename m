Return-Path: <linux-kernel+bounces-163056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED7B8B6451
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442A91F21FB1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B939717BB3F;
	Mon, 29 Apr 2024 21:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cgKAzGaP"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EF117BB3E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 21:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714424590; cv=none; b=cnC8IV1KoVbLZZZKLZJK6b+W7jacJ5qNkAsj9BPC9nkrI2XbCxnppK0klg34vYTxdrd5crLeecKtcTTTlcko63Qb8U/Rul4xicqLVTVlozXamlE0zoPnYujb2uNcNrrLh/K1O/E0r6R1GRA+lmO841euT6fVpSyqbCysygeg9y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714424590; c=relaxed/simple;
	bh=SK3G96T4aqZ9rwUi1oPJAY9W3TBSIlSx0r4F6GDwouM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AxEECkSy6Y1Jv13LfqWAv1ZsaPrDRna77FoqQ+zKuqm06oCSf0Sbz+hOtKSvld21REAGOeGDXMyJCXuCQEER3uRlViWEFtlqVThgWeZZ85Q7FBSS+PpAwfsTkSobHHrQc+u/Epb6o/mwuYM5ntjJbwB18thg9x4J0pA+ZbntLoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cgKAzGaP; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2a4f59746f7so4965070a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714424588; x=1715029388; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WPUCCa2Pl8BfWUCgilhIb1m2EInOqsTo96Ea33xypmw=;
        b=cgKAzGaPZ9ujApIH4Hcnxrqci3z8/11B1kI2+e2cgTpyDBcW0qqUwqDnOvAAXl1k7F
         NLectClbYdiytd3+VDYGtM/0OwRmTIUM86C1Z+7wQf2hguYCybrURfq/JdFudlr+aZPX
         BRzKD53xHf8XQ+pW2lY83bbAexyizNRgW2wPk8F2OSJd+4Bx4yhDSN+W+0DK85ZKJG7q
         X1gevqfdmAc6gqlNhBcxZ9W0ykCB5Y0DbZsxHCkWrS3QmedZ5IAa6xKnskdC7gEkKELv
         fWPKZ0rX5IF1f6qZDFZ1nmooUyu6tqQZJFdKcGjoHy/Cf5xK53n/UYQwe6O9ivIkBKUb
         YZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714424588; x=1715029388;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WPUCCa2Pl8BfWUCgilhIb1m2EInOqsTo96Ea33xypmw=;
        b=YAe0pNv//vQUmraBtIC0yfd2O/1neuQeXS185uA4Cp/XZL51oNvy0PI+GqKGPhcTPT
         W6rGUkL069CYiq5YgWLV/E9qmtOQrxs8J7B9esYzP6CY70WEZicvt3QrFbWEtN+i8Ehy
         c3tCgOiL7IrQx2iUPG32Xx+AOLrDLMNcn5CmfE/EiZ15blxsoUpMvxt6j8/JYczQxKCV
         jZFe+0fyC5s6NUu87uFSNV1gjy2vkj6qbvh76/X0UKKBQClL/LI3xTXy2CIYx4elUiHZ
         dC/Z5isSXn3+0hdMk6rbIQDFLpknxo4izjJgxbr7Z+r9ThnoOUTx9gBl7LtLfRPBlMgP
         BGSg==
X-Forwarded-Encrypted: i=1; AJvYcCXC2TQ5hIqU4OMFn5TaLVZbJPNGx4oHjTm0nUGjqg+an0+vaR9ejWwLAmU886VECvyhdBqATWb4CFZyJx0umLJgaQap4F8Om/Vgf25+
X-Gm-Message-State: AOJu0YxTbwkhPFKWFoNVnjM7iLRgyy6euK7lc5rlFFcHvq0Ojvcuos/k
	ZaqcUs5mbAQqHApP5JNS0GfV4MlcAN52GfcQ50TzySvl60n6YO39vrod0GPlcV+YL32evzFDjWB
	Mtg==
X-Google-Smtp-Source: AGHT+IEf5flitXXjN5u4Fo/6BuICYPX69sOUimUW4HLvgZ+EOzKzbDHisvJHvToaGifZKMFhjp1lvKfYuJo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:8814:b0:2af:2a48:b458 with SMTP id
 s20-20020a17090a881400b002af2a48b458mr2004pjn.4.1714424587929; Mon, 29 Apr
 2024 14:03:07 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:45:27 -0700
In-Reply-To: <20240206151950.31174-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240206151950.31174-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <171441840173.70995.3768949354008381229.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: selftests: Compare wall time from xen shinfo
 against KVM_GET_CLOCK
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Jan Richter <jarichte@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 06 Feb 2024 16:19:50 +0100, Vitaly Kuznetsov wrote:
> xen_shinfo_test is observed to be flaky failing sporadically with
> "VM time too old". With min_ts/max_ts debug print added:
> 
> Wall clock (v 3269818) 1704906491.986255664
> Time info 1: v 1282712 tsc 33530585736 time 14014430025 mul 3587552223 shift 4294967295 flags 1
> Time info 2: v 1282712 tsc 33530585736 time 14014430025 mul 3587552223 shift 4294967295 flags 1
> min_ts: 1704906491.986312153
> max_ts: 1704906506.001006963
> ==== Test Assertion Failure ====
>   x86_64/xen_shinfo_test.c:1003: cmp_timespec(&min_ts, &vm_ts) <= 0
>   pid=32724 tid=32724 errno=4 - Interrupted system call
>      1	0x00000000004030ad: main at xen_shinfo_test.c:1003
>      2	0x00007fca6b23feaf: ?? ??:0
>      3	0x00007fca6b23ff5f: ?? ??:0
>      4	0x0000000000405e04: _start at ??:?
>   VM time too old
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: Compare wall time from xen shinfo against KVM_GET_CLOCK
      https://github.com/kvm-x86/linux/commit/201142d16010

--
https://github.com/kvm-x86/linux/tree/next

