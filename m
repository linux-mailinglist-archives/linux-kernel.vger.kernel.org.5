Return-Path: <linux-kernel+bounces-33173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2605183659D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60E12829CB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CA93D567;
	Mon, 22 Jan 2024 14:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muiakLok"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F28B3D550;
	Mon, 22 Jan 2024 14:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705934344; cv=none; b=T6fgjD6f9sRmARHiNejP43EqbJxgbzMh4kyyUUUtpN5uA8kH7oiH8Ld0pQuDdtrn5JT1QHLlrC/WFc/fgwXe0lxMfE8a1oBerjQMJRFgXrC2YTHk9XB0G1o5Znd8NlhVmDSuu1vHECGVYbPXfHFlRImWJOdfc8Dp5aBEVAqmMc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705934344; c=relaxed/simple;
	bh=YSUNPwoWfGMmfWKPSAXl0wleuODMangCwpYPqnFnaIs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=gDDP/Kh9qOwpzx5lzfsBhuh4UdnvUkk8BqTtQ31lRnCzbjNByBacRWzaSDhpJ6qbtoQfjeepSLitLgpgx2BSisYSLm4BqmJdye27RyEF9+a90hS9jGhqtUBG93x1q0dXNVpkFpot8D3mNP+91CTGFlF5nG9kTjSun8nJJHPzsYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muiakLok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7403FC43394;
	Mon, 22 Jan 2024 14:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705934343;
	bh=YSUNPwoWfGMmfWKPSAXl0wleuODMangCwpYPqnFnaIs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=muiakLok3r2D9h9GKyLHPrNJKoRdokMJIFJxNmqszHWRjHTp7xC5ca0Cu0xSNhuYi
	 kBP/mTReYLgN0y8xPQ7tJCOfCALHuGk077uXwQeHXPB9GaZY8kAyapfllCukxEqhZu
	 WnT4uQLE9k3fOs8wR069QbH4uqTmHxhYaSusahVkKtfg1lboxIfroMbHkyRRvSY/Nh
	 bTXeFxFLU5BUa5V9nnZU8/jZGp3i+W/gNJfEZyvA99AV+fipj3PBXWa5lTfSPCRcap
	 7cpVDi5l1XvTtwKgTnmgWyqwaWsEJK9zmGNlWEbwOvTF5qq69wW0mhjAmbU9qu4XYD
	 c+KM8nOAmbHlA==
From: Kalle Valo <kvalo@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,  Jeff Johnson
 <quic_jjohnson@quicinc.com>,  ath11k@lists.infradead.org,
  linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: ath11k: checking RCU usage
References: <20231019153115.26401-1-johan+linaro@kernel.org>
	<87o7goxget.fsf@kernel.org> <ZTfgJCBxsNv3bVjv@hovoldconsulting.com>
	<87zfx98r6a.fsf_-_@kernel.org> <Za5pOIkQ0SN2XzHr@hovoldconsulting.com>
	<Za5124pntbOOtURc@hovoldconsulting.com>
Date: Mon, 22 Jan 2024 16:39:00 +0200
In-Reply-To: <Za5124pntbOOtURc@hovoldconsulting.com> (Johan Hovold's message
	of "Mon, 22 Jan 2024 15:04:11 +0100")
Message-ID: <87bk9d301n.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johan Hovold <johan@kernel.org> writes:

> On Mon, Jan 22, 2024 at 02:10:17PM +0100, Johan Hovold wrote:
>> On Sat, Jan 13, 2024 at 12:26:53PM +0200, Kalle Valo wrote:
>
>> > I just found out that sparse has __must_hold():
>> > 
>> > https://lore.kernel.org/linux-wireless/87sf31hhfp.fsf@kernel.org/
>> > 
>> > That looks promising, should we start using that in ath11k and ath12k to
>> > check our RCU usage?
>> 
>> I see that Johannes already commented on this in the thread above.
>> 
>> I'm pretty sure smatch can't be used for this.
>
> I meant "sparse"...

Yeah, that was a disappointment. I should have tested it first :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

