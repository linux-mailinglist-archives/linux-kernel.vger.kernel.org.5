Return-Path: <linux-kernel+bounces-97531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0351E876B88
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C348B21E55
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9F65B5C8;
	Fri,  8 Mar 2024 20:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9jKrthm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9862C191;
	Fri,  8 Mar 2024 20:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709928351; cv=none; b=aXIJfgqxouBDkvycqrjHyL1ggrqFfjv5Wz6J3utaCVLF+nS6lWFWtWslqT37iyNONH7ZLeRnPNUORtS//2rgmWkHB5wtIGuhrqImv3b5C6eIGQ4dyxKrsDNYAqVhdXzKINlg59978AOfhRENc101+PrYesY3D2CFUGBxr9FDepI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709928351; c=relaxed/simple;
	bh=Fjbr8IfY/JuQgJCrOKUOPWAPqtOc7XVMJSi1kxk8q3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgFC7ZnuQVTLIUWe3H4tooYmnFCqg7zQw90PR5SpySHrfvepvNeea7+o/tch5d8MYv6l29R96AbNlj0HvZY1QrQkxwm3hqP11PXmMHuoaYXuk1ZwhqGAowrcxcijM/ER1XBdEBtwoE9BhX2ycYRSmZonfiqD5olc179yZC5hJNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9jKrthm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12EF0C433F1;
	Fri,  8 Mar 2024 20:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709928351;
	bh=Fjbr8IfY/JuQgJCrOKUOPWAPqtOc7XVMJSi1kxk8q3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E9jKrthmWHS+OdgLrwbXboECUrSiykTuI9kCerRbgKkz2bvcXESmeXA80yTdOgpUN
	 S7o4GOEOpvEsVgO0f7+REU2to6D4AE32EJ5VqGoi4wnC0EUwqdCsNrG7M9j3wXtt8h
	 Cq5x4r130Hl9f1bnmzjE9SfToCGdbSmiYwNFZBVx1O77K8A5B0p5/5YbYcyLbBHYDZ
	 t8ygjfbPSI367U8m2GZ4yKyNPfc/P6x0AAXMhGsW4rSfhE2v7HpBbS3xXyOYAV7Dt2
	 9cUh52J42UfNoelFPa0//kYfpi6xUiVvemlbMMyh8uJ5RNxtl+qZhJdoAl+ekaMEnO
	 e687xCWQTqDLA==
Date: Fri, 8 Mar 2024 14:05:48 -0600
From: Rob Herring <robh@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Saravana Kannan <saravanak@google.com>,
	Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>,
	Sonal Santan <sonal.santan@amd.com>,
	Stefano Stabellini <stefano.stabellini@xilinx.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 0/2] Synchronize DT overlay removal with devlink
 removals
Message-ID: <20240308200548.GA1189199-robh@kernel.org>
References: <20240307111036.225007-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240307111036.225007-1-herve.codina@bootlin.com>

On Thu, Mar 07, 2024 at 12:09:59PM +0100, Herve Codina wrote:
> Hi,
> 
> In the following sequence:
>   of_platform_depopulate(); /* Remove devices from a DT overlay node */
>   of_overlay_remove(); /* Remove the DT overlay node itself */
> 
> Some warnings are raised by __of_changeset_entry_destroy() which  was
> called from of_overlay_remove():
>   ERROR: memory leak, expected refcount 1 instead of 2 ...
> 
> The issue is that, during the device devlink removals triggered from the
> of_platform_depopulate(), jobs are put in a workqueue.
> These jobs drop the reference to the devices. When a device is no more
> referenced (refcount == 0), it is released and the reference to its
> of_node is dropped by a call to of_node_put().
> These operations are fully correct except that, because of the
> workqueue, they are done asynchronously with respect to function calls.
> 
> In the sequence provided, the jobs are run too late, after the call to
> __of_changeset_entry_destroy() and so a missing of_node_put() call is
> detected by __of_changeset_entry_destroy().
> 
> This series fixes this issue introducing device_link_wait_removal() in
> order to wait for the end of jobs execution (patch 1) and using this
> function to synchronize the overlay removal with the end of jobs
> execution (patch 2).
> 
> Compared to the previous iteration:
>   https://lore.kernel.org/linux-kernel/20240306085007.169771-1-herve.codina@bootlin.com/
> this v5 series:
> - Remove a 'Fixes' tag
> - Update a comment
> - Add 'Tested-by' and ''Reviewed-by' tags
> 
> This series handles cases reported by Luca [1] and Nuno [2].
>   [1]: https://lore.kernel.org/all/20231220181627.341e8789@booty/
>   [2]: https://lore.kernel.org/all/20240205-fix-device-links-overlays-v2-2-5344f8c79d57@analog.com/
> 
> Best regards,
> Hervé
> 
> Changes v4 -> v5
>   - Patch 1
>     Remove the 'Fixes' tag
>     Add 'Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>'
>     Add 'Reviewed-by: Nuno Sa <nuno.sa@analog.com>'
> 
>   - Patch 2
>     Update comment as suggested
>     Add 'Reviewed-by: Saravana Kannan <saravanak@google.com>'
>     Add 'Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>'
>     Add 'Reviewed-by: Nuno Sa <nuno.sa@analog.com>'
> 
> Changes v3 -> v4
>   - Patch 1
>     Uses flush_workqueue() instead of drain_workqueue().
> 
>   - Patch 2
>     Remove unlock/re-lock when calling device_link_wait_removal()
>     Move device_link_wait_removal() call to of_changeset_destroy()
>     Update commit log
> 
> Changes v2 -> v3
>   - Patch 1
>     No changes
> 
>   - Patch 2
>     Add missing device.h
> 
> Changes v1 -> v2
>   - Patch 1
>     Rename the workqueue to 'device_link_wq'
>     Add 'Fixes' tag and Cc stable
> 
>   - Patch 2
>     Add device.h inclusion.
>     Call device_link_wait_removal() later in the overlay removal
>     sequence (i.e. in free_overlay_changeset() function).
>     Drop of_mutex lock while calling device_link_wait_removal().
>     Add	'Fixes'	tag and Cc stable
> 
> Herve Codina (2):
>   driver core: Introduce device_link_wait_removal()
>   of: dynamic: Synchronize of_changeset_destroy() with the devlink
>     removals
> 
>  drivers/base/core.c    | 26 +++++++++++++++++++++++---
>  drivers/of/dynamic.c   | 12 ++++++++++++
>  include/linux/device.h |  1 +
>  3 files changed, 36 insertions(+), 3 deletions(-)

This looks good to me. I can take this given the user is DT. Looking for 
a R-by from Saravana and Ack from Greg. A R-by from Rafael would be 
great too.

Rob

