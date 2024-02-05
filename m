Return-Path: <linux-kernel+bounces-53310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0826D84A344
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A11D1F213AC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A5F5BAFA;
	Mon,  5 Feb 2024 19:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l6Slrggr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8AF5A7BE;
	Mon,  5 Feb 2024 19:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159787; cv=none; b=l9ly9x0jvDaEkdwDVfN33N77cUriLxsI+499uuoxxRnHMTzmDQWgNszzAv9qS07vJqVWoFhQOcaykJA2YZVlRaV8gHOhW3V8WWy6c3cBcdFCbXMujGoiI4xz8+eOnqJgLTiolw5nAAE9bvazaA67VHA2Y2OlogAwgdt5GPqakSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159787; c=relaxed/simple;
	bh=y7rclFvbLz49u6nM+LwwvLo07quZDiET4J+mtxUDuyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXONUSzpe7igQyMV6sakgB0Hq5Pf953GL7ye1cgd+8CjGWxiRs2TNTJrHIXRAUfmkYZtMvvniffClPt/OshCTUDMcKCN9wpvT/+bzaFSjadhh44mtd5z0k5FhGfJUTam4IAAq3epIW/FijIUX8NTmhzacuVMUGQBMlVUmKPLobk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l6Slrggr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5AEC433C7;
	Mon,  5 Feb 2024 19:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159787;
	bh=y7rclFvbLz49u6nM+LwwvLo07quZDiET4J+mtxUDuyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l6Slrggr7PSxn55Jtzac3Ggl68HEyUAlgX9S+Isrzs3to/q2uqyKYV7B/qiMzM4Mw
	 F/jqV6z+sm0OM3QdZ50NgXqxd4KudI3HsL/vfQ+pQP4pt1CC0ab9/nyIkuPEYCrb2o
	 OouBUzS00q7j3DLezv4d/phvcCilABcKI4+112wE=
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

