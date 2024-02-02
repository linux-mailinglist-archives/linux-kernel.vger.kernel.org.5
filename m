Return-Path: <linux-kernel+bounces-49975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFADA847267
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AC011F230C4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D08145B28;
	Fri,  2 Feb 2024 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zpo4VN7/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48877145354;
	Fri,  2 Feb 2024 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706885867; cv=none; b=V3qj3Y+juhhLfBzO0iBqSULVBvjpyEa/0E6ypFeyt9lMu2zuwd3pyGYonnWdwaQlzOlzvj6rInrCUGXXFwnHh39Pxfc/C2OHlCSfx+9EKKQA7PYYVaHVdZptTQtjOyT5Vi16u0O+d5m3Xjge4bU/QRFGnxyvjSqUicWlOVH+fBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706885867; c=relaxed/simple;
	bh=JiTq/BfMXk7nz4QykgpQCgV3jYFPRs6u7r4WNW0vjno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vp7gmsZPxO6r3BKeesZZk0C39aswzBPyJ9g6/Le48738TAm20o3DMhssDnjamsvN021WaA9kprbmOy2DnRI98IFa32Hp6/34sBhb6d/oeuxRubrrhMDYHMUMvyF41R0ZrXJ1Cl7tPvVBtrBDNPP2XhKLSidyjsRXbQLX4T+jl24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zpo4VN7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C78C43330;
	Fri,  2 Feb 2024 14:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706885866;
	bh=JiTq/BfMXk7nz4QykgpQCgV3jYFPRs6u7r4WNW0vjno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zpo4VN7/UqfADSyaqhst1nWs0O8focBLs+7d6RXl7c4damBWJOUcpZZzX9bOVi/yK
	 n0rKrgE7MSPGwLBSBpaglhoUS2gbRA4MTQiOw68ATFkAgIOn9eyw38/zQuMEhjO/jd
	 dgTUpBgLcxeHgXhMQWH9A9sMAp1H414ADm9tD4fo=
Date: Fri, 2 Feb 2024 06:57:45 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Guan-Yu Lin <guanyulin@google.com>, mathias.nyman@intel.com,
	stern@rowland.harvard.edu, royluo@google.com,
	benjamin.tissoires@redhat.com, hadess@hadess.net,
	heikki.krogerus@linux.intel.com, grundler@chromium.org,
	oneukum@suse.com, dianders@chromium.org, yajun.deng@linux.dev,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	Linux PM list <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] usb: host: enable suspend-to-RAM control in userspace
Message-ID: <2024020238-process-shelve-e81b@gregkh>
References: <20240202084815.3064391-1-guanyulin@google.com>
 <70412f57-b59a-3a46-6853-4312991c19e5@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70412f57-b59a-3a46-6853-4312991c19e5@linux.intel.com>

On Fri, Feb 02, 2024 at 04:51:06PM +0200, Mathias Nyman wrote:
> To me it looks like this whole co-processor case needs to be developed and
> designed into the pm framework

That is what was said for the last time this patch was submitted, but
for some reason the author ignored those review comments :(

thanks for saying it again, don't worry, I'm not taking this change.

thanks,

greg k-h

