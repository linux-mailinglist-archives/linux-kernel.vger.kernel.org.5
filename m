Return-Path: <linux-kernel+bounces-59798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8528784FBDA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B84F1F2417F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733EF5733C;
	Fri,  9 Feb 2024 18:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6PF/grW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C2854F85;
	Fri,  9 Feb 2024 18:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707503479; cv=none; b=O9QfhOyjg1NFQS9Hn4qw6dPw0O0HFJgWuQOI0+y4OspVtKkUr03uS5WOGGii1WYzpyjQ0UczhrmQyzE7Zol27I6Ed/nKyGtLJpz/B3dGk+tTAYHD3ZBeXMP1gPI6KKKsTtnqAwKTIV2e+54VB+jR0Eo29YiMvLqMTlo5V/bXoBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707503479; c=relaxed/simple;
	bh=8OBu+LxePOLOnmiVLOUigvWdhDY3l0XMehSH9FAPASo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HTwG5EKmtCfHXYqhKAyYaOXxfRu0krTo+7ibKeB82CQzf2RdzJc8T6DXl9wW+ASLoUrtokRCkfhnDvKZnl4cnM+s8D2ERtZZPtQEPPEPNJPS5eZ6a8Th9GvWQy3Ehvae1dMx6Iva78SrLP8iaXn+JbltzprcLObtIelshx1sZS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6PF/grW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F58EC433F1;
	Fri,  9 Feb 2024 18:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707503479;
	bh=8OBu+LxePOLOnmiVLOUigvWdhDY3l0XMehSH9FAPASo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s6PF/grWZroBlno3PlKGZ8Ecy4AvebuVDeT7yoLE1scyxPXxggR2TkGuORZY8az9A
	 xr78RQVgBAhvQVND+bqj7qv+WeeU3HxgMVNdkjq3SVN4Tn5DEeDBMUrjjVi4BPLZGQ
	 zJLJQFer1tUFGSaTCPfwPltRR3DjDdiXm1lofYoIMYqToSQ05vnJ/Xr0wzm0pjAZCX
	 yB1AIsB3LB13Cklaz6NkLmjxQv2oPoF4rzjpTXbi+TusqbQM8hAm3aTZf08SDFU2r6
	 QIe2G1flruNZC0qMs+zEsGABdztaOPSK3pru/PvRG14uGZYyqMJ4vZBU62PCvUdGGk
	 atFiOaftuQUeg==
From: Will Deacon <will@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	stable@vger.kernel.org,
	Dave Martin <Dave.Martin@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/signal: Don't assume that TIF_SVE means we saved SVE state
Date: Fri,  9 Feb 2024 18:31:06 +0000
Message-Id: <170749646399.2626752.9932899949301214148.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240130-arm64-sve-signal-regs-v2-1-9fc6f9502782@kernel.org>
References: <20240130-arm64-sve-signal-regs-v2-1-9fc6f9502782@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 30 Jan 2024 15:43:53 +0000, Mark Brown wrote:
> When we are in a syscall we will only save the FPSIMD subset even though
> the task still has access to the full register set, and on context switch
> we will only remove TIF_SVE when loading the register state. This means
> that the signal handling code should not assume that TIF_SVE means that
> the register state is stored in SVE format, it should instead check the
> format that was recorded during save.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64/signal: Don't assume that TIF_SVE means we saved SVE state
      https://git.kernel.org/arm64/c/61da7c8e2a60

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

