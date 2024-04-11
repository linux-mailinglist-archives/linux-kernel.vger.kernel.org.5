Return-Path: <linux-kernel+bounces-141600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AE68A2088
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA0491C217D7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255FA2BD0D;
	Thu, 11 Apr 2024 20:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bgAo3Z5Z"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5AF15E8C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 20:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712869046; cv=none; b=MSxo9EI76L3UW7hBZhUTIGyGoupAolz+3iSLSiICXeHrKmev10t47aGkIP1Pm5xzX8C1b023Z2elAUVi39xo3twiz5mKkC+MHXab/E5hSFXK6QtK9/otfwzZgDXAVfLAlvSa96ubiSfJuHlEhrO4hXNikQ+oN1hDPqanqKYtpp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712869046; c=relaxed/simple;
	bh=3USpWrUNdliUnscE24vOtr4QdAGj6lskCeojhOFYzPo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Grym6zZhJMAR/nDpfKLIrp930XBzah0bNFsWR1gz6EeViFKPfCpfp0FC0AAsh/hfGD9RibUDeYlXSqb6Xdveay9sCXyp6tnAwFBOmKmvAkL7Ssq/1FG5nSLQv2WRyFQV+RPk7yAz2g8wgt73ATXZx+DMMUvjj692+LGRz29eWJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bgAo3Z5Z; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-610b96c8ca2so3126707b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712869044; x=1713473844; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HYEU2A1US/h58udhZtj8GUv/NlwFdWP5dUC/V5yhCYE=;
        b=bgAo3Z5Z8YlxchApJSWwvLNxUIct4f5jUXsEVbv5eeRhP0AewFemHgKqtBB6/dOYP0
         vjTPUIUlVcut7bUddcYVRUIbwpI/dW5clQ7eYbHZSZSjxlxkObzDnglp3LjwkyGT4hNZ
         PXo9HUdOD02hvu/8lnJ6dYoliJzWi0edm67Ho6ItR/LSSUcuCtf06dwmNWsuBt/cIJM8
         jwjxsHdIPCzF/j8NTKEeZJgbH+x1ku848sob740eY2iiy938RBIB0pkhT8YK8P7K9ygZ
         5UCElEc560pFkIjkzDKdN/GCSMbly2t9Av+KVUz/qdSUTOK7mNuQoU5dW/cN0KxvVx0L
         2IVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712869044; x=1713473844;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HYEU2A1US/h58udhZtj8GUv/NlwFdWP5dUC/V5yhCYE=;
        b=chXhPpKI/P0SI9rLIn50mztQGyrVSqej5ZrtBADQ7oHJucvfI3EtbwrTbUJzz0e6P7
         3fozapaKjjXTrMxUJqLfMBQwmL99OZXIZn9rz23+SULE1UvH/UZb5cOYL2f6JWPLA2Vl
         bY2qA1HJFqouEGqk/26EY2id3snXifd7YiPM6sOjM8WLAe7q7PnVqH30q0w+t2sGnJqq
         UnxUM2RQE8StSn7ssLzK2WTnQZA5e18qI6xzl/N/nGa2NN8PF0c6FeCagFjh/RX89CtH
         QvJF/DTBVjoG6MYlFXwY7Oe5ly/if+rZ/IeV9SVcCGFzOH1gOjEQYb5+zxhKEy8ZEBLE
         w0Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXdWqTSiaC76g97H46WMbuu3Vt0To4apq6EInvjpYTdZ19HbT+u7r8ZvJs/ODN3MT2GYZXjcfDP2bEZeIKyGzsI5GvNpIZ41DIc7a/s
X-Gm-Message-State: AOJu0YwXekZbL5ykKdNKrrTUzi2A3nR57uoo2N4z9u9LVw4VSoV2jGGp
	HSqDxH8ylE0IDPmadSpmmq+bCpEoD9D2MyZkl8pJ/4rmwiPc22ravSHYEIyE9k0Cpld84lmmLaj
	Y+Q==
X-Google-Smtp-Source: AGHT+IH0B7KlVbl2bxNL8+iczB8+rRyeR8gTDQmgFF/XhbcdNrmoi+RlgGKOLAAFLeDcsQfs3Ca5mIGAi50=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:100b:b0:dcc:f01f:65e1 with SMTP id
 w11-20020a056902100b00b00dccf01f65e1mr183523ybt.8.1712869044460; Thu, 11 Apr
 2024 13:57:24 -0700 (PDT)
Date: Thu, 11 Apr 2024 13:57:22 -0700
In-Reply-To: <20240126085444.324918-13-xiong.y.zhang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com> <20240126085444.324918-13-xiong.y.zhang@linux.intel.com>
Message-ID: <ZhhOsvPxhEQl9YmX@google.com>
Subject: Re: [RFC PATCH 12/41] KVM: x86/pmu: Plumb through passthrough PMU to
 vcpu for Intel CPUs
From: Sean Christopherson <seanjc@google.com>
To: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Cc: pbonzini@redhat.com, peterz@infradead.org, mizhang@google.com, 
	kan.liang@intel.com, zhenyuw@linux.intel.com, dapeng1.mi@linux.intel.com, 
	jmattson@google.com, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiyuan.lv@intel.com, eranian@google.com, 
	irogers@google.com, samantha.alt@intel.com, like.xu.linux@gmail.com, 
	chao.gao@intel.com, Xiong Zhang <xiong.y.zhang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jan 26, 2024, Xiong Zhang wrote:
> From: Mingwei Zhang <mizhang@google.com>
> 
> Plumb through passthrough PMU setting from kvm->arch into kvm_pmu on each
> vcpu created. Note that enabling PMU is decided by VMM when it sets the
> CPUID bits exposed to guest VM. So plumb through the enabling for each pmu
> in intel_pmu_refresh().

As stated in the previous patch, even the most naive implementation can be:

static inline bool is_passthrough_pmu_enabled(struct kvm_vcpu *vcpu)
{
	return enable_passthrough_pmu && vcpu_to_pmu(vcpu)->version;
}

