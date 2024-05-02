Return-Path: <linux-kernel+bounces-166034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142B58B9508
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459D41C20B61
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B6622EF2;
	Thu,  2 May 2024 07:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRqGX9Fx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7DC1CD32;
	Thu,  2 May 2024 07:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714633541; cv=none; b=fccELQUodKFdTD9JNFC/Q74a5X+0Z+/JC1pU+z1nS9yDliDV6bZitJ49XXfmTusWVLEZiHO1VYvEwuoy49AT++nK/mnKhrnlQTe9fqLJbPSDPS6t7Rq/lgrqORId7SY41OwQK6KqbL10hKyfgat3T8qmtYN9Zr4YRC518C0WQhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714633541; c=relaxed/simple;
	bh=qohn0+wgZK8fW1L5cozppymgAyY5UyPVH1hNxyFm7eU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=YRQ8bOGerjxTyiiS97QkNvgC4EVkXGQS0+tZ/ZdegEFCz2JqkeJxc5YzkEryN2Fe0rqKudOl1D+Zv9chhpTHlyghzgMDHs9HzBDXwChaZKttNBOCyFwtJPhF9EMKGdjWPKSVVS8oq649cYP2rEYa7ajvA0JaSOzDmNh7IQvHT1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRqGX9Fx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CB4C116B1;
	Thu,  2 May 2024 07:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714633540;
	bh=qohn0+wgZK8fW1L5cozppymgAyY5UyPVH1hNxyFm7eU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=oRqGX9FxmLIFyp9Bj3JGwc+u09C7EFFuKGwAASNv4wI1ZecH8gJiEifMEwVgOmiyX
	 3ukJLI8BFq4b5Bm/t6P2NyP3eFpDt1ymuOO1Q1Ti9QuFKuNnM+Zt6ShK3WDBtUBhdH
	 JqCy1IprTP8X+NzlXZRb97dGg6iZZgD7fbqxlpwe9rilg43LBzPtoJrgq/ohjORFhS
	 A6wrkUXcbDN3+OWOo2boPlvWB8+RBeSI39lHsDcsvCsXbnPKnh57RL/Oon7OZAofAc
	 pl1tOc6XriZ1t6L5TtbjxGoerBIckRM8/KxWvpbaiiHcWhV8OIKJoDpkXsK6Dgw0Z1
	 I917sxhoe5jNA==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Ziyang Huang <hzyitc@outlook.com>,  <jjohnson@kernel.org>,
  <linux-wireless@vger.kernel.org>,  <ath11k@lists.infradead.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath11k: fix remapped ce accessing issue on 64bit OS
References: <TYZPR01MB55563B3A689D54D18179E5B4C9192@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
	<6336ffc7-d8ae-4cfd-8b66-d6d91cb0d15e@quicinc.com>
Date: Thu, 02 May 2024 10:05:37 +0300
In-Reply-To: <6336ffc7-d8ae-4cfd-8b66-d6d91cb0d15e@quicinc.com> (Jeff
	Johnson's message of "Wed, 1 May 2024 09:56:15 -0700")
Message-ID: <87zft8elry.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

>>  static inline u32 ath11k_ahb_read32(struct ath11k_base *ab, u32 offset)
>>  {
>> -	return ioread32(ab->mem + offset);
>> +	switch (offset & ATH11K_REG_TYPE_MASK) {
>> +	case ATH11K_REG_TYPE_NORMAL:
>> +		return ioread32(ab->mem + FIELD_GET(ATH11K_REG_OFFSET_MASK, offset));
>> +	case ATH11K_REG_TYPE_CE:
>> +		return ioread32(ab->mem_ce + FIELD_GET(ATH11K_REG_OFFSET_MASK, offset));
>> +	default:
>> +		BUG();
>
> you can WARN but you can't BUG (and even WARN is being discouraged)

Yeah, even WARN() is risky especially in a function like this. It can
cause so much log messages so that the wathdog can trigger and reboot
the host.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

