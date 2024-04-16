Return-Path: <linux-kernel+bounces-146340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1A88A63AB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 409391C20A27
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8A96CDCE;
	Tue, 16 Apr 2024 06:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="iqnfddhq"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5113FE2A;
	Tue, 16 Apr 2024 06:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248276; cv=none; b=Dgjbdtqgy0QUww+IBxrw257jT8OrCq/l0XP/S28swAhLu+zkMIAAdJpOw3As/+/WJYaBpRHD9peHlewVYbDGKiHrkqAYDh+McxoJKeJGQLuzaNSLL3qE/XnLdMgO9n/mo4H2UC8pS285+2MmQ8ila4EUcKkU60ajwgwvmVCaA5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248276; c=relaxed/simple;
	bh=X+Jdad5MYJjeowNK7WUDKVcmRB0TARMUthcNAdaLKNM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BP4TfK/iOb2FeqNHHZNn/9sC70uqwjGeIIuJhBlRhGMcIYga/kySc/hj7RCfaOjodT/KlKG/a696EtuYjQHC9R/HssMtzmJBrM4EubruV9GpiUVjs20NjBQ1QPQIk2Hl3+Wx14Q9+dEkZuj6RHlAxQVMJa5/RjruVg1/6OgIrB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=iqnfddhq; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=X+Jdad5MYJjeowNK7WUDKVcmRB0TARMUthcNAdaLKNM=;
	t=1713248272; x=1714457872; b=iqnfddhq+BIoXRz8UfEtqJkRjHEt0E2RA+XCftyLlyJYvB0
	QhOrGA40g/55FfITLJ6Nb+r8jjXJUHJwWpNas5zzVtmbspOLB4rwjtqUEokfmjVjzlk4L36t7Q7SE
	b5OR/8heF20ATIkWhiT4OcIym4z3J79BdvA+jItlnTSdFI82vi9y9D4OZiyjzS/YaYMhW2vmzgzzM
	VXcL1zfJ4+xjp6ImwuVn1aVWccMK0nhfaLXr/5jz+sgELb3xqXqolvTJpzskaiAdt7B4XmvFH6TlA
	XJ0RiDIpG+k6iNxiLkl+qAFvW0mMunsPAwrpEsXAf05uqwqjZdMAMlSXPZVoCJgw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rwc8b-00000009AgD-0tJh;
	Tue, 16 Apr 2024 08:17:49 +0200
Message-ID: <8736ebc8881e1e0cabfbbf033725a3123a5e8e90.camel@sipsolutions.net>
Subject: Re: 6.9.0-rc2+ kernel hangs on boot (bisected, maybe LED related)
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, Lee Jones <lee@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org
Date: Tue, 16 Apr 2024 08:17:48 +0200
In-Reply-To: <de43c7e1-7e8c-bdbe-f59e-7632c21da24a@candelatech.com>
References: <30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com>
	 <30819e01-43ce-638f-0cc6-067d6a8d03c7@candelatech.com>
	 <89a9eec3-337f-3c9f-6bbe-00a26a15287c@candelatech.com>
	 <20240411070718.GD6194@google.com>
	 <de43c7e1-7e8c-bdbe-f59e-7632c21da24a@candelatech.com>
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

On Mon, 2024-04-15 at 13:37 -0700, Ben Greear wrote:
>=20
> Johannes, you had another suggestion: changing iwlwifi's request_module()=
 to request_module_nowait() in
> iwl_req_fw_callback()
>=20
> Is that still best thing to try in your opinion?
>=20

I guess so, I don't have any better ideas so far anyway ...

johannes

