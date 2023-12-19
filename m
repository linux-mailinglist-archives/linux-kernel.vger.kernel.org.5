Return-Path: <linux-kernel+bounces-4680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C784681808E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F89CB213C4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741FDBE74;
	Tue, 19 Dec 2023 04:29:27 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB06BE56
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 25DD168AFE; Tue, 19 Dec 2023 05:29:22 +0100 (CET)
Date: Tue, 19 Dec 2023 05:29:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 03/16] nvmet-trace: avoid dereferencing pointer too
 early
Message-ID: <20231219042921.GD30580@lst.de>
References: <20231218153105.12717-1-dwagner@suse.de> <20231218153105.12717-4-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153105.12717-4-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 18, 2023 at 04:30:51PM +0100, Daniel Wagner wrote:
>  #ifndef TRACE_HEADER_MULTI_READ
> -static inline struct nvmet_ctrl *nvmet_req_to_ctrl(struct nvmet_req *req)
> +static inline u16 nvmet_req_to_ctrl_id(struct nvmet_req *req)
>  {
> -	return req->sq->ctrl;
> +	/*
> +	 * The queue and controller pointer are not valid until an association
> +	 * has been established.

s/pointer/pointers/ ?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

