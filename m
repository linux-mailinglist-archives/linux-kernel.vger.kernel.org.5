Return-Path: <linux-kernel+bounces-64019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5939D85390A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BFF41F2476C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8320C605C7;
	Tue, 13 Feb 2024 17:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mAbNEmEO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA644605BA
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846862; cv=none; b=aelKscnQ+gbLKNcQwVHrK1rbybQtgw4S6T5o4MtAS3tkYUYouUot9XbCL5rdWzB1GrOvpt9KQyN+065Von750OGwyUH5zKUmqvW7PV3JJ2qNLHE+swWCCxtWaXG3MRFzLeY5hGtMybX+RenQOZBLF0N3UF/KtN8yhy16o1wISqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846862; c=relaxed/simple;
	bh=ZFGOWRAQbD8VvKdr3JfQp789zI/xn658SoRBQfTwrsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKz//Eao7noqECYHNLPHE4L9RK/OEZaUN3t6f3Sn1LV4ULi7Q91eG/En9jmRWPhoSM982F1FtxsNCN1K6tDY938PpAUu5eilL/tVGx9/+XJBmXFmUqVr/qpEgptmzQq1vX/ZK2cyNLNJ3ABEeLoi+GiqDWFdlC3fmod4gF4DDGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mAbNEmEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E66C43394;
	Tue, 13 Feb 2024 17:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707846862;
	bh=ZFGOWRAQbD8VvKdr3JfQp789zI/xn658SoRBQfTwrsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mAbNEmEOy0lDUd/vMPHw1FQqCFL9Ol4vzV+WgpIdWH6b+Bqf07qmbK1EQW0DI1nxZ
	 rSlt2PNTnvixO7Ti5aHVmrAcrhyRUfgqjufN4iGD9vF6QI9oFKIbtsw9A3xaXvotOI
	 Pv61QFHQiAukvI4w5G7Dp0kv4VRnaAVVfnFUZvK4=
Date: Tue, 13 Feb 2024 18:27:48 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: ds: make pcmcia_bus_type const
Message-ID: <2024021345-relearn-snooper-2272@gregkh>
References: <20240213-bus_cleanup-pcmcia-v1-1-97273c37e277@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213-bus_cleanup-pcmcia-v1-1-97273c37e277@marliere.net>

On Tue, Feb 13, 2024 at 11:48:45AM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the pcmcia_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  drivers/pcmcia/cs_internal.h | 2 +-
>  drivers/pcmcia/ds.c          | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

