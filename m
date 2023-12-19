Return-Path: <linux-kernel+bounces-5163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE8A818768
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20DF8B236F9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2CC18633;
	Tue, 19 Dec 2023 12:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="He1O7Dll"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECA918622
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id DF01B4FB;
	Tue, 19 Dec 2023 13:24:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1702988696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zo1bvGMOlMzlZUMlT7LD46uyFfN2T/tY+yhbado4I8M=;
	b=He1O7DllNLSQCRI6CEHrhhtQSLhUBhTSPm0+zqz/PciEb+AoKUZzy8JBzd6YwXkpsIpRBW
	TTpAv/wll81uuH6JEE+lo8Y0DbtGW5cmDy7vAFEnODr4qkMiHZ6m/IVyXhVVJsv8YCG7sK
	P839Gt7qOK/P3jzj1VE8v13HxpoF/pUjGJ9icNVTEQtdh7uoCz0X0GQpVI5OQFqoubRwZB
	TpNtpiouXWABbvCy+Fdmx4Q53WvK4oNc8G50LqR/e0+4UYLJZ/D4OmQVQ3CIb2yt5VKDAZ
	EK+N28j4deO+ku/qEPnzUc+J5QYeAvxbHpoMmSXQD2mP1CPVB5BdrTshtB1+uQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 19 Dec 2023 13:24:56 +0100
From: Michael Walle <michael@walle.cc>
To: =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?=
 <rafal@milecki.pl>
Subject: Re: [PATCH v6.8 1/2] nvmem: layouts: refactor .add_cells() callback
 arguments
In-Reply-To: <20231219120104.3422-1-zajec5@gmail.com>
References: <20231219120104.3422-1-zajec5@gmail.com>
Message-ID: <dad4bd72d2d133b86385859a6978a72a@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Simply pass whole "struct nvmem_layout" instead of single variables.
> There is nothing in "struct nvmem_layout" that we have to hide from
> layout drivers. They also access it during .probe() and .remove().
> 
> Thanks to this change:
> 
> 1. API gets more consistent
>    All layouts drivers callbacks get the same argument
> 
> 2. Layouts get correct device
>    Before this change NVMEM core code was passing NVMEM device instead
>    of layout device. That resulted in:
>    * Confusing prints
>    * Calling devm_*() helpers on wrong device
>    * Helpers like of_device_get_match_data() dereferencing NULLs
> 
> 3. It gets possible to get match data
>    First of all nvmem_layout_get_match_data() requires passing "struct
>    nvmem_layout" which .add_cells() callback didn't have before this. 
> It
>    doesn't matter much as it's rather useless now anyway (and will be
>    dropped).
>    What's more important however is that of_device_get_match_data() can
>    be used now thanks to owning a proper device pointer.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

LGTM,
Reviewed-by: Michael Walle <michael@walle.cc>

