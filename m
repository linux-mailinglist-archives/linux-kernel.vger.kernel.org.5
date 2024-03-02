Return-Path: <linux-kernel+bounces-89590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEC186F265
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 21:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28FC21C20AE4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 20:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFF221100;
	Sat,  2 Mar 2024 20:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L/LvDSM5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08D11CD33;
	Sat,  2 Mar 2024 20:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709412284; cv=none; b=IiqHD2TnNBVyefPaK4+xQKRLwnvweBXmQUJOWuk2gHLQFibi2KFj5U3IL/jAkgggaE9UTc5+mkajqI6JxZuvnS2946oXBae+EcrXf59eEMDbz85OBrTChflfyVPUpSmcpvEQs41A4J9VOlzqAJwNo15EtobniEXucjyascI8KFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709412284; c=relaxed/simple;
	bh=uORoj+aCZMJXyq3QBV5PLg2nAJwWO3vSilNvdbM03yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnXa170+tYe4kK8FojRX820NLakE7g0x22UmAjClRPymmlIDRH1gaWJ35l5auYBoE0GzHKYXk/3+gudfhXlQUdpVDr4om3udfqrj9QZhkAW2LNnd0PYQWV8x4Z9rMQKrFbnAX82D+5e+OdO57E0ir2LhO92dpMftZk8v4ks4nNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L/LvDSM5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB135C433C7;
	Sat,  2 Mar 2024 20:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709412284;
	bh=uORoj+aCZMJXyq3QBV5PLg2nAJwWO3vSilNvdbM03yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L/LvDSM5zXtA1zDYO1QrOKvlS8yGL1sPbyV/Kedojm7aSq8eVUcACWfEhF5HlLkmR
	 gkPfKaEx/XA9oTAChO/sWZS6LQLx5cysKjbGrAfrytYtL9YwHjiphuxpCVDn8GTQMY
	 CRqVAI2/kGxEm4woJwj5zWZbOGB5Y3XxrNIyC5zQ=
Date: Sat, 2 Mar 2024 21:44:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: LiuYe <liu.yeC@h3c.com>
Cc: jason.wessel@windriver.com, daniel.thompson@linaro.org,
	dianders@chromium.org, jirislaby@kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] kdb: Fix the deadlock issue in KDB debugging.
Message-ID: <2024030232-verbalize-eggnog-f04a@gregkh>
References: <20240228025602.3087748-1-liu.yeC@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228025602.3087748-1-liu.yeC@h3c.com>

On Wed, Feb 28, 2024 at 10:56:02AM +0800, LiuYe wrote:
> This e-mail and its attachments contain confidential information from New H3C, which is
> intended only for the person or entity whose address is listed above. Any use of the
> information contained herein in any way (including, but not limited to, total or partial
> disclosure, reproduction, or dissemination) by persons other than the intended
> recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender
> by phone or email immediately and delete it!

Now deleted.

