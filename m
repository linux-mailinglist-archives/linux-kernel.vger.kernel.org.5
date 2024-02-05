Return-Path: <linux-kernel+bounces-53723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8981A84A658
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463D528E46C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E97019B9C3;
	Mon,  5 Feb 2024 19:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0V1jmYS4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D308D1741E0;
	Mon,  5 Feb 2024 19:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159852; cv=none; b=ietSYLmRG2ilYaOPBnZtg/kF10Wxzy6YEsvjC9o+TPRoexG/2VTQT5OkRHLHeVTmSbie4QndMn3LlXhRoluyIa2DCxqJ5MxdO5ZyUlDlB8KMfUvEwfSYTG6+Y7fmrW0+g/+acJm81X3F/+7g3tZAe9rgzcsVTMdiLPX/6EZe46Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159852; c=relaxed/simple;
	bh=nIlg0Ojr7ROSJ4zCSJfQ+EY2JGPU+IPkd+GLvdpsS1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmzxJCzGd0qoGhzPiptN+Xe4XseQoTIw+31HK+J5ilfil4uICqmJX8znkKuDPbogf6by6amFcrsQHG7Lhjbu1zRJZQS5eM/Kl4MgtRXZ27E3Yy1iUaHGOVW3OUfWVf4dRyK/2RDlxvEpEGVbJu+bYOT2jPwhKWW+H8nGQYu/rHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0V1jmYS4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661CDC4166A;
	Mon,  5 Feb 2024 19:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159852;
	bh=nIlg0Ojr7ROSJ4zCSJfQ+EY2JGPU+IPkd+GLvdpsS1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0V1jmYS4HmaK6xg/wSeX0H9MPCaohVnlEgK4AazxwYD9Q6IKxktyVLF2mMliyxGed
	 u9m+wbajdTvLoeq0Fx0Jl5nWcDyRteIMgB2ezLh6ihWB94aojuXinaOIlxhX67Klo0
	 zdgbYvdTBwn8OtTivE87+y46tI0P6n7CKzfv9T04=
Date: Mon, 5 Feb 2024 04:51:34 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc: vio: make vio_bus_type const
Message-ID: <2024020530-arrange-hertz-9e41@gregkh>
References: <20240204-bus_cleanup-sparc-v1-1-4ca7fe8de5f7@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-sparc-v1-1-4ca7fe8de5f7@marliere.net>

On Sun, Feb 04, 2024 at 12:19:50PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the vio_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

