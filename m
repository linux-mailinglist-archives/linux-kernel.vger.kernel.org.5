Return-Path: <linux-kernel+bounces-100680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4151879BB4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF602897D3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A963142908;
	Tue, 12 Mar 2024 18:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vP4DvnHD"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004031428F9
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710268696; cv=none; b=T47w5/56erCHD23xL6q+YZxBFrw/JZANiVe4qBJOKfd0fFOMNwh1GhATF2apa6pQjRwGHtkPJo8AHYqWCfyN4t8EN9CiPLldPAqBKMth34he+ZcN0YW9L9nrTi/AGhOv0jsUiCAwZcVwQ5DTsnZ9C+D85fsSxzzw8CQIpO2VJTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710268696; c=relaxed/simple;
	bh=wYX4U4mgWZDDTAVNg6/c0mwBAAO7KZiivCc6MfSMAN0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WcJRyvJ+Ax4CMdfW3qnOHnfvwqJj1oInQZFEJM1OS1HtkCfmaEgeW5VCG8FM5DxcA7ETDUdoiO2nPQrFZkWMSO8kk1Kt1ct6PMIEAb01TzgkBGPYWVZwG8tmA4fG6ks7GM01ktWxIXjaGI1Q3wWZo9oJ6Jqmt94EqjpLBGN16iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vP4DvnHD; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1ddafc9a900so15360425ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 11:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710268694; x=1710873494; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kcNw7BbBTvDVZigmwhGYQ/p09R6CDgjmySJUJxjAXMQ=;
        b=vP4DvnHDTUkfquUVXNOhtR4snNzWYxhhefeuYo664upQcJcp8vSuZ5x6uuGIohSYEI
         4AT1tPiam+BYeXUBrqBDUM8KLyxsy1ZsfPqey/qr0SHCVLtfhWb0GKkdnibTIaV+Ilyf
         PZbTt2/hWuhheexirbnprTSLvF5BSvLdMg1/iWp9LbnAeaqOQlaxaM8Ab8VrmDJQ6JBZ
         gPnRb3v3mTBJ/YlA+K1S/wVpbeF7FhcDd+LLAbU7YLHArnjjvMlyjokJzcyDmONq9h7C
         g7KT8LJJWz+VCdMLBzADIPipb9FwEQ7vO1TpQdnyqouigWiexZnEb98/4+8YOGC2Gxly
         uFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710268694; x=1710873494;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kcNw7BbBTvDVZigmwhGYQ/p09R6CDgjmySJUJxjAXMQ=;
        b=YRv8P+0E+axU7SF1JuDF/ef5K4CBP1vuA9HzDRD6RVIEDEEzYq/ViIdZvovOD7G3+I
         CAu70f7YAJ4c3eFa1DJCUgXHrf4posOrp4t057p4Qim9mIHGSDWuGssjfNwuCbeUqZNo
         U3MY0FysD6e6yfsAOOuX87f1aESMTNgI0Ekw9HNeu3+o4cHwSYs8sbMa4BIh5j4+sFQa
         VSWhUsLposic+N7gPf1ohh1k7xlIGuGLuM4Kk5j0BtFAwk+jeTkmEnPj4qVwCsia+5rs
         T1fVUVs6VLQ6Ywz2daVnzvay+dlUI+0ETZuCmESrMJ48Ir8mTq5QQDf10ZXCqBXDVSie
         j2dw==
X-Forwarded-Encrypted: i=1; AJvYcCXrPox47L3Sl6o9PgM0SoEOagKe/pXmt9bEGILGJNla0S32gL1b0zZCNsmDkF+8bR9/53VAtPpBiVbadbJ5R8Irs5OULiTk+BGaEj22
X-Gm-Message-State: AOJu0YxMAwv8eFR1waLLMp+Wq2gRA/guOGTdILt2nuBGcZLezx0oG6Au
	XMty+NiC8IJOXrwG7oyF5z0Ay7kSM4fN3Cs/9/VO5Sorfrh9x/HE4uAJXMa8645K5gD/ihW3Uo2
	Z+g==
X-Google-Smtp-Source: AGHT+IHnTaoY80kiWglVX7HwtJTr9eNN/Iw0syp/e7CC8QvlnR6x+Dku2AN4fdTbxKX2GWg/wBPcHMFJMdE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ecc2:b0:1dd:8360:df97 with SMTP id
 a2-20020a170902ecc200b001dd8360df97mr664667plh.13.1710268694242; Tue, 12 Mar
 2024 11:38:14 -0700 (PDT)
Date: Tue, 12 Mar 2024 11:38:09 -0700
In-Reply-To: <c7619a3d3cbb36463531a7c73ccbde9db587986c.1710004509.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <c7619a3d3cbb36463531a7c73ccbde9db587986c.1710004509.git.christophe.jaillet@wanadoo.fr>
Message-ID: <ZfChEaiQ29qYzFaq@google.com>
Subject: Re: [PATCH] KVM: SVM: Remove a useless zeroing of allocated memory
From: Sean Christopherson <seanjc@google.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sat, Mar 09, 2024, Christophe JAILLET wrote:
> Depending of the memory size needed, we clear or not the allocated memory.
> This is not consistent.
> 
> So remove the zeroing of the memory in the __vmalloc() case.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This is just a guess.
> 
> I don't know this code at all, but because of KVM, it is maybe safer to
> clear the memory in both cases?
> So, maybe it is better to use kzalloc() in the other path.

Not zeroing should be totally fine, the array is only used to hold kernel pointers,
if KVM leaks that state and/or accesses uninitialized data, we have bigger problems :-)

