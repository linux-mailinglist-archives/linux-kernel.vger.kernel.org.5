Return-Path: <linux-kernel+bounces-32017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2BD83555C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 12:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F6AA1C20A36
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 11:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58308364D0;
	Sun, 21 Jan 2024 11:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="pNUlJpFo"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED76D3613E
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 11:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705834811; cv=none; b=qkw7RAcWforqSXMD/mT23Ck5DfiLUSjKya2PorDEUVfW0BgW83q18/AQnt0nZJxPwzq+o/UpOSzCcfLhr44VRoctdOZMEWV7gmc5KBNCwKr+MqoexxaVLCVO6FuulpMyb/La8KIFw0LmPQHfMVP1hOGTMnZbuj1IE6cAu6tBLQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705834811; c=relaxed/simple;
	bh=mpx2L0PpidQmn6LII8E4mdM0zc9ViLhNoJxMy+C3hKc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SLz4me0usk1XsPIxGNPH6Fpm3k63H4XPwEwULgBnkuqI8mKooL2HwqwUvSJfyayximFcP11c4BpU7tnmJ3eXK1LOX5TwVci+qv3YIskUoPON3b1FzD0w1xLTKMDqh294PlUBcS2cvhbT1S8X85aa2WjoE+iYX8L3uXgytQ/6p10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=pNUlJpFo; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UWN54G8DcZhwd8CcYCFZ1mep8750dTOYSTQEJt94oPc=;
  b=pNUlJpFoM8WUIuaolUNsU5Nq6sK9B4liqDlyzJOIsDTh2M0+7139ZDf4
   +9HohTrYH2FXLvQ+ikHA1Ub1rLTVaacZMuO94GJ30VRjoyVvKTiobSGcH
   sLu1+D5MtTjtfxl8iiCrKtpuWtH3C2J/xqFv4EA9a33gyC6zrWhCK5S3A
   U=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.05,209,1701126000"; 
   d="scan'208";a="147776685"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 12:00:01 +0100
Date: Sun, 21 Jan 2024 12:00:00 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Li Zhijian <lizhijian@fujitsu.com>, cocci@inria.fr, 
    LKML <linux-kernel@vger.kernel.org>, Nicolas Palix <nicolas.palix@imag.fr>
Subject: Re: [cocci] [v2] coccinelle: device_attr_show: Adapt to the latest
 Documentation/filesystems/sysfs.rst
In-Reply-To: <f34231dc-186b-4cb9-889b-b3be9224c5a9@web.de>
Message-ID: <alpine.DEB.2.22.394.2401211159350.3743@hadrien>
References: <20240119062057.4026888-1-lizhijian@fujitsu.com> <alpine.DEB.2.22.394.2401202217550.3267@hadrien> <f34231dc-186b-4cb9-889b-b3be9224c5a9@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Sun, 21 Jan 2024, Markus Elfring wrote:

> > I subsequently simplified the patch case to contain the following:
> >
> > -              snprintf(BUF, SZ, FORMAT
> > +              sysfs_emit(BUF, FORMAT
> >                                ,...);
> >
> > This also works for the case where there are only three arguments.
> > It has the benefit that the change is recognized as a line replacement, so
> > no extra {} are added when the call is in an if branch.
>
> Would you like to consider the application of the following SmPL code variant?
>
> -snprintf
> +sysfs_emit
>          (BUF,
> -         SZ,
>           FORMAT,
>           ...
>          );

It's ok too.

julia

>
> Regards,
> Markus
>

