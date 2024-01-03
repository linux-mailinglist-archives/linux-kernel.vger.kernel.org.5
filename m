Return-Path: <linux-kernel+bounces-15742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65637823136
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1AD1C23B23
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6461C1C283;
	Wed,  3 Jan 2024 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKpfvShb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3C21BDC4;
	Wed,  3 Jan 2024 16:24:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D1FC433C7;
	Wed,  3 Jan 2024 16:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704299050;
	bh=oDxUJ0csC6lWNRIuyYFs6Gg2tiCMbVHu/gNkuWzoWzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NKpfvShb6tkMIJpN0xEoI1S0zR4aLeaRArZwkobSudX3RkKpGjhNHy7iR044qE4HK
	 zvd6GWk3J7PgtL/GHT0G+bH7zAu57/uWcaWQpl5nx7+3IBolmGkmWRh77k32S1xFb9
	 xvQV48hg5VbrUz/0abaminyQw6+uu42GfcWgX792V6X4CooopX/mcrkaLa9KuEQK7a
	 OCwGZ8d3eQJGe7BxWsFYgxw5etLbuRKscIsP8BJuXk6bD4qyHF2joQcWgyl9H5PftA
	 syayVLlMizbNxE4C5uOh4kdVTMjdA5sia4spSl9GLJz4Mi8zT7Fg2MATiYcCUxvmij
	 enitnIElliOow==
Date: Wed, 3 Jan 2024 16:24:02 +0000
From: Simon Horman <horms@kernel.org>
To: Alexey Makhalov <alexey.makhalov@broadcom.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	mingo@redhat.com, tglx@linutronix.de, x86@kernel.org,
	netdev@vger.kernel.org, richardcochran@gmail.com,
	linux-input@vger.kernel.org, dmitry.torokhov@gmail.com,
	zackr@vmware.com, linux-graphics-maintainer@vmware.com,
	pv-drivers@vmware.com, namit@vmware.com, timothym@vmware.com,
	akaher@vmware.com, jsipek@vmware.com,
	dri-devel@lists.freedesktop.org, daniel@ffwll.ch, airlied@gmail.com,
	tzimmermann@suse.de, mripard@kernel.org,
	maarten.lankhorst@linux.intel.com, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v4 2/6] x86/vmware: Introduce VMware hypercall API
Message-ID: <20240103162402.GA31813@kernel.org>
References: <20231228192421.29894-1-alexey.makhalov@broadcom.com>
 <20231228192421.29894-3-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228192421.29894-3-alexey.makhalov@broadcom.com>

On Thu, Dec 28, 2023 at 11:24:17AM -0800, Alexey Makhalov wrote:
> From: Alexey Makhalov <amakhalov@vmware.com>
> 
> Introduce vmware_hypercall family of functions. It is a common
> implementation to be used by the VMware guest code and virtual
> device drivers in architecture independent manner.
> 
> The API consists of vmware_hypercallX and vmware_hypercall_hb_{out,in}
> set of functions by analogy with KVM hypercall API. Architecture
> specific implementation is hidden inside.
> 
> It will simplify future enhancements in VMware hypercalls such
> as SEV-ES and TDX related changes without needs to modify a
> caller in device drivers code.
> 
> Current implementation extends an idea from commit bac7b4e84323
> ("x86/vmware: Update platform detection code for VMCALL/VMMCALL
> hypercalls") to have a slow, but safe path in VMWARE_HYPERCALL
> earlier during the boot when alternatives are not yet applied.
> This logic was inherited from VMWARE_CMD from the commit mentioned
> above. Default alternative code was optimized by size to reduce
> excessive nop alignment once alternatives are applied. Total
> default code size is 26 bytes, in worse case (3 bytes alternative)
> remaining 23 bytes will be aligned by only 3 long NOP instructions.
> 
> Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
> Reviewed-by: Nadav Amit <namit@vmware.com>
> Reviewed-by: Jeff Sipek <jsipek@vmware.com>

Hi Alexey,

I'd like to flag that this breaks gcc-13 x86_64 allmodconfig builds of the
following files. And although this is resolved by the subsequent 3 patches
in this series, it does still break bisection.

 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
 drivers/input/mouse/vmmouse.c
 drivers/ptp/ptp_vmw.c

...

