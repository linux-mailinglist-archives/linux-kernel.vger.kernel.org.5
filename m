Return-Path: <linux-kernel+bounces-79069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6CC861D17
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AD961C2467E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C17B145B38;
	Fri, 23 Feb 2024 19:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="dYgTWex2"
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7C913DBA8
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 19:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708718389; cv=none; b=Hd5FowKd6Cpr2hZbhtpQcCscIsubYY2+ZrbIro32LFtF5V5qGnho6YFGq131RJ1buubw6+Hlvd+7WJeoGABdvT1jMCp0tOVJzta4AK/YGHlCH4EjDNnnfEgbkyeTDDjV5s0khuwDRz0OxL9e0fJY+gEdGQ1t10LNWi/piTcZYkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708718389; c=relaxed/simple;
	bh=3DZrggAv7PSmCRfsKKuC495Q/yAOKviJrsrA5XNvsPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQtjUhJN8Z9HJSYZ9gGmZadrUt2OEaNVEZEUPmfpvVLrmwCl8SEu3bcEvLG1HtUkchpgxN1akYX01VjwrzlDuft2PAOzVm96zsgCa1yLW9SD0mbaYcGYoJEQ9l5Ulc0bNiwJRMZfuCYj784i97f9GBG1uQPDU7uRoQjP3oKgmOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=dYgTWex2; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ThLSt3DfBzBgq;
	Fri, 23 Feb 2024 20:59:42 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ThLSs5tsRz3X;
	Fri, 23 Feb 2024 20:59:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1708718382;
	bh=3DZrggAv7PSmCRfsKKuC495Q/yAOKviJrsrA5XNvsPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dYgTWex2B5DVRwzAsfcmDAwYJ0C7TV2pBmjfQ83MbdEOuW0BHlp8u7KbzBNvpG5aT
	 XqpteceYv5GE61GOxVznLMtCvavK9qys7AqE/gvusqjDjhnZDLNf+Kkp8Ra5ikCVDn
	 MHUAHTGCT/jdC7NtEWQV8s7KC/MxZILocNZ5tUjM=
Date: Fri, 23 Feb 2024 20:59:33 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Casey Schaufler <casey@schaufler-ca.com>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] SELinux: Fix lsm_get_self_attr()
Message-ID: <20240223.ieSh2aegurig@digikod.net>
References: <20240223190546.3329966-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240223190546.3329966-1-mic@digikod.net>
X-Infomaniak-Routing: alpha

On Fri, Feb 23, 2024 at 08:05:45PM +0100, Mickaël Salaün wrote:
> selinux_lsm_getattr() may not initialize the value's pointer in some
> case.  As for proc_pid_attr_read(), initialize this pointer to NULL in
> selinux_getselfattr() to avoid an UAF in the kfree() call.

Not UAF but NULL pointer dereference (both patches)...

