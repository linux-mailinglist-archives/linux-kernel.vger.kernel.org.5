Return-Path: <linux-kernel+bounces-84053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 295A286A1B3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD5A51F2E2E1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096C814EFF0;
	Tue, 27 Feb 2024 21:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nIKpG3lk"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E033A14EFE1
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 21:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709069397; cv=none; b=ERpYyM8FwAoYXHZbSjDqWkLoJ4qKVDOkWtk3/S24pbYKGY2ecEcY7k5dnlqEm5lrIe2fiI6ZuhewsQ8KN661UG/eROR5eah6N7v/lpV9v+YrwjW2gf3NHmM9AXBinIlP65rvCMo/R3FD74lXD6JUdTQzPUGCEEDK1MRrje/hxNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709069397; c=relaxed/simple;
	bh=rIJ88V/tax2NVL6+s5zvK1X7yO1VCi2lK4BLuDBl1jM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=elnFFrvkrKgnoM56ctY8PRdAtrmNDVrf1cT7wGHm291Rr5D1pX2Zx01LzG5kG7I+dSxJpkts+qZHf+xE3DJWkzIlDVUBA+5WZtAnwYJflf/IZ3JCJIdIZwLlzcYD5jkqvgQmEFzfeWpSuNqaH5ZWZSWcgsjH+SCsNRsN9Ql54wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nIKpG3lk; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6088fa18619so65774737b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709069395; x=1709674195; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N1u5BW5TjNAUcNNWbLgeCkfXH3SJ+Dkjz6FwWTFOoAM=;
        b=nIKpG3lkXmLWo+BoVsm56aWMoEsE/oXMbrwKxnoWFzPGVVKjZTJP+oU1U6uhYtyfPU
         Y3ShS/eA3libhFwiYSR0TTAxsnpyS/F996063R6G2cAJWM1Hy1zJkWD6zsaxFrONYz2b
         BnIJyfvLjuLtx8D3YaSKHxBGZIM7lc6rAUXjb/ZjDwFuLTJ1OHg4yR7IV11ZAXM/ZICN
         YvpopKgzWEP7EWTsVk/3UvoJO5T4NtCr6KeYoKrvaYiI/k6NKkmPNPbKLS0l+Rhb5w6u
         ++KLA6ryAepjMxIwGIuq6VflNuRElt/5XVpTxzotQFDHInFlmDLa9jzSEVkreXHBD8fv
         zjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709069395; x=1709674195;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N1u5BW5TjNAUcNNWbLgeCkfXH3SJ+Dkjz6FwWTFOoAM=;
        b=USq9qfFUo8fG4eIolf4NUrX8MMipvjTwjRCZp0OZJDG+t3u+v2dZBoRpkvHe7IZW3D
         t0zTBccCjlbEIgIlxsHzK/E3rUlmQ0Bim+o1fWXokM2/JOzHfMfvjCkyVFnWVkKzdrKv
         aViMMKIj9s/YhUfz7ppo33L7UsXheAhkuYfyW1NxUAhMPW36TLiFJ9nIuy8QruQThSkI
         u7OBYVXaaLRf7Po9lxP4SXdMN/UDYeGroMsTPHldYEH7uJHOhPqRH4SJYNnJvJAI0Ppx
         1zVKx1+Jaw7M/V7+57beiCuNLcMSTbic4dsqIAexRgr8q4EobwIWQ1SAxXkCxk8+Y+/o
         95Yg==
X-Forwarded-Encrypted: i=1; AJvYcCW5VQ4eAdjyCsCkm7G/Hl5W3zAaQ2deevCJNnau+mwWjLwMHDtSaAT54YOaoWPfUrEl4i/BpMTJjtvzzllLlkiZ0W+NyyMTMDzZ2Xez
X-Gm-Message-State: AOJu0Yy6/KnZRN5ehR9FM00W+6IFjeAKApOvpcmUf1fXvQJCbyv2eA2D
	Kd/tbS7KIcuF0AR/kM2Jogg3w5jgDP3Z3bUFTQMJ7FSi6f4fAFn55Fs8k+I2InvgN/mv15pefnq
	sbQ==
X-Google-Smtp-Source: AGHT+IGazU+KPE8nu6wnjCFcCHmiJO6Upez3suJ4jvSyuNFIOpHZPK+ySHvTniCbWEqCCkaz7BIpbqbivSM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1891:b0:dc7:82ba:ba6e with SMTP id
 cj17-20020a056902189100b00dc782baba6emr54802ybb.7.1709069394930; Tue, 27 Feb
 2024 13:29:54 -0800 (PST)
Date: Tue, 27 Feb 2024 13:28:16 -0800
In-Reply-To: <20240227200356.35114-1-john.allen@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227200356.35114-1-john.allen@amd.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <170906539667.3824343.10867999255321122858.b4-ty@google.com>
Subject: Re: [PATCH] KVM: SVM: Rename vmplX_ssp -> plX_ssp
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, John Allen <john.allen@amd.com>
Cc: pbonzini@redhat.com, mlevitsk@redhat.com, bp@alien8.de, x86@kernel.org, 
	thomas.lendacky@amd.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 27 Feb 2024 20:03:56 +0000, John Allen wrote:
> The SSP fields in the SEV-ES save area were mistakenly named vmplX_ssp
> instead of plX_ssp. Rename these to the correct names as defined in the
> APM.

Applied to kvm-x86 misc, thanks!  I put this into "misc" instead of "svm"
purely because I already sent the SVM pull request for 6.9, and the only other
patches that are SVM specific is my SEV-ES VMRUN series, and I'm not sure I'll
queue that for 6.9 or wait for 6.10 (and I'll probably throw it in its own
branch regardless).

[1/1] KVM: SVM: Rename vmplX_ssp -> plX_ssp
      https://github.com/kvm-x86/linux/commit/78ccfce77443

--
https://github.com/kvm-x86/linux/tree/next

