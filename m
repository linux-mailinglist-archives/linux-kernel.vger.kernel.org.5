Return-Path: <linux-kernel+bounces-87070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D13B86CF07
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B455A1F23C71
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508734AEC3;
	Thu, 29 Feb 2024 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EoNGllXp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBD2160633;
	Thu, 29 Feb 2024 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709223870; cv=none; b=PMEwOrHEhIm8M+vyCb2UJq4S45n7DRVWV8vr12PWmDxMnUD7Rf7Pz4K0/HOwyry15eqR+rGAyzWtRT8/202FVLAyduXYy/j6vcsM4Y/HhYUj+2F6LIojbW0WsOBtqwWH1DoWUnGJxYSyh+VLrQOS2NjLKIZkfq9Xw5TMoW8ztHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709223870; c=relaxed/simple;
	bh=9k31lWJ2e6h/DVQB5uOefmdIlQYWXG1nOz0FEl41Mpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cw+IIEHL1GtqR55Orb7hZmk9UpMwuFPbPB51miKytmVSKJHBQ7UQ4Lqj+sfhbwtFPnh9LwbhYMmfvn8ibPWLOIU75ddfOaErGFS1qkKZi/KYV5PG9S2rtWIlNCyRrLjkL7fo/VgBUAxe7rVwoXngLgqLM7hKUrWT1dByK+1DXWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EoNGllXp; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709223869; x=1740759869;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9k31lWJ2e6h/DVQB5uOefmdIlQYWXG1nOz0FEl41Mpc=;
  b=EoNGllXp6OI2PV3C9gKYYZNtDD+qH51QagCvDAwMnyYlk9lFz6Prs/y5
   PCxoXyGdLw90sBzC4M6csyjrOYdFddDqiKZJK0k3sbaus72mTPHYchT/u
   XNsy5vKb080wSWAuMErO/rszcLGruz+ASk+jPDfmxFg5d5HuL+8+yzh7t
   DRWcygVNtHfIXG3UFgdMUAAdr/BAldK9hufn1QLbqoJAoXbcj60dlMIRc
   lKNKdqKSUvyHDic9w54qe1HgwT0RhIy8gMB7GhWWMp2KgEoG/psoOcxX/
   Wv133ZJaF4MdjbzO36oioTUeurw1NVuceatWX/66+wOk0Rs2heU4vnLPI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="6660110"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="6660110"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 08:24:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="937036114"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="937036114"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 29 Feb 2024 08:24:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id AA29623A; Thu, 29 Feb 2024 18:24:25 +0200 (EET)
Date: Thu, 29 Feb 2024 18:24:25 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Oliver Neukum <oneukum@suse.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: no opencoding FIELD_GET
Message-ID: <20240229162425.GJ8454@black.fi.intel.com>
References: <20240229132401.3270-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240229132401.3270-1-oneukum@suse.com>

On Thu, Feb 29, 2024 at 02:23:57PM +0100, Oliver Neukum wrote:
> We have a macro. It should be used.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Although I think the $subject should probably be something like "usb:
typec" or so since this does not relate to USB4/Thunderbolt subsystem in
any way.

