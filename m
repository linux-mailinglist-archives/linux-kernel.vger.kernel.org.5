Return-Path: <linux-kernel+bounces-100344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 427788795F8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1E20B23A9A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E551C7AE68;
	Tue, 12 Mar 2024 14:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="yPI9Gd9b"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9010E77655
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710253412; cv=none; b=GDYwRqVbzAOnuXyaBwciXUeGNI5LGfEnp5NLnLWTFB7kZ7gParmki2P0iAc94REtuqtPTVxFZ/CkillgsSqfzDnwZ8QdLpl0PAxYK6WKeXZYi/p3B0+XlBc5B6PPU87zOM/5tg97NSQPX98sRlXjXjByFgwt22LFOJMP+Dj4ofQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710253412; c=relaxed/simple;
	bh=gf9yMtKzRBlOhLL/fmxIguN/CTFdrmIfHjtFEg9Eo+g=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=l6mJkTtFAOovz6oHm2xu54L/cvveEWxenmLSFaKmMHGcJpGEeSePqA/7KuhYBUwSHS7vtWgANE1RyUbrNVwf/f1xG5hGV6nCCK+4vl+wYb7QNhHq12q4KxfV2cO8HXd11ymPt0Bq8jJ/RgoA9cm+kp9s9VTxzbXKrfheWvCaha4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=yPI9Gd9b; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dca3951ad9so45494535ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 07:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1710253409; x=1710858209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ixjDXdUDhwXI0JLFZkupTe/KFpB3Bws3seOjqAl5dc=;
        b=yPI9Gd9b0/sHZX4nK0ssdhSH1TyxAh6WrCWLTY9SS+lNVJPhJB+BVACb5H53ie+hbX
         hYBweQcZp3gfut0+IYunnyabD75TuihKhTugYI+PbgBwFoJLAbIR7wT8AGXeXE45NtWF
         pOmjMW8c4dCHy5g3DCZ0kv5itqwE8MzLpT3SJ+LQ2MyK41t6qjPMyCIIK3CDTeIrGNrs
         yOD5kBdcGWRVcRflPZDnHFNDWkVVTzIoiNUERgaBjkJpmSUOOkioWDiwT1934PY94t1Y
         PU/BGcuI+lqwUMYyBJj97zSnOFPuYX4dEX6rmy3MpNW/5fFzAOlralB9A0vqFGhL4oGO
         J9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710253409; x=1710858209;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ixjDXdUDhwXI0JLFZkupTe/KFpB3Bws3seOjqAl5dc=;
        b=G7AaDJq720d91NBiXlW3JZKVlEQyypGYOjdlC7cIBjiXLhJ10FhTb4Eh9o3Y60346W
         ZaSmqRXF0H3Ia+bp9PJUjt0UVSAG7lKnVlAKdK4n6HIXE/Yj9hK4NplYPQJ7338nW+if
         hoGasYnL/ttGL3Ei5rOdIKcX4cIr30ph98a1shArhXhk0AFIJ5LY8aiW9pqmn3lAokQJ
         UhdIyNifyqAeOpDdpWPKSv1RyVysz6Rv78DUJ3sjd3hIvjZIXqqMiqH7jb4wukCGKj5H
         QeoewUpYW7hE6b2rf8dX0ov6564Dl88C/Mam5qipiC2UyGIham9fD9iBJQB3dy4X95t9
         Tzyg==
X-Forwarded-Encrypted: i=1; AJvYcCVjmEPzCTBfmiZr1QWUB9NsbVMqE6/oC7D93piPUOLD1kTxe+dvpD754dfEUMI8WKHLpCz2MSA/7H254I9Eg2GljcmLlL3DxgBETXTd
X-Gm-Message-State: AOJu0YxIEZ3anhBWWqczcrFkJD1CPCeRiNmko8KOfoQOQWQkiZkP6Miv
	FtaIovL60B+TyKyy7aM/0NBcTSaN9RRD9JwAMaj+X5XHtf8n9hm6ouVtZ4PHAA4=
X-Google-Smtp-Source: AGHT+IF5Tdh4z8JQsHyW1PPsqQuYiflOdAu+RNp46pn6g+B0xVaFC5Y6Ggu7odCPQpbbShIDcpWR1Q==
X-Received: by 2002:a17:902:e74a:b0:1dd:a134:5680 with SMTP id p10-20020a170902e74a00b001dda1345680mr6869873plf.69.1710253408730;
        Tue, 12 Mar 2024 07:23:28 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id jy8-20020a17090342c800b001dd5806eff3sm6836433plb.306.2024.03.12.07.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 07:23:28 -0700 (PDT)
Date: Tue, 12 Mar 2024 07:23:28 -0700 (PDT)
X-Google-Original-Date: Tue, 12 Mar 2024 07:23:26 PDT (-0700)
Subject:     Re: [PATCH v9 03/10] irqchip/riscv-intc: Introduce Andes hart-level interrupt controller
In-Reply-To: <871q93eehn.ffs@tglx>
CC: peterlin@andestech.com, acme@kernel.org, adrian.hunter@intel.com,
  ajones@ventanamicro.com, alexander.shishkin@linux.intel.com, andre.przywara@arm.com,
  anup@brainfault.org, aou@eecs.berkeley.edu, atishp@atishpatra.org, conor+dt@kernel.org,
  Conor Dooley <conor.dooley@microchip.com>, Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org,
  Evan Green <evan@rivosinc.com>, geert+renesas@glider.be, guoren@kernel.org, Heiko Stuebner <heiko@sntech.de>,
  irogers@google.com, jernej.skrabec@gmail.com, jolsa@kernel.org, jszhang@kernel.org,
  krzysztof.kozlowski+dt@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
  linux-perf-users@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
  linux-sunxi@lists.linux.dev, locus84@andestech.com, magnus.damm@gmail.com,
  Mark Rutland <mark.rutland@arm.com>, mingo@redhat.com, n.shubin@yadro.com, namhyung@kernel.org,
  Paul Walmsley <paul.walmsley@sifive.com>, peterlin@andestech.com, peterz@infradead.org,
  prabhakar.mahadev-lad.rj@bp.renesas.com, rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
  Sunil V L <sunilvl@ventanamicro.com>, tim609@andestech.com, uwu@icenowy.me, wens@csie.org,
  Will Deacon <will@kernel.org>, inochiama@outlook.com, unicorn_wang@outlook.com, wefu@redhat.com,
  randolph@andestech.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: tglx@linutronix.de
Message-ID: <mhng-d47edbdb-0a36-4adb-9575-8af094d80e5e@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Fri, 23 Feb 2024 01:06:44 PST (-0800), tglx@linutronix.de wrote:
> On Fri, Feb 23 2024 at 09:54, Thomas Gleixner wrote:
>> On Fri, Feb 23 2024 at 09:49, Thomas Gleixner wrote:
>>> On Thu, Feb 22 2024 at 22:36, Thomas Gleixner wrote:
>>>> Palmer, feel free to take this through the riscv tree. I have no other
>>>> changes pending against that driver.
>>>
>>> Aargh. Spoken too early. This conflicts with Anups AIA series.
>>>
>>>   https://lore.kernel.org/all/20240222094006.1030709-1-apatel@ventanamicro.com
>>>
>>> So I rather take the pile through my tree and deal with the conflicts
>>> localy than inflicting it on next.
>>
>>> Palmer?
>>
>> Nah. I just apply the two intc patches localy and give you a tag to pull
>> from so we carry both the same commits. Then I can deal with the
>> conflicts on my side trivially.
>
> Here you go:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-for-riscv-02-23-24
>
> Contains:
>
>   f4cc33e78ba8 ("irqchip/riscv-intc: Introduce Andes hart-level interrupt controller")
>   96303bcb401c ("irqchip/riscv-intc: Allow large non-standard interrupt number")
>
> on top of v6.8-rc1

Sorry I missed this.  I just merged this into my testing tree, it might 
take a bit to show up because I've managed to break my VPN so I can't 
poke the tester box right now...

>
> Thanks,
>
>         tglx

