Return-Path: <linux-kernel+bounces-52206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 007CA84955A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A98771F22A1C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BBF125BC;
	Mon,  5 Feb 2024 08:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="PZCdqhoR"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F753125D3
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 08:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707121614; cv=none; b=uKrL7p7aMVuRO0qKAxYpew0Ast4LcX6997onfIbbA+pcluePAWAmfJWUf0NuCVGVy+GwxeiThIZ1oUkrdl6t2JD4X0fvxZdSRuBYC5IV18gpOQhlyzlwNOF78QsDWm50WeYOn10FywPSY826WDVN0dhDKu4c3tQT1TvyRdyen4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707121614; c=relaxed/simple;
	bh=qV/lPKy0+uPSjew6UcgWRpbtSJxEVqIxrWTeO0HOXyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuaJwObHTluF93VsoynLHvNc4AWsKCI7fwxbhBvwfip91RvEfoqu2mGYfEDE9C4errJ8PuboMKVm3yykchJ1P+dz4jtXEncOeHCXRYZ154Lk8BCnyIjY6Aib11DhULUvSBOSboA+OJiP5q0fzBR9D1EKy7k6OOV7+hC1ej2N1KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=PZCdqhoR; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (99.141-128-109.adsl-dyn.isp.belgacom.be [109.128.141.99])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9A339667;
	Mon,  5 Feb 2024 09:25:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1707121528;
	bh=qV/lPKy0+uPSjew6UcgWRpbtSJxEVqIxrWTeO0HOXyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PZCdqhoR8H5x9+9QPwObgK9QZixFqM0OXaZQ880ogM7izu6bSrPh/Ur5u3Sip961d
	 2n/MoxZHXiGJhz9QJl/s2BaRx9Gg0FGYKAIRwdfQwCfTp0k7WgGG9vflFW89WdFmNX
	 1Gldnmyi0qJqHY0KkgcGuqyVwPOsZcBDqsXQ7xgo=
Date: Mon, 5 Feb 2024 10:26:52 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Anatoliy Klymenko <anatoliy.klymenko@amd.com>,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	michal.simek@amd.com, dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Fixing live video input in ZynqMP DPSUB
Message-ID: <20240205082652.GI6804@pendragon.ideasonboard.com>
References: <20240124025402.373620-1-anatoliy.klymenko@amd.com>
 <20240205072908.GE6804@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240205072908.GE6804@pendragon.ideasonboard.com>

On Mon, Feb 05, 2024 at 09:29:09AM +0200, Laurent Pinchart wrote:
> Hello,
> 
> This series looks good. Tomi, could you get it merged through drm-misc ?

I got things mixed up, sorry. Patches 1/5 to 4/5 are fine, but 5/5 needs
a different approach. I've reviewed the first four patches, which I
think are fine and can be applied already.

> On Tue, Jan 23, 2024 at 06:53:57PM -0800, Anatoliy Klymenko wrote:
> > Add few missing pieces to support ZynqMP DPSUB live video in mode.
> > 
> > ZynqMP DPSUB supports 2 modes of operations in regard to video data
> > input.
> >     
> > In the first mode, DPSUB uses DMA engine to pull video data from memory
> > buffers. To support this the driver implements CRTC and DRM bridge
> > representing DP encoder.
> >     
> > In the second mode, DPSUB acquires video data pushed from FPGA and 
> > passes it downstream to DP output. This mode of operation is modeled in
> > the driver as a DRM bridge that should be attached to some external
> > CRTC.
> > 
> > Patches 1/5,2/5,3/5,4/5 are minor fixes.
> > 
> > DPSUB requires input live video format to be configured.
> > Patch 5/5: The DP Subsystem requires the input live video format to be
> > configured. In this patch, we are assuming that the CRTC's bus format is
> > fixed (typical for FPGA CRTC) and comes from the device tree. This is a
> > proposed solution, as there is no API to query CRTC output bus format
> > or negotiate it in any other way.
> > 
> > Changes in v2: 
> > - Address reviewers' comments:
> >   - More elaborate and consistent comments / commit messages
> >   - Fix includes' order
> >   - Replace of_property_read_u32_index() with of_property_read_u32()
> > 
> > Changes in v3:
> > - Split patch #3 into 3) moving status register clear immediately after
> >   read; 4) masking status against interrupts' mask
> > 
> > Link to v1: https://lore.kernel.org/all/20240112234222.913138-1-anatoliy.klymenko@amd.com/
> > Link to v2: https://lore.kernel.org/all/20240119055437.2549149-1-anatoliy.klymenko@amd.com/
> > 
> > Anatoliy Klymenko (5):
> >   drm: xlnx: zynqmp_dpsub: Make drm bridge discoverable
> >   drm: xlnx: zynqmp_dpsub: Fix timing for live mode
> >   drm: xlnx: zynqmp_dpsub: Clear status register ASAP
> >   drm: xlnx: zynqmp_dpsub: Filter interrupts against mask
> >   drm: xlnx: zynqmp_dpsub: Set live video in format
> > 
> >  drivers/gpu/drm/xlnx/zynqmp_disp.c      | 111 +++++++++++++++++++++---
> >  drivers/gpu/drm/xlnx/zynqmp_disp.h      |   3 +-
> >  drivers/gpu/drm/xlnx/zynqmp_disp_regs.h |   8 +-
> >  drivers/gpu/drm/xlnx/zynqmp_dp.c        |  16 +++-
> >  drivers/gpu/drm/xlnx/zynqmp_kms.c       |   2 +-
> >  5 files changed, 119 insertions(+), 21 deletions(-)

-- 
Regards,

Laurent Pinchart

