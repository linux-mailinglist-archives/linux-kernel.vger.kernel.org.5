Return-Path: <linux-kernel+bounces-149372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C76C28A9037
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 680581F2233D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81CA6FB2;
	Thu, 18 Apr 2024 00:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEmUFUP1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3822CA5;
	Thu, 18 Apr 2024 00:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713401783; cv=none; b=TOQdnq04Zl0RJw2oo+tE0pJ6lDadl9pDc38wjEoz5DZy5136wAP1OVcYKd9lXDH8yJUmc4YMH21B5s8DwzoOyQsjMAvYOwYS/XUUNs3Ap3QW2KDNrPqH1cZYDWcAldng1PlRZEB++ZQWcu4KM6+/qH4IuQSZXvS4rOb0dIz4Rw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713401783; c=relaxed/simple;
	bh=vL4BH11YiczMtA85AfUXDUCqO8U2VxAovNR9Q83/HtE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VMQKQ+Z8jUJUufwgbuWxnKjy6gtM9j+bbDGtQu3kVAUCtKaPtVg4qLJTsbaCaLa8tZqQqRYlkTfpEEf2cQM2DW5JXGqFLUZlbt78pWBp9cUd8+u2TjMvLAVn5VYnXGf2EqDMZnOFc5pJHtNEus/NGTuV8ple03PHhaO8OmiWx8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEmUFUP1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565D6C072AA;
	Thu, 18 Apr 2024 00:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713401782;
	bh=vL4BH11YiczMtA85AfUXDUCqO8U2VxAovNR9Q83/HtE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NEmUFUP1seirP89YaqGwC+l/pKXO5ht+Zx9+19+PYD8SuN6mDLD2EF5Y1OPfvZcOj
	 LtL/07TI69eLBh7U5gMgGJ36/0QYR81nZUWAwxT7KrO7/p1qT45rtctc8MWKgsIx2Z
	 isC2YLHaFsIk2Gutqq1erKWMf/67F9SJsK6MISot2PEKBtNceO2OCdNardYyoy2kh8
	 VxGlj7h3pOBMcOC0+OdTAYpl/EpDQAfalOD/fT1Kh1XullYd/TbIB+QxWsPnni6Xci
	 pGwAzj7xDqTU2I/3F3gqHrYhxAtNSnTYP48AQzlTqUJFzlcctcysk6D0QoO/3j1znu
	 MZdKhyO2Rafyg==
Date: Wed, 17 Apr 2024 17:56:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Chen <justin.chen@broadcom.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Simon Horman
 <horms@kernel.org>, Markus Elfring <Markus.Elfring@web.de>,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: bcmasp: fix memory leak when bringing down if
Message-ID: <20240417175621.780cb1f8@kernel.org>
In-Reply-To: <1f3131a4-fa84-4d25-8c1a-ab0023aace23@broadcom.com>
References: <20240412181631.3488324-1-justin.chen@broadcom.com>
	<6881c322-8fbb-422f-bdbb-392a83d0b326@web.de>
	<9afad2b3-38a5-470d-a66f-10aa2cba3bab@broadcom.com>
	<8ae97386-876f-45cf-9e82-af082d8ea338@web.de>
	<20240417161933.GA2320920@kernel.org>
	<3a5cb80e-7169-4e82-b10c-843ff1eb0fd3@broadcom.com>
	<1f3131a4-fa84-4d25-8c1a-ab0023aace23@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Apr 2024 11:48:33 -0700 Justin Chen wrote:
> I try my best to address feedback. After a bit of thought, I feel the 
> feedback given was not out of good faith. I would like to keep the patch 
> as-is unless someone else has feedback. That is if the maintainers are 
> ok with that.

TBH the "if" in the subject gives me pause too, please respin.

