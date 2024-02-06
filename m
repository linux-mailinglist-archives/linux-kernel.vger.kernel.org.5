Return-Path: <linux-kernel+bounces-54953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BFD84B559
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938492891E7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B6112FF68;
	Tue,  6 Feb 2024 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3UFHHs/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A054912F399;
	Tue,  6 Feb 2024 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707222628; cv=none; b=Uo9/6bM57b3vvKNyKMFXUSZF62DL1daTneJXZtJ1ofRLtwVz4nOYyniL5UEdcHZnQCublqvKG4jtJgBUGfNliYJHaZgH5m5ttbukMMUcpfUiAyxpcdxg/Aan7zzBL17EQxNEtGeENrGYYZ2LMh0LFSsspgKW7DfjwUov5Xm/JeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707222628; c=relaxed/simple;
	bh=3E6W6YiXOQMimuiMDxemep8UT52NggZB36Tpv4obHjw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YkibJ18POh5/w87b62QQWnJBMocimOwtURyB/sUJ4B08rrqO7ZtohaLHrt7t/fykWYGviUsn5AGqQ4m+s/eIcjuws5y9CAD7hxZ89EBOnRzOGytJWhxsqpX1659dAtj0orl93IKc/N5No5KPQOJzBUSRk30lXmbbmt5ahkeKeeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3UFHHs/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 452E0C43394;
	Tue,  6 Feb 2024 12:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707222628;
	bh=3E6W6YiXOQMimuiMDxemep8UT52NggZB36Tpv4obHjw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W3UFHHs/h3tiEDunOQy+6f07g2LsRppyYqp+uSPY4Vu6gfxjTaDhrTu+OWb1aE6Rx
	 zPAbiYN2072o7UAvR3Pbvu0otlyovH3vCleBaJLS39QM5MllCZWQpyrO1/y3/46uku
	 wb+HOWmPLnwd5Uu674+u6kWICdCjV63k2ZaRkUXeJrAPZPqJ2IFQaEp3uG5doEmV0r
	 +w5eYQzrZ67kbFGrHuJMd83KtPI7dIOE3L02womdhHMQ/fhF8JLXdLj0UzsCASK89L
	 kSisW/S7SBOXsIEO+jfx/PHUQ1E8Df4ZtJe+0hjwCB2mx+aJcxWm3ebApd3YWvuMKi
	 BMOJXwyvHOyMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23DC5D8C981;
	Tue,  6 Feb 2024 12:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7] bonding: Add independent control state machine
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170722262814.15492.1613133605046050372.git-patchwork-notify@kernel.org>
Date: Tue, 06 Feb 2024 12:30:28 +0000
References: <20240202175858.1573852-1-aahila@google.com>
In-Reply-To: <20240202175858.1573852-1-aahila@google.com>
To: Aahil Awatramani <aahila@google.com>
Cc: dave@thedillows.org, maheshb@google.com, j.vosburgh@gmail.com,
 liuhangbin@gmail.com, andy@greyhouse.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 martin.lau@kernel.org, herbert@gondor.apana.org.au, daniel@iogearbox.net,
 jiri@resnulli.us, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  2 Feb 2024 17:58:58 +0000 you wrote:
> Add support for the independent control state machine per IEEE
> 802.1AX-2008 5.4.15 in addition to the existing implementation of the
> coupled control state machine.
> 
> Introduces two new states, AD_MUX_COLLECTING and AD_MUX_DISTRIBUTING in
> the LACP MUX state machine for separated handling of an initial
> Collecting state before the Collecting and Distributing state. This
> enables a port to be in a state where it can receive incoming packets
> while not still distributing. This is useful for reducing packet loss when
> a port begins distributing before its partner is able to collect.
> 
> [...]

Here is the summary with links:
  - [net-next,v7] bonding: Add independent control state machine
    https://git.kernel.org/netdev/net-next/c/240fd405528b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



