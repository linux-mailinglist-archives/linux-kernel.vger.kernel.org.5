Return-Path: <linux-kernel+bounces-8351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D3081B60B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D20E6B2156D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D096E5B6;
	Thu, 21 Dec 2023 12:36:55 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay05.pair.com (relay05.pair.com [216.92.24.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482DF1DDE3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 12:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=pobox.com
Received: from iguana.lan (99-122-168-208.lightspeed.irvnca.sbcglobal.net [99.122.168.208])
	by relay05.pair.com (Postfix) with ESMTP id B64761A163A;
	Thu, 21 Dec 2023 07:36:45 -0500 (EST)
Date: Thu, 21 Dec 2023 04:50:08 -0800
From: Adam Goldman <adamg@pobox.com>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] firewire: core: detect model name for legacy layout
 of configuration ROM
Message-ID: <ZYQ0gNwDsocA9QS7@iguana.lan>
References: <20231220041806.39816-1-o-takashi@sakamocchi.jp>
 <20231220041806.39816-8-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220041806.39816-8-o-takashi@sakamocchi.jp>

Hi,

> -	ret = fw_csr_string(dir, attr->key, buf, bufsize);
> +	for (i = 0; i < ARRAY_SIZE(directories) && !!directories[i]; ++i) {
> +		int result = fw_csr_string(directories[i], attr->key, buf, bufsize);
> +		// Detected.
> +		if (result >= 0)
> +			ret = result;
> +	}
>  
>  	if (ret >= 0) {

ret is an automatic variable with no initializer. Unless you initialize 
it (to -ENOENT), this is UB.

-- Adam

