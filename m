Return-Path: <linux-kernel+bounces-78767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1547861891
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0082D1C23B1E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FA412A140;
	Fri, 23 Feb 2024 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IAgxXDZG"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201D21272C5
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708707529; cv=none; b=ZgQ7382Ax6GCHrLUgBJbWUxweIXYUgez5gOdyIqZ6GDujLBryA/0c/mkmrGYbRjd4PvFdT59TruZX9bKNOg0q+gmq9PA68BzB0Dc523ognAkn4LODpCFehgPRk/BkakPqcp2DxvHGkDj/dymzKFS4AuHxRhw9JzQhfSfx5tbdnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708707529; c=relaxed/simple;
	bh=/qCYSqlO9DNszGUQz3vCGxRHgLhruOfrybgzCU6DVXA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NADBzuUw5BzCnVcGIuYA7VXesAKTSwaUJdSjZT4VuCDAOREQPIidMG7KjcE5rG3EeZYs4n8djHYjaQevJyZ+h7CEbunKEIT6eynenJx9zGqmeNjfx9AVX5QMeFnqwuVsVz/7x3KbVd1g8ZF3mCKpW1A4BqxfgWbKsTEwuQ/RLjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IAgxXDZG; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-607cd6c11d7so17813147b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 08:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708707527; x=1709312327; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oc3Qq6lAIDsi/q5F7XRr3cp32P8qkiyEnUPLih6Y/wY=;
        b=IAgxXDZGMqLfSlz96LIdeX51FWRb2z2mPqCH+Rq76KcHLn3hrtiS1bY5ttltIRB3Fv
         JzOsWlUBO/1CAaXouuHE/6SRDm0J6Frg9AMzyRnHr4LbwXNR+fD7mO2VynOiDjHh76ZM
         ++7WmX+7RS1LrUQudStQnQ2RYk8L5rdfWojJlcn1l3kOR78L9BtcJRoV5wOecOdbTSpf
         yfC68QWjX6zA3UJE86HOyNN78OT78NIPsVbLbFpKqZrKnRWoO1CPtH5f6XlCcNeDaEZJ
         FQoSR1ev+9YOdTGylgYYzb7GBq86tDgHGVtZQgXZnIvGtntvsKf3lD7XcErMpaxhIjpK
         vYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708707527; x=1709312327;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oc3Qq6lAIDsi/q5F7XRr3cp32P8qkiyEnUPLih6Y/wY=;
        b=AOmPwzBOMTyd9Gwuxo1ZqIYjCj7k/F3zyQrOr8Xrh9/wqplO0wTDTVzWRgYD8Z0YHN
         j87SC0cYN85y7eRWGo0N85i3vEDrPvymtsAWXyFyLxJ5gnEla40/Lt5Y78gqLw6jy4qJ
         JK2R1ARszS8DC7V0ryRhI7XTSaOESC2wTHX2qq6Mjf/Oh5rOPAdoDaVkEXSaGkIXDN/8
         QMtogr3XJG50FJmuPfki15L+061mHRdl7n8BcB13YBbXw6m6gTdeqkzCxvl8kWZvdxhV
         qC729F5kz+adk/xs85Nxb1o4zkxodzRCUKArcjgPCPtX9o9T+3AhMxdXt470q/RabIIz
         h0PA==
X-Gm-Message-State: AOJu0YxmRnpwRZLHFgm6mfqYA2lDkxBMWoAkvdYKPVkQ6lx0TArDoqsc
	p33rm91iDMDc0noobTSsycXJHir6u2pOTnHaQGwmqnhAnAjPqOjd1Dx6eLzz0vqSzFK7KkxOyLT
	auw==
X-Google-Smtp-Source: AGHT+IG+gq17ikIqA8XdmP9ANQ3WUhP5iYW2W+seOy/2+HGUIAfb6gwraEplyOYx/xpz0xfx0noUaIPphmM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:9e13:0:b0:607:83bd:bea3 with SMTP id
 m19-20020a819e13000000b0060783bdbea3mr64043ywj.10.1708707527179; Fri, 23 Feb
 2024 08:58:47 -0800 (PST)
Date: Fri, 23 Feb 2024 08:58:45 -0800
In-Reply-To: <20240223104009.632194-11-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240223104009.632194-1-pbonzini@redhat.com> <20240223104009.632194-11-pbonzini@redhat.com>
Message-ID: <ZdjOxe1BHyn9KDrY@google.com>
Subject: Re: [PATCH v2 10/11] KVM: SEV: introduce KVM_SEV_INIT2 operation
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, michael.roth@amd.com, 
	aik@amd.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 23, 2024, Paolo Bonzini wrote:
> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
> index 12cf6f3b367e..f6c13434fa31 100644
> --- a/arch/x86/include/uapi/asm/kvm.h
> +++ b/arch/x86/include/uapi/asm/kvm.h
> @@ -683,6 +683,9 @@ enum sev_cmd_id {
>  	/* Guest Migration Extension */
>  	KVM_SEV_SEND_CANCEL,
>  
> +	/* Second time is the charm; improved versions of the above ioctls.  */
> +	KVM_SEV_INIT2,

Heh, I was just laughing in a team meeting yesterday that it took me an
embarrassingly long time to realize that KVM_SET_CPUID2 was version 2, not for
setting two CPUID entries.  :-)

> +	if (copy_from_user(&data, (void __user *)(uintptr_t)argp->data, sizeof(data)))

u64_to_user_ptr()

