Return-Path: <linux-kernel+bounces-145503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FB18A570B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26A31C22044
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED338061C;
	Mon, 15 Apr 2024 16:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXktyWh2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621F179DD5;
	Mon, 15 Apr 2024 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197194; cv=none; b=DlkuTN76cGSwKLDWI3g+hbwG4MDmmtZNYAUqsyXWHp5XnYBppKxLZsrwwiKGpEY7xVT0Ynoz4VAJlQWpNFd2Wg/NL3I7H5Z9UkTnkfITsRR3ZNWLZA+FlJ8y9OxWTgq7y8IxdaZb5vddeCzZWFMNbtWhXwI7oCpAjjDipbh9BqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197194; c=relaxed/simple;
	bh=63edPZGvTejQU5Y0eC42owDzMIedIHDtuS1pEqj8Sy8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=QgQiduiyxSjSskZVRcgfCo8Sbr7oma4gGDGbwbc31Ira884RI8hJ06EG35zJFKy6msLAzfc5TDq9yiWWsi/IcHen4j29lFR2u91hCYyqKrj9DTl0LMoLOA4RzmqainikUO7tZM2mFPoaMz1Q5WgHMas8CMPb+MUN4cs48BEFSVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXktyWh2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837A3C2BD10;
	Mon, 15 Apr 2024 16:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713197193;
	bh=63edPZGvTejQU5Y0eC42owDzMIedIHDtuS1pEqj8Sy8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=kXktyWh2HUDWg2oZ4MgYYoWgziCuftsEglZ1213wbAkO8tOpP8WlxmEsgBD556d0K
	 23riC/5P8StOGGomfCZaWLhvkoSUkqIe0hlPj6w9fSg5ecKTl//tq5hd9sjH44ZzRI
	 PZgvmavzvvkMKzUY6+SHZWBuwgJhT9RABRIYHevLNPzIPfFwGOV6dMudGc5py5wDjB
	 1ao8w7ybV2XzYTH7ys9z/zl+Ic3b9+C2JfbydhvY3w8Y91s0OEV4IJXa/KGa9nyspy
	 KUfKultJ2lZ/MVgYPa8vPFg8BQ/hqQJmFIlV/9DUXstcePc/Px+A8NQYAd2GB+eVzW
	 l+fXTwm3E2kDA==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Christian Lamparter <christian.lamparter@isd.uni-stuttgart.de>,  Robert
 Marko <robimarko@gmail.com>,  <davem@davemloft.net>,
  <edumazet@google.com>,  <kuba@kernel.org>,  <pabeni@redhat.com>,
  <robh@kernel.org>,  <krzysztof.kozlowski+dt@linaro.org>,
  <conor+dt@kernel.org>,  <jjohnson@kernel.org>,
  <linux-wireless@vger.kernel.org>,  <netdev@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <ath11k@lists.infradead.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] wifi: ath11k: support DT ieee80211-freq-limit
 property to limit channels
References: <20240412162510.29483-1-robimarko@gmail.com>
	<20240412162510.29483-2-robimarko@gmail.com>
	<4a1e0cb6-c319-4eb1-9bd1-5ff13eabfe1b@isd.uni-stuttgart.de>
	<c7106c8e-0c99-4160-966e-b1a8ba5770ee@quicinc.com>
Date: Mon, 15 Apr 2024 19:06:28 +0300
In-Reply-To: <c7106c8e-0c99-4160-966e-b1a8ba5770ee@quicinc.com> (Jeff
	Johnson's message of "Fri, 12 Apr 2024 13:53:02 -0700")
Message-ID: <87ttk2y5iz.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 4/12/2024 12:52 PM, Christian Lamparter wrote:
>> On 4/12/24 6:24 PM, Robert Marko wrote:
>>> The common DT property can be used to limit the available channels
>>> but ath11k has to manually call wiphy_read_of_freq_limits().
>>>
>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>> 
>> I've seen this before.
>> 
>> https://patchwork.kernel.org/project/linux-wireless/patch/ed266944c721de8dbf0fe35f387a3a71b2c84037.1686486468.git.chunkeey@gmail.com/
>> 
>> (dt-binding too. it has/had an ack)
>> https://patchwork.kernel.org/project/linux-wireless/patch/fc606d2550d047a53b4289235dd3c0fe23d5daac.1686486468.git.chunkeey@gmail.com/
>> 
>> sooo.... this is awkward.
>
> Patchwork indicates Changes Requested
> Any idea what changes Kalle is looking for?

I can't remember anymore but most likely I assumed based on Krzysztof's
comments there will be v3 and missed that Conor already had acked it.
Sorry about that, I set Christian's patches to New state now so that
they are back in queue. And I'll drop Robert patches. Does this sound ok
to everyone?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

