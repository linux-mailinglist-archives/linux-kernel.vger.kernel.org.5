Return-Path: <linux-kernel+bounces-167546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBD28BAB1F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282731F219EB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D7E15216F;
	Fri,  3 May 2024 10:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tacbuA+V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528E017758;
	Fri,  3 May 2024 10:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714733863; cv=none; b=KiQq8WnzIiElHdgyjdiw0ZNryP67z8tfvk3uMjUQs//nZRj9gbbTHJPe5LusFUaNNHuKRWV5hIeA8VKq7TuxlrrXRY6S69GcGsjkvxRAkK7kmmbhWVKlzpga9rS+OyREwSguPn8cvsTaN65H9biYbwHGpZMNQrVmYLYCUKn4jV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714733863; c=relaxed/simple;
	bh=P5CKWZ2xCu+HyLA9GJYxKRvnqvJqVTPDARsJ0/n8HOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJoHN8URsQDZrs5KiHEkbeHUwqZ2kNC2pfbrR7oNH0Rm8hIgGmymvKiaV/5Fhcq/w7Ul3+cpX0hfpVIItrqSqgZKIsU4pPn3G9F/TZmNaXXD6eblBogjJYTaMk0mnm6iX9jml/YEfJPEN5iFMlJigT+AoQkZGtaa7voHobkrsE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tacbuA+V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3443C116B1;
	Fri,  3 May 2024 10:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714733862;
	bh=P5CKWZ2xCu+HyLA9GJYxKRvnqvJqVTPDARsJ0/n8HOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tacbuA+VyWNAhuawI+diZSSbU8d/A0IAarPODCRabmX+qWRJNz4ZoV6MkwWZqez73
	 yoXbOqWyx0/xZxtWpOSyiCe7oNP33ufjaM5oEj1pOatce71qXAyxm5wHRGJ6uWe2II
	 59oCR3/Cz5KQur9BeWfk9kMk3/7xLTJ+hk8PDcRqMQ93idmy8bMd59YCtQdXTCqC9B
	 twWS1Q6ZQ/KnL5PBd/guYHPgsNAdNPOXRzKm3qEvmIMeNnv9amxcrOfr4NTXm83ZVM
	 jM06SnQmSeb9J4eBWm44ykxgNIQ+3VKHVlL5qdfFLU04vgmbF5h/xADy0JRZRFphAt
	 8bZn+QK8jNIYA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1s2qbo-000000006NE-0kC8;
	Fri, 03 May 2024 12:57:44 +0200
Date: Fri, 3 May 2024 12:57:44 +0200
From: Johan Hovold <johan@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/52] USB: store owner from modules with
 usb_serial_register_drivers()
Message-ID: <ZjTDKKiYhU7zC9Sb@hovoldconsulting.com>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
 <ZhzrPA1wP7bER6Pi@hovoldconsulting.com>
 <ee4daf22-8979-45f7-8e20-3cafd6c3e8f3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee4daf22-8979-45f7-8e20-3cafd6c3e8f3@linaro.org>

On Fri, May 03, 2024 at 11:49:53AM +0200, Krzysztof Kozlowski wrote:
> On 15/04/2024 10:54, Johan Hovold wrote:

> > No, sending 51 trivial one-line cleanup patches like this is not
> > acceptable.
> > 
> > This is just one logical change so squash them all into one patch for
> > the entire subsystem (i.e. this series should contain two patches).
> 
> Sure. This is not exactly one logical change, but two, because the first
> patch might fix some drivers which forgot to set the owner (even if I
> did not identify them).

Sorry if this wasn't clear enough, but I was referring to the last 51
one-line patches being one logical change (and hence the series should
contain two patches as I mentioned).

Johan

