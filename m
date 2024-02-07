Return-Path: <linux-kernel+bounces-57241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FB984D58F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9437B28A7A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AF3132C19;
	Wed,  7 Feb 2024 21:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDRtlpVm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D5A134CFF;
	Wed,  7 Feb 2024 21:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707342480; cv=none; b=T2B7/DtsBCD8Dv07WieNjf5HkMI1tbbxCuHfTg/Gn1jhjmlqsGUHH1HhB38vmjOZQ9nGKmACufzIhWkHRoPF4Ck+Qa0BcIOehCKUQarcSI6lwC0/gE1cNWpEuk8Xb6WSPW0eojlrRPUT7qXE3a3UbT9Httwx05cAOOYK/g+4R5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707342480; c=relaxed/simple;
	bh=VHe2yJyAM+ce7BaDBL2a1L8/IELsLZavLcYjHWeL4ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JKtuSkeXwIp8THcIWR6ngejcZUSvxyJaKYnJnPbZUCbhPgo79uxDTEUeByuJGvGaa9GTukko4TUi1e56pphXH+MEEcZHtEsiTmdEsxLFHjZLddD4EB9bsEpqTIOUZaEK2KmgeSdx0JlQ9KewggC5PaST9fMeVccjkETFPLOqCHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDRtlpVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E23C433C7;
	Wed,  7 Feb 2024 21:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707342480;
	bh=VHe2yJyAM+ce7BaDBL2a1L8/IELsLZavLcYjHWeL4ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eDRtlpVmofjE/Vcn590P6Smm89V8G2Xmqof3as38LymjClzEuB4mt2rCR+tL+vyBP
	 RI/KAamvmTjHvZHlFuSybwv5Y0AEMLldsR8s5+p2UeGxBPiCBIVMS8My28dTYnOx3e
	 PXugmWfCPhqjZLWy5qoqoNj1yAOYnZsyWRkAhQog4YI/170PfcRmUhUqLL8HDcuig5
	 OBA1Tyc+khtUXE/xBRri8X78YcZNbShVbrJjuB1vGl5xBeCRAhhQ3dK7BR21U5ic5g
	 ICPoacIkyZszrkxbeLxNZsGoU0cXz30WwireLwrlb8Vcf4HWeRrWjqpzKWkwus+UQS
	 RtB8sJoe4JO2A==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	peterz@infradead.org,
	mingo@kernel.org,
	kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: amiri.khalil@intel.com,
	adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	ak@linux.intel.com,
	ahmad.yasin@intel.com
Subject: Re: [PATCH] perf script: Print source line for each jump in brstackinsn
Date: Wed,  7 Feb 2024 13:47:58 -0800
Message-ID: <170734243427.3472515.9177879341122405433.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240205145819.1943114-1-kan.liang@linux.intel.com>
References: <20240205145819.1943114-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 5 Feb 2024 06:58:19 -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> With the srcline option, the perf script only prints a source line at
> the beginning of a sample with call/ret from functions, but not for
> each jump in brstackinsn. It's useful to print a source line for each
> jump in brstackinsn when the end user analyze the full assembler
> sequences of branch sequences for the sample.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

