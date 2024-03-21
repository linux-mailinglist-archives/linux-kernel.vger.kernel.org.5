Return-Path: <linux-kernel+bounces-110575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B5E8860CD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 475BA284BCB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331F4134408;
	Thu, 21 Mar 2024 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/ivQd2O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754E613398E;
	Thu, 21 Mar 2024 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711047628; cv=none; b=f7I10LO+ojX0JK7WZYFMQ+9OMYZ/OYW3jpRd7oV8B5MwPPmaHm1EZFqXOeT3QJxhms9BsC6ow0FLk0Mq674LZKvHh6z8H2SN8qunAkgXUr9Z0nzdvMEQHyIZjfouYQ5s4C/bVP7HnlNQcjTYxdFs2xG4h62Clw+edfK2iU2UOFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711047628; c=relaxed/simple;
	bh=whz6tw0k+eALQzOg9CmKVLWksdsYytKj+KrUW9Jz0mU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=elk85MQVmUW6z48/QRo1pZ4sew/fzW12UoeRvGWh0QHihzEpwSPGfKNr4mSP+2NcPW3yQxOo5qA+WQn28U4LuiMnRKgoBgdGPLkG4ofG341vAXEzE7/UArKNRTIJR3D5034SlC+eR3ZSlXrKcbB8+5gN3aGAnxuaa7VermsU2go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/ivQd2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21D22C43399;
	Thu, 21 Mar 2024 19:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711047628;
	bh=whz6tw0k+eALQzOg9CmKVLWksdsYytKj+KrUW9Jz0mU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r/ivQd2OYTM4KMNa2a+8fQ+guGwforSVWDDYQBcc69fWkaRN3dpiy8tLMRrbXmRr/
	 QguIJtiioWvR0zeqZGaaBwBPuyb7o47PePyrZW7g8e5YUWvCLUzO0Cwu027peIILXh
	 K0PWMOl8NjuC6FRK8rWq9Bdc+DS9dBDUHAgNRsq/nd+bRkbcdT0g9oJOxAni+adjud
	 KTYsB1tItJTzLumy3+LYTJUVjrBjuAApZ7AM4Sa2wU+W5fxL1QYba9Rlh90h8eKruL
	 IA7sBayDhroLMRiNV4Ay3swoleos2NolrTJyyAt4HLmqCAphfRnr3ss222d2lEZHkf
	 VGGUFoeF5cGeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07E9ED982E3;
	Thu, 21 Mar 2024 19:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf-next: Avoid goto in regs_refine_cond_op()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171104762802.29533.11593097586818264707.git-patchwork-notify@kernel.org>
Date: Thu, 21 Mar 2024 19:00:28 +0000
References: <20240321002955.808604-1-harishankar.vishwanathan@gmail.com>
In-Reply-To: <20240321002955.808604-1-harishankar.vishwanathan@gmail.com>
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Cc: alexei.starovoitov@gmail.com, harishankar.vishwanathan@rutgers.edu,
 andrii@kernel.org, sn624@cs.rutgers.edu, sn349@cs.rutgers.edu,
 m.shachnai@rutgers.edu, paul@isovalent.com, daniel@iogearbox.net,
 ast@kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 20 Mar 2024 20:29:54 -0400 you wrote:
> In case of GE/GT/SGE/JST instructions, regs_refine_cond_op()
> reuses the logic that does analysis of LE/LT/SLE/SLT instructions.
> This commit avoids the use of a goto to perform the reuse.
> 
> Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
> ---
>  kernel/bpf/verifier.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)

Here is the summary with links:
  - bpf-next: Avoid goto in regs_refine_cond_op()
    https://git.kernel.org/bpf/bpf-next/c/4c2a26fc80bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



