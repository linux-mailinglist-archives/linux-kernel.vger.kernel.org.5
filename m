Return-Path: <linux-kernel+bounces-157740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C698B153D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6838B21C3A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A288E156F56;
	Wed, 24 Apr 2024 21:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CuofVGuC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE598156999;
	Wed, 24 Apr 2024 21:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713994768; cv=none; b=PBqmxFH8Iin3rHC88sPWs7y8AtW4H+33ST3ZDh8wvI39mFR3JRodccWwTfq+MznaSLdYkJwC6qCYdPuTQc5f39zaxKEd3z21RjU6nPAHQi+KGhGqktYiWoRMWLOhXj+/g2O1Mo8d93I5BXNVJKRZkjaH6A19RgxP6FGNIZvebjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713994768; c=relaxed/simple;
	bh=Yoz0p4DuYNY86ytkQCrafsdSRRHisQsrPccjw+Ox++E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lav1MnwLk4bEzVpt57bjB29zmyQyAnZIO9LGw6Kgl/H55IbOiNLnJqWaCofENty1EgOTFeLGM2IR1RzPlzONh05OS2qjZlut3V4/akaMx6Le9oxqEBCtYOip2Bbb6jk3Fr60nVZi5yX65kimNYnaMAZEnq7/0iY95rCOquTI6SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CuofVGuC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7404FC113CD;
	Wed, 24 Apr 2024 21:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713994767;
	bh=Yoz0p4DuYNY86ytkQCrafsdSRRHisQsrPccjw+Ox++E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CuofVGuCfq18i3Z1DHuKb3sp9/YMkdI9oIQ3cnJDfQT2Pf2eLsUFD1EPC4aV3PQ6A
	 74hxtgaTGVNlphKnzKJp7yJbz/EtFYDUday2A3bXZ8CFx+udBeuBeeiHP4xQ8N91n0
	 EzTDn+9g6QBcWAVrlizQZ5VzCWRKZELp+TK6acZg=
Date: Wed, 24 Apr 2024 14:39:18 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: Jonathan Kim <jonathankim@gctsemi.com>, Dean ahn <deanahn@gctsemi.com>,
	Won Kang <wonkang@gctsemi.com>, support@gctsemi.com,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [RFC] staging: gdm724x: How to proceed with drivers gdmtty and
 gdmulte
Message-ID: <2024042433-reimburse-cork-8239@gregkh>
References: <f82fffbf-a983-4ab4-897b-b5a810426f04@gmail.com>
 <igi27iwrzg3ovgj3sym4gsi45timpkt4vkl5ss5dbftdzat6p4@ctxcjocvunpt>
 <78b521eb-4e89-4c01-8dfc-1fb990e6887d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78b521eb-4e89-4c01-8dfc-1fb990e6887d@gmail.com>

On Wed, Apr 24, 2024 at 08:33:25PM +0200, Philipp Hortmann wrote:
> Dear Sirs,
> 
> Won Kang contributed a driver gdm724x to the Linux kernel staging subsystem
> in 2013. Have you done any tests with this hardware in the years up to
> today?
> 
> struct usb_device_id lists the following devices the driver can work with:
> PID_GDM7240		0x8000
> PID_GDM7243		0x9000
> 
> but on http://www.linux-usb.org/usb.ids I can only find:
> 0x1076  GCT Semiconductor, Inc.
> 	0x0031  Bluetooth Device
> 	0x0032  Bluetooth Device
> 	0x8002  LU150 LTE Modem [Yota LU150]

Note, not all USB devices (I would guess only a fraction) are listed in
the usb.ids file because USB devices are self-described (i.e. the
strings are in the device itself).  So don't go by the presence or not
of a device in this file to determine if it is "real" or not.

thanks,

greg k-h

