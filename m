Return-Path: <linux-kernel+bounces-47236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCDD844ACC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35331C2357E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4351B39FE4;
	Wed, 31 Jan 2024 22:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qbtjbIzz"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3253A38FB5
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 22:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706739312; cv=none; b=WHdSyYKJ7qpfjXlmnMqzXmXp5W1MUWpDEiWy4jYE8HOv1SguNeDdYezSE2uqQuc6k+OOONoa8Tx7cI9EjSBRiJyDBbn1oahe/tzWH4/Rm2WQ1oNWTwjnTXQDtJLVuvIbd4VV762OiN6dF0pIgaviNnyZHqVpscjeqlN6QhBv/b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706739312; c=relaxed/simple;
	bh=LbAU2QOSUO4G2w7KXKLwqZIy9v04ComU9ZUQlJty5nc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y7LIl5IKIwn/hVmtXF9TDaz2Z93Q7xV9OOz3XONJgV3y8upz3Vs8YT4wFwgIzw9qO84+yzV2Dv90q9h1+wNGYdEhGqz7WDhCQJxaj8X+2yLULmTUnptP/452fmMwwlQZsQ1axhaiWl2tb5FRmwb5pOJ6sMJiIE8/ItK++T1mcpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qbtjbIzz; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5cfda2f4716so273488a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706739310; x=1707344110; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bw10OTGUzfIt3yMJ/JYelZQmmsijYp7LFaUSBetq8KM=;
        b=qbtjbIzzKii+/LAwUeXZSONTG5ZfHFFBCPyYAEb3jsnWHFp5nkZc83JEtdtQAumK+F
         AcyBMzj12DfcmUECL0wqomwpO41E5xqeektYLCl+hrLvA7n9PATZtMuUEWOdDFS9eMbN
         jQk4GpQO67+WdxjgDadjEbb5AvY0f90tgFmerVSXCtdD2xCqdgepEfVLgAQRUZVwPqZX
         XCEm/90s2cbMFBOqcRHi3xMcZQIUaVhFzrcmCEtEMnmxv1B6xTw0ls8MaSzseybEa5up
         8IE1TLUA9rIUtKx8tmN1m85mA1AD+n0Me2FygwkfwwfRWM7Vx960CUG4Qc6cMCa9+NlM
         W4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706739310; x=1707344110;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bw10OTGUzfIt3yMJ/JYelZQmmsijYp7LFaUSBetq8KM=;
        b=GAvb6R+V7VX/VeLcjxvg/v34iVSm4LzJImjaQc53y3+7BEsbK5ESjY4jSl1o+DybXs
         pvQseehtH7urz1rpuctKZ4+RiQxJQBNsP5eHrwGKTSkXda1FQ3CUCeyTXtIsNc+xAXHL
         D0heS6aJH+6yealtpC75iMYaxeXGshpoOvYAoDx5/c3FveJ/jxzYVJeKNYHWh+nY52Ag
         1R9G4l2Wvak6w2PZf7Bzib+CURjOTm29flMTMBvqu/mq5mcr02K94hsoDjjNC3FMBCXq
         C7el6vncn4QUyx6q5qsoukmwubolbBPG8ZXlPyJr0JiTH/vLL3a1atSqJ4X02Hn1UOVN
         VOWA==
X-Gm-Message-State: AOJu0YyBKOpxoPQlxieEy3m+XCYepAL0iRQjKz4jp5nA3z9BlLPy7rHG
	ZBA0C08jLE7IYXlgVWTBCjgCdCGI9ZpT2BsMl0yfklvn4ugHVrNBMD55LyiA1wwtRLvmnT9PSRv
	SwQ==
X-Google-Smtp-Source: AGHT+IE+Vo3GXPRreNgaVd3lwX5nZFPepIKP7aB/TwetnDkyydFJ1AKzRBneBfh6gsYeBkB6ujDvtkFrTvI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:68d3:0:b0:5d8:be91:930d with SMTP id
 k19-20020a6568d3000000b005d8be91930dmr18124pgt.0.1706739310357; Wed, 31 Jan
 2024 14:15:10 -0800 (PST)
Date: Wed, 31 Jan 2024 14:15:08 -0800
In-Reply-To: <20240104190520.62510-1-Ashish.Kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240104190520.62510-1-Ashish.Kalra@amd.com>
Message-ID: <ZbrGbLLvdwRfMun5@google.com>
Subject: Re: [PATCH v3] x86/sev: Add support for allowing zero SEV ASIDs.
From: Sean Christopherson <seanjc@google.com>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	thomas.lendacky@amd.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	joro@8bytes.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jan 04, 2024, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> Some BIOSes allow the end user to set the minimum SEV ASID value
> (CPUID 0x8000001F_EDX) to be greater than the maximum number of
> encrypted guests, or maximum SEV ASID value (CPUID 0x8000001F_ECX)
> in order to dedicate all the SEV ASIDs to SEV-ES or SEV-SNP.
> 
> The SEV support, as coded, does not handle the case where the minimum
> SEV ASID value can be greater than the maximum SEV ASID value.
> As a result, the following confusing message is issued:
> 
> [   30.715724] kvm_amd: SEV enabled (ASIDs 1007 - 1006)
> 
> Fix the support to properly handle this case.
> 
> Fixes: 916391a2d1dc ("KVM: SVM: Add support for SEV-ES capability in KVM")
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> Cc: stable@vger.kernel.org
> ---
>  arch/x86/kvm/svm/sev.c | 40 ++++++++++++++++++++++++----------------

This should be ~3 patches:

 1. Convert ASID variables/params to unsigned integers.
 2. Return -EINVAL instead of -EBUSY
 3. The actual fix here

E.g if #2 breaks userspace (extremely unlikely) then bisection should point at
exactly that, not at a commit with a whole pile of unrelated things going on.

I'll send a v4, #1 should also be accompanied by a cleanup of sev_asid_new() to
not multiplex the ASID with the return code.  It can simply set sev->asid directly,
which as a bonus makes sev_asid_new() and sev_asid_free() more symmetric.

