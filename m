Return-Path: <linux-kernel+bounces-129662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9974896E36
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2548EB28436
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB6C142E75;
	Wed,  3 Apr 2024 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHFJBEBY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB96135A5F;
	Wed,  3 Apr 2024 11:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712143614; cv=none; b=tXkvV3dSZiOJHd5nrPpCOiVbbh3bmZO9iySzuVFGK2ZRv/IZ/9dVk12EnDLWeD7KWIWVdw5U4nF/xGDuuNCUu+8E3ANvCcWc8cDVUhmq+RZkfvm56nHV/Hf92MQUYG3SmPz29lrBmMqKxQkCPdaVlKabKIp+25ULEHO5vo/00P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712143614; c=relaxed/simple;
	bh=+2lGMxA3dcgWqfN8txptFhwJYk5Th+m4fTU+REELCOg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ETE6Yt5LZ9Os3DEGaY4NAftPCaTVFGThcA59++lUej93HLf50tYf31HAEaY9shIm65dEDAkNOm0dycXAZHFuwTzqlJVbCAj61ROuh1jUJwrIxFkjiIoSOdSiTiGnL2ExplAOap9pfk9tgWKWT4dFeTRJ+hiU9EbnNCUje7ViAb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHFJBEBY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB72C433C7;
	Wed,  3 Apr 2024 11:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712143614;
	bh=+2lGMxA3dcgWqfN8txptFhwJYk5Th+m4fTU+REELCOg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=jHFJBEBYaU7I3GwVpaz7sh2Qo+r5vNdXqsJY+0LfecRL0N9d9EooQJA20RunkNoQa
	 NwZpvmT7L60tCJ8S+Ub4IyVe0HaHjFJrQqnpTitD1dnfI/UetnueJYmji0N7WQMl3U
	 v9+MdkeOZjPclQraW86CeZYUL4vzWd2UKeD3sIE7Weio/8tI0NNHl4848jNuGxUA0V
	 wJCr7sQ0EZ14FWGc1jX9znj2dG0ZMtYwfc1jBeLDMM7tK+p0+gQn4tmMhMqghznGRs
	 GbFecSd2hjuXLkZiuvNtdMlSD1piYuV91wG+8Gekuwu3y654v4TCeukhl9I8EaNM/e
	 82Oa7ZCh0M0Bw==
Date: Wed, 3 Apr 2024 13:26:52 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Martino Fontana <tinozzo123@gmail.com>
cc: djogorchock@gmail.com, benjamin.tissoires@redhat.com, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Ryan McClelland <rymcclel@gmail.com>
Subject: Re: [PATCH v3 RESEND] HID: nintendo: use ida for LED player id
In-Reply-To: <20240318110145.18490-1-tinozzo123@gmail.com>
Message-ID: <nycvar.YFH.7.76.2404031326430.20263@cbobk.fhfr.pm>
References: <20240318110145.18490-1-tinozzo123@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 18 Mar 2024, Martino Fontana wrote:

> Previously, the leds pattern would just increment with every controller
> connected. This wouldn't take into consideration when controllers are
> disconnected. The same controller could be connected and disconnected
> with the pattern increasing player count each time.
> 
> This patch changes it by using an ID allocator in order to assign the
> player id, the same way hid-playstation does.
> 
> Signed-off-by: Martino Fontana <tinozzo123@gmail.com>
> Signed-off-by: Ryan McClelland <rymcclel@gmail.com>
> ---
> Changes for v2:
> 
> ida_free now frees the correct id, instead of an id that got moduloed.
> 
> Changes for v3:
> 
> Destroy allocator when removing driver.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs


