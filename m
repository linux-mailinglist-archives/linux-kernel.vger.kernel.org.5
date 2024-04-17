Return-Path: <linux-kernel+bounces-148402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 602748A8202
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1579F1F243F4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBA313C9CD;
	Wed, 17 Apr 2024 11:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZH3Z8Lor"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D2113C90A;
	Wed, 17 Apr 2024 11:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713353092; cv=none; b=MG6iWbVujujb/7HErHDJGSOHV+zTJiBF3A3jv1ne01DNE7Q9ld/qTkA5GIKVYInPA3Ua2BUiDCqffH52Tfhx+/Eji9xtl1vgBA11+OO/qNWUHNd/iGa8P7Sym/BNaJXtp5ALgqzbFNWBwFhVhYnyKpoa2eyQL+3okQOBR4yqIqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713353092; c=relaxed/simple;
	bh=svPI3Zi+32eA6Lf4twQeWFA9ixZsM/ee2dayjbjdZmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9PbqCYY7TMBrAJFn6IiYQQ6zzmVbk4BsXUqGMMm4g6puTkK1syteKNAa6V/5M4nqPaULWSN68nrP4zvuJ2Klh/FYApGOtx7JvdEluFpnXGjdNC1QOFGUe66/ZxAZcJfULAe6w4JYofumBob+IQimEYN/UGX2/zVz+sbdETrwKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZH3Z8Lor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF24C072AA;
	Wed, 17 Apr 2024 11:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713353091;
	bh=svPI3Zi+32eA6Lf4twQeWFA9ixZsM/ee2dayjbjdZmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZH3Z8LorASOFnoj0mWWm8LSkK27sb3oazyOlfys4Y7nKrPvVKznW4xWmLyv1NxB/T
	 KCPmZ+qZaLrktUJFCt8aR8v7iU6O2amvQ5W+qcz9DfasKnJvKzwlxRWBcq24j83d7L
	 bV2pGUMU2FateFo+vNWr9OE/bnrVkMD+9r8XwgBE=
Date: Wed, 17 Apr 2024 13:24:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Parker Newman <parker@finest.io>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v3 0/8] serial: exar: add Connect Tech serial cards to
 Exar driver
Message-ID: <2024041723-abroad-jugular-89db@gregkh>
References: <cover.1713270624.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1713270624.git.pnewman@connecttech.com>

On Tue, Apr 16, 2024 at 08:55:27AM -0400, Parker Newman wrote:
> From: Parker Newman <pnewman@connecttech.com>
> 
> Hello,
> These patches add proper support for most of Connect Tech's (CTI) Exar
> based serial cards. Previously, only a subset of CTI's cards would work
> with the Exar driver while the rest required the CTI out-of-tree driver.
> These patches are intended to phase out the out-of-tree driver.
> 
> I am new to the mailing lists and contributing to the kernel so please
> let me know if I have made any mistakes or if you have any feedback.

Much better.  I took the 1st patch already in my tree to make it
hopefully easire for you to rebase and redo the rest.

thanks,

greg k-h

