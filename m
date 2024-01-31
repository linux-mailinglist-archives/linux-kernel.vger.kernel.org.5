Return-Path: <linux-kernel+bounces-47013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049E48447F1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4F9928CA21
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004303F8ED;
	Wed, 31 Jan 2024 19:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpbXaMRZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311013EA8F;
	Wed, 31 Jan 2024 19:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706729079; cv=none; b=K+mEcvx9koWkZoPEESyXPhevu1OESxnFLHnSxIeGTm3BA4gP2If3ts9LvVyfdVMc3iF/1jK4p30OiKZlS58pBYri2riwLcpJJEkzqW1IXWwI78rw5CHUxxaPXxeIsyV1MKw2UgMQj2JBFMirgJIav9W70CWu1LK4Z14Erdp6k7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706729079; c=relaxed/simple;
	bh=G00LMao4GevkYINsVIDt8RNrwzZ/UP+aNdCnJJg3bbE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KC1yG10kNdEvNxnXi1KPAeUCwREV1V59EkowndGp2iQCo/MOA0LUuMAdpK24dI9tIr3mlvHa2wikGvmV7/ksKAlZsStPstlVTXafaNC1SVEzR20v0e+fYQbYtTNj337zyLiPP4KQDRyQxxcaoNIiTUCRcnVlaXNow2wxk0C81N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpbXaMRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C12BC43390;
	Wed, 31 Jan 2024 19:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706729078;
	bh=G00LMao4GevkYINsVIDt8RNrwzZ/UP+aNdCnJJg3bbE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BpbXaMRZ0kgyskPS6KSBqq94sBmHpqrEtvijtUW8ouURXNZzFyk1Cc1MAnan2VjUj
	 FY2/+7rYUBWt9qpkbIwnKUO0Z8y++oWNFSzT5bQNSWyuvpblScWHnToWkyGncgiRd7
	 3Nc25Pt34WCy1G0fxuXj7EFEq1+sZ5qNryZXnjnykEAnIwNk0uSUQauCi3t8f6lz9n
	 cdJhCsSzJ5GlfRWnBS9ct9o1CHxFZimDCQzmnGAQtJZ4EZBN8ZMnVDV7mWBfXnjrNL
	 jdFehURzNPqP3oIHMomov4qGmVSXT45ncYAfqkDb0Na1D0mpQjXQbMwGa+HhaI45ir
	 zhbWM95+eLFkw==
Date: Wed, 31 Jan 2024 11:24:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: mcgrof@kernel.org, russ.weight@linux.dev, gregkh@linuxfoundation.org,
 rafael@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, keescook@chromium.org, masahiroy@kernel.org,
 nathan@kernel.org, nicolas@fjasle.eu, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kbuild@vger.kernel.org
Subject: Re: [PATCH RFC 3/4] net: ethtool: Use uts_release
Message-ID: <20240131112432.5133bcaa@kernel.org>
In-Reply-To: <20240131104851.2311358-4-john.g.garry@oracle.com>
References: <20240131104851.2311358-1-john.g.garry@oracle.com>
	<20240131104851.2311358-4-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 10:48:50 +0000 John Garry wrote:
> Instead of using UTS_RELEASE, use uts_release, which means that we don't
> need to rebuild the code just for the git head commit changing.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Yes, please!

Acked-by: Jakub Kicinski <kuba@kernel.org>

