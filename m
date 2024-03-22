Return-Path: <linux-kernel+bounces-111355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3773E886B16
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68DC41C2250A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1993FB0F;
	Fri, 22 Mar 2024 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQ0XuAcM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FAF3F9C7;
	Fri, 22 Mar 2024 11:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711105804; cv=none; b=KXVP107DYdNGpbWl7E1JJVBPbM0hkqm2IhOuOHKSfUiZ6uyNv/dbhBr8BDVTOmnoVN3EzhqDqEXmL3qiSJZuYN1JaUqBeE58XCYE3+YLrRQHtY/L6G+46Qw6lEBgtzQYAr41F2dFAikRwW3T4usRxrRpwW1Z2g9hbAmwgHyh2Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711105804; c=relaxed/simple;
	bh=QPJatH0sgxvvMTKa/sKQ4wAo3u2RfrMDqrbaWUPt4kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ql+rM0pLbI34/ehed+mgoT9LZ89PKZQEqNLOw7kXS4TTwLUb5odcaRf62u7JY3Db+WI5Yhum+KklMdhuM9Zeaq7gfB7AMLklmfshmNJ4YwvaTgayC1Yheho6vuQN6ntvLd32zHH0FT6KOcj9Y8UfwWDebQqShoh5Y3rY9Kxloto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQ0XuAcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2A4C433C7;
	Fri, 22 Mar 2024 11:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711105803;
	bh=QPJatH0sgxvvMTKa/sKQ4wAo3u2RfrMDqrbaWUPt4kc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VQ0XuAcMo+KfpKuq+hLIydBJoqsMcXHd5r1L6haEIixsM/uy6ntEJSFQqSIOSccs7
	 2AvfofF/84VFHiqKOX71bephghtQSwdgt2JIDiMiW2IubcNJfiw8GzOWkCkXBj8wT9
	 rQMx1Wz6nuoCfplJN5goDqRFZGGdx0pQU0DjtkExZVeVx2bzJ06RjcRt23kC3is7l8
	 ELzIZanfq9GO5cMHq9x16MtHV8ruqQK5mLgkFimRBEFJnXtYSG0So1K844uHKFT9Lp
	 sNsgTszKIC0AswkkSohyhesMRscfHxb8Enn6BwwA3wpLnEhNdvNwIYhbEsWd492ZDc
	 SfUjXAV3f/sCA==
Date: Fri, 22 Mar 2024 11:09:59 +0000
From: Simon Horman <horms@kernel.org>
To: Brett Creeley <brett.creeley@amd.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, shannon.nelson@amd.com
Subject: Re: [PATCH net] pds_core: Fix pdsc_check_pci_health function to
 print warning
Message-ID: <20240322110959.GA372561@kernel.org>
References: <20240321063954.18711-1-brett.creeley@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321063954.18711-1-brett.creeley@amd.com>

On Wed, Mar 20, 2024 at 11:39:54PM -0700, Brett Creeley wrote:
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
> 
> Unloading the driver in the fw_down/dead state uncovered another issue,
> which can be seen in the following trace:
> 
> WARNING: CPU: 51 PID: 6914 at kernel/workqueue.c:1450 __queue_work+0x358/0x440
> [...]
> RIP: 0010:__queue_work+0x358/0x440
> [...]
> Call Trace:
>  <TASK>
>  ? __warn+0x85/0x140
>  ? __queue_work+0x358/0x440
>  ? report_bug+0xfc/0x1e0
>  ? handle_bug+0x3f/0x70
>  ? exc_invalid_op+0x17/0x70
>  ? asm_exc_invalid_op+0x1a/0x20
>  ? __queue_work+0x358/0x440
>  queue_work_on+0x28/0x30
>  pdsc_devcmd_locked+0x96/0xe0 [pds_core]
>  pdsc_devcmd_reset+0x71/0xb0 [pds_core]
>  pdsc_teardown+0x51/0xe0 [pds_core]
>  pdsc_remove+0x106/0x200 [pds_core]
>  pci_device_remove+0x37/0xc0
>  device_release_driver_internal+0xae/0x140
>  driver_detach+0x48/0x90
>  bus_remove_driver+0x6d/0xf0
>  pci_unregister_driver+0x2e/0xa0
>  pdsc_cleanup_module+0x10/0x780 [pds_core]
>  __x64_sys_delete_module+0x142/0x2b0
>  ? syscall_trace_enter.isra.18+0x126/0x1a0
>  do_syscall_64+0x3b/0x90
>  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> RIP: 0033:0x7fbd9d03a14b
> [...]
> 
> Fix this by preventing the devcmd reset if the FW is not running.
> 
> Fixes: d9407ff11809 ("pds_core: Prevent health thread from running during reset/remove")
> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>

Reviewed-by: Simon Horman <horms@kernel.org>


