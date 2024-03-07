Return-Path: <linux-kernel+bounces-96290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFD48759C4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 720DC1F21188
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A47B13B7B3;
	Thu,  7 Mar 2024 21:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOHVjV8i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787B71CA8A;
	Thu,  7 Mar 2024 21:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709848130; cv=none; b=aeg0B7ub9/VOargiu4N6lgCuVvE4f3CUE4rL+hFVE2S23DllWcNZCB8fb+AIObXn8PR6g8pbJ2jIp+deiiRXZeVBCAlDyIZ3ySTqx8wfwQN7k/gn8B18VGGbS84P88GOl43zRvDMzIDqWcxpbj0cXlMugi7K2GYMLMl8F8uZOVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709848130; c=relaxed/simple;
	bh=vLs9m6gRf8Snl4inPBLyLLfxA3kwLZa12Mi7NvvO8R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W39CNklIORVvo2Qqtkf8fA3jGYR7F3jt3A7f/ADlI++gQjcCfJ1cgVKaiufV85rCl83pGWPnKPrwEDDfTGhgrNyIxuS6eY2LjL5SNFRuFtAZtGdGtG09P+jqsgIGLy2NVV3JkNmkAmMKq+TKQxeNfiuuR08nGqfn0xjyoJIkbik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOHVjV8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0F7C433C7;
	Thu,  7 Mar 2024 21:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709848129;
	bh=vLs9m6gRf8Snl4inPBLyLLfxA3kwLZa12Mi7NvvO8R4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IOHVjV8iznlznY2XzPlCiYQx9hT9NmkmBVnxipkHZ2zKbpIoNDIzRTfyHy5loCqf/
	 KEpYHru6GiLS9bbkwqx1G1TfNolMBN6qHiZ2UoIbyME351CN0CaFCbJw4wFaGZr+ua
	 GclbUHC1WHuJ8AYppEyZWRPJnVOk0b2bK0upHeassP293vjnUkma4BoHl/jtSVDY6o
	 LJ7JaMN/3xGzOf6zEIEBR3rpj97pd79imifmo1oaTbWEyy3Hqa5C5HuV7qsRxqvPX3
	 3hpKsRXNbawfmgDUBNk2kijSs0uBPjojS8+YMA+yy03vTO1i0RuS/YgCPiPET7qJJY
	 VkjSEh+rLAPlw==
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Andi Kleen <ak@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 0/4] perf annotate: Improve memory usage for symbol histogram
Date: Thu,  7 Mar 2024 13:48:46 -0800
Message-ID: <170984809560.445746.8499697523973754680.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
In-Reply-To: <20240304230815.1440583-1-namhyung@kernel.org>
References: <20240304230815.1440583-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 4 Mar 2024 15:08:11 -0800, Namhyung Kim wrote:
> This is another series of memory optimization in perf annotate.
> 
> v2 changes:
>  * fix a bug when offset is bigger than 16 bits
> 
> 
> When perf annotate (or perf report/top with TUI) processes samples, it
> needs to save the sample period (overhead) at instruction level.  For
> now, it allocates an array to do that for the whole symbol when it
> hits any new symbol.  This comes with a lot of waste since samples can
> be very few and instructions span to multiple bytes.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

