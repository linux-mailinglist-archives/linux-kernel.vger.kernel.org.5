Return-Path: <linux-kernel+bounces-83283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9529B869142
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B97711C262A8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9633E13AA47;
	Tue, 27 Feb 2024 13:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kezAT0w6"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AFE13329D;
	Tue, 27 Feb 2024 13:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039050; cv=none; b=Gjm3wxOCkDQTwAWQzgSY2b4p76y3e0stCg/yXLwF/uPbueT7szcfWypJksxfOhOQeZ3l9+LvhUd3dnVqWDv/S3pJ6YHPVEI90EvwySAO15vCiiVo3IZUajwh2GN4LgaJipj1VVP8EtwcBdRdkWZieUn+p2JPSOpeOf6iBx3PAsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039050; c=relaxed/simple;
	bh=NlcmpxMFcKuSWGfjXh3Cy0nln/RX9DconWQ2TonOgzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbsUiPcOQP2YruyQKF6s1IlQtMz1YOrvMGhYlYmT/P5oS/+j6G/f3riXC0+U6MFfH60PSw/f9RgeMQu4dURUoZ063Klv5YEKcJ6/ahuUeB5AV7e+E3Ef9lbFjCTzKW9exrb0WcGYVt4u+fGR7bRXZMONjJoaaavVFe/2DkVR4Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kezAT0w6; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5a058b9bd2dso1958012eaf.2;
        Tue, 27 Feb 2024 05:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709039048; x=1709643848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HptIF1yWZvMjjphHz7xj8eIlIunqnVXVXD3nCrOY+7Q=;
        b=kezAT0w6/Q0XrbrYHmQJF10Tn8UolVQL0oHiV2Ji3n6WAtCZTFSRmqJ/9Tg2jn/wmP
         s84uFlOVVgmtWJpgFb6pLbeiVqBsg96mWcfzZiGQSDq0YA9diZXibFIVTP51QZOGfDQg
         pbkcWsxI71RlpqQBbpn0W+WIRD5QgQDpshwTsZr10OBgzMM/K9KqVkl1kBpO5DVE+thw
         +KXPatmrFaQdrx/ZDT5Rd6ev3OzrdvoojPiyLLxddc6FZIFC0za37NyLG85aznvN0j3P
         dPn2GnH1iUgNG9iTuFbrsMzoldgKQPNE5WnqwKvB4zJ0q1YNLGNk9XskQ7LpdRAII9bj
         xAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709039048; x=1709643848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HptIF1yWZvMjjphHz7xj8eIlIunqnVXVXD3nCrOY+7Q=;
        b=FMV8nvRMQmBnC5s81dIlnppJf2v3jrxGP2J0fx+pMVHXZmqMD76Lyx8waotBsLGekW
         YYdY2UXIU+c0Pv3D/+R9sTvNENqknXFCSQz2vjaNCE5M6upX4JUgmpTZtbBhPTIX1183
         dT1iViiXzw7gKU3Jpj/G3nKX6n9zeo5ZRMExoEUTzJs54hdxig1kh/IrmxQEesJPKRLU
         bRfdeynKe4J2r3vuD+13NYeFfBOVQ9Rd7yEwazp6eBnC2mdMIGmqMpYnrZHuZ6qiSKzW
         Vhj1Ismuge7P+GbQN73VjmgD2FlDP3Ck80qwudE6/6kdFjakSANivwSgUfdGuNhIrYjL
         k6bA==
X-Forwarded-Encrypted: i=1; AJvYcCXWI7zVsitsFUKihQFTElf0s/UWCDyvBWklDu0oY4TPi2ywtzCE3N7XVp4gM0v4YYEOXLWc37ZMbLKxbnfvhj3vk0h/MKUQ9fN/pnBSMtuyqX8TsP1ULFa2wBpaUrxgLQxNkqhxfUsgCw==
X-Gm-Message-State: AOJu0YzVqJfU6nMn5hcWmLX/RmUFHGBmT8q1mqrr3bYQbrajYKbQgDXm
	6KCPT7rvM6y7/r5phdcaXXOW75G4biOlklNebkacL21e+x+RsuOV0rc/gATNQRQL1J2tHQccVYQ
	ehFz5P4WfHQOGzrg1kcq2PbIVMfA=
X-Google-Smtp-Source: AGHT+IGJ4Y6WAzCnIwhWdJgaVB3PqjPLh3CpaDhTF27xh2aL6QNM84mqgLvmeqLfQ/uaKvETFhq3YkEAD9zf35D+Dw0=
X-Received: by 2002:a4a:6f4d:0:b0:5a0:30af:6b6f with SMTP id
 i13-20020a4a6f4d000000b005a030af6b6fmr8367251oof.7.1709039047973; Tue, 27 Feb
 2024 05:04:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205171930.968-1-linux.amoon@gmail.com> <20240205171930.968-4-linux.amoon@gmail.com>
 <4248e19e-5f2f-4e4f-a869-a0fec81b16bd@lexina.in> <E850AF1E-BF7E-45F7-8AF0-68B548166094@gmail.com>
In-Reply-To: <E850AF1E-BF7E-45F7-8AF0-68B548166094@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 27 Feb 2024 18:33:51 +0530
Message-ID: <CANAwSgRmwXUqb-NUadgS1ENLvJQZXX9xjc4V6j+vw7jHf+dZZA@mail.gmail.com>
Subject: Re: [PATCHv1 3/5] arm64: dts: amlogic: Add cache information to the
 Amlogic G12A SoCS
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	devicetree <devicetree@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, 
	AML <linux-amlogic@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	Viacheslav <adeep@lexina.in>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian / Viacheslav,

On Tue, 6 Feb 2024 at 13:23, Christian Hewitt
<christianshewitt@gmail.com> wrote:
>
> > On 6 Feb 2024, at 11:48=E2=80=AFam, Viacheslav <adeep@lexina.in> wrote:
> >
> > You missed the AXG family with the Cortex-A53 CPU. The datasheet does n=
ot provide information on cache sizes. Given that the A113X/A113D are equip=
ped with the Arm Cortex-A53 processor, it is assumed they use the same cach=
e size as the S905/S905X/S905X2 models.
>
> GXM is also missing, and also using A53 cores.
>
> Christian
>

This patch is valid if the hardware supports perf PMU events, see below
I dont have the hardware.

Best way to let the Amlogic SoC members comment on the CPU  L1/ /L2 cache s=
ize.
But with the lack of pref PMU events we cannot test this feature.

alarm@archl-librecm ~]$ sudo perf list

List of pre-defined events (to be used in -e or -M):

  branch-instructions OR branches                    [Hardware event]
  branch-misses                                      [Hardware event]
  bus-cycles                                         [Hardware event]
  cache-misses                                       [Hardware event]
  cache-references                                   [Hardware event]
  cpu-cycles OR cycles                               [Hardware event]
  instructions                                       [Hardware event]
  alignment-faults                                   [Software event]
  bpf-output                                         [Software event]
  cgroup-switches                                    [Software event]
  context-switches OR cs                             [Software event]
  cpu-clock                                          [Software event]
  cpu-migrations OR migrations                       [Software event]
  dummy                                              [Software event]
  emulation-faults                                   [Software event]
  major-faults                                       [Software event]
  minor-faults                                       [Software event]
  page-faults OR faults                              [Software event]
  task-clock                                         [Software event]
  duration_time                                      [Tool event]
  user_time                                          [Tool event]
  system_time                                        [Tool event]

armv8_cortex_a53:
  L1-dcache-loads OR armv8_cortex_a53/L1-dcache-loads/
  L1-dcache-load-misses OR armv8_cortex_a53/L1-dcache-load-misses/
  L1-dcache-prefetch-misses OR armv8_cortex_a53/L1-dcache-prefetch-misses/
  L1-icache-loads OR armv8_cortex_a53/L1-icache-loads/
  L1-icache-load-misses OR armv8_cortex_a53/L1-icache-load-misses/
  dTLB-load-misses OR armv8_cortex_a53/dTLB-load-misses/
  iTLB-load-misses OR armv8_cortex_a53/iTLB-load-misses/
  branch-loads OR armv8_cortex_a53/branch-loads/
  branch-load-misses OR armv8_cortex_a53/branch-load-misses/
  node-loads OR armv8_cortex_a53/node-loads/
  node-stores OR armv8_cortex_a53/node-stores/
  br_immed_retired OR armv8_cortex_a53/br_immed_retired/[Kernel PMU event]
  br_mis_pred OR armv8_cortex_a53/br_mis_pred/       [Kernel PMU event]
  br_pred OR armv8_cortex_a53/br_pred/               [Kernel PMU event]
  bus_access OR armv8_cortex_a53/bus_access/         [Kernel PMU event]
  bus_cycles OR armv8_cortex_a53/bus_cycles/         [Kernel PMU event]
  cid_write_retired OR armv8_cortex_a53/cid_write_retired/[Kernel PMU event=
]
  cpu_cycles OR armv8_cortex_a53/cpu_cycles/         [Kernel PMU event]
  exc_return OR armv8_cortex_a53/exc_return/         [Kernel PMU event]




> >
> > Best regards,
> > --
> > Viacheslav Bocharov <adeep@lexina.in>
> >
> > _______________________________________________
> > linux-amlogic mailing list
> > linux-amlogic@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-amlogic
>
>

