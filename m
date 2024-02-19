Return-Path: <linux-kernel+bounces-71361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EFC85A408
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2207F1C231B9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE77360AE;
	Mon, 19 Feb 2024 13:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vdMIpNI5"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436E034CDE
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708347681; cv=none; b=O55Jk5B6gbrjoye7COZkg8yvSExp/drj2bxubt2TtmVNoHVJMvtUtb2jVeLvgClUNJfxtmp18pqbCMtJTbrqVwzpYzRSsQXUCgK+a89Psmvl83eHlrjiNtDBeIDD3+Hb122HtwLZ/eDJ2jVvCZtzSw6yLDKf5QM80QxXgPH2cbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708347681; c=relaxed/simple;
	bh=SFWnjeNwNJD7FjXnCCO4T0U+0JJ5Grb2rBe4WOV7eZo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=RAnvakUGYELOxZJ8cSe7jiT0/We6eOsTNIkfURxXcKAChqzmApgQFmKE6HOGPmYDT3aHlqAyKFavxu539MUxeXOtRUQt5RkLjt54I+N5fqSqzNIUE8Wnk19bBQIyxb9SUbuKSKfGMprbw8eAeU09l8PSjzWQJeh5Zg1eeVA9u+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vdMIpNI5; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-563dd5bd382so13813a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 05:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708347677; x=1708952477; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SFWnjeNwNJD7FjXnCCO4T0U+0JJ5Grb2rBe4WOV7eZo=;
        b=vdMIpNI5UgKkksP/9bDuIBo15RfKgf0x1HqIzU+6qwrQOZjhHnaYJ3hMQJK9xCO/8c
         KN6y8qGMY51qgFDCBgQxn2fT7PlVvQEb5K2G20/0KUVqMy33be/mVgIf1HQa9HYZxNZs
         VhQsbHt5tlJn1YvlIUVPa/HgV9XerD+4fp1XexoiUNcrBimTKsowDWqjzd3xzxwLd/fC
         ZkKO3teEoy9PkoYA/U2qzOGaJ2PqsOYYjCdREGxQBB4Z3nRdS41EG9xt0VQaG61iEPn8
         1tuXi0UBkWm7ve3ALcOFuTolj8V/fKDgbTwQgB0RVv3V8hVh6h5IKJW+97R1oY8aWqKO
         9thw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708347677; x=1708952477;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SFWnjeNwNJD7FjXnCCO4T0U+0JJ5Grb2rBe4WOV7eZo=;
        b=myN5YG0Orwd3t3Xx20QfIkb9EoBDmWE5k637xmXU7YiUd7cfOr1rtwZ7hbhV8GJYHz
         p/Fzgn42+8xbyV53cBByr6QTLSMt8S2v4IJnJz3nAEn9snM+h/zGQ5znB2OpCcUJjgby
         Drfwe4yl5FjprG1+/sAjcxnsjz/NOTNLW9OTBROGN/Gn3RZ3MEY9DlE7p6asrFTQrJ0C
         tHPh8SrS7536if+3kCWWRS+swX7NLCCe06bzA9pgHWUrdw+cGreIYRPSS8VFH7neKQT6
         hCxVBRjwatCoZ+VFK0Hk+nTSwNlNBbzJgT8Gd46GY7KL/8Ka1X/zDOl1rRYlSmuQTNCP
         PH0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGGGjqLLbwnPrLqNHij8vrppBhGMk9n1fZLGEk0nyUEF5CKkW/l+HPtiejYZuAVKbOT692USz6F01CSdSyx7RQMPWY0h8GoDasBxQJ
X-Gm-Message-State: AOJu0YxFn8eFm3UCOW2GZHK/2oAeC5DZmyAHveARGMrhTsZmz6lk6LmR
	MadRToiloHOHQKvZ40NRNeQUHM/xa0bYlxqFhEihTfqLBqft2MZPDxTSCihiNdPcf6eiNQMXape
	dGNest2YhC4KAnLGyQ8hbOUdm1+HeYBc3wgBF
X-Google-Smtp-Source: AGHT+IHpYMU4YqiVSY3dBqpsEMf3rMu/OQbQSacMLTWWiVD1z8BcTgLzcXXaJUJ8TbvcVgng6HSRfBQgZHFTaKuX7r0=
X-Received: by 2002:a50:9555:0:b0:563:c0e0:667c with SMTP id
 v21-20020a509555000000b00563c0e0667cmr257446eda.0.1708347677401; Mon, 19 Feb
 2024 05:01:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jann Horn <jannh@google.com>
Date: Mon, 19 Feb 2024 14:00:39 +0100
Message-ID: <CAG48ez3RmV6SsVw9oyTXxQXHp3rqtKDk2qwJWo9TGvXCq7Xr-w@mail.gmail.com>
Subject: [BUG] perf/x86/intel: HitM false-positives on Ice Lake / Tiger Lake
 (I think?)
To: Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Feng Tang <feng.tang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"the arch/x86 maintainers" <x86@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, "Liang, Kan" <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi!

From what I understand, "perf c2c" shows bogus HitM events on Ice Lake
(and newer) because Intel added some feature where *clean* cachelines
can get snoop-forwarded ("cross-core FWD"), and the PMU apparently
treats this mostly the same as snoop-forwarding of modified cache
lines (HitM)? On a Tiger Lake CPU, I can see addresses from the kernel
rodata section in "perf c2c report".

This is mentioned in the SDM, Volume 3B, section "20.9.7 Load Latency
Facility", table "Table 20-101. Data Source Encoding for Memory
Accesses (Ice Lake and Later Microarchitectures)", encoding 07H:
"XCORE FWD. This request was satisfied by a sibling core where either
a modified (cross-core HITM) or a non-modified (cross-core FWD)
cache-line copy was found."

I don't see anything about this in arch/x86/events/intel/ds.c - if I
understand correctly, the kernel's PEBS data source decoding assumes
that 0x07 means "L3 hit, snoop hitm" on these CPUs. I think this needs
to be adjusted somehow - and maybe it just isn't possible to actually
distinguish between HitM and cross-core FWD in PEBS events on these
CPUs (without big-hammer chicken bit trickery)? Maybe someone from
Intel can clarify?

(The SDM describes that E-cores on the newer 12th Gen have more
precise PEBS encodings that distinguish between "L3 HITM" and "L3
HITF"; but I guess the P-cores there maybe still don't let you
distinguish HITM/HITF?)


I think https://perfmon-events.intel.com/tigerLake.html is also
outdated, or at least it uses ambiguous grammar: The
MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD event (EventSel=D2H UMask=04H) is
documented as "Counts retired load instructions where a cross-core
snoop hit in another cores caches on this socket, the data was
forwarded back to the requesting core as the data was modified
(SNOOP_HITM) or the L3 did not have the data(SNOOP_HIT_WITH_FWD)" -
from what I understand, a "cross-core FWD" should be a case where the
L3 does have the data, unless L3 has become non-inclusive on Ice Lake?

On a Tiger Lake CPU, I can see this event trigger for the
sys_call_table, which is located in the rodata region and probably
shouldn't be containing Modified cache lines:

# grep -A1 -w sys_call_table /proc/kallsyms
ffffffff82800280 D sys_call_table
ffffffff82801100 d vdso_mapping
# perf record -e mem_load_l3_hit_retired.xsnp_fwd:ppp --all-kernel -c 100 --data
^C[ perf record: Woken up 11 times to write data ]
[ perf record: Captured and wrote 22.851 MB perf.data (43176 samples) ]
# perf script -F event,ip,sym,addr | egrep --color 'ffffffff828002[89abcdef]'
mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff82800280
ffffffff82526275 do_syscall_64
mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff828002d8
ffffffff82526275 do_syscall_64
mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff82800280
ffffffff82526275 do_syscall_64
mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff828002b8
ffffffff82526275 do_syscall_64
mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff828002b8
ffffffff82526275 do_syscall_64
mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff828002b8
ffffffff82526275 do_syscall_64
mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff82800280
ffffffff82526275 do_syscall_64
mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff82800288
ffffffff82526275 do_syscall_64
mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff828002b8
ffffffff82526275 do_syscall_64


(For what it's worth, there is a thread on LKML where "cross-core FWD"
got mentioned: <https://lore.kernel.org/lkml/b4aaf1ed-124d-1339-3e99-a120f6cc4d28@linux.intel.com/>)

