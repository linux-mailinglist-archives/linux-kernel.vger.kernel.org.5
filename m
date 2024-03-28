Return-Path: <linux-kernel+bounces-122581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DE688F9FC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9104DB2512C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338E454907;
	Thu, 28 Mar 2024 08:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vKOostsJ"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367E21C288
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711614355; cv=none; b=gk9f2PsFpU9J3zfQeCcYThlE+zdWoxAIFfoAUKC6ife6VgDm18JAwcbjaJ+2dEBLU3EwFNQT2E1nuOEMHhgBJ8GeDKXdmMI5w19KGVODj6haLRN++/3hmZKXtmklnmI/+v8JIbGeDRl7snADwV/WYCBsHWySxTps4sk3SjWrZyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711614355; c=relaxed/simple;
	bh=xyJ35OeYZ8gYDoCSDvqC+bURigKZ0DrKEJIfJCIxPiA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WMUXaiq6Q3s7eQJVMyzHhdQJb8yB2xXH1OdUd1gk4DnqUHx+hyZbB9YdsX/8d/unVYeL8EaUdFnvd2mBvnPnGe1oJW05L6QYf7E/xa9bNcOm/Z1A0r0HqePHrmw8y9Zr8Jvsy6w/4b3ZLU9xJegf5w1/xavzfYKmww8DA9vIM6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vKOostsJ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=xyJ35OeYZ8gYDoCSDvqC+bURigKZ0DrKEJIfJCIxPiA=;
	t=1711614353; x=1712823953; b=vKOostsJpL7kb+WntTWwPGs3/0Y/OWqW18vvaGyfSYKwY64
	auWJQ0UpmDIZAhuw7oaqkJEl0jZHr+B1rjOp3NisNtqVq0lmSI5xwshO3AcRauBkwt+NuY+zF6Ntb
	qzYtsbSztocAjWr/57Ja4/5ZCx0+tou5TJxmZbe4qMAZNUtK/hxGedG4tHsKUsj5On+bR8B3Lgv0K
	NSF8/nody1Vv9NLxDPOrz9vY3sicvTBko5MFLZ/vuupq1wgBDk1tVUq8tIdcbbW7fn3paHyjsHG6x
	RKYVD6S+0/s29ofx7zpvfcYy/UJmLzgjQnIAj1Ho8WqhbVPgLNYYUsuLkvmJYm+Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpl51-00000000mV1-3Jg5;
	Thu, 28 Mar 2024 09:25:47 +0100
Message-ID: <1743ad022502d64042fa7db4d847a988bb90cbdc.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Add winch to winch_handlers before registering
 winch IRQ
From: Johannes Berg <johannes@sipsolutions.net>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, Roberto
 Sassu <roberto.sassu@huawei.com>
Date: Thu, 28 Mar 2024 09:25:46 +0100
In-Reply-To: <20240307104926.3531358-1-roberto.sassu@huaweicloud.com>
References: <20240307104926.3531358-1-roberto.sassu@huaweicloud.com>
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

On Thu, 2024-03-07 at 11:49 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Registering a winch IRQ is racy, an interrupt may occur before the winch =
is
> added to the winch_handlers list.
>=20
> If that happens, register_winch_irq() adds to that list a winch that is
> scheduled to be (or has already been) freed, causing a panic later in
> winch_cleanup().
>=20
> Avoid the race by adding the winch to the winch_handlers list before
> registering the IRQ, and rolling back if um_request_irq() fails.
>=20

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

johannes

