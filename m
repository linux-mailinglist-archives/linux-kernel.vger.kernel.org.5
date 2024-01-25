Return-Path: <linux-kernel+bounces-39328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4FE83CECD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1C5D1C24AB2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C464D13AA5D;
	Thu, 25 Jan 2024 21:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z44kmTMX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115A213A25E;
	Thu, 25 Jan 2024 21:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706219106; cv=none; b=hL6JzQYNngq/y04UPoInVfPrU9v7pFmSAMjOo5VWrR/qLqbGy2iqkguDRElGYWfR0zr9fWLRIb3rvOpaWoDRQuroTu3EmV6gvq7C46/0zHn326Nt9UWvDV3Lh4KIerdgHbVeWOx1nx5KvV+KfGh1dZyuYq6OYEUiShWnMKYpf9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706219106; c=relaxed/simple;
	bh=JQd1N0cLbwJCRpu8W5IyZC5+ZemZha23KmJar4jpt2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kp3y7xpLj+pN0zgcOq9MfbF96ZONHofutzcLimt3EOok7xQttpIVa2puJp/tzfSFDwuuxFwGXzROXfD6rpmC0nTzCVDhW6wI2lC+WY7usvxVFUWnhpEZzbDvqCnFCMujuxWTkELh1EEoYvIxyRvjMYedVJ9Qh+vEL9S31jMNsAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z44kmTMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF25C43390;
	Thu, 25 Jan 2024 21:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706219105;
	bh=JQd1N0cLbwJCRpu8W5IyZC5+ZemZha23KmJar4jpt2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z44kmTMX6eKCkVGjdG2q+PBh5PXvlqwLzhixVqfzqE7KXJ22Ktmz9zQszRHToGwOK
	 ws2j/h5CdM7E5F0SHsj/f1QxrFSmUji9WfeovgY3qcREzzRHtPhL8Wc831pp/no6hd
	 xZDOPP6/vFIPG7fa4bidMJXX9azcKkmqutV4S6fuJPSIVK9WXLLAz9OCpDuuZky9XF
	 cTxlQ0KhKHlqsfYdBK+44RWzN4t/NDKDcBMFq8u50Z15TYgXF2TFEWb7/+3UenH+fx
	 M+n8fLDKmmUQGhwk9nhILlIAhCfzi1J7aaSLBBQ55n8jXd5cZP9+ellGHC5proxXW2
	 EsE4qktjP+LiQ==
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@arm.com>,
	linux-perf-users@vger.kernel.org,
	irogers@google.com
Cc: linux-kernel@vger.kernel.org,
	Spoorthy S <spoorts2@in.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 0/2] perf test: Skip test_arm_callgraph_fp.sh if unwinding isn't built in
Date: Thu, 25 Jan 2024 13:45:01 -0800
Message-ID: <170621898549.3227482.15120591332128691529.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240123163903.350306-1-james.clark@arm.com>
References: <20240123163903.350306-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 23 Jan 2024 16:39:00 +0000, James Clark wrote:
> The first commit outputs the unwinding feature definition in perf
> version so that the script can gate on it. And then skip the test if
> it's not present.
> 
> I didn't add any fixes tags because it's modifying the perf version
> output, requires both commits, and it's just for a test skip change so
> I don't think backporting makes sense.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

