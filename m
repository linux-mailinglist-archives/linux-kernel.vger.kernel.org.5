Return-Path: <linux-kernel+bounces-53613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5E084A5E4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B48A284F49
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FFC1851F4;
	Mon,  5 Feb 2024 19:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pTRgGR0A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C73F15DEE3;
	Mon,  5 Feb 2024 19:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159840; cv=none; b=VFtTwO6WyLbXvdjF/gogFTudnAD9m7eAQi09KvkELF2BfWRUFuWsseKGAwTdWu127sevfT52mm1tCZmUuQ4H2NnNpHHheUYTLoHCzkzKxmttOrEV4esYLwZLyhKqoBrfjTS50OG0Kqxpj0vQLCVdTSmBh7K29LjxwJ8Gp9zCJck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159840; c=relaxed/simple;
	bh=ySecDCyg8vuEud4f7aCMlAWM0dO7bI/xCzLq61pslLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utoqLnLIr38Uo2WUY/xy8N0bTix5mST8DiftYHApnWc5m1Ha4mN0zbbVJpHbUHNectIjmWmvp1mG7UGThlJJEyjrPCdb4ss68TMszk22wlyoVDlCkQOOxpGS9VJA3/LkLmobCubGcAlj2OTIz2QiWl67OlJ0h8JCqf/OD2pXMB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (0-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pTRgGR0A reason="key not found in DNS"; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A16C433B1;
	Mon,  5 Feb 2024 19:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159840;
	bh=ySecDCyg8vuEud4f7aCMlAWM0dO7bI/xCzLq61pslLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pTRgGR0AQIAIAWTNzJkFYczXTrNc5XPzFCPsvRk8Wez5/3it6SAy2OoeT8EfNHJvP
	 H7bAqabu99tnc7LGCQ58b+zV8O4SoeAyIxONP01kFuavk5SKxc51XWG1ufHPfvK2Ov
	 CTLa84oUhPdr02DbnaXpfUy6XOecQi3z8h3uElE8=
Date: Mon, 5 Feb 2024 04:50:38 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device-dax: make dax_bus_type const
Message-ID: <2024020534-stoic-swooned-0985@gregkh>
References: <20240204-bus_cleanup-dax-v1-1-69a6e4a8553b@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-dax-v1-1-69a6e4a8553b@marliere.net>

On Sun, Feb 04, 2024 at 01:07:11PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the dax_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

