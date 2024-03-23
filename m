Return-Path: <linux-kernel+bounces-112151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB4088764C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 02:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFE8BB2135C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 01:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B2A10F9;
	Sat, 23 Mar 2024 01:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3vh28u9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2848D7F;
	Sat, 23 Mar 2024 01:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711155773; cv=none; b=E5gB4Kh+GWXyTl5W/QXmTBSF+vhceQa8NokNnAJC1oO5iQiPr7V258xoGyE1bRc+Ixz3lgb22nil4tPfg91+LdCK8GFxnQ21iQScGpvtNgioU8ijCgI5LR0cu4o0ui3ImW4/eOAIlF5Jo5H+HF4eJWdkSEzwIndpJ6HtcBrDQ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711155773; c=relaxed/simple;
	bh=zQGhmaTz+212cAdp+y8J3GuQx94jKrboGaWKL2xBtsA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+N5na4cCN8KHdHaoYiIo9Bz/oG5kwiQb4R8/egMT2dheYm4froDNXNsuxjOGVz6B6oIoINs/RW+RnK4OLUn8QapoC7kJ1eyabYzopkENVpiZBKsEQMypshfFNHadHgCreDDu0oQCH1DhfayzAk7AwHOYcNejGpBhqpka9FuM9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3vh28u9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BD8C433C7;
	Sat, 23 Mar 2024 01:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711155772;
	bh=zQGhmaTz+212cAdp+y8J3GuQx94jKrboGaWKL2xBtsA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W3vh28u9q/GWv3n9CCWN5QDvL2cZNYDYw5t9cpwMu2uo9RM/ibB1SOMMnNEx+D3NM
	 BnbSVSKfZ6G6WHalsMy7ZMW/qzE93BEGfEWfb0hTXiQNNA4MCvJodkUfvXNI3eaTcl
	 sZtp3uiwhfJHUwfiBBXO5spivey6LqE4LLAVNP0xBUJf+KnTvjjgaOLAn8BZLs3EfE
	 Tg99y2+1V7QMaDEYuwNKO5c0dYsWw12Lu7cOsIhKNSxJSnxsYSwT5e4rO1yKuQC38e
	 tA2LYf/Uy73ss6sj/CkU6lW0ZmFX2yil/p/Mscjr3FCcgXyQUx/zabWBlBHy9fe54I
	 UyoVhc0aHJbXg==
Date: Fri, 22 Mar 2024 18:02:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Brett Creeley <brett.creeley@amd.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <shannon.nelson@amd.com>
Subject: Re: [PATCH net] pds_core: Fix pdsc_check_pci_health function to
 print warning
Message-ID: <20240322180251.69167fd1@kernel.org>
In-Reply-To: <20240321063954.18711-1-brett.creeley@amd.com>
References: <20240321063954.18711-1-brett.creeley@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Mar 2024 23:39:54 -0700 Brett Creeley wrote:
> When the driver notices fw_status == 0xff it tries to perform a PCI
> reset on itself via pci_reset_function() in the context of the driver's
> health thread. However, pdsc_reset_prepare calls
> pdsc_stop_health_thread(), which attempts to stop/flush the health
> thread. This results in a deadlock because the stop/flush will never
> complete since the driver called pci_reset_function() from the health
> thread context. Fix this by changing the pdsc_check_pci_health_function()
> to print a dev_warn() once every fw_down/fw_up cycle and requiring the
> user to perform a reset on the device via sysfs's reset interface,
> reloading the driver, rebinding the device, etc.

Dunno, to call PCI reset you don't need much device context.
Perhaps you could allocate a work entry, throw it onto a per-driver
workqueue, and return. Basically some minimal viable way to
"asynchronously" call pci_reset_function()?
You can take a ref on the device so it doesn't disappear.
And flush that queue on module unload.

