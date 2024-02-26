Return-Path: <linux-kernel+bounces-81890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13688867B9E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451801C2A487
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B70512C7F1;
	Mon, 26 Feb 2024 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cF//Q6Fc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10CC12BEA1;
	Mon, 26 Feb 2024 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964480; cv=none; b=FcMXVJHyZXV/ZgINGYAtKakRnbiaNpzpBMreT5qcmqTUWVmv/usz3s+bdVHrlJJBwkXxRGFti7iGWuOulhQiSm5v+19xAKJDKJpayWx8aTYzCBIL7MeLJznNyKvLjyru9a6A8QPKBHIB2ndCqLcxYuiIfGPxxw5j7/CxI+PDfhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964480; c=relaxed/simple;
	bh=R6yxrXujX0jfOIll4TI/UYi3wy+Ea/LBT8jqilVrwiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hKIK8JN3/VJqVyCZvHyVxx0LVGfQStFr8EK30C2tTuDTV0jM2ut3f2N78QcfJMOULf0umeRfAd8UP+e/scymdEaHmT98eiWwK7foWkTCK5tJbkg77GG3jzGuMthny8CngSitSDS2t7vLu+KpGM4wXI5pJCAWTRxGcaaJv28r7fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cF//Q6Fc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F23C433F1;
	Mon, 26 Feb 2024 16:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708964479;
	bh=R6yxrXujX0jfOIll4TI/UYi3wy+Ea/LBT8jqilVrwiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cF//Q6FcrtHLiC6DHEAN7oNTERuKBhSi5/isIxW21Evf5p/DcR3/FuYyfUsvnsEkh
	 qjA+Slr8PrLNa3alCeX4PjxGOc0utZt7bw+LtvgKb8/2JndUCDO7wkMz9m5TDK90/U
	 ZwvGLkqdzLBBXsooZd7RcXs/x3WPLa0iMgl5W6yEThdYW+lld5YJ0t78le4PK2CSR4
	 xyOcaAdFW8uzOB4Xjalvdf/YqwnmkKVuNsTXI1Z6qqD2LahZvXnmPqWl0QhcxAppw7
	 RdfW1nOyPLerJL45Mzk6yahRE1I7A/CzTkVZt4xcTZH308RV3pG1KScy5P7auBRIJM
	 pprr1F7/T2vew==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 1/1] perf bpf: Check that the minimal vmlinux.h installed is the latest one
Date: Mon, 26 Feb 2024 08:21:17 -0800
Message-ID: <170896440864.1919080.11021929412128903940.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
In-Reply-To: <ZdoPrWg-qYFpBJbz@x1>
References: <ZdoPrWg-qYFpBJbz@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 24 Feb 2024 12:47:57 -0300, Arnaldo Carvalho de Melo wrote:
> When building BPF skels perf will, by default, install a minimalistic
> vmlinux.h file with the types needed by the BPF skels in
> tools/perf/util/bpf_skel/ in its build directory.
> 
> When 29d16de26df17e94 ("perf augmented_raw_syscalls.bpf: Move 'struct
> timespec64' to vmlinux.h") was added, a type used in the augmented_raw_syscalls
> BPF skel, 'struct timespec64' was not found when building from a pre-existing
> build directory, because the vmlinux.h there didn't contain that type,
> ending up with this error, spotted in linux-next:
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

