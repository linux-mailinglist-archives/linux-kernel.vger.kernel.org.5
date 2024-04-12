Return-Path: <linux-kernel+bounces-143267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F5E8A3670
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1B3C1C23AF6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D864B150981;
	Fri, 12 Apr 2024 19:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oN9iWj92"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250B023778;
	Fri, 12 Apr 2024 19:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712950739; cv=none; b=qZmLolsZOeXSGX3s9jRWaK8nbMjTdA5FwJwL6Xa8eTZQIuCVojdfLkGIAclApA/Xi6QP/k9+j42Y6x8tjYVp1KhJuJ+iD+9Zit9mH80/QPE2FPw5eFe2qeTPSLbWqfLWZMX6IJn+Qcs1SDG7eQ3Qs33ruYzBBRnGjuliOQGvC2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712950739; c=relaxed/simple;
	bh=i7i1PFPEoJy3XOUMVcnnF6PhOm/ibYgL07VPiFhWnQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjogxIuyQKVTAKtD4El4UuhpfdI7yyXeie6UbhC5RgSfLlpf4Tpo24ivovWbqAJEnlvrfCUHly6NmQWfuiDdjaIKJS+yB0qPv+AJPQd/GyxTRnTXd9BeR8YX+mWsNhSjZ41kFmXY8dWVspMe9QnUcnz5qlRHsVNxtPqpAvpX1M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oN9iWj92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CF1C113CC;
	Fri, 12 Apr 2024 19:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712950738;
	bh=i7i1PFPEoJy3XOUMVcnnF6PhOm/ibYgL07VPiFhWnQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oN9iWj92fATojrO5+v2/QdaJKeUe1UilFvRh0oIJ6gGNQEvjYYqnP32Of2buvZtFu
	 f34u1iUJWXxWU9HxrmCPwQe5V38dCFtIZNSrfWOp5KsKF4FYX7htt4Thf2dOG9mesW
	 xtlG3d656XkDg7lC3op0Todbkq/Tc0bDOpU0uvKIU1OdOsp9NdPZyZ5h0jQowQHSOs
	 IF8fn5Vz+qY08vRQyiIkI9Y5oNlUJveRiyEJJhvxdFmdjSNWQoihwiTn7rqEX0X4de
	 BIrLak/eCwjUEejqlYQ8eD6a2xOGKEg+ROsYdHWhu/Tvztyqj0s7BzkFaOPXZYtruH
	 qfyx90IetbIcw==
Date: Fri, 12 Apr 2024 16:38:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@arm.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/4] Add shellcheck beyond perf/tests
Message-ID: <ZhmNz00T1iAzuMiq@x1>
References: <20240409023216.2342032-1-irogers@google.com>
 <4949d61b-6b25-4433-bd2b-a50b4f22ff42@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4949d61b-6b25-4433-bd2b-a50b4f22ff42@arm.com>

On Tue, Apr 09, 2024 at 11:02:58AM +0100, James Clark wrote:
> 
> 
> On 09/04/2024 03:32, Ian Rogers wrote:
> > Add shellcheck to other locations of shell scripts, not just
> > tools/perf/tests. Fix issues detected by shellcheck.
> > 
> > Ian Rogers (4):
> >   perf build: Add shellcheck to tools/perf scripts
> >   perf arch x86: Add shellcheck to build
> >   perf util: Add shellcheck to generate-cmdlist.sh
> >   perf trace beauty: Add shellcheck to scripts
> > 
> >  tools/perf/Build                              | 14 +++++++++++
> >  tools/perf/arch/x86/Build                     | 14 +++++++++++
> >  tools/perf/arch/x86/tests/Build               | 14 +++++++++++
> >  tools/perf/arch/x86/tests/gen-insn-x86-dat.sh |  2 +-
> >  tools/perf/perf-archive.sh                    |  2 +-
> >  tools/perf/perf-completion.sh                 | 23 +++++++++++++------
> >  tools/perf/trace/beauty/Build                 | 14 +++++++++++
> >  tools/perf/trace/beauty/arch_errno_names.sh   |  8 ++++---
> >  tools/perf/util/Build                         | 14 +++++++++++
> >  9 files changed, 93 insertions(+), 12 deletions(-)
> > 
> 
> Reviewed-by: James Clark <james.clark@arm.com>

Thanks, applied to perf-tools-next.

- Arnaldo

