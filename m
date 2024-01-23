Return-Path: <linux-kernel+bounces-34705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82575838664
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 05:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18682B228FE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 04:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034151FDB;
	Tue, 23 Jan 2024 04:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pezuVUvl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4020A7E6;
	Tue, 23 Jan 2024 04:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705985078; cv=none; b=SHccMiZgwp8PM6Kq6XGxmexwbjtYmNvt46nozTYthjTEHWaGo21fbHorLvZ58p2TeKkZZRpoOaSY6Tz/fHz1ge4Q+D4Yo7WEtfLOYSGpfUDQqLGumHg4CujVvB0LcLtk+PnIOeO9uRXjjUwH7vgdxDMGN9BmZsNSimw+3fYvlj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705985078; c=relaxed/simple;
	bh=qzv9zHZFVzYdHVnyYxp4OEawdiigNueSOUfaz4BQTsY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LRUyoKdzkACRwckxbHWYCadWsnguPWUMhA8VSmNqDWMiezcYXgXxtMdAxR8Kui5h4POepiQYX+XtciEJ5B2IJ6TR6djp7vBD/IGiekas5nL3W8+kBepPqlNjsSL6JB3Ef9V1p9djHyk1ds2vXSgswX4nVc+cv25GDgdEUEjE1aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pezuVUvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83254C433C7;
	Tue, 23 Jan 2024 04:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705985077;
	bh=qzv9zHZFVzYdHVnyYxp4OEawdiigNueSOUfaz4BQTsY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pezuVUvloecPhxs65yiKJ7nS+lmTO/8cNCjPXeQi2lDjv6WGKldYgUMYU2z6zksvU
	 QQDCmicgCXBYgkKX7wMa2S4w663b6rPhjlppkRFGfsv+2/4Qm+a1zOr8JBKv2+yfqJ
	 mpHN3DyYM9BTLiCwxJZrWeL/j/IMVHPjdB5c58zyHTHGrbGt87Vcs5c8TEhdyggGYG
	 EvvC2ZB3+qc1C1v7f7QX8YOmk174TsR2A99I51OZuy+n/vHHIo1tnt+TK5RhEKqTv2
	 uGAsngAuafEcnXbQB2LFhxf/t2f4UfEAECZS9SYRQQUkBHmYadjMD4PG4jRqmL8SaI
	 j4nA/mPQLgM3w==
Date: Mon, 22 Jan 2024 20:44:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <corbet@lwn.net>, <linux@armlinux.org.uk>,
 <sdf@google.com>, <kory.maincent@bootlin.com>,
 <maxime.chevallier@bootlin.com>, <vladimir.oltean@nxp.com>,
 <przemyslaw.kitszel@intel.com>, <ahmed.zaki@intel.com>,
 <richardcochran@gmail.com>, <shayagr@amazon.com>,
 <paul.greenwalt@intel.com>, <jiri@resnulli.us>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <mlxsw@nvidia.com>, <petrm@nvidia.com>, <idosch@nvidia.com>
Subject: Re: [RFC PATCH net-next 8/9] ethtool: cmis_fw_update: add a layer
 for supporting firmware update using CDB
Message-ID: <20240122204435.5a72b485@kernel.org>
In-Reply-To: <20240122084530.32451-9-danieller@nvidia.com>
References: <20240122084530.32451-1-danieller@nvidia.com>
	<20240122084530.32451-9-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 10:45:29 +0200 Danielle Ratson wrote:
> +err_commit_image:
> +err_run_image:
> +err_download_image:
> +err_fw_mng_features_get:

name labels after the target

> +	ethtool_cmis_cdb_fini(cdb);
> +err_cdb_init:
> +	ethnl_module_fw_flash_ntf_err(module_fw->dev, NULL);
> +out:
> +	netdev_put(module_fw->dev, &module_fw->dev_tracker);
> +	module_fw->dev->module_fw_flash_in_progress = false;
> +	release_firmware(module_fw->fw);
> +	kfree(module_fw);
> +}
> +EXPORT_SYMBOL_GPL(ethtool_cmis_fw_update);

does this really need to be exported?

