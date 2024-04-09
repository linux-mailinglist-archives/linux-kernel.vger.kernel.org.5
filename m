Return-Path: <linux-kernel+bounces-136116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF36489D029
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3301F22D1E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9345427E;
	Tue,  9 Apr 2024 02:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o7zPDv37"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E77353E32
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 02:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712628131; cv=none; b=ffT1LLRc36AF43JEOb4lT8nKJyLMQrpfr1phEwyCb1sB3jpeYHHgUACuAaijD5K4wmRFdmCpZllRTPhtfgxOVX+YRlOoz0pE9R7dceaj71wvA7TCXXhX37D10Et9InA51Hi//yIuK50h0u+N3QJfqZeprnKfW+3lpKXJcXmPaaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712628131; c=relaxed/simple;
	bh=jI+s4ADLS0AUp2OuvikaP10RD+xAePIr1NB6aWES2II=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ixo0ZrCJ38E1asu+kJgXq2+RINB5ZGmz203tKhDZqGieM1uC079Dogz5YuZPqHPtm78H97E6FZT9o63ii55EAAZwh1Xnhg4hqMNzfgoN6xtZWWRw9xSWKPrqrkEvgQfuUF9nIVKaq1cecpN5b1KpKY1CZVQQUm/99t6FKnZsmnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o7zPDv37; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6180514a5ffso17045987b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 19:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712628128; x=1713232928; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I/9Qg7KGNzFHHNKyCZNdrvRxR6/vuhSy2raPKaP9KdQ=;
        b=o7zPDv37XnfjaFI22DXRMSGIqvsuAFE8ySW9vMA7ciOLro0n/inKeP7nzJ0HYXQlD5
         kRpdRuUapEvjLvc5TTeAteUb1VZs/R2faRsYQvBmdY+cyZt/mcnzhFY4lDCUvKuxaQDj
         Of0plm7BDVfo7+ToDcYGefyHuwcHH8QM9eqxaqAz2RYsdP+FSTCj6SOw5iNc/27V5s/Y
         AEf2O8b1x2LX1xJ2QSEHR1FGwfBj8A1x6U8rRJ/KTkgzQlv2SpybajnV9Wbo8SfIX9An
         GzZaZpVN8+VIZE/T3jTlcDs+KkxNrfPoNyjYU+A619ZxE2Ccqm4tTqf72zB/aNccEnA7
         lJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712628128; x=1713232928;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I/9Qg7KGNzFHHNKyCZNdrvRxR6/vuhSy2raPKaP9KdQ=;
        b=QOtHwjMlh8qImc6xhkemMmtpOt4SIUmQ4ypR8uYdtQNwp7Ca2Gk6YyskrLjN2NIClg
         bLwmsA0knS4s/g4K/c+5193DehyMc4oXU9OlI/nZr+0aLRxlR+twTWiXFHrQgU+5Kwna
         whU5QUDw41az05W4Nwbd4t/9jkC5hSPAIrAtT+ijAjz1AK7Pre+hAbHXn2Nv5ZRNWX9c
         R9TecfewxSzxngHdP0KGlC1sXjWWVRau4O7l2jFTUZOeo1IB3SFq7vaP6ttqIYsQN4Oz
         Fwfyj11lUQjLpbfYB9j/2MQZltustECLpCjmtWDuuUzie9ecD1sE+gBlPTttIalE4w0P
         4O1g==
X-Forwarded-Encrypted: i=1; AJvYcCWLst8u/e3A6L9s5JI5x3zhuyRjk0Z1bCZ5cLGrs4Ep1Dx8nl2TrV8aaiJ+9adv5ta+79B94d4hmbFxyKpPpn8MnWqi/kngueOM0GUh
X-Gm-Message-State: AOJu0YzCOKl/JWs12w8GcvbY7ilFdjCMcLXtugGjt/z4Ank6eb/7z4TC
	rHZb81q101sDMXwMpboLAXrqLnoxOYrxz8xColpeKWY9KY2iSKB0yxtdfNckPjgVszHf1FUVvYF
	bPg==
X-Google-Smtp-Source: AGHT+IG4wDA3Fz7BPEo0USQk77/KnMmvMTFS/8h5KGrzx+o+VcVEyzAqvxNynb6XccOlL91RUsAwmJT0QeU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:c74d:0:b0:615:1c63:417e with SMTP id
 i13-20020a81c74d000000b006151c63417emr319167ywl.1.1712628128689; Mon, 08 Apr
 2024 19:02:08 -0700 (PDT)
Date: Mon,  8 Apr 2024 19:01:29 -0700
In-Reply-To: <20240309013641.1413400-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309013641.1413400-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <171262712105.1419825.3878505678593336929.b4-ty@google.com>
Subject: Re: [PATCH 0/2] KVM: x86/pmu: Globally enable GP counters at "RESET"
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Babu Moger <babu.moger@amd.com>, Sandipan Das <sandipan.das@amd.com>, 
	Like Xu <like.xu.linux@gmail.com>, Mingwei Zhang <mizhang@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 08 Mar 2024 17:36:39 -0800, Sean Christopherson wrote:
> Globally enable GP counters in PERF_GLOBAL_CTRL when refreshing a vCPU's
> PMU to emulate the architecturally defined post-RESET behavior of the MSR.
> 
> Extend pmu_counters_test.c to verify the behavior.
> 
> Note, this is slightly different than what I "posted" before: it keeps
> PERF_GLOBAL_CTRL '0' if there are no counters.  That's technically not
> what the SDM dictates, but I went with the common sense route of
> interpreting the SDM to mean "globally enable all GP counters".
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/2] KVM: x86/pmu: Set enable bits for GP counters in PERF_GLOBAL_CTRL at "RESET"
      https://github.com/kvm-x86/linux/commit/de120e1d692d
[2/2] KVM: selftests: Verify post-RESET value of PERF_GLOBAL_CTRL in PMCs test
      https://github.com/kvm-x86/linux/commit/08a828249b16

--
https://github.com/kvm-x86/linux/tree/next

