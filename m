Return-Path: <linux-kernel+bounces-108354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C82880989
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38DE283276
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DD811717;
	Wed, 20 Mar 2024 02:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="D7FppUSG"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3683C11182
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710901226; cv=none; b=f3J8QnpDYwPkRaWNWJfDEzx7icC1Gm/dpq/vxESS/ZgD+DIWUh78Osmi6t26uhYH5sgZLymx37f/AqmPMRyjhyr9ABzcijc3hYk0Fy3+bXe5Qs5+vVDA2wi9RD04NWcW9/KmQ8trv3rt4zSbOhSPL9+AhZ/dK7JL/iyGTECAMms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710901226; c=relaxed/simple;
	bh=r1a2dQmso7WmPn6SVeXwodMlSbIH+idSKJIJvPtb1Es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ExQQKLwHNL/ZCycFrWqJB54tYcao17qzRCL2M270sTkzcKmTpATmOdbxX1uBGUTsLREogoYTEGfDsyrN01tqx+O6xzj8uyUYNzPXSPKkJPh71dJFUQfm6+HLg40kk0D5x92rEHFEqBCi02/3/uqtxdMZz3SF2+/bvLVvyJ3i5Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=D7FppUSG; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2218da9620cso3933777fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 19:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710901223; x=1711506023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOyJHHqFC/8u3+w4ikgJUO8ZFv830cLwlnuWmCFNnBM=;
        b=D7FppUSG14qP71gSkaJoqQjKCJ6cyNY5tx8dTFRsNp3AlDgZ0eXR1oFSCGL6p59VTr
         KMzTdzTFNOheUTitsHl6ip7XlYK6srzhDfF2Mf6d9qaxv8QSr5gTE99KJxbtyW3hUJvq
         mJeweWpd2xEiYpcZxnO2qmtWCiP8OWVE8jzwwVFCrQPqpVGWOE6aVKlEcyeqQry+z0er
         PJBUzAmW30Pa1xhNOFJQSq5hH5fJGFz/tkUwRbcamDdZhy1sLdCEarNi9RvNUNC4FXJc
         f+J/Cfpb1r8wU5WaHP8KJrW3eYuHvJahbZUtm8Gkjt5gQuFwGDFI3yxtUmy77PYhW+MD
         ucnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710901223; x=1711506023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OOyJHHqFC/8u3+w4ikgJUO8ZFv830cLwlnuWmCFNnBM=;
        b=UA7Gw3ggdZ21AyL6ZR0E7ydNIQDs4WnKBA9XEOTsdc+9bFYFEKHp7bC9tIkj05b9uB
         XBgcmi/RcRzDnZlRNxPY0PuZyBYhag9Gr+6tQKU0pM9IV5hbW/9IwyKXz38hMko4pDpy
         ergO/nqZbeYOP1MKYTW3xeqjhkwTRuCGc2bCk0tYAisgwSF/V6cOhfG49v5e6MCpuHgd
         +IGgSvhKcrkAptHE0H91TnYguwXacxQJZv5MDus+WtrqL9fLAP7ueJna2jX2jfj5+cCY
         bp9dv5saH6fh4fBB6C7Gbtife6TgzqhQHLFErJ7aIGiJs/Ovv3Gd5zQYF9PnXnC933I7
         v0YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAa7UtgoBzrUsYvpfzO1zJdycjfNND65ATLSb19J2R1AhbNDSKIsIz1nBkRZbzlx8axX93TJZNe/GBHM4I1vA500Jmj7d8+WdJj5dV
X-Gm-Message-State: AOJu0YxXqrDbyGEOmy0OmIuvi0R+7p+rgj2hsZkNm1u4hBOkj7UsQHtj
	jxkVf8tpfJm7+1oR+QsrNapfWwSJRggh8WyV44w1fzDl0eYtokmWvmLxS3LDsrwKeQQDnlxwf6f
	vJGdLSZK5MpgmBVe7sty2oWzwC0E/GuGEyPMUyg==
X-Google-Smtp-Source: AGHT+IFD3N83WmavB5Hm7jsd91hTsO36CvDfhQosv4S2NtXZYOzNE5wIlFjWRDHY3yAUCsc8x4RZGs2LuqSiWwL1Tcc=
X-Received: by 2002:a05:6870:218a:b0:221:3ba2:fff0 with SMTP id
 l10-20020a056870218a00b002213ba2fff0mr18600721oae.45.1710901223344; Tue, 19
 Mar 2024 19:20:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <mvmy1aegrhm.fsf@suse.de>
In-Reply-To: <mvmy1aegrhm.fsf@suse.de>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 20 Mar 2024 10:20:12 +0800
Message-ID: <CAEEQ3wkg5kP7q6qnjV5Xmi_-jJnGBSLb2PkN1M88h5rjsif4oQ@mail.gmail.com>
Subject: Re: [External] [PATCH v2] riscv: use KERN_INFO in do_trap
To: Andreas Schwab <schwab@suse.de>
Cc: linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

On Tue, Mar 19, 2024 at 11:40=E2=80=AFPM Andreas Schwab <schwab@suse.de> wr=
ote:
>
> Print the instruction dump with info instead of emergency level.  The
> unhandled signal message is only for informational purpose.
>
> Fixes: b8a03a634129 ("riscv: add userland instruction dump to RISC-V spla=
ts")
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> v2: clarify commit message
> ---
>  arch/riscv/kernel/traps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index a1b9be3c4332..142f5f5168fb 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -121,7 +121,7 @@ void do_trap(struct pt_regs *regs, int signo, int cod=
e, unsigned long addr)
>                 print_vma_addr(KERN_CONT " in ", instruction_pointer(regs=
));
>                 pr_cont("\n");
>                 __show_regs(regs);
> -               dump_instr(KERN_EMERG, regs);
> +               dump_instr(KERN_INFO, regs);
>         }
>
>         force_sig_fault(signo, code, (void __user *)addr);
> --
> 2.44.0
>
>
> --
> Andreas Schwab, SUSE Labs, schwab@suse.de
> GPG Key fingerprint =3D 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D=
7
> "And now for something completely different."

Reviewed-by: Yunhui Cui <cuiyunhui@bytedance.com>


Thanks,
Yunhui

