Return-Path: <linux-kernel+bounces-50761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAF5847DA6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16061F279B9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96207D287;
	Sat,  3 Feb 2024 00:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dJqq1Pxt"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F37C135
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 00:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706919194; cv=none; b=ml4kEmp9xUtseUmmqhBQn7D6cxrhOrdHxIRjmaZy7Lut97ysjNGyr5sUMgSuMkTy1oMOo6XxEIpqq2lEV8aR1S6OCd0TFD+GgbqaRrxfjjxDzAkkAcuQLi98/XEbanrjiHgp3HqWscpHih6krzHCkqaA4dzrJAMZAhByKH33NBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706919194; c=relaxed/simple;
	bh=Jni0TSg9ot6qcQozjcLTwevDpNhGotmKANfaFNXV3iM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PIOonh6z8+sYz81kwWZVopxNgVIXPdECPpy7Sx/l3Cz2AR0+ICjSR0gXUYJl1YWHOcRsi58WLrwhIhEQvdm53NgPOHridVGsDWbeQ6p/pR4gkQwKnC2QvBGwU4ZdX2ksxW8Y2lC9hstiiIrtlDpC3/32ca9KwPSKvmwWjYKARmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dJqq1Pxt; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6bea4c8b9so3672717276.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 16:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706919192; x=1707523992; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KV+FXAPZ13lcrJzUvKxbJ1XxGB1dtZes5YLuLkQ/DUU=;
        b=dJqq1PxtZ1rd+4yceOyl/TgQ2EZzCBeRSuBSU2J/YdClCPRhj6Dg3PBPCVzP/FZK/j
         z+iJOFF/Gh74++jM0ikpvmGO4gEvxdlazkjoUSZnx1tbgeCt3U7ULiZTvNnN8jY22+ud
         g2RSO9fr01Yz0n/s8urDPDnGI84ghYKznGi0GOQgME5BfbK8JPQ3nNyYFXKU7svVDpz2
         HLVX81X9z3t17uyYBTPfFG/zRHDq6UtG+rQBtsFAx7FUdtoiI9u+saBe4E4HJC2e3hq2
         Vhu6w+yvOXSElybXJAzONtvGJUIgzzitVSJxBaVf6pLCspaEKrh8TRKmSfSOSFzoFn2Y
         iSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706919192; x=1707523992;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KV+FXAPZ13lcrJzUvKxbJ1XxGB1dtZes5YLuLkQ/DUU=;
        b=nDNQvqeDG5VQ6h9QwImDOzuBOzH7uc1cLMPoT9sN4HTrW/BDHx3doAdrhond2JQfBj
         C8j0gjKc9nVTKk/+zwW+PCQWRCGRmNRYvC1rgY1jX6b2Mut4SCaY5gXDPn+3vQJqHv+U
         pouOU3M6pN1Bw+U56h1KvJ4UXSvLmwwJxrmue8N5xdf/482xcBC+r+VhIR5w4eEPJYvo
         14fXSOhL2K8LUfJB3NS7TOcpuYsc1vW4OeAHiL3Wp3Q1g8Du2wy9wIE3JpaRMtuKU+v7
         1X+f9GLHxncJmHONns0XEd3A4fGHRR/toLu/CyN5IoyhZXNGxUkXETIMLE4BsWk5YY4T
         Wifw==
X-Gm-Message-State: AOJu0YyBMtWGkmsNe5FKMbTCgNmeJU/ktmjjYogJZ5/ImDYCU3BMy/NG
	nSbi4AyukMzprkVSvl8Bi14DeTLAjNGjZ3TPbiVobsrkwgEEpWWEzikfm13jT1CzTGXNzUx5RHk
	/+A==
X-Google-Smtp-Source: AGHT+IFwrMnn4VvsrgYURBQxyrN5tkSM7D0Vd6WTyJGbeg2WyMB02hw0RcROA7FQcIWE6njYR8iWglMP0xk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:e0e:b0:dbe:32b0:9250 with SMTP id
 df14-20020a0569020e0e00b00dbe32b09250mr207201ybb.0.1706919192678; Fri, 02 Feb
 2024 16:13:12 -0800 (PST)
Date: Fri,  2 Feb 2024 16:11:33 -0800
In-Reply-To: <20240116100025.95702-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240116100025.95702-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <170674428314.4156118.6499513902134394843.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86/mmu: Use KMEM_CACHE instead of kmem_cache_create()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, Kunwu Chan <chentao@kylinos.cn>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 16 Jan 2024 18:00:25 +0800, Kunwu Chan wrote:
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> 
> 

Applied to kvm-x86 mmu, with a slightly expanded changelog.  Thanks!

[1/1] KVM: x86/mmu: Use KMEM_CACHE instead of kmem_cache_create()
      https://github.com/kvm-x86/linux/commit/0dbd05469966

--
https://github.com/kvm-x86/linux/tree/next

