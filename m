Return-Path: <linux-kernel+bounces-84310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 443B286A4D0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A43B0B258B4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68AD1FB5;
	Wed, 28 Feb 2024 01:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIgiXhCq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC65EDD;
	Wed, 28 Feb 2024 01:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709082799; cv=none; b=WeocnG6kgN5HNQuJSQHPIsTTnMttEcc+P0U18PL48Mva3njNt+lQoDbgjA1ikRDDoQbJmxAro/wIFB/GcI6xD9srpp7b97cOPuUMrGUeUkupVND4vqsSBKYmBauwIPe05cB/uvq59wYGpF2r7gF1LmUX30x+NcgyAofyrAcPynk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709082799; c=relaxed/simple;
	bh=C+rRmB4z5l9btdhBTc4yMDZ+lILSCJDrkTvKG1X3jXA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A+CJy20Et4I4TVVmUGFN9hy2er7WnIMbhLcQHCFBKekN6ZfK5iEGlxqK7MGdbGW796hr0Pcb8MqVws0padbt2tQiHF8Z88CYpp5qYDaJfIxguYZ6hZz33oRTOmlwOVYUihqoNuLhDS+37L+c8Gns3Lh0w9M1MMvwFv0xITDgJUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIgiXhCq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F75C433F1;
	Wed, 28 Feb 2024 01:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709082798;
	bh=C+rRmB4z5l9btdhBTc4yMDZ+lILSCJDrkTvKG1X3jXA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UIgiXhCqo5GJGvw8M0/WD+WE7QrPKzJjzB3pkMf5itTvtlEQ6Lq00qHknYNCbYuhV
	 kAtEO+6SnJqmzJyA/4ieoPAg32PRSbl2G8EW0Ip5c8aok5Scj2duT2A+sao1E2rKMB
	 z0lrm63NvXJtwaL9a2a7wnoMmEBf1qnMV6BfJI8sORNJ+rwf9zKa+044vGv0zlvbON
	 028bBMDnGdRr2mUuinl1+AkvcxSToOAFso9x7wc5W7E8N6cfrNKtbjLa7AavamtnPz
	 VejFJ91dsPoBoxKlKyDf2flbMJCYGO8MoQeDC07gj/uFMZP4UufQjiDyxvbiNTLvG7
	 geGMr9qpvCyVQ==
Date: Tue, 27 Feb 2024 17:13:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Lameter, Christopher" <cl@os.amperecomputing.com>
Cc: Eric Dumazet <edumazet@google.com>, Adam Li
 <adamli@os.amperecomputing.com>, corbet@lwn.net, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, yangtiezhu@loongson.cn,
 atenart@kernel.org, kuniyu@amazon.com, wuyun.abel@bytedance.com,
 leitao@debian.org, alexander@mihalicyn.com, dhowells@redhat.com,
 paulmck@kernel.org, joel.granados@gmail.com, urezki@gmail.com,
 joel@joelfernandes.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 patches@amperecomputing.com, shijie@os.amperecomputing.com
Subject: Re: [PATCH] net: make SK_MEMORY_PCPU_RESERV tunable
Message-ID: <20240227171316.40fe9c35@kernel.org>
In-Reply-To: <bc168824-25dd-7541-1a34-38b1a3c00489@os.amperecomputing.com>
References: <20240226022452.20558-1-adamli@os.amperecomputing.com>
	<CANn89iLbA4_YdQrF+9Rmv2uVSb1HLhu0qXqCm923FCut1E78FA@mail.gmail.com>
	<bc168824-25dd-7541-1a34-38b1a3c00489@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Feb 2024 15:08:18 -0800 (PST) Lameter, Christopher wrote:
> > This looks good, do you have any performance numbers to share ?
> >
> > On a host with 384 threads, 384*16 ->  6 GB of memory.  
> 
> Those things also come with corresponding memories of a couple of TB...

We have a lot of machines at Meta with more cores than gigabytes of
memory. Keying on amount of memory would make sense. Something like
max(1MB, sk_mem / cores / 8) comes to mind?

In fact it may be a better idea to have the sysctl control the divisor
(the 8 in my example above). I had issues in the past with people
"micro-optimizing" the absolute size, forgetting about it, moving
workload to a larger machine and then complaining TCP is choking :(

