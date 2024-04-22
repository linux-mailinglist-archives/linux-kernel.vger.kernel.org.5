Return-Path: <linux-kernel+bounces-152738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF5E8AC3A1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E4FC1C21226
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9B91862F;
	Mon, 22 Apr 2024 05:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="QTcc38Hv"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E90818C3B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 05:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713763507; cv=none; b=ac64cslOGErU/ODTD71CcfVA5FGxUpcYSlM8oU5wK75a0aNXErrlxfk4lbeKWNcOgmq8W5Ssa96LYdoKS/9KrjSvTrsh5dzexzlMdtb3kKV51ae1n/1W3Vuus45ygnmyYapXnz09IW1PydmAVMFpCwq7lYtjTiq8n4eMYEAevm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713763507; c=relaxed/simple;
	bh=Ik9DM1QNpRlU+dZ0CiUmfKQUt5GK17SQR7pdunVTi1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IbBbK9NvOFxMtH/N418D9tWw3l9Fj+0uViIYTwzIaFgoFxIQWI7IQzdi6FRjZA72QiHYvifti/AazaOz+c3JuMsyQN4bbFjxtwLAa1q9qdzjZKmPmJf7S+tTvBKtuJRNdcfGoPDaxemfKdQOnPVdvrxgBPND24K7pfyRbRX14+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=QTcc38Hv; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36c134743abso233565ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 22:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1713763503; x=1714368303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dF7iMXOY4VDDCKv5qNAPNo7XCDSpEYvkOWLnZnfiQso=;
        b=QTcc38HvYi+gmcROXNRPsN2+ACsXYSft+1UQ15tpXXXGoGqZlrz19XifTGmH4TgnQY
         Zof3ACGEUZ/cK87E0+XDCuiBkB+WplA5CAaxOwnxx2V6JthzB5/C3AmcataAjo6BWJSV
         k1pmen2KHTwR3Y5Ygo9ScVSJySmr3kzaXiyX7NEEB/h1/u9sx00ZJxSuXeJO2lzqdAdw
         c0eIU6EUtvTPi4STzxTw558iLQ7E7vV6VNAu/O3RWFC6vK1UjAK8KccfdVgeDNooDh6X
         AgxwUxgEW9A1CiY4wFERXwV2cZoCBxCqzCRldZFr0WxJVeuOVubx6zV1g3e77iPEYgTL
         NmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713763503; x=1714368303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dF7iMXOY4VDDCKv5qNAPNo7XCDSpEYvkOWLnZnfiQso=;
        b=aFptPqa8CHmaozU94ggvtXZ9CGSTI9rzd3hgE6ZSl+KuFGSisCp74IQk8bJEwclARF
         xrYhhtemkTlmhSNE7A6tLEkYQYvA4kaj+j1B2e+QwOuDZNZi6LiIk3F39jhl1IcLzFBv
         xz4ukSpY5ndzalc1Ll0lIN5aDMISsMfSe0ELVxM01QTzpqNz08bI1TiLLJRIBSHJpm3K
         f8+JPIpdY78cYFaZaDkO/CK6z49nPooyu9Ez++kxtQxOhczWxJOOECXvvMsZEhap8RzD
         JeYKzJ19q38ymZ1FjdpythG3YiWdfgebYSzQW3WQFvKUGaJGSlYSqCoou9zBriXloifq
         HvRA==
X-Gm-Message-State: AOJu0YwaeMHzXVht8Q1rsY1oqJUg2tCvVMEvY2slgxLxKgOqVJhYG0Wk
	86wkz97h3DHgijOAfkc/Z3yIFJc71m6/W8gJE083WbXRv29AQ+kcoPOc676mBbkY+mRIhCRiKh+
	Ps7QxI3cbgQPJfivQmNz79Qq5sZYKbS8S9pkrTA==
X-Google-Smtp-Source: AGHT+IHdn2npWqT6eXE8OXOJ8aeE+1uvyLE2k3jLpLR2kMrW4luyMtoF2cYuLh1aaMn2GPPBLemb20goD4jLZbNz7Kk=
X-Received: by 2002:a05:6e02:152e:b0:36c:a46:e018 with SMTP id
 i14-20020a056e02152e00b0036c0a46e018mr5159166ilu.24.1713763503545; Sun, 21
 Apr 2024 22:25:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420151741.962500-1-atishp@rivosinc.com> <20240420151741.962500-11-atishp@rivosinc.com>
In-Reply-To: <20240420151741.962500-11-atishp@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 22 Apr 2024 10:54:52 +0530
Message-ID: <CAAhSdy34VhGY3v9h3cw167MafKHOF1dL6zqB7Wi6A9Z4fo7ZNg@mail.gmail.com>
Subject: Re: [PATCH v8 10/24] RISC-V: KVM: Fix the initial sample period value
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Andrew Jones <ajones@ventanamicro.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, samuel.holland@sifive.com, 
	Conor Dooley <conor.dooley@microchip.com>, Juergen Gross <jgross@suse.com>, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	Will Deacon <will@kernel.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 5:18=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> The initial sample period value when counter value is not assigned
> should be set to maximum value supported by the counter width.
> Otherwise, it may result in spurious interrupts.
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/kvm/vcpu_pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index 86391a5061dd..cee1b9ca4ec4 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -39,7 +39,7 @@ static u64 kvm_pmu_get_sample_period(struct kvm_pmc *pm=
c)
>         u64 sample_period;
>
>         if (!pmc->counter_val)
> -               sample_period =3D counter_val_mask + 1;
> +               sample_period =3D counter_val_mask;
>         else
>                 sample_period =3D (-pmc->counter_val) & counter_val_mask;
>
> --
> 2.34.1
>

