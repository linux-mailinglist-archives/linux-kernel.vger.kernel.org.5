Return-Path: <linux-kernel+bounces-7010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5613E81A081
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E8C1C22A99
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC0B3985C;
	Wed, 20 Dec 2023 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCdhlTlo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2E538F9D;
	Wed, 20 Dec 2023 13:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4AAC433C9;
	Wed, 20 Dec 2023 13:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703080776;
	bh=3DzpkFz+DOeDrNrZbMR42pmfhVx7KleuGlObv9MGS4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dCdhlTloZsKa6+Y+Ztdmp6v/gKEtI/6Lzy1FYV+gxIu6R+rRSdMoI6x+1O5NkLS1J
	 B11EUjAHzYiTxi45yZEt1fYZtCIMIhyo5kkFRoz9mcXtwgjW/+Mp64IayVkQg6hWaw
	 w1Yo6sQfjLgkq/nlPhE0pLUlmVZ13m0xbrWBzCPmCn0u7xn0SUj1MXF3fgFthvi3bh
	 YxipUS1GRfINVpuGamryuhnkyAaCl7yPOxcnISODay5GccI5KUzf4VN1Y5jZSlawXS
	 JfhifRcUIibArPWB/kJY/MXe5+ma2qi9jeic7bR8J6Xws1EmPdzlx+2LqVgYAWaauu
	 R+aCK+EWsNUig==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 495E2403EF; Wed, 20 Dec 2023 10:59:33 -0300 (-03)
Date: Wed, 20 Dec 2023 10:59:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: vmolnaro@redhat.com
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com, mpetlan@redhat.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] perf archive: Add new option '--all'
Message-ID: <ZYLzRV2MY33fBtuS@kernel.org>
References: <20231212165909.14459-1-vmolnaro@redhat.com>
 <ZXihN3th3qbo6L8Z@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXihN3th3qbo6L8Z@kernel.org>
X-Url: http://acmel.wordpress.com

Em Tue, Dec 12, 2023 at 03:06:47PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Dec 12, 2023 at 05:59:08PM +0100, vmolnaro@redhat.com escreveu:
> > From: Veronika Molnarova <vmolnaro@redhat.com>
> > 
> > Perf archive has limited functionality and people from Red Hat Global
> > Support Services sent a request for a new feature that would pack
> > perf.data file together with an archive with debug symbols created by
> > the command 'perf archive' as customers were being confused and often
> > would forget to send perf.data file with the debug symbols.
> > 
> > Perf archive now accepts an option '--all' that generates archive
> > 'perf.all-hostname-date-time.tar.bz2' that holds file 'perf.data' and
> > a sub-tar 'perf.symbols.tar.bz2' with debug symbols. The functionality of
> > the command 'perf archive' was not changed.
> 
> Thanks for working on this, I'll do some testing and apply, probably
> tomorrow.

I applied it, tested by doing a 'perf record' on an hybrid Intel Machine
(14700k) and then using --unpack on an hybrid ARM64 machine (rk3399-pc),
all working as expected:

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/?h=tmp.perf-tools-next&id=624dda101e03c3a3a155d51e37a7bb7607cb760b

Some suggestions for further improvements:

acme@roc-rk3399-pc:~$ perf archive --unpack
Found target file for unpacking: ./perf.all-number-20231219-104854.tar.bz2
perf.data
perf.symbols.tar.bz2
tar: /home/acme/.debug: Cannot open: No such file or directory
tar: Error is not recoverable: exiting now
acme@roc-rk3399-pc:~$

Check if the ~/.debug directory is present, if not, create it.

Also maybe use:

   Informative output
       --checkpoint[=N]
              Display progress messages every Nth record (default 10).

       --checkpoint-action=ACTION
              Run ACTION on each checkpoint.

with 'tar' to show some progress in decompressing the tarball.

- Arnaldo

