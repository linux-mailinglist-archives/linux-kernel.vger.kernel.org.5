Return-Path: <linux-kernel+bounces-4707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAC58180E4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C79031F23B81
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79A711CB3;
	Tue, 19 Dec 2023 05:16:55 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA2211C96
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 05:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 812FD68AFE; Tue, 19 Dec 2023 06:16:48 +0100 (CET)
Date: Tue, 19 Dec 2023 06:16:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 08/16] nvmet-fc: untangle cross refcounting objects
Message-ID: <20231219051648.GA32634@lst.de>
References: <20231218153105.12717-1-dwagner@suse.de> <20231218153105.12717-9-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153105.12717-9-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 18, 2023 at 04:30:56PM +0100, Daniel Wagner wrote:
> The live time of the queues are strictly bound to the lifetime of an

> +	struct nvmet_fc_tgt_queue	*_queues[NVMET_NR_QUEUES + 1];
>  	struct nvmet_fc_tgt_queue __rcu	*queues[NVMET_NR_QUEUES + 1];

For magic prefixes we use __, not _ in Linux.  But having two arrays
of queues right next to each other, once with rcu annotation and one
not rings a bit far warning bell to me.  Why do we have both?  When
are we supposed to use either?  Why is FC different from rest?

I really don't have any good answers as I don't know the code in the
FC transport very well, but I think this needs more work.


