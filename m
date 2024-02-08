Return-Path: <linux-kernel+bounces-57593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 619FD84DB24
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02E7CB222B3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEECA692E6;
	Thu,  8 Feb 2024 08:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="LOUDwAWe"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DE36A03A;
	Thu,  8 Feb 2024 08:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707380034; cv=none; b=Ph46zr57ALJHmaETCVEMumdTUB08t7829+MC0sLIxwUtQ0UVNwGGHHm5QPha7wljpn19XVT2ZBpkrLeqDKs/MV1vLS639osEdQVi4Z9mqetfLvvj/v222QStCQvAGeWSyN1zwdngw5E0PYThZ/xvIgO9lZ8B57aTsPs34FSJcEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707380034; c=relaxed/simple;
	bh=LFohAqcwHqGuwSh8U95371hYU/NXi/YIftlluaNzgcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1nPWYAPX/ViCq5Qk8cA+/pmBKsIRM3anw5GBvWtpS1tEzt3l08Mc/Cag3kXJTAsAOVlCCDkZPfqY8zS0Ph3g1Tsy+Wv9ukXMenHpXMoL7+BElSf+R9kpFIMnREU3/8FZuvYOqDMUdbbx/FXERdOyDPduald06dskVsihhEG074=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=LOUDwAWe; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id A4F60603F4;
	Thu,  8 Feb 2024 08:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1707380025;
	bh=LFohAqcwHqGuwSh8U95371hYU/NXi/YIftlluaNzgcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LOUDwAWef0wGBHc1K0Sizi+WgSJcc491FzEJrY2mlV7cJ5ky2R27R++QPMOvFe6Jz
	 f6bk0O0rLVjZ4UrvJgeGf327K043lXsuZePC4DsBYjidpXsRwjLPtkOBl84loSPkhX
	 JdhiEWwiM0/bkA7s8bDiv1001tkGQYlR1ODEqenTZzrblGMXkbvsuk6ZiYmeN5TRLP
	 1akTBcstpH1j2z3iZSKeZTwv1BBNz+wYA1AYhTtxRYWqVwoo573xBmIJx0nRo6wDaD
	 ldX4NQL+dpYGlq8wn4hF4ldtRLzea8HQkizegHxWQMm9X8fyo3xHuZTFHEjAHEJSb2
	 7C7MWtOxgFddA==
Date: Thu, 8 Feb 2024 10:13:15 +0200
From: Tony Lindgren <tony@atomide.com>
To: Yicong Yang <yangyicong@huawei.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	john.ogness@linutronix.de, andriy.shevchenko@linux.intel.com,
	tglx@linutronix.de, yangyicong@hisilicon.com, linuxarm@huawei.com,
	prime.zeng@hisilicon.com, jonathan.cameron@huawei.com,
	fanghao11@huawei.com
Subject: Re: [PATCH v3] serial: port: Don't suspend if the port is still busy
Message-ID: <20240208081315.GA52537@atomide.com>
References: <20240208075216.48915-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208075216.48915-1-yangyicong@huawei.com>

* Yicong Yang <yangyicong@huawei.com> [240208 07:56]:
> Reviewed-by: Tony Lindgren <tony@atomide.com>
> ---
> Change since v2:
> - Narrow the spinlock region per Andy
> - Make __serial_port_busy() return -EBUSY if port has pending chars per Andy
> Thanks.
> Link: https://lore.kernel.org/all/20240206073322.5560-1-yangyicong@huawei.com/

Looks good to me thanks.

Regards,

Tony

