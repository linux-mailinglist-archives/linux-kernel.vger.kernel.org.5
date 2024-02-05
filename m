Return-Path: <linux-kernel+bounces-53368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D99AB84A3A3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 743A51F22DDB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893E78121D;
	Mon,  5 Feb 2024 19:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x0lTfEf1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A792580032
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159804; cv=none; b=ig5EaVL5WLeTJbo9r4Ezs2EdJKmywDdbYSJD1x38fz/2DF1Nv9wGCs4gmwBEEd5+xvRy1w5S178ghNK3OV/kXlRdKN+Tv3xuFDNsNBwRadsDlbzSn8xp3zdPMi9mj7mapGsoBEhFwF/S0z3zycHhHkhLasZ/mRiDQvotvvqJRfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159804; c=relaxed/simple;
	bh=pzZpbeAfRWRXcDaTKAmrNezLJqRxqLfisQvtNhqamEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BegAMx4X78d4lAfzZk0do5+bLElyBksqzknvw61WCzNFiO01xnNodqikjRo8TIzAEsmvEIaf5ycfqzJPz/sb2huxRDeV+OVp19+Dc0DfLqpj91tCVRfX9//j0G53QatdDViNipPRSOypFOKKIgdNCeKBEOHPWipgfwqlGvfAEaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x0lTfEf1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A541C43394;
	Mon,  5 Feb 2024 19:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159804;
	bh=pzZpbeAfRWRXcDaTKAmrNezLJqRxqLfisQvtNhqamEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x0lTfEf124QO85OU4Bfc9+FmBepmukA8Wr7p6zTbPcSBR8Ru4sZMjjTUTyopEqQ+B
	 u8OOejLeJSfjo2PMys2ul712dtb8SfXkLQ7kq6ZxKiucAAUp4hBVad+A2MlFv82BCL
	 XD6i4fcMv7Rk5CoFsBgblENNWvW/3W4zFdizjFb8=
Date: Mon, 5 Feb 2024 04:48:10 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmem: core: make nvmem_bus_type const
Message-ID: <2024020505-monstrous-shorten-81bb@gregkh>
References: <20240204-bus_cleanup-nvmem-v1-1-21775783d1d2@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-nvmem-v1-1-21775783d1d2@marliere.net>

On Sun, Feb 04, 2024 at 05:22:51PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the nvmem_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

