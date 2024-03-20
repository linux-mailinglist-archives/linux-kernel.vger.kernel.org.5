Return-Path: <linux-kernel+bounces-109413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21DB8818C8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B026284C9F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CF086659;
	Wed, 20 Mar 2024 20:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5qlDElu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F738592E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710967839; cv=none; b=sd1CupeEfKl0gEwf2tBs1WFuxBFeuoLZQS9Ijvn9MXaiP4J33F7n43K+Bo68apYn3EKNWUwFqM+M7XLfPNOFRkzrhMbrdmbKsMmYbhFXUZPpTcFWosejRAF/J5i4vrpLmUHeNn4k6Bbo27HmaY26zZ1e/8dL0MSGRctLKlKQbxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710967839; c=relaxed/simple;
	bh=l/9iJWoH/f/YfhX2gaiUfb3YoSSB39W0tME/SJHepYs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WCxLwAB3ilOk0eCoY7E4jt22RolTuHCihJpVrQJ669IEnIq8Tu/6pS9jt0160k8sl6XjgtFI9t1I09MlvWS5cdrZSBj/Sjfhk3qeVHWFjcCK4oEXdP97PVM8AwyyQtW0OVOoWfRp0TFHn901BP5OY3+7DiTn7tq4oULq5lPkAOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5qlDElu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B498C116B1;
	Wed, 20 Mar 2024 20:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710967839;
	bh=l/9iJWoH/f/YfhX2gaiUfb3YoSSB39W0tME/SJHepYs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g5qlDElupvSOTbFHPMC+aQf+KLiBRimzmBFUIkAq6cUde8e5omhOmI6aH7bqZt9vU
	 Ow8bR2/36Zs1w7SFjAIFPahmAuuRJhDGSGVvRjas1HTlGPsaKuvwHH+3+re2BDZ4hO
	 VtJ8BE0j11uBxh8KAk4tHoDcp3nVv9MnRlnFeYtkYEPX8VGzJWPF9xsdbrQjCYnhRd
	 R7CwrmURhpK+oTx0VAH/L2pkx1YnEl75qm4XEKn4ueQ890hyMpM1ZrrfQkXrEdJAEx
	 Q0XT1eI5POlDLAWRbsSJLRxfju81CjEXVUM8wVzvjx+SOf2nobLHSplpretWSIFgNG
	 pjP5da33R2W2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7388AD84BB0;
	Wed, 20 Mar 2024 20:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Only flush the mm icache when setting an exec pte
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171096783946.6804.8158757772819473697.git-patchwork-notify@kernel.org>
Date: Wed, 20 Mar 2024 20:50:39 +0000
References: <20240202124711.256146-1-alexghiti@rivosinc.com>
In-Reply-To: <20240202124711.256146-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri,  2 Feb 2024 13:47:11 +0100 you wrote:
> We used to emit a flush_icache_all() whenever a dirty executable
> mapping is set in the page table but we can instead call
> flush_icache_mm() which will only send IPIs to cores that currently run
> this mm and add a deferred icache flush to the others.
> 
> The number of calls to sbi_remote_fence_i() (tested without IPI
> support):
> 
> [...]

Here is the summary with links:
  - riscv: Only flush the mm icache when setting an exec pte
    https://git.kernel.org/riscv/c/01261e24cfab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



