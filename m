Return-Path: <linux-kernel+bounces-99190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51F08784AC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC9C2824B2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B8C481C0;
	Mon, 11 Mar 2024 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dd0/4lqZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CED4597C;
	Mon, 11 Mar 2024 16:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173473; cv=none; b=JVtrdDvW10gxF9xyTDtBJrFLrXUDnMSZasccne5qUrRfdYSxzuo2OpdTUvrVUK05Lj8RrytqJ5flHMZOiNRvMesK3XMedKvTNlzKiL0XAjLRUSw9lvcGbd75KuEfZL4Vc0Wmg9wU6pMlXw04b3pxvbhfwB6iFWTORpJIILaf5qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173473; c=relaxed/simple;
	bh=soyh4RW8kdcWJgux8T6B7dk9eDDacZ74o8oa5TzKhJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u3R07y09mdP/ADfp8MBDTghAufEhv4waALS/zscf8fvhwkihoFIFl0Z09v+8wBobceW/FQI1GNbrllmjwqGJ5hp1uhQ2krPOMihKfubBQ2FfNxb22q7ziMLYwYRugC+0xMTQFtMeqWRk3sI7DeBfQGxtpZA+4hrVeLHsZl4JQ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dd0/4lqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1E5C433F1;
	Mon, 11 Mar 2024 16:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710173472;
	bh=soyh4RW8kdcWJgux8T6B7dk9eDDacZ74o8oa5TzKhJQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dd0/4lqZ5MNtinVMiG169g9pXnKbX52fNuZ6OnMXIw+v8N6Yc5qq6T1sDoejrRV2F
	 CIL+DKfT0vMvl8YjYF3yUOtwCxIDYg+t7MQ7zZZSwRoH6OzJCtGHVBlot6ZTp2J4TY
	 P8fFXRkpZ+iqB+WKetMxBgb6Thke+1YKm+33iYsxWeda7aJO0oSNxz8dO52u+2xSAv
	 f69CUoYNCAlsJG9c8oHd61PuxqpdITFPQfikVPLOmClaxhNOjG1ktbqxYA6XXwUNRE
	 p71LQLk+P7sWzyZ00SVjU0zx9Fj6kKzT6225naAekJK6DGedrx/+aQSWQSxBTRzp2e
	 bb+kcCLL1hLeg==
Date: Mon, 11 Mar 2024 09:11:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Luiz Angelo Daros de Luca
 <luizluca@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alvin
 =?UTF-8?B?xaBpcHJhZ2E=?= <alsi@bang-olufsen.dk>, Andrew Lunn
 <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: dsa: realtek: keep default LED state
 in rtl8366rb
Message-ID: <20240311091111.53191e08@kernel.org>
In-Reply-To: <09793a72-bfe5-4cb5-a6da-ffee565e6956@kernel.org>
References: <20240310-realtek-led-v1-0-4d9813ce938e@gmail.com>
	<20240310-realtek-led-v1-2-4d9813ce938e@gmail.com>
	<388b435f-13c5-446f-b265-6da98ccfd313@kernel.org>
	<20240310113738.GA1623@kernel.org>
	<09793a72-bfe5-4cb5-a6da-ffee565e6956@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 Mar 2024 12:47:19 +0100 Krzysztof Kozlowski wrote:
> > FWIIW, I think this relates to review of an RFC of this patch-set.
> > 
> > https://lore.kernel.org/netdev/CACRpkda8tQ2u4+jCrpOQXbBd84oW98vmiDgU+GgdYCHuZfn49A@mail.gmail.com/  
> 
> OK, then this is v2. RFC is state of patch, not some sort of version. Or
> just use b4 which handles this automatically...

Eh, hum. He does according to the X-Mailer header. More importantly
I thought the RFC to PATCH transition resetting version numbering
is how we always operated. Maybe b4 should be fixed?

He put the change log in the cover letter and linked to RFC, FWIW.

