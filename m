Return-Path: <linux-kernel+bounces-91138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B697D8709F6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46C7E2823DA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB5A78B58;
	Mon,  4 Mar 2024 18:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulYrerPi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF5F6216C;
	Mon,  4 Mar 2024 18:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709578606; cv=none; b=VbrN001EZjFcUiB4Gt1FMG52IYJI4dxZR3f2xRqC1p2r9yp1wafC4mQ5VyAp4bx8awx1TQUeiUp+BSYhGLz9W88Cclh0TStoyGWpL7trWJXB+ep1oI0LlJDOvEe/AbNrQ/4LtD3TMrJQPBN1kfNf9vlxzHLy5r1Ld//pNlOaaMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709578606; c=relaxed/simple;
	bh=aVZvpwaBlw4HmtrPOu8/hFMD8VTcR2LaTc//Pd2XLrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TT1HNGpcGkClHsam7ernQfQBQz1WUOCGFeLIIK+n7T26J283ZWNCAE52J89AzYhWu7UWgboaSEfS3Q1KiO8MviND3E4BIWBljYj0rcXb3kPXsZGuuiH2v1ASDUOyvbGZVMXEHPBj2ObBuxQuqNdD7KGWuv8++PQtls4Yub0fVjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulYrerPi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8442C433F1;
	Mon,  4 Mar 2024 18:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709578606;
	bh=aVZvpwaBlw4HmtrPOu8/hFMD8VTcR2LaTc//Pd2XLrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ulYrerPijf+vywjQejxgr9L12TEDehZR3Q5uvbCDl10IlSsqZa2YU9Zq3U5o2GavV
	 IzjBch82P6QrnLWltcSJmBfzIQfb4yx5tNHVCPXoRLr3ehEs7goOcWxP6R83ermr+S
	 l7JyM6hb32fM3L/QEg20vv5DhHLnaG9HeYLtxdso8XSuggM5d8q8fHaa93obnBR5CT
	 8//8RvShVCARvIrlIGIFXHgUOaCA/sHO/eXDLRRY/XIG5nFgaTUvfB7IjBHXmqshA8
	 gbasoOcdil+4l5SKdDqx5I13vc5DjoWYNliedSTTmWYXP+gvkGMOKw/aCIaLMtF2Ky
	 Mo2QklzYAgXdw==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Sandipan Das <sandipan.das@amd.com>
Cc: eranian@google.com,
	jolsa@kernel.org,
	ananth.narayan@amd.com,
	acme@kernel.org,
	peterz@infradead.org,
	irogers@google.com,
	alexander.shishkin@linux.intel.com,
	adrian.hunter@intel.com,
	ravi.bangoria@amd.com,
	mark.rutland@arm.com,
	mingo@redhat.com
Subject: Re: [PATCH] perf vendor events amd: Fix Zen 4 cache latency events
Date: Mon,  4 Mar 2024 10:56:44 -0800
Message-ID: <170957856863.1606352.5043156720799964711.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
In-Reply-To: <20240301084431.646221-1-sandipan.das@amd.com>
References: <20240301084431.646221-1-sandipan.das@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 1 Mar 2024 14:14:31 +0530, Sandipan Das wrote:
> L3PMCx0AC and L3PMCx0AD, used in l3_xi_sampled_latency* events, have a
> quirk that requires them to be programmed with SliceId set to 0x3.
> Without this, the events do not count at all and affects dependent
> metrics such as l3_read_miss_latency.
> 
> If ThreadMask is not specified, the amd-uncore driver internally sets
> ThreadMask to 0x3, EnAllCores to 0x1 and EnAllSlices to 0x1 but does
> not set SliceId. Since SliceId must also be set to 0x3 in this case,
> specify all the other fields explicitly.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

