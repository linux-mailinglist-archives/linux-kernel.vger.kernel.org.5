Return-Path: <linux-kernel+bounces-53653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2897384A60B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE7F21F2863A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD6C18D667;
	Mon,  5 Feb 2024 19:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WWV4vvbp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E93616EAB7;
	Mon,  5 Feb 2024 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159845; cv=none; b=jb12XmH7ad5a4noQps1fJTFqbF7rObSlMs/PNecD+KVRZzEI1S2k/pyVFhyhsQeg0LsQ+wfR40FWMvfQukVbtfF2gzPOm2yGcEpQLBko2YMTntS8VzW5A15muiIo2Q5KrNXKmHG2TQR4rGjXHIyJG2fy+NQcSkqRpj5DIQsUyYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159845; c=relaxed/simple;
	bh=sZ9TJFqD7g8XKsIhoCMPXGeKJUZSP50HX1EyzPXNSyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efPCIIs9dT/7rQfCbJH5o9LZFktuckl9gNzVorj6MWZRQvMYv6KqVgcjDCsVAG+x0+1zvYPpRWIycAt9QUvG1dyrC/0pZ5lMAF/EiXZYl1BnrZw7l6tXuExqJvLcs0NNRKe/oqPIEIPxeeUv/8Ysx6KzNQBmGAO8iLvhh+WuMyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WWV4vvbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EC7C32787;
	Mon,  5 Feb 2024 19:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159844;
	bh=sZ9TJFqD7g8XKsIhoCMPXGeKJUZSP50HX1EyzPXNSyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WWV4vvbpRDsU37jJ7ZM//vKUuMH2iKRitSCtwsMnu4/cv2Yxt0vjKxRHA/5ygiSSS
	 T87cOlWtNBTXCM2tmV/UzIDyqbx7rCw1eeS+a1qFmukLYKlSbCV/ePU6wQPzS98CyI
	 s5HEY3+1bM2/RLeGt53ACpgyeMYWi6tmyKfVZSAI=
Date: Mon, 5 Feb 2024 04:50:59 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: sunxi-rsb: make sunxi_rsb_bus const
Message-ID: <2024020550-stipulate-washbasin-42a4@gregkh>
References: <20240204-bus_cleanup-bus-v1-1-bda309c4b829@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-bus-v1-1-bda309c4b829@marliere.net>

On Sun, Feb 04, 2024 at 12:56:44PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the sunxi_rsb_bus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

