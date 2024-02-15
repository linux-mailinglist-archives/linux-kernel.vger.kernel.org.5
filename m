Return-Path: <linux-kernel+bounces-67381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C7A856AAD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9EA1C241D2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFF813666C;
	Thu, 15 Feb 2024 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jqkhZqRB"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE34D136663
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 17:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017231; cv=none; b=q4VWbPVc5hx0lu+DgaS3bzKTTIDd5MZRpCDWRr5f/qHQxdmpoN+YAcX32LgQk9gE8Vss/5WhVWjOR8VDQO75tJTYrFFdB1s3iXEUfVCmQnByaEFBg1XyV15ZGzxW8zAeAeGU/CsFJfxkWqSUKqyIfK09PsS+xvzc1EGKw6PsW7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017231; c=relaxed/simple;
	bh=4KfSgtAfZD37/FIJaRSDhjOsPagNqzXs4cq+YyiV67s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SmuPfqBYJMfqD1jgGjkQbvSkPUp6qE7WIB8lKtYFUA5CtHzXOJHXe3ogB8OK18IQb4TAKx7b8r7kbDpmo1E4Ur0OJCIHgJUzi+gWaoDh97nDsItqu/SDk41tUjMvXxinIkGd9V41RNfWuO3Bv0KBks6CakaHJcoH9o7bgL0AktQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jqkhZqRB; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56037115bb8so11602a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708017228; x=1708622028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iad/Zy2GjaaFx2a8li/jYlFETFryFlNntHsoRxU5KYM=;
        b=jqkhZqRBBaVdBA55C1Fq6rVhn++GE+mM9N54C11HatzK4ttfqKXJoEfYpUEJKxsWQI
         GWb+XK8X+rS60ZYa/4bMKW6V3/KQrK/4OAWRvGj3LqvYhDV491nyifCEKGYIjv8CK+ZU
         bi2FvvJeC9I7CxYxfa9TYgvqpD4KAWp0HLTSzJ805/Xzo8TM6ustSkzOg4nYaqjQUc5G
         XDs20ShDjDo2Rh8cHLy2GkbOosXOfDrgDbd2p5YVDfJ2y5qo4XmmVwHYU1ZQlW+AxJno
         9Cn9aatqPDm5wuQMasD2lm3jg4lQnOKhgF8zuDx1DWdFXOstkB2oCGE073McfnJhgkBV
         ytdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708017228; x=1708622028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iad/Zy2GjaaFx2a8li/jYlFETFryFlNntHsoRxU5KYM=;
        b=aWZi1YnGwF12z3EHCoGPBWkFkXCWqFAj3LA+NYeiO/KjXYZVTd5+Jg70aS5jPptIki
         YsHhz6Tuz2XY6VGUL0Jr5TpEM643gbh4f6Bikln5VDJXrdatm7KYaWUIS92jziqHkDif
         EZL7aIfgwfFIM29CbWGtMIP9RCiHwBEYFkFx59okDTAXyOm+nrZimx2cRc4E9TG9IAbH
         Q/jTLOHTraYRIsisQT2EucQDWLcsmhZCUlQNErzXVX9ko+1SvxYj6C7bQd3dZHZX2xoH
         QA9zpzGbKk2RMvhJhDS3J9XHDh4UXF1aIfgRjQFvhyADIIZYSX29/WJQAXnch/X5UVDE
         z6mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUya43vXBIjmFvpBEQX+lUcb3aWdBSmBVmXe6BREzm2OstiwoNpY3zsjrGZhUqicQmZTy3VS5z19s/5LoSEObG95N5RBaQhV4TVOdCu
X-Gm-Message-State: AOJu0YyYdRpgSZI8nV+j/YJDrLTaW6CvavYoaFBdqBbWtt5XzzWmrA1X
	e+jv7ewQfGL5tWvgCxBODzVXFjHKUSBEG2SqcEqi1kp9DLMUdOGB8oIfJidJQdMfiVPAXFEXrdJ
	w8RP35jiG/W/k2bjUtBbn8sFUPLC8Rv2XFQxK
X-Google-Smtp-Source: AGHT+IGZNw7fc2kZJJpDXqC9iEc2obKjv5RjjbUoiLxpw1mSvwqdqqrem5zu7gKD2XqXNNmwDH4VTc78e12HGaid2y4=
X-Received: by 2002:a50:cd8c:0:b0:562:70d:758 with SMTP id p12-20020a50cd8c000000b00562070d0758mr1150edi.2.1708017227953;
 Thu, 15 Feb 2024 09:13:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215010004.1456078-1-seanjc@google.com> <20240215010004.1456078-2-seanjc@google.com>
In-Reply-To: <20240215010004.1456078-2-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 15 Feb 2024 09:13:36 -0800
Message-ID: <CALMp9eSg5eDiraSMptLvyLkTXaH4DYX48xG_hKXEqzN_tHMUEw@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: x86: Mark target gfn of emulated atomic
 instruction as dirty
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Michael Krebs <mkrebs@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 5:00=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> When emulating an atomic access on behalf of the guest, mark the target
> gfn dirty if the CMPXCHG by KVM is attempted and doesn't fault.  This
> fixes a bug where KVM effectively corrupts guest memory during live
> migration by writing to guest memory without informing userspace that the
> page is dirty.
>
> Marking the page dirty got unintentionally dropped when KVM's emulated
> CMPXCHG was converted to do a user access.  Before that, KVM explicitly
> mapped the guest page into kernel memory, and marked the page dirty durin=
g
> the unmap phase.
>
> Mark the page dirty even if the CMPXCHG fails, as the old data is written
> back on failure, i.e. the page is still written.  The value written is
> guaranteed to be the same because the operation is atomic, but KVM's ABI
> is that all writes are dirty logged regardless of the value written.  And
> more importantly, that's what KVM did before the buggy commit.
>
> Huge kudos to the folks on the Cc list (and many others), who did all the
> actual work of triaging and debugging.
>
> Fixes: 1c2361f667f3 ("KVM: x86: Use __try_cmpxchg_user() to emulate atomi=
c accesses")
> Cc: stable@vger.kernel.org
> Cc: David Matlack <dmatlack@google.com>
> Cc: Pasha Tatashin <tatashin@google.com>
> Cc: Michael Krebs <mkrebs@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Let's try this again, gmail...

Reviewed-by: Jim Mattson <jmattson@google.com>

