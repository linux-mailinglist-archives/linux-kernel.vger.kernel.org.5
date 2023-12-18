Return-Path: <linux-kernel+bounces-3301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 478AB816AA3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 040F32826E3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AB814F70;
	Mon, 18 Dec 2023 10:12:24 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay05.pair.com (relay05.pair.com [216.92.24.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E4014F7D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=pobox.com
Received: from iguana.lan (99-122-168-208.lightspeed.irvnca.sbcglobal.net [99.122.168.208])
	by relay05.pair.com (Postfix) with ESMTP id B52AB1A1929;
	Mon, 18 Dec 2023 05:04:54 -0500 (EST)
Date: Mon, 18 Dec 2023 02:04:52 -0800
From: Adam Goldman <adamg@pobox.com>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 7/8] firewire: core: detect model name for legacy
 layout of configuration ROM
Message-ID: <ZYAZPRt79Qa1YPS0@iguana.lan>
References: <20231217103012.41273-1-o-takashi@sakamocchi.jp>
 <20231217103012.41273-8-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231217103012.41273-8-o-takashi@sakamocchi.jp>

Hi,

On Sun, Dec 17, 2023 at 07:30:10PM +0900, Takashi Sakamoto wrote:
> -	ret = fw_csr_string(dir, attr->key, buf, bufsize);
> +	for (i = 0; i < ARRAY_SIZE(directories) && directories[i]; ++i)
> +		ret = fw_csr_string(directories[i], attr->key, buf, bufsize);

I believe this is incorrect. If the attribute is in the first directory 
searched, the loop will continue. The second loop iteration will set ret 
to -ENOENT because the attribute isn't in the second directory. Then 
show_text_leaf will return -ENOENT even though the attribute existed.

-- Adam

