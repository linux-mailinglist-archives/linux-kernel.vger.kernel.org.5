Return-Path: <linux-kernel+bounces-79073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BFD861D3B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19B11C23117
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B5914601C;
	Fri, 23 Feb 2024 20:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="JfknjjIn"
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1F084FA7
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 20:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708718646; cv=none; b=bKhQEJ2VDn9YctcQ7vcGtACDugPh8Q6PTNdQypojv+Qcrwp7q6io3/7AbWDFZEPcanvLkC5zRxpXj0hELCnypTPpyXmQMb44CvmxWfThfnwpJFMruFddxCkvWkk5JqTDwKbVxduk0zFQPXD9WidCmdVlvEShX/UKIRuUVxKAwiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708718646; c=relaxed/simple;
	bh=9cEDsIi8vRUs821xVTfotIwh6nb7wOR2IdPnx9HNDH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRvAPTE9dDQv5/hI71HpaZuY4GkzdT7idn40VwKJ/hAzOIt0RBVvK78FX7v0QWWSxWvi1dlRcSUYRexObHfFpu8b6ghjxLLDFJ6TAKzKn3JcPnFyB0w0h/6nVpzv9iqOPLP+lETGxO+J9v61M1c0yaKtTSWkLXL8r3MM2jgq7sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=JfknjjIn; arc=none smtp.client-ip=45.157.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ThLYs49M6zDVP;
	Fri, 23 Feb 2024 21:04:01 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ThLYs1CxQzqSX;
	Fri, 23 Feb 2024 21:04:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1708718641;
	bh=9cEDsIi8vRUs821xVTfotIwh6nb7wOR2IdPnx9HNDH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JfknjjInQug3qdZGhwqvNpZPx7gaVjnaWd8pJ7emv2KpVxsH4x/UtqnHs+8NFJgDj
	 WchxVjpycDUWTgmHLsTCbSbvJKPyyTAQ86rBp71J+/DZcFdqgTZayz1gju40xLYBzz
	 D+Xs0yJQOSkkMyQ7o4btN9r19WF4Ci7mUOTZ0sMM=
Date: Fri, 23 Feb 2024 21:03:52 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Casey Schaufler <casey@schaufler-ca.com>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] SELinux: Fix lsm_get_self_attr()
Message-ID: <20240223.eij0Oudai0Ia@digikod.net>
References: <20240223190546.3329966-1-mic@digikod.net>
 <20240223.ieSh2aegurig@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240223.ieSh2aegurig@digikod.net>
X-Infomaniak-Routing: alpha

On Fri, Feb 23, 2024 at 08:59:34PM +0100, Mickaël Salaün wrote:
> On Fri, Feb 23, 2024 at 08:05:45PM +0100, Mickaël Salaün wrote:
> > selinux_lsm_getattr() may not initialize the value's pointer in some
> > case.  As for proc_pid_attr_read(), initialize this pointer to NULL in
> > selinux_getselfattr() to avoid an UAF in the kfree() call.
> 
> Not UAF but NULL pointer dereference (both patches)...

Well, that may be the result (as observed with the kfree() call), but
the cause is obviously an uninitialized pointer.

