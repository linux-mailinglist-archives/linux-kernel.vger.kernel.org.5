Return-Path: <linux-kernel+bounces-167981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 103DA8BB1D9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40DCD1C211AE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D4A15820C;
	Fri,  3 May 2024 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLeQbgEl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9EB158200
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 17:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714757586; cv=none; b=Hf965/0VHztGebSM40IQp3jJJvBbRTuGlg1XrD8k1DNKhp7RrFL6RWjXhtGq3mvf46lo9XV2toJcTLa8pZS1/nMCAczmB57S+dArbu4EL3PadyYOtU6Oyixr0fchfm3fnkMvD/foJObe/wcGHmurvYSZ1SRkxEIvtWCciFtQaGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714757586; c=relaxed/simple;
	bh=ivUf0YHwPrVFlk2SOzJDvBwivlo23YyIa4VrFwPBDEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XIZL8CDb48ICTZFOvUkPKwciu/vDyUHUVedlesGlYesWsUJkrahHC0Rc6kLE/QQ4Ok7K7gjrklOMlKBOXAMD+WZX/I293XV7RGT+qEtyZtgoBrUs0wk1KRpXq59aXuKVXhnrA+WRvNBEtdIiEuVZYgNNk6TfWeYaDZe+8CgXqDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLeQbgEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F6BC4AF14;
	Fri,  3 May 2024 17:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714757586;
	bh=ivUf0YHwPrVFlk2SOzJDvBwivlo23YyIa4VrFwPBDEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MLeQbgElhsj2RIOlErTUvVgbZCmql4j0DNrKHvhiGsPlog+1gYqERx0Slyq204o/f
	 SuYhadOnJViQne0PLgm15gF9VQVMjwWw86B/72S9JXUjoYbVkuPcqOqQ1cp810wAXe
	 TNfZOSXSt/uQ+qWSupEfCaWL7P4Au7ckSyvqhQ0Y8BdRIvNuJrDfwjNK0wMYGIFt4V
	 kq3/Fzp24mxcPj2JfVTCjzASM14OegWs2IYjE+SnBof6QD5bmmzcVIsZcxhUxvDy0a
	 J3Jmw24IIIvaWqLCINLevJjxwKk3bkvCh7LVsHYT0YC1qlMNyPymw993Pv2p1PAMDX
	 FS5z5rMT5IMow==
From: Will Deacon <will@kernel.org>
To: mark.rutland@arm.com,
	George Guo <dongtai.guo@linux.dev>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	ardb@kernel.org,
	guodongtai@kylinos.cn,
	jbaron@akamai.com,
	jpoimboe@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	peterz@infradead.org,
	rostedt@goodmis.org
Subject: Re: [PATCH v3 0/1] cleanup arch_static_branch/_jump
Date: Fri,  3 May 2024 18:32:57 +0100
Message-Id: <171474219706.3292579.15222046072610530568.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240430085655.2798551-1-dongtai.guo@linux.dev>
References: <ZiYs3itsmdOmuPq4@FVFF77S0Q05N> <20240430085655.2798551-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 30 Apr 2024 16:56:54 +0800, George Guo wrote:
> I have tried to define macro with key and lable in v3.
> What do you think on v3 patch?
> 
> George Guo (1):
>   arm64: simplify arch_static_branch/_jump function
> 
> arch/arm64/include/asm/jump_label.h | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: simplify arch_static_branch/_jump function
      https://git.kernel.org/arm64/c/588de8c6d362

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

