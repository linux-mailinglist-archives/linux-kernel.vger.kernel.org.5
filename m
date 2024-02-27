Return-Path: <linux-kernel+bounces-83284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7FB869143
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FBE11C263C6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E9713A88A;
	Tue, 27 Feb 2024 13:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjzM8JEm"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2814913AA2A;
	Tue, 27 Feb 2024 13:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039064; cv=none; b=VEbSwA1dMEgBaw1cTLDVn9GQow37B2zFXuQmWI9R92nvCRfqZMBL0WA8uF1HnJynxw9a6p14w0x/D4L2bsmRwQtpaNGd66v9cbIYYhgI1hJfDf6IIfuG32gDAGqD2FUBhTIHxLi60DxvHnL12SWGvGJX53Bh1cU5akYQ+X/jZo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039064; c=relaxed/simple;
	bh=Mt/4P+2QS2VZfTkmlXi8V7FiUmQV8Vur/xYbaL/ix50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHmFZDTS031R0V0E/c4E6Rqb4SSA8paY+GfyzswS5exQg6CPZdWDE+PIPmnr7Q9f1YktDT8a+TiIOuO8yYQZxysyIJZ7iioE5iFX/m5LltbCjmIxIsBvkv6Ld0/jCRWgHMNXUrltsXdVhib7BiMihbR1uPThcaS5SAjI2iKxGwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjzM8JEm; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5a04dd6721dso1128958eaf.0;
        Tue, 27 Feb 2024 05:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709039062; x=1709643862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmGIhE1/yiAnczVNxJafVkaO2xp7KonC01JesBARNDo=;
        b=BjzM8JEmU2BOg1BKu+Ms/o82ebOsonEFetDPDQbOrImaz/SmIV4rLmgdsTvxx7ZgY4
         epBhkexauufQtPyUzloLu6j944wMvhX1ccegSgzs6EjdsWcekyc5FfWLwbvYBGgLO9Hl
         31j1DY8ruiptpC7E+wmVFQItUkCtakyQsgyCbBDBVQr0v8o1Ah7DcJXLiB6282mampz6
         gxVQVG/6/trUR/bC3/vANoY5qDXLAmSWsamYGPzq9SJF5P7uFeEY992C3PjWSRvFWRkL
         okF2eyPxKjGndHJiy0Y/Y9hDaogPD1IbtSWdGWXZ/7Jx/Eq8H6+9yPYXbuX7p+QZ+L9r
         y0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709039062; x=1709643862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KmGIhE1/yiAnczVNxJafVkaO2xp7KonC01JesBARNDo=;
        b=e9JoMTvXQtrBtDnAfTn6dEA6K1H+doZCyNqWqJZY6AcAIf34VGsOlNIq9CpcipH2Wy
         seFrEpot00n0rOjN6g5QpWGS8dA3xazcdTlj2cbsqMhvphR+nCU0pnTFZHSsZsQjc1+m
         6AbqVBHNowC0OYxHZnA8ak30IqgpmJ1kVpOiSV45EaT0xkJB6Gva1Z1LIZGYqOr5d0zG
         p10tPypCqTm+W9yYwEOUNhkHDEMHV70BeN90YfalVTcKdZO6H5GdlulzwE0i04UM7zrn
         KVbPvCdWJzRRXAUubUdUOHG8q8I4Yepn+kYQ7qeIvET8Z/FztMEBMA8ZY8VlRMunIiar
         95hA==
X-Forwarded-Encrypted: i=1; AJvYcCXZxma0jC9Jpo8OBcoSc/Km57/4LRZjZZJb0doDis9yPpCJTGxFk2/RC/D6G9vsL4qBRpNvlFsB9bpKrG/ZREr1WRpXj7AQeP2XIBmOgHoCwtvWgo0uESdzz4bXtEw4UKT5o6EjsX8HZw==
X-Gm-Message-State: AOJu0Yz0z85qSkt9jSf1NG0tMHAHqPMZ0ZRsg6waQ/IX8x2KgkbEkSPq
	0ODZ3plzc04cPO/aXE0o6lYHaszGD5n0an97xNdCH+l5/oacvdt5PWOZFV5iZFBBr5BnY3CInyJ
	IpRS7rPpSMEdnDC2Jcvsg/YRfW2c=
X-Google-Smtp-Source: AGHT+IGxJzeAEVxdv8cuiqF70NYJMK21XSZ6TXCxSS4URg5FBbqpRHb9nXTWZ3TQvYRw7dGRitIBE98EwmUuCRyti+o=
X-Received: by 2002:a4a:7617:0:b0:5a0:3917:5d46 with SMTP id
 t23-20020a4a7617000000b005a039175d46mr8684041ooc.2.1709039061908; Tue, 27 Feb
 2024 05:04:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205171930.968-1-linux.amoon@gmail.com> <20240205171930.968-5-linux.amoon@gmail.com>
 <cf47b82c-6307-475b-af3a-eab7f09715f0@linaro.org> <CANAwSgTOpDmZGR33veBWrzr75=xEZ-28iu=GeCzqa0ZPXxDchw@mail.gmail.com>
 <f87069a4-042c-467a-94fb-0b65bfa4758d@linaro.org>
In-Reply-To: <f87069a4-042c-467a-94fb-0b65bfa4758d@linaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 27 Feb 2024 18:34:05 +0530
Message-ID: <CANAwSgR1+Fb5Si6yBU6JXCfRiq-XU0xjr-ecVbnALMj7qmv0Sg@mail.gmail.com>
Subject: Re: [PATCHv1 4/5] arm64: dts: amlogic: Add cache information to the
 Amlogic S922X SoC
To: neil.armstrong@linaro.org
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Niel,

On Tue, 6 Feb 2024 at 20:31, <neil.armstrong@linaro.org> wrote:
>
> On 06/02/2024 11:15, Anand Moon wrote:
> > Hi Neil,
> >
> > On Tue, 6 Feb 2024 at 14:30, Neil Armstrong <neil.armstrong@linaro.org>=
 wrote:
> >>
> >> On 05/02/2024 18:19, Anand Moon wrote:
> >>> As per S922X datasheet add missing cache information to the Amlogic
> >>> S922X SoC.
> >>>
> >>> - Each Cortex-A53 core has 32 KB of instruction cache and
> >>>        32 KB of L1 data cache available.
> >>> - Each Cortex-A73 core has 64 KB of L1 instruction cache and
> >>>        64 KB of L1 data cache available.
> >>> - The little (A53) cluster has 512 KB of unified L2 cache available.
> >>> - The big (A73) cluster has 1 MB of unified L2 cache available.
> >>
> >> Datasheet says:
> >> The quad core Cortex=E2=84=A2-A73 processor is paired with A53 process=
or in a big.Little configuration, with each
> >> core has L1 instruction and data chaches, together with a single share=
d L2 unified cache with A53
> >>
> > Ok,
> >
> > Since all the Cortex=E2=84=A2-A73 and Cortex=E2=84=A2-A53 share some im=
provements in
> > the architecture with some improvements in cache features
> > hence I update the changes accordingly.
> > Also, I checked this in the ARM documentation earlier on this.
>
> I don't understand, Amlogic states it's a shared L2 cache, but you trust
> the ARM documentation instead ???

Yes please find the Cortex=E2=84=A2-A73 TRM
L1 Cache
https://developer.arm.com/documentation/100048/0002/level-1-memory-system/a=
bout-the-l1-memory-system?lang=3Den
L2 Cache
https://developer.arm.com/documentation/100048/0002/level-2-memory-system/a=
bout-the-l2-memory-system?lang=3Den
>
> >
> >> And there's no indication of the L1 or L2 cache sizes.
> >
> > What I feel is in general all the Cortex=E2=84=A2-A73 and Cortex=E2=84=
=A2-A53 supports
> > L1 and L2 cache size since it is part of the core features.
> > but I opted for these size values from a Wikipedia article.
> >
> > On my Odroid N2+, I observe the following.
> >
> > I have also done some testing on the stress-ng to verify this.
>
>
> Ok I don't feel confident adding numbers that comes out of thin air,
> and even more since they are only shared to userspace.
>
> I think we should only add the numbers which are 100% sure

Best way to let the Amlogic SoC members comment on the CPU  L1/ / L2 cache =
size.
But with the lack of pref PMU events we cannot test this feature.

>
>
> This looks pretty, but let's keep exporting verified data.
>

This CPU hardware supports cache this feature, but with missing PMU for thi=
s cpu
so its not getting listed hardware events like cache-misses cache-reference=
s

alarm@archl-on2:~$ sudo perf list
[sudo] password for alarm:

List of pre-defined events (to be used in -e or -M):

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
  meson_ddr_bw/chan_1_rw_bytes/                      [Kernel PMU event]
  meson_ddr_bw/chan_2_rw_bytes/                      [Kernel PMU event]
  meson_ddr_bw/chan_3_rw_bytes/                      [Kernel PMU event]
  meson_ddr_bw/chan_4_rw_bytes/                      [Kernel PMU event]
  meson_ddr_bw/total_rw_bytes/                       [Kernel PMU event]
  rNNN                                               [Raw hardware
event descriptor]
  cpu/t1=3Dv1[,t2=3Dv2,t3 ...]/modifier                  [Raw hardware
event descriptor]
       [(see 'man perf-list' on how to encode it)]
  mem:<addr>[/len][:access]                          [Hardware breakpoint]
  alarmtimer:alarmtimer_cancel                       [Tracepoint event]
  alarmtimer:alarmtimer_fired                        [Tracepoint event]
  alarmtimer:alarmtimer_start                        [Tracepoint event]
  alarmtimer:alarmtimer_suspend                      [Tracepoint event]
  asoc:snd_soc_bias_level_done                       [Tracepoint event]
  asoc:snd_soc_bias_level_start                      [Tracepoint event]
  asoc:snd_soc_dapm_connected                        [Tracepoint event]
  asoc:snd_soc_dapm_done                             [Tracepoint event]
  asoc:snd_soc_dapm_path                             [Tracepoint event]
  asoc:snd_soc_dapm_start                            [Tracepoint event]
  asoc:snd_soc_dapm_walk_done                        [Tracepoint event]
  asoc:snd_soc_dapm_widget_event_done                [Tracepoint event]
  asoc:snd_soc_dapm_widget_event_start               [Tracepoint event]
  asoc:snd_soc_dapm_widget_power                     [Tracepoint event]
  asoc:snd_soc_jack_irq                              [Tracepoint event]
  asoc:snd_soc_jack_notify                           [Tracepoint event]
  asoc:snd_soc_jack_report                           [Tracepoint event]
  binder:binder_alloc_lru_end                        [Tracepoint event]
  binder:binder_alloc_lru_start                      [Tracepoint event]
  binder:binder_alloc_page_end                       [Tracepoint event]
  binder:binder_alloc_page_start                     [Tracepoint event]
  binder:binder_command                              [Tracepoint event]
  binder:binder_free_lru_end                         [Tracepoint event]
  binder:binder_free_lru_start                       [Tracepoint event]
  binder:binder_ioctl                                [Tracepoint event]
  binder:binder_ioctl_done                           [Tracepoint event]
  binder:binder_lock                                 [Tracepoint event]
  binder:binder_locked                               [Tracepoint event]
  binder:binder_read_done                            [Tracepoint event]
  binder:binder_return                               [Tracepoint event]
  binder:binder_transaction                          [Tracepoint event]
  binder:binder_transaction_alloc_buf                [Tracepoint event]
  binder:binder_transaction_buffer_release           [Tracepoint event]
  binder:binder_transaction_failed_buffer_release    [Tracepoint event]
  binder:binder_transaction_fd_recv                  [Tracepoint event]


[root@archl-on2 alarm]# perf stat -B -e
cache-references,cache-misses,cycles,instructions,branches,faults,migration=
s
sleep 5

 Performance counter stats for 'sleep 5':

   <not supported>      cache-references
   <not supported>      cache-misses
   <not supported>      cycles
   <not supported>      instructions
   <not supported>      branches
                56      faults
                 0      migrations

       5.003404106 seconds time elapsed

       0.003396000 seconds user
       0.000000000 seconds sys

Thanks



-Anand

