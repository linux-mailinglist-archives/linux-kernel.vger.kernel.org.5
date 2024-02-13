Return-Path: <linux-kernel+bounces-63779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B7785344E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C20B281115
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7F15FBBF;
	Tue, 13 Feb 2024 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H7C4M9rd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24F45578E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836725; cv=none; b=oBvATmpyFeNs1ylorwmSsJS8OCqnzx+JeKihVIXz+vin7/zafbzF5WPyVlIFoR7vBp0AqVNsPyLPUjMOEkVBEmiPvFjkelaEu5glu/LbDRKMY3X/Ku0gGzQlcwvR+XwuYm/eHF0Ev3EAxNlVxiWR7rrKnUperoY8cVXrtg+Igbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836725; c=relaxed/simple;
	bh=Qa6rVTdH4iQGyAAt2k4ZX9zqEob7WMbTmIXFs7XCOio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGBOJAW63oNS7CkRp+J3udf5CEEPLyc8lkDdVB1fZHi4976KDhIylIYfRSuntVknsEegH01b6Cu4slbVxA6Ig5AB40RbGXbvPXU2MFKsiYnTNh/Gnfr55rlnBdTCW7e8EsbDOYFjTH/M73FpPOLUsaJ7ZPz3PDHJNg0RiFNasao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H7C4M9rd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CC4C433F1;
	Tue, 13 Feb 2024 15:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707836725;
	bh=Qa6rVTdH4iQGyAAt2k4ZX9zqEob7WMbTmIXFs7XCOio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H7C4M9rdRXokWR0t+dcNMJMksJsOVh7lNpJoEITtBG8GNgSp1b7NVVg/ra3HOC043
	 YpNX14dvMfJz99sgnbH7n2TfY+D1NwlEq8GCH30cidPhdnShJ7HsV5GdhFnkd4/nuU
	 wv3m49EbmKNobmnROko2cMPV1f+dG/RL2sKfWAAs=
Date: Tue, 13 Feb 2024 16:05:22 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zorro: make zorro_bus_type const
Message-ID: <2024021314-coyness-frosty-f8cc@gregkh>
References: <20240213-bus_cleanup-zorro-v1-1-388ceed8e7bd@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213-bus_cleanup-zorro-v1-1-388ceed8e7bd@marliere.net>

On Tue, Feb 13, 2024 at 11:41:25AM -0300, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the zorro_bus_type variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

