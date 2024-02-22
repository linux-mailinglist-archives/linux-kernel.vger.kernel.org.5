Return-Path: <linux-kernel+bounces-77472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 017A98605D0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832851F22C39
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A9317BD5;
	Thu, 22 Feb 2024 22:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SaeMbPpo"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C47418026
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 22:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708641735; cv=none; b=qhxcPSZiv4gkukiV24wea7kvxzf3+vYMZYtLsM/9lMA43+8P7+khJsD6sIo+drbn2S4DdoQcC26jJNiWl9wjLxEUB145zi3yXNysj16xG+AlSN86E/0mFohbhuqgPxPdaPU5Gwzlg2GzCNc/+71a4Sqbl2PGaOlfA1CkNZDCEJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708641735; c=relaxed/simple;
	bh=imYlGZaDB2n5vfS4ZwIvsXZiZqAKg8o6WkaCZH5L1Qw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=uzRIpRfZumTpDrm0lh1KsOx4t6XGCFO1LwdIKYH7SoYzvqKSYwDYTF3ya5mFgu1AvbS0+F2ttx9t5bQSpGoyXZnKVJtHqmy8tu83YSVPs9Af0JqAiPv63rdGWlPSMfh5/2unofqA4CuBuhe2rftEoEFFA4wcBxKN5bahRPH0sDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SaeMbPpo; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607cd6c11d7so4817457b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 14:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708641732; x=1709246532; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jFvVQg9UZb065hqoLsESeNre8JaYtsdQOcTRgkYVRKY=;
        b=SaeMbPpo6eyjEje/9O8LxIFYQSMovoXOTvHSYbqCZYIXEWQpXdVepqWghUELLvtJkv
         rOcWCIK5p3WDzrOpjyDUwwxDQ1Ev4focvCZuj4bHvt/UEgfRtqPv8MggySN14DAMP4dd
         Xef8Hr4fcHiTbNM0UGVJ+jL242JBb4wtiPSeSNVBMM1t4Qzx6yIUPv0sWI0xfyemO8uW
         rxFRL6TBZLuUrUIe8nNZ8YbCojNYFZ7qMK7jcqidZgAg2+Yt03LaGUbvQCZd/C4+cofn
         Qnco20h/iNlTEWKkozSJOeICkkt+izMJEwcQYwQZjIMBIiM3eftXdDeHw9pbtUIFBu9x
         ExWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708641732; x=1709246532;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jFvVQg9UZb065hqoLsESeNre8JaYtsdQOcTRgkYVRKY=;
        b=P/klCAKJqKFJOArT8Q+R7+XqST+v9+u+bSE9iOsl9afGo/ZEkEC5+AicQcYJgET3Pp
         bL+3vGmq7VtXAl9H8heZw7SFRNoZr7LZVNR7Tsw3ZE+Banvc+qmAZ2g8aUZ6wg//GosL
         f2xvKXz13fI1DcX1sdCQIxBD+n2pEPG4KY1nawZiRW7HNTD2dp9mvaqUQPRP4ANh3wrZ
         o7VjkCKXh8744OEBy8d30R5yKHGUzDR63Qe1NpLYqoPBZQGWdJLtA3DNSaqmtIGMTAlL
         SkLSZJ5J68aC7LaGD6wJOO5R8XAakNmFdwrTtDGIEwEg6hUmS4CDESAn1gxR5cFgE8FO
         ponw==
X-Forwarded-Encrypted: i=1; AJvYcCU0ROtfiu8UpRqbtJwbcTgXrJgYXGzTc3RSHf9rh6oP4mXMVtIMQ3d7VsR7SFv0y4h9Clq1KT8L+rZ16c2PJlUxmfDDUepEpf7fA3gt
X-Gm-Message-State: AOJu0YzoGGG/PBVPJozFjP0V2DIbLfhMW8LOs2Kw4K2C+Ax6XWPkaNqy
	lU1hsd22tDLSmcJN8oe7b3vYZ2k88xPNeloj51lzbFuDriJ2okrI1l4j0qYxpmVN1Z4jOA/qtt7
	h6Q==
X-Google-Smtp-Source: AGHT+IEn84VsOMK3xly4fJg9p4ZGQL4jC+l+k5U6BnNNTDUyy7r/Gzq9iPM6OigIQq722pMhxaceeSC3g0o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:9242:0:b0:608:20df:8b0a with SMTP id
 j63-20020a819242000000b0060820df8b0amr102171ywg.6.1708641732562; Thu, 22 Feb
 2024 14:42:12 -0800 (PST)
Date: Thu, 22 Feb 2024 14:42:10 -0800
In-Reply-To: <ZcKYRsNUAngWGy2a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240203000917.376631-1-seanjc@google.com> <20240203000917.376631-11-seanjc@google.com>
 <ZcKYRsNUAngWGy2a@google.com>
Message-ID: <ZdfNwhe2s0Mn2gB4@google.com>
Subject: Re: [PATCH v8 10/10] KVM: selftests: Add a basic SEV smoke test
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Vishal Annapurve <vannapurve@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Andrew Jones <andrew.jones@linux.dev>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Peter Gonda <pgonda@google.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Feb 06, 2024, Sean Christopherson wrote:
> On Fri, Feb 02, 2024, Sean Christopherson wrote:
> > +int main(int argc, char *argv[])
> > +{
> > +	TEST_REQUIRE(is_kvm_sev_supported());
> 
> This also needs
> 
> 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV));
> 
> to handle the case where the platform supports SEV, i.e. /dev/sev exists, but
> KVM doesn't support SEV, e.g. if TDP is disabled, if SEV was explicitly disabled
> via module param, etc.

Thinking more about this, I think we should simply delete is_kvm_sev_supported().
(a) it obviously doesn't query _KVM_ support, and (b) if KVM says SEV is supported,
then it darn well actually be supported.

