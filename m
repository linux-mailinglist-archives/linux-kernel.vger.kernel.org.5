Return-Path: <linux-kernel+bounces-53313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CA184A349
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0061F22278
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD385D8F6;
	Mon,  5 Feb 2024 19:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oW7IMVUR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FF65C618;
	Mon,  5 Feb 2024 19:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159789; cv=none; b=fshq7RQOJNJmkEo6KsJR5LSnuJzXRsk+8Oil7fHiNQ0fsQshUUOxDe69Y2vcA7tcVN8T0Ur4385HbHcrvVv9F0yBOYbt6a4DU3rh29XRwO+JDWkJ+QFxWKGj/LlovnfZrbS/i/x1DhE0Q4PulQXnKlINGolox5whm/pfHc5Aap4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159789; c=relaxed/simple;
	bh=y7rclFvbLz49u6nM+LwwvLo07quZDiET4J+mtxUDuyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bj/dEEZ3PeKMh7722zAbRDMkxOk4l1IgdGqM1aO2NnygavnHod2zdWs1cpjQDPHJ1XOUqODxjtDOFdB1vbOJvuUNBWOKj+alwCtS01otB+8koqOtFCYjFLHPaNAiqUn1Jk2z+95g+L9S+J4tYunauPmbt9taeIMCmN8yu4TsRmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oW7IMVUR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31730C433A6;
	Mon,  5 Feb 2024 19:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159788;
	bh=y7rclFvbLz49u6nM+LwwvLo07quZDiET4J+mtxUDuyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oW7IMVUReTOrXcCJQjZ+Y+ekd2rRmDejLUQ5Xl8BfwxiNiBYCOf5BLhBt5bhtrvh/
	 Hu9aalNDbyIxYWMAkpClOk+r/bGHrjjYBcTE2Y6lDqnmEgtZ7gam7NR+GlHVndLWOM
	 J93dYjRwjKuKMtuLXo1q8cruh7w9mRemcb24V5f0=
Date: Mon, 5 Feb 2024 04:46:46 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Michael Buesch <m@bues.ch>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ssb: make ssb_bustype const
Message-ID: <2024020543-footsie-unreeling-1cd2@gregkh>
References: <20240204-bus_cleanup-ssb-v1-1-511026cd5f3c@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-ssb-v1-1-511026cd5f3c@marliere.net>

On Sun, Feb 04, 2024 at 05:44:21PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the ssb_bustype variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

