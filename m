Return-Path: <linux-kernel+bounces-167980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A398BB1D8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106DD1C22789
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB15A1581E4;
	Fri,  3 May 2024 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfNyl+zV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E934815698B;
	Fri,  3 May 2024 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714757584; cv=none; b=XiFWC8lPxxgPj2vSZLIPraSqMb/tEs+cOPc5pdKcNMJaWgJQ4Y1xxBIhiZjwWWCFhpIpMzpk5UYJqpMIgQA8PuvHvcVnfge4Ddy8DZOEjyi/FVYk3nWmNZa8utiewLyjqHz4b3ySsz/XFOsFnEC9k7mWhCcWnp8RfdSt2emKqSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714757584; c=relaxed/simple;
	bh=bxs2MrtcFn9XA7XJyfymNrvY4aBIko4rE8ptPAXCSC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQEzgDCoEXdOJksszzaScFR36lEpiEtEWKnZVn35gyucCjdkatToFlduBrf7UzdqjqOoMeKzwYHebYYFPMKY1TmLwnLtYhJYPtwdoPoKLpS2vxf3rzODbBN3au1IRL3iULTGEDfmmBD39Chx5es9qisQgRjglOLF7JhTOb7EQrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfNyl+zV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9932C116B1;
	Fri,  3 May 2024 17:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714757583;
	bh=bxs2MrtcFn9XA7XJyfymNrvY4aBIko4rE8ptPAXCSC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NfNyl+zVStx5U4N/Zz52jJkmPndgTx1kJNseuatyBdzGlKUdaNSFEXNQDYHubn/xZ
	 po6zBbG4m8qFRPPr7Ny/OqHmWprXO2CfsjmqXtXz+XP9b8/TVJAYnoxNHngZHCExHz
	 4ehDBKPkBZuFJQhnr820fcbB0zPWB+nRs0ddYuLluYdQQvL27dj1vaxfZt4erZCEQ4
	 qaYdqAGWfE4tRrYL8hHTPj2AhfkTcxoXZ/4seSS3HhlWplBey/YiG4GJ5chYzlXOTQ
	 6kCfAFdMvYIIMRIcAiA1mzqw5fkDJmlRH22pge6wJTBlkMExsMJ7wbbXxCCmS4tcwj
	 uiNV3Zua66kew==
From: Will Deacon <will@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Andrea della Porta <andrea.porta@suse.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3] arm64: Add the arm64.no32bit_el0 command line option
Date: Fri,  3 May 2024 18:32:56 +0100
Message-Id: <171473808737.3281813.8263493761556062643.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240429102833.6426-1-andrea.porta@suse.com>
References: <20240429102833.6426-1-andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 29 Apr 2024 12:28:33 +0200, Andrea della Porta wrote:
> Introducing the field 'el0' to the idreg-override for register
> ID_AA64PFR0_EL1. This field is also aliased to the new kernel
> command line option 'arm64.no32bit_el0' as a more recognizable
> and mnemonic name to disable the execution of 32 bit userspace
> applications (i.e. avoid Aarch32 execution state in EL0) from
> kernel command line.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: Add the arm64.no32bit_el0 command line option
      https://git.kernel.org/arm64/c/1279e8d0dcea

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

