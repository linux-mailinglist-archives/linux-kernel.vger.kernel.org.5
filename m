Return-Path: <linux-kernel+bounces-92232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D559871D24
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B38501F21DF8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642AE5490A;
	Tue,  5 Mar 2024 11:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GPuS6XjG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4F610A1B;
	Tue,  5 Mar 2024 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709637243; cv=none; b=TxYMMUdSMoUJWQJy3+Mg8wSVXj/OzDWWrUhfW3QpAscOf/NxuuVCodqC+GtIwTAmLhqaI75Oyssk2/X5NP3JHlIgwqAz9/VGKmJSHU9CSnx3wTq4zmBC5g/ZKzISWqxyyHFxlkyfhc9JGFommB4gDXMJq/lIVISVaisyI3LGxU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709637243; c=relaxed/simple;
	bh=93YHXb6y0Apt1lST2quTYaRCRf9LwfK1dm7emYdB/SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2shKjvMKXQRLVXmBF9pfxzYn8TAyGp+G4rXZ2TxSg0k+MGwRMIw0RLvdbhXzcy9fOhJllinGyzF0BwZ/4501g3cUBjQOAI0t7wE8YL8lPU+qGMi0pEmpDc42pQMU2vcfAOsF0Qv6Xwq5zQcMo3dd61qO9Pdl47x0iNbQdqJHwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GPuS6XjG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F8AC433F1;
	Tue,  5 Mar 2024 11:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709637243;
	bh=93YHXb6y0Apt1lST2quTYaRCRf9LwfK1dm7emYdB/SM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GPuS6XjGbPpN0ba0Fx5rGW74/zG9ly/+1muILjETohYjtuS8H95S/yeCKzqzpU0bc
	 E6Nrf8VivrpW3osM12PI5xTxCHsvV/vpAdBpMWHaT8t/nzhHpZLH5aTpwVfOfklfNy
	 lXPuicmw3Za40+YhXmBkzMY2RhofJKNJXm/fMYYs=
Date: Tue, 5 Mar 2024 11:14:00 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: GuanBing Huang <albanhuang@outlook.com>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, albanhuang@tencent.com
Subject: Re: [PATCH] serial: 8250_pnp: Support configurable reg shift property
Message-ID: <2024030518-encrust-gutter-f507@gregkh>
References: <PSAPR06MB49522EB50BDE08A5D9D0DACEC95F2@PSAPR06MB4952.apcprd06.prod.outlook.com>
 <2024022916-captivate-state-0255@gregkh>
 <PSAPR06MB49526EEA505F752A2A1E1A97C9222@PSAPR06MB4952.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PSAPR06MB49526EEA505F752A2A1E1A97C9222@PSAPR06MB4952.apcprd06.prod.outlook.com>

On Tue, Mar 05, 2024 at 11:24:08AM +0800, GuanBing Huang wrote:
> 在 2024/3/1 6:00, Greg KH 写道:
> 
> > On Thu, Feb 29, 2024 at 07:51:54PM +0800, GuanBing Huang wrote:
> > > From: albanhuang <albanhuang@tencent.com>
> > > 
> > > The 16550a serial port based on the ACPI table requires obtaining the
> > > reg-shift attribute. In the ACPI scenario, If the reg-shift property
> > > is not configured like in DTS, the 16550a serial driver cannot read or
> > > write controller registers properly during initialization.
> > > 
> > > Signed-off-by: albanhuang <albanhuang@tencent.com>
> > > Signed-off-by: tombinfan <tombinfan@tencent.com>
> > > Signed-off-by: dylanlhdu <dylanlhdu@tencent.com>
> > "interesting" names, can you not just use your native encoding to make
> > this easier?
> 
> > ->I'm sorry,this is my first time sending a patch.The names should be changed to the following. Do I need to resend a new patch?
> 
> Signed-off-by: Guanbing Huang <albanhuang@tencent.com>
> Signed-off-by: Bing Fan <tombinfan@tencent.com>
> Signed-off-by: Linheng Du <dylanlhdu@tencent.com>

Yes please, I can not take it in the original format.

thanks,

greg k-h

