Return-Path: <linux-kernel+bounces-54125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 976A784AB13
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DCE7B23262
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEBE7FD;
	Tue,  6 Feb 2024 00:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZj3wRvl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A1F3FE4;
	Tue,  6 Feb 2024 00:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707178783; cv=none; b=D9YZHbnfCALGRsrqATeoTSxILg8W0qQpstOozjZkjNcRffIxXIYk6Yii8ePdjiF5w8IWynZHcflSSyMudMweiNYYXQtoUNIF+n0e5u+7oaWiddojHUuqErQpWU8J3F7YXVEfEJf+dvjsr4AxKZj3Qdf0w4Tlkq7hoDbfi1kpuaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707178783; c=relaxed/simple;
	bh=s+JNYYoa/aWZY28sbi5PW8y/reMlR60lqXxnm7UTLXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kwuL81EUa22ASg/bLfb60WsuEDKCsu1xlzti5xHG0jAXnmb23BfSBCG/9cjyosdhDKIdUQX9Zlyq73K2t04jKCbm8jhCoHdTzoRaI3EEMhsq6Aq5tAvA2Qx0R24X8KBCN0kR4PsOCEBE7kG6Lkoq3lUZUjSDfN6kKWfDHKgwe2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZj3wRvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE966C433F1;
	Tue,  6 Feb 2024 00:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707178783;
	bh=s+JNYYoa/aWZY28sbi5PW8y/reMlR60lqXxnm7UTLXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pZj3wRvlUT9c54nEafsfJYHDK0xPTOGUpoXrwfggnIV9MmWY0qRs6pEovQGyediXY
	 LSLD/5yieSqosM6U5LR0lct798Z4cu4DckvpMJ2G4H3bHXFluJ+y8yQcchpGShU+Zz
	 atOoK5A8urutWa1duho8H2H+4/576uAvcu0nnzvW+gLC8lxhmS64A+TeEy54jPAdIQ
	 2zhefxB5EXveCOgpKYWxvxFGo2RVzkEqhQxquyV7/1VARKzaUWIoXwwXYSh3XK5RD0
	 5EYNRpTDWSJJveVufGUFkued6Ez5PnOr9E4nzQ01Cq9AD3TmTfpkHvWwGRZZrVjws0
	 U0NT9/k4wm4mg==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Ben Gainey <ben.gainey@arm.com>
Cc: adrian.hunter@intel.com,
	mingo@redhat.com,
	acme@kernel.org,
	irogers@google.com,
	will@kernel.org,
	mark.rutland@arm.com,
	peterz@infradead.org,
	jolsa@kernel.org,
	alexander.shishkin@linux.intel.com
Subject: Re: [PATCH 0/1] tools: perf: Expose sample ID / stream ID to python scripts
Date: Mon,  5 Feb 2024 16:19:40 -0800
Message-ID: <170717858575.1700937.1642994669335608980.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240123103137.1890779-1-ben.gainey@arm.com>
References: <20240123103137.1890779-1-ben.gainey@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 23 Jan 2024 10:31:36 +0000, Ben Gainey wrote:
> This patch modifies the perf python scripting engine so that the ID and
> STREAM_ID are exposed as part of the sample so that they may be
> correlated to the corresponding throttle/unthrottle event (for example).
> 
> NB: For scripts where perf_db_export_mode = True, this may be a breaking
> change depending on how the script is constructed. Each field is passed
> to `sample_table` as an argument so any script that is written as:
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

