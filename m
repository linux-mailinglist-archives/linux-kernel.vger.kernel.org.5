Return-Path: <linux-kernel+bounces-122019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E61188F0DA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9093B1C2D07A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39897153591;
	Wed, 27 Mar 2024 21:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="eGdUKc52"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1EE28366;
	Wed, 27 Mar 2024 21:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711574703; cv=none; b=TPK0Rh41mZSPMxaMkKysvJ3Yv2ho+NWtkQaAHCZHsnT7Bgp5P2met0rnPJoFzATIfv1nq0JQs/HVevaJkqEKkcImtnUwGKvoCErlPup5GUwv3CRfI2Euim6WSgJgK4RUjzBZZRWdJc7b93fAUMkUFr8nKkMYJ7YHlyvaZgP1MHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711574703; c=relaxed/simple;
	bh=fMWyR4T8HDfiXSrxNx4i4P75j10VLhztLf65/nEwedA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L2oUVuHnGjGROlR/MAagYXGvgnzy1e+10LZTvbJldYODhKEiAoCynqJQTTaOeHybA60wZMK4cYJ4e6eIfnsy/8fx7spKOJVp5IRSYfNIgL45Wjo+OAZlkpGSdmiGPY9jQpsjEXwHmCA4jGCdb8f76gHiA1flYsrLu2jY2azg2ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=eGdUKc52; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=fMWyR4T8HDfiXSrxNx4i4P75j10VLhztLf65/nEwedA=;
	t=1711574701; x=1712784301; b=eGdUKc529jKPvDJpYhuu7ujqZgD6Oonudp6XU+ZXie5k5Kl
	t1yt7HVoL2GI0EkL5RoIFxRk1OTrsYmq+EoBKw/4IrNVypqQXexG8ViH/wah4QFL9PEt0h1FLko4O
	5IT65arrJXuxoytyg2iPlraYHeRIX9HuTzz6JYApJnEwsMUwv00TqB6r/Jkf6q7QbNFqjfih4/NAX
	3cLrT4qjHTVJDCViq768HhjYQpDAfcxU6HxKwB7TgaW4kK7QHQlXWzrNsBMsMEVCbNroufKTFT8HJ
	nHiUaAl2zkl1IpDMy0YFK+1dPvJ5vge2KgUGWbaThIrp44woFAWfzaUSpcRrLxUA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpalV-0000000HOpZ-2XGl;
	Wed, 27 Mar 2024 22:24:57 +0100
Message-ID: <f50b31a3328986952f4042985eb5bab66c4ed1d9.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v2 1/4] tracing: add __print_sym() to replace
 __print_symbolic()
From: Johannes Berg <johannes@sipsolutions.net>
To: Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Date: Wed, 27 Mar 2024 22:24:56 +0100
In-Reply-To: <20240327211119.GW403975@kernel.org>
References: <20240326192131.438648-6-johannes@sipsolutions.net>
	 <20240326202131.9d261d5bb667.I9bd2617499f0d170df58471bc51379742190f92d@changeid>
	 <20240327211119.GW403975@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-03-27 at 21:11 +0000, Simon Horman wrote:
>=20
> I'm seeing some allmodconfig build problems with this applied on top of
> net-next.

> ./include/trace/stages/init.h:30: warning: "TRACE_DEFINE_SYM_FNS" redefin=
ed

> ./include/trace/stages/init.h:54: warning: "TRACE_DEFINE_SYM_LIST" redefi=
ned

Yeah, the 0-day bot reported that too, sorry about that. It needs two
lines to #undef these in init.h before their definition, just like all
other macros there. Not sure why my builds didn't show that, maybe it
doesn't affect all users.

johannes

