Return-Path: <linux-kernel+bounces-126793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3809893CCB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 597241F22826
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FC2481DD;
	Mon,  1 Apr 2024 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fg5ZiGTn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C344AECF;
	Mon,  1 Apr 2024 15:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711984861; cv=none; b=LJfUwPRhG2oGlq+1RC721rqrELoqzc10mFDSKSh/4xPU2ik5i2iWtRstDII2q+/VawE26Uiaetf71w4yyocfT0T0k/WG+BrLzF4dc1Lp/2m9AwSD+TSNwiXcOrrm8duGXwzU0waCUQu8QoiWC47+MiHABL2uzzd7Q8aQoWbC+2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711984861; c=relaxed/simple;
	bh=ZBiBE3qZkHMm5Z23/govMm0X9TLV1iM7mEWgmk1P+oU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AcYJbAI+ndsmzJ1PTcHkdkL+WQAKwXPxktbH9JKxR7NgkQGb6jkgLPXiblc0W9yRBhzvKWP0+hJ+JsA8nRzST+hRu7Oylo31nYw71oooqBMt3OLdvO/VzOkBA3sXEbFokRi1FkAjQyPRUefEvdgKt9DScChMHNu+glvwoDcb+i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fg5ZiGTn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED925C433F1;
	Mon,  1 Apr 2024 15:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711984860;
	bh=ZBiBE3qZkHMm5Z23/govMm0X9TLV1iM7mEWgmk1P+oU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fg5ZiGTnwlWG59PKdduv+jm4pSBi8QM4G2Ox8yiViz/oWewJH5UFDzxvoxjcsmEYD
	 pfUV3qkXIQW2Wgmb4vUz4L9E+SbduzgENEqefxfLzhRiTFXMsVSvYVmHsECK8jm3td
	 nY5Ot3wf05bG59/VOI8568Rk3RPD309vB8RcTtEBhMJIwYdmbvwUnZUqQP/96ojCOz
	 xi+zHt9sEuuwr8ZT/uTO/xh5J+84+71XEjmwhf7pVtxkPqMZIzFijlgVFLfyJ5TVyR
	 JZHNlktj75gRwnYciOqFeq6WvxOkHX3cHX6TxpAtDTl+Hl1C6I/MWyx8hb302+tmqf
	 spggwy8/Rj3MQ==
Date: Mon, 1 Apr 2024 08:20:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, hengqi@linux.alibaba.com,
 xuanzhuo@linux.alibaba.com, Jason Wang <jasowang@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Andrew Melnychenko <andrew@daynix.com>,
 rbc@meta.com, riel@surriel.com, stable@vger.kernel.org,
 qemu-devel@nongnu.org, "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux.dev>, "open list:NETWORKING DRIVERS"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3] virtio_net: Do not send RSS key if it is not
 supported
Message-ID: <20240401082059.77df2ff0@kernel.org>
In-Reply-To: <20240331160618-mutt-send-email-mst@kernel.org>
References: <20240329171641.366520-1-leitao@debian.org>
	<20240331160618-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 Mar 2024 16:20:30 -0400 Michael S. Tsirkin wrote:
> > Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
> > Cc: stable@vger.kernel.org  
> 
> net has its own stable process, don't CC stable on net patches.

Not any more, FWIW:

  1.5.7. Stable tree

  While it used to be the case that netdev submissions were not
  supposed to carry explicit CC: stable@vger.kernel.org tags that is no
  longer the case today. Please follow the standard stable rules in
  Documentation/process/stable-kernel-rules.rst, and make sure you
  include appropriate Fixes tags!

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#stable-tree

