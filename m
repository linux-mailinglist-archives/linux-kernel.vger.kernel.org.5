Return-Path: <linux-kernel+bounces-38848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D4083C73A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E8E1F23CF9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3879745D0;
	Thu, 25 Jan 2024 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hVBEH2TK"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2907319D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706197728; cv=none; b=OWPFa1IRTWor/GU/kH65wEPr5jUfeVjUDVPX7M3sLK7kC2amTbuOtgyEw0luS/WOPI/CIZ5St9BlHivmfBI0VjOncEwAD6X1i5ClH+gP6efFTHASKMaD3wEj2GdeUghCjlFARITCqr4kojoaCFUgD+oPkIJtBWUSJb1lfU6nedY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706197728; c=relaxed/simple;
	bh=XkDB2j+aumLxzM/ebMuF8e8HHtMU2QXUT7kkqJuzBVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atvUG5dXtkpsnt8Vgd7AXPkJj4li6gmeRdkMk59oYK/eLnaSVesxzYOqceUxs6yEEV6oJxNi8YHPncT5ivlD9BcI30dLdI9ToODJIFfO55BRWmWrIHQRhJSemKYLwHrSGvo4LQ+8IInf7Ls3myun77CmEH7aOQ2Vvt9yFSkOJFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hVBEH2TK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QiJ4CwmCyo6dKl+Q+qnikTNWtt26HZyYn+VJFvkIfIs=; b=hVBEH2TKO5dzIChvSoPv+Rg47C
	5H8wbbzqwIn1B4Cz1Iw1Q7b0AiB6HYf43tJbia3F3iCdSiNI6ccnFD9NIsWf21f0XATUxmop9RR7s
	AGw+ovbc14YxNzcl/y/kcSMhHBUgTKlfc/4K6PDbQcooaQZvrM3QW5j/Q/DQu2+6R1IKwVp0kKRHV
	NyZNX24Suby5v9FS7BC2kORLmnSXs43Fy/lK39V1BnGa0fGflqAO+SZ+LqG7raMmTJQXylqIrTowi
	E52a9NqOfypHrm598v3g24pr36Oc0nLO0tvaj8qmJb4xPxa2hL8iwg1k9pArTJMMKvGpJGseyQJOx
	U2GeFwyw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT1yA-00000000gRI-0FCP;
	Thu, 25 Jan 2024 15:48:46 +0000
Date: Thu, 25 Jan 2024 07:48:46 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russ Weight <russ.weight@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware_loader: introduce __free() cleanup hanler
Message-ID: <ZbKC3gLfNz301hRQ@bombadil.infradead.org>
References: <ZaeQw7VXhnirX4pQ@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaeQw7VXhnirX4pQ@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Wed, Jan 17, 2024 at 12:33:07AM -0800, Dmitry Torokhov wrote:
> Define cleanup handler using facilities from linux/cleanup.h to simplify
> error handling in code using firmware loader. This will allow writing code
> like this:
> 
> int driver_update_firmware(...)
> {
> 	const struct firmware *fw_entry __free(firmware) = NULL;
> 	int error;
> 
> 	...
> 	error = request_firmware(&fw_entry, fw_name, dev);
> 	if (error) {
> 		dev_err(dev, "failed to request firmware %s: %d",
> 			fw_name, error);
> 		return error;
> 	}
> 
> 	error = check_firmware_valid(fw_entry);
> 	if (error)
> 		return error;
> 
> 	guard(mutex)(&instance->lock);
> 
> 	error = use_firmware(instance, fw);
> 	if (error)
> 		return error;
> 
> 	return 0;
> }
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Luis Chamberalin <mcgrof@kernel.org>

  Luis

