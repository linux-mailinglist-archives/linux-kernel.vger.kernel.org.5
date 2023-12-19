Return-Path: <linux-kernel+bounces-4686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFBA81809C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 751971C2184D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25466FB4;
	Tue, 19 Dec 2023 04:35:19 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D58963D1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4ED9668AFE; Tue, 19 Dec 2023 05:35:14 +0100 (CET)
Date: Tue, 19 Dec 2023 05:35:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 06/16] nvme-fc: Do not wait in vain when unloading
 module
Message-ID: <20231219043514.GG30580@lst.de>
References: <20231218153105.12717-1-dwagner@suse.de> <20231218153105.12717-7-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153105.12717-7-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 18, 2023 at 04:30:54PM +0100, Daniel Wagner wrote:
> The module unload code will wait for a controller to be delete even when
> there is no controller and we wait for completion forever to happen.
> Thus only wait for the completion when there is a controller which
> needs to be removed.

This whole code looks fishy to me, and I suspect this patch only papers
over it.  Why do we this wait to start with?  If we've found that out and
documented it, the code really should be using a wait_event variant that
checks for the actual condition (no more controllers), because without
that you might still have a race otherwise.


