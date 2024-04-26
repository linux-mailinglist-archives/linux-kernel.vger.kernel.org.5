Return-Path: <linux-kernel+bounces-159996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D5F8B376F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B13C9283380
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94515146A7E;
	Fri, 26 Apr 2024 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecWCkYsd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DF82A1B0;
	Fri, 26 Apr 2024 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714135691; cv=none; b=A/GXBHD9FLeMw1ShOLaWZwefA/aGG9oUiE03/k/E0KfZqb5K1urBHJrwN1ZUG9Vc7u9HuiA7l13n3IQsh6qCLQOeQJixAGz1XAYlgfpqTxi93qcpURD9OhrdJsGEA9GxezcBkHvdmB75P60RBY7XJu/8gWoyAFqdlWxIe19s0Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714135691; c=relaxed/simple;
	bh=FOzFFi+msUeLXNfbb70s5KkbOCz2J/1lKkGOcbc75Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J12L6kqaunsCcTPCUvpN9XxVLfSdFS6uDUHbR71ypR71JHEkRew0NM0il3tTQ67OOEsuaFrSqLCP3EcZHg+V/2Xe1uNcHK5skQmrTsypXusvhceHBfrryMqywSgAY7131ldhe+Ark7ak4V6dH++0QMMDCE+7XgP1ZORIdMvEOsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecWCkYsd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA065C113CD;
	Fri, 26 Apr 2024 12:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714135691;
	bh=FOzFFi+msUeLXNfbb70s5KkbOCz2J/1lKkGOcbc75Vg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ecWCkYsduNjS49+qSQh1C9PfkhcSQEE6IyK+p7RSLiL63G45KfKhpPKyvSIAMjfNp
	 Gphe2ZSFIxP6ouvibgmzqnhI2l2AT85SgrbTll+xnmIXCKGoPKi9VGqT5PO8G8I8QV
	 9PiSZxvQCmC1dHV38z8xHJpo3QWWvYuAlwPYpXDD/BvlbUM0DIMU4JMbGS648KyHJE
	 iM4z5I98bkBIEq57JQT+iJlyMC+oFV0IfXIun0yMJmN6MF7yLsbKYbkcNjS44f2wuY
	 r+gKvc6AmRFZ7ieo2sgIyfLbRwrEl827SQjo+9u3QL9K9lHdDNkYTdNdOn3VYRqkrZ
	 vAiqgGO+oHm3A==
Date: Fri, 26 Apr 2024 09:48:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V3] perf scripts python: Add a script to run instances of
 perf script in parallel
Message-ID: <ZiuiiFdPhJIrjI7k@x1>
References: <20240423133248.10206-1-adrian.hunter@intel.com>
 <ZihFYbdrnarNFWOd@tassilo>
 <ZikT69GIsijZajoI@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZikT69GIsijZajoI@x1>

On Wed, Apr 24, 2024 at 11:15:11AM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Apr 23, 2024 at 04:33:53PM -0700, Andi Kleen wrote:
> > On Tue, Apr 23, 2024 at 04:32:48PM +0300, Adrian Hunter wrote:
> > > The script is useful for Intel PT traces, that can be efficiently
> > > decoded by perf script when split by CPU and/or time ranges. Running
> > > jobs in parallel can decrease the overall decoding time.

> > > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

> > Reviewed-by: Andi Kleen <ak@linux.intel.com>

> Thanks, applied, and added a note on testing it using:

Plus this, please check.

Committer testing:

  Ian reported that shellcheck found some issues, I installed it as there
  are no warnings about it not being available, but when available it
  fails the build with:

    TEST    /tmp/build/perf-tools-next/tests/shell/script.sh.shellcheck_log
    CC      /tmp/build/perf-tools-next/util/header.o

  In tests/shell/script.sh line 20:
                  rm -rf "${temp_dir}/"*
                         ^-------------^ SC2115 (warning): Use "${var:?}" to ensure this never expands to /* .


  In tests/shell/script.sh line 83:
          output1_dir="${temp_dir}/output1"
          ^---------^ SC2034 (warning): output1_dir appears unused. Verify use (or export if used externally).


  In tests/shell/script.sh line 84:
          output2_dir="${temp_dir}/output2"
          ^---------^ SC2034 (warning): output2_dir appears unused. Verify use (or export if used externally).


  In tests/shell/script.sh line 86:
          python3 "${pp}" -o "${output_dir}" --jobs 4 --verbose -- perf script -i "${perf_data}"
                              ^-----------^ SC2154 (warning): output_dir is referenced but not assigned (did you mean 'output1_dir'?).

  For more information:
    https://www.shellcheck.net/wiki/SC2034 -- output1_dir appears unused. Verif...
    https://www.shellcheck.net/wiki/SC2115 -- Use "${var:?}" to ensure this nev...
    https://www.shellcheck.net/wiki/SC2154 -- output_dir is referenced but not ...

Did these fixes:

  -               rm -rf "${temp_dir}/"*
  +               rm -rf "${temp_dir:?}/"*

And:

   @@ -83,8 +83,8 @@ test_parallel_perf()
          output1_dir="${temp_dir}/output1"
          output2_dir="${temp_dir}/output2"
          perf record -o "${perf_data}" --sample-cpu uname
  -       python3 "${pp}" -o "${output_dir}" --jobs 4 --verbose -- perf script -i "${perf_data}"
  -       python3 "${pp}" -o "${output_dir}" --jobs 4 --verbose --per-cpu -- perf script -i "${perf_data}"
  +       python3 "${pp}" -o "${output1_dir}" --jobs 4 --verbose -- perf script -i "${perf_data}"
  +       python3 "${pp}" -o "${output2_dir}" --jobs 4 --verbose --per-cpu -- perf script -i "${perf_data}"


