Return-Path: <linux-kernel+bounces-45827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BE68436B3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACD561F21D21
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18913EA82;
	Wed, 31 Jan 2024 06:27:46 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96553EA68
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706682466; cv=none; b=DXBNGZoeQPNU1D0EHrwlrg1Ur3IKoeiPQvLnDI81suMvIqxGtrWQrshfNkwvUNeuvVQfBfvFs6IaFFdBskdg039KV2QWaA1sQo60p3BDO+Ko30t8N3S80v2CRifhLcpnTs9+Wq8zYd++MO0Fy8UUkBFlQHCME4zkMBqedRWVfJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706682466; c=relaxed/simple;
	bh=5a6kabL1Imum/t71C6ufR+TowFQ0vw8KXkpbEbavqO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GltBeKLctJUxko8d303ig4bbo9P4ysDvm0OelyQjIk3vg/pMLpvxqWcQMgm4iEGUyDF2Kh8O9AQJoan/S/iT/8Af3dVsZeHF/RaX30CaAzgS5W0QMmoJ320LWsWz2l2y8d4pSuwJ+7ujHlh1LYX446QcuUkmju0j2hMotYgge2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CEFDA68B05; Wed, 31 Jan 2024 07:27:41 +0100 (CET)
Date: Wed, 31 Jan 2024 07:27:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/12] nvmet-fc: hold reference on hostport match
Message-ID: <20240131062741.GE16225@lst.de>
References: <20240130094938.1575-1-dwagner@suse.de> <20240130094938.1575-7-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130094938.1575-7-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 30, 2024 at 10:49:32AM +0100, Daniel Wagner wrote:
> The hostport data structure is shared between the association, this why
> we keep track of the users via a refcount. So we should not decrement
> the refcount on a match and free the hostport several times.
> 
> Reported by KASAN.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

