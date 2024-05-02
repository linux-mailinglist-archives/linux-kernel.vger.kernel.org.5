Return-Path: <linux-kernel+bounces-166708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A83B8B9E69
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FFD21F24BFE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D9315E5C8;
	Thu,  2 May 2024 16:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="YrIFh892"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74A714A634;
	Thu,  2 May 2024 16:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714666872; cv=none; b=uEYWGE4+yFEoSe/SQoOLXpwqU9YlvrtAXTfTPReDiXMEJMjG4XxT9/5fh6SsbOJlSId8VSYkSPP+H0LAobaJl0qJZPairXbzcqWfr7LtStNEsZMp3AvQkhGS1xyaqPpE1gh/P4BBWiWcaavGHCva1MfGSUycwdEJb2f8NdYXSug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714666872; c=relaxed/simple;
	bh=Z05WgU3aafLprgYV9IDNlMX9MUGyo1Jra7XKiJMpEHI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m3Bdv2+yu6HuX5S8OcLktvepRwhio/hCU+G92JtOg3W72y2YcDNg1ZVXs+DzvcC2dZV5UjB6cw11zD0Aqyt7DGIB92iFK+XGcKvxq6Z7PfDhVzh8JDQwIfO4c4n4N0LTeFPqueeW3VLux0s2MmyDSn4VzkMqpq8397TeckbaF+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=YrIFh892; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B170947C39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1714666869; bh=XMrTBMGLBVTy6sqrL3KsBhAdRcCXU7B5G0Wg6k9C0HM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YrIFh8925mWjDSdAqOvl4dt9FupkIPQbxNYQVv+ECsl4325j3DdLByH1BpF/Ik0yE
	 tSzaM1ckgEOgz2wKPQecnVtcWH5KRhrJlkum8mW2GOyV6V56Ei+IhRU4oEx5/pY7Ju
	 2oufhSRw1+1w4Mg//H1k04qJgrCL2IDl2AKrK8S/Hd0eg7FBvxGbM2igjOzEt2MEER
	 VqlJGqanwzL+cBTXm5V3+wFsSh/LxGHxz5fBWP21aKbOeyt/6D4u8yO5SUqh6HzETW
	 bUiAKFEES62jWx6WykwtXT1pt6lvOzxaQwmu8X9uFODW8axVwwJCa00PaMdD5Giv/i
	 NkAZ3Xf8dmMnw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B170947C39;
	Thu,  2 May 2024 16:21:09 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: "Bird, Tim" <Tim.Bird@sony.com>, Greg KroahHartman
 <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "workflows@vger.kernel.org" <workflows@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] docs: stable-kernel-rules: fix typo sent->send
In-Reply-To: <SA3PR13MB63726A746C847D7C0919C25BFD162@SA3PR13MB6372.namprd13.prod.outlook.com>
References: <SA3PR13MB63726A746C847D7C0919C25BFD162@SA3PR13MB6372.namprd13.prod.outlook.com>
Date: Thu, 02 May 2024 10:21:08 -0600
Message-ID: <877cgc6v7v.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Bird, Tim" <Tim.Bird@sony.com> writes:

> Change 'sent' to 'send'
>
> Signed-off-by: Tim Bird <tim.bird@sony.com>
> ---
>  Documentation/process/stable-kernel-rules.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
> index 1704f1c686d0..3178bef6fca3 100644
> --- a/Documentation/process/stable-kernel-rules.rst
> +++ b/Documentation/process/stable-kernel-rules.rst
> @@ -78,7 +78,7 @@ in the sign-off area. Once the patch is mainlined it will be applied to the
>  stable tree without anything else needing to be done by the author or
>  subsystem maintainer.
>  
> -To sent additional instructions to the stable team, use a shell-style inline
> +To send additional instructions to the stable team, use a shell-style inline
>  comment:

Applied, thanks.

jon

