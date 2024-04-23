Return-Path: <linux-kernel+bounces-154984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB66A8AE3E6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B35281BA0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CCB7E586;
	Tue, 23 Apr 2024 11:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="aYtOY2Ic"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5F57BB06
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871770; cv=none; b=XCUp1rqYwOU67NwWOG8WRDciNhYPcvzm/49mV3IbVEmPOrvW6y8PYN457BIaJY2feABTJYC7tU+sWIXIr7ZQ+POndddW/ziaLebsEkPzkxzhNhKX6Niaz5AkPTd5HWty/LhVdpOkXqbkEATxO0Aoqm8ORA29iXsjajgNkLek4tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871770; c=relaxed/simple;
	bh=o6YwXkKcrBip/n8XbotfTNmmwA3LZw9jroITc42suXc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lbrpkyWhBln37/IO1WrBvXY6V6BqxafoBKYDjyvZsdgefydFpXTv8e/UEXuYe1d5/igR7/9yPWh2UeWYu7LbVWX+H7yAxIoljm9fQ3cnt4E5eroXCpSVgMFvRLamzj3PRXPxr5Piisp5RExY2NtVmRKCsOZvktUBhLH6MtAzrV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=aYtOY2Ic; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ZReZYBGsS5mYNtqYDrh+YYklkB/Yp7ikoMDuzoyx5Vc=;
	t=1713871769; x=1715081369; b=aYtOY2Icr3xRWNEdXU9Bn1eBrkdhCjJNeqHGqXh6OYak7Vn
	FMN4XGxvXAAVr+UehdsjdLPU8yIinqrr6RXveyKTBlWz2kMfRHDrmPYE2Pr6sTpTr2JG7GGkY9G9/
	gPnnflYqKY8P4nEnhzk+f5mL69okXxeWPsjtcE5fq9zZKw+WLPLWPKkE4wTY36TnBZFYZfQ8YzWdW
	HSH9WWIqcjffZZlRLdK22+TWBdMZZcq07aerBGdDbFt9bbtt8XSJy5OJ6t2pAk9vf4Y4e45IBI3br
	Oy2dRm/oxmVV0C7SgALZLPqYwCXJeJhS1cseh3a7ECSIUctIS+ejLM+uUauK5Z0g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rzEKx-000000025wR-13fF;
	Tue, 23 Apr 2024 13:29:23 +0200
Message-ID: <8134c423c1a7f911cb5ae2f2e8e40e80f2e5270f.camel@sipsolutions.net>
Subject: Re: [PATCH 2/7] um: Fix the -Wmissing-prototypes warning for
 __switch_mm
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 23 Apr 2024 13:29:22 +0200
In-Reply-To: <20240423112457.2409319-3-tiwei.btw@antgroup.com>
References: <20240423112457.2409319-1-tiwei.btw@antgroup.com>
	 <20240423112457.2409319-3-tiwei.btw@antgroup.com>
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

On Tue, 2024-04-23 at 19:24 +0800, Tiwei Bie wrote:
>=20
> --- a/arch/um/include/shared/skas/mm_id.h
> +++ b/arch/um/include/shared/skas/mm_id.h
> @@ -15,4 +15,6 @@ struct mm_id {
>  	int kill;
>  };
> =20
> +extern void __switch_mm(struct mm_id *mm_idp);
>=20

Maybe drop the extern while at it?

johannes

