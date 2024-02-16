Return-Path: <linux-kernel+bounces-68365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CACD85794A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A47BBB24EA4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AC81C68F;
	Fri, 16 Feb 2024 09:50:18 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4B91C29B
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 09:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077017; cv=none; b=QMJXfyc6YYeS/At9I61hK9/ZcpwYfUpsADCt6o6K+4/CbS6g5+eyVnBOklssO8w0Faxye1TgS0jtugSwaOKv0yVREtBlerzD6cccbpdzJgmUT3Nx6Gqslq24FTefGSKf9q3WGA6UIokK6JassaOlFtfMXdNY9Hj9gZNnGdd8ncc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077017; c=relaxed/simple;
	bh=OgTTNaCUTyLbECHK5cme/Osf+zYb8mCvQLxELN+mbdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uG0fYAu9rXsp3wPnIAIwTjhiAZIaD8aUeAC6+rB5k8BHUP4SH23yGtkF+F7SiEwZpmJp4bLXjcTpDiZVt3bTumgDufWoWmmob9SKc0DcqkaTQzUyhFRW4Ozru/PgtsKPq3+EXr5uU77v8Zj9waEkuDgVGqkx6Oz6/3gZk5Gqt08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 63D7168BFE; Fri, 16 Feb 2024 10:50:13 +0100 (CET)
Date: Fri, 16 Feb 2024 10:50:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v0 4/6] nvme-fabrics: introduce ref counting for
 nvmf_ctrl_options
Message-ID: <20240216095013.GD19961@lst.de>
References: <20240216084526.14133-1-dwagner@suse.de> <20240216084526.14133-5-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216084526.14133-5-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Feb 16, 2024 at 09:45:24AM +0100, Daniel Wagner wrote:
> The FC transport is offloading the connect attempt to a workqueue. When
> the attempt fails the transport is starting to cleanup resources. It is
> possible for user space to trigger a crash because nvmf_ctrl_options are
> exposed to sysfs.

Eww.  I think the async offload is the real problem here..


