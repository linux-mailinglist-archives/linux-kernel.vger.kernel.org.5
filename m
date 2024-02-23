Return-Path: <linux-kernel+bounces-78172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AFA860FC8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF56D1C231C8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80147BB17;
	Fri, 23 Feb 2024 10:42:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCC75C902;
	Fri, 23 Feb 2024 10:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684950; cv=none; b=X/UgveILCZeNVerDYBfd2lmG1R3pnv9mPFqEqoAS/ocai4jr9UuDLGF4IVykUhQ6x/h68iGfWJHchlCG1ZfBJbeclDXIETetXlOZWuPkE8khu2zjKd4bS0dvm5bkNGv4PPuMCGprthfiFODpv2TfanjcQCKth/Bsyk9UuPgCHGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684950; c=relaxed/simple;
	bh=TuRfPZIINLDlgF89geTHSbS2hhL4J/pD5I7aljCqZF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOv8lRulHmXAhi/4PX5VH6WQU9PsgFdhUWZZviNUHUBO9yFYLbZBbTmFK9RSf1d3u0JY4I2/FlhZhcm8HXwsuAzHAr4jKIAOnIz8i4tU4TUDp+3+wKJof6Cp5zgSPVKCorkmnBmP2uEI+Qm7M+X6e8h6XRB7PacEeAzDrDDnFTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28E9F1596;
	Fri, 23 Feb 2024 02:43:06 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.66.180])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45B013F762;
	Fri, 23 Feb 2024 02:42:25 -0800 (PST)
Date: Fri, 23 Feb 2024 10:42:16 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: syzbot <syzbot+07144c543a5c002c7305@syzkaller.appspotmail.com>
Cc: acme@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, eadavis@qq.com,
	irogers@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	namhyung@kernel.org, netdev@vger.kernel.org, olsajiri@gmail.com,
	peterz@infradead.org, syzkaller-bugs@googlegroups.com,
	xrivendell7@gmail.com
Subject: Re: [syzbot] [perf?] WARNING in perf_event_open
Message-ID: <Zdh2fjuWi0sQIhpV@FVFF77S0Q05N>
References: <000000000000e8099a060cee1003@google.com>
 <00000000000007401c061204919d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000007401c061204919d@google.com>

On Thu, Feb 22, 2024 at 07:58:02PM -0800, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 7e2c1e4b34f07d9aa8937fab88359d4a0fce468e
> Author: Mark Rutland <mark.rutland@arm.com>
> Date:   Fri Dec 15 11:24:50 2023 +0000
> 
>     perf: Fix perf_event_validate_size() lockdep splat
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=157c509c180000
> start commit:   5abde6246522 bpf: Avoid unnecessary use of comma operator ..
> git tree:       bpf-next
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8f565e10f0b1e1fc
> dashboard link: https://syzkaller.appspot.com/bug?extid=07144c543a5c002c7305
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ba8929e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17be7265e80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
> #syz fix: perf: Fix perf_event_validate_size() lockdep splat

I believe syzbot is correct; this is fixed by commit:

  7e2c1e4b34f07d9a ("perf: Fix perf_event_validate_size() lockdep splat")

.. so:

#syz fix: perf: Fix perf_event_validate_size() lockdep splat

Mark.

