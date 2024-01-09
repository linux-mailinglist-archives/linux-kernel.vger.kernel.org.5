Return-Path: <linux-kernel+bounces-21399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CC0828E9E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A138B287D81
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73163D990;
	Tue,  9 Jan 2024 20:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bmin4gO1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1C23D978;
	Tue,  9 Jan 2024 20:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A443DC433C7;
	Tue,  9 Jan 2024 20:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704833278;
	bh=QteKBQGsANCi2lfyGrXPvlyFVGCr0qwIbw45fnPbvqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bmin4gO1ml/3fuxC5x1qnS0URvLIYr2G6veI8G49N+D8xVrYnn0D8u7qUYIXqyvBc
	 PFVL2fWoTiNkIaxWfCOckz9oTs+VuF5X/nVO7lAJsxTx0PZ/0rCX/8tYblCvfP+p09
	 vMcIxwK6Yf/ntv7LlKo3t3/k+ebm11i5WrupmbF9Q6UviIL5YpU2hmq/LwkjVzQ3AL
	 IejDYl49avcaMPrXcO/7N3ERTsObBiEqMriFHFlX/K/Q1M/Sb3ZwL19xbx+efNfR+y
	 EbQXg2MiL3Mo+0oHRMFuYGiBPoilld5KodlfCYkBuciI0U8SbAFt7f3v9imliIhQn2
	 pF+bFmymv61Vw==
Received: (nullmailer pid 3193485 invoked by uid 1000);
	Tue, 09 Jan 2024 20:47:48 -0000
Date: Tue, 9 Jan 2024 14:47:48 -0600
From: Rob Herring <robh@kernel.org>
To: Mark Hasemeyer <markhas@chromium.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Daniel Scally <djrscally@gmail.com>, Raul Rangel <rrangel@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-acpi@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, Len Brown <lenb@kernel.org>, devicetree@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Tzung-Bi Shih <tzungbi@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 21/24] device property: Modify fwnode irq_get() to use
 resource
Message-ID: <170483326744.3193407.6920780554098441341.robh@kernel.org>
References: <20240102210820.2604667-1-markhas@chromium.org>
 <20240102140734.v4.21.I38ac58ab04985a404ed6551eb5813fa7841ef410@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102140734.v4.21.I38ac58ab04985a404ed6551eb5813fa7841ef410@changeid>


On Tue, 02 Jan 2024 14:07:45 -0700, Mark Hasemeyer wrote:
> The underlying ACPI and OF subsystems provide their own APIs which
> provide IRQ information as a struct resource. This allows callers to get
> more information about the IRQ by looking at the resource flags. For
> example, whether or not an IRQ is wake capable.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
> ---
> 
> Changes in v4:
> -Add Sakari's Reviewed-by tag from v2
> -Remove ioport.h dependency in fwnode.h
> -Use Andy's @linux.intel.com email
> 
> Changes in v3:
> -Add Suggested-by tag
> -Initialize struct resource to 0 on stack
> -EXPORT_SYMBOL()->EXPORT_SYMBOL_GPL()
> -Remove extra space in commit message
> -Reformat fwnode_irq_get_resource() declaration
> 
> Changes in v2:
> -New patch
> 
>  drivers/acpi/property.c  | 11 +++++------
>  drivers/base/property.c  | 32 +++++++++++++++++++++++++-------
>  drivers/of/property.c    |  8 ++++----
>  include/linux/fwnode.h   |  8 +++++---
>  include/linux/property.h |  2 ++
>  5 files changed, 41 insertions(+), 20 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


