Return-Path: <linux-kernel+bounces-156321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 033968B0122
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970AB1F23F65
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E457515686D;
	Wed, 24 Apr 2024 05:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJ0uprlH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2765C13CFAD;
	Wed, 24 Apr 2024 05:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713937142; cv=none; b=HNB8yljLfes+YZ8OtAnyDSBWKrybuCbrcffLpa9CQ1E/74Nx8fM/89qx5kc8mqyT9Ns6nBtl9by/GpO0ndNIspKJJ/ab/4jzsteVHUaKK18tKZPvqFqId1f344YT+PBxBiXnWtEgl7++wIGOcL3h26I/Yodpa0mvtfwIFkaAz48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713937142; c=relaxed/simple;
	bh=ay9Awlh5bevS7aC0s4/0vSKV1IHpC9vfF+b2hfqoGKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zvr7LaaSapyEsLZIfYtYtlDIO7jkbo4nNWIrPR/B6Xwl5cL2AQ+tbUqEXu9tWYp1RlmEAicVv2d3zNiSZ+2xxjAujMt7EULw5/EM865tUfCFi/7JQPqXdaBbFOiTEE0BbD/YJDHWrfQmFEkYhsIzRbvg6AamTgzY+H6kJnw6XTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJ0uprlH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C500AC113CE;
	Wed, 24 Apr 2024 05:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713937141;
	bh=ay9Awlh5bevS7aC0s4/0vSKV1IHpC9vfF+b2hfqoGKs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KJ0uprlHown4qsaCkUVlFJjtPPccNrXH7pCXV8H5Qzt+cafh3RjqfLeY62cmJXeyg
	 K6tiWYSizKwv+B8ZCJJqLGIsF44+3sr2RaPel5BkqFcID/rBx7erK+MD8oVql7F2yb
	 jGwUtI8Hl5w+ZKBae+d5Qi6DbeGPr+cOpHJl/4WmSfs6BOlu+JszapSBSTFOM13GKa
	 JWUL9U8AG/k8NHVR/oqRWC6U2jqaac4UfkuBYqE0gQ2eeKxAb3+hhg1zVWYSX5R5D2
	 5rdm5kc/FIlAKVaDtwpoDkbW0h32XeyO6mCN3KngB/fePp1ZNSdi/V1ILsX1ZiXVA4
	 rdZUiJKSFx2zw==
Message-ID: <39fe27f8-545f-4246-9b18-ab1c50ff8edc@kernel.org>
Date: Wed, 24 Apr 2024 07:38:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfc: pn533: Fix null-ptr-deref in pn533_recv_frame()
To: Yuxuan Hu <20373622@buaa.edu.cn>, gregkh@linuxfoundation.org,
 johan@kernel.org, davem@davemloft.net, u.kleine-koenig@pengutronix.de,
 Jonathan.Cameron@huawei.com, francesco.dolcini@toradex.com,
 jirislaby@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, sy2239101@buaa.edu.cn,
 Yuxuan Hu <yuxuanhu@buaa.edu.cn>
References: <20240422080408.1639247-1-20373622@buaa.edu.cn>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJgPO8PBQkUX63hAAoJEBuTQ307
 QWKbBn8P+QFxwl7pDsAKR1InemMAmuykCHl+XgC0LDqrsWhAH5TYeTVXGSyDsuZjHvj+FRP+
 gZaEIYSw2Yf0e91U9HXo3RYhEwSmxUQ4Fjhc9qAwGKVPQf6YuQ5yy6pzI8brcKmHHOGrB3tP
 /MODPt81M1zpograAC2WTDzkICfHKj8LpXp45PylD99J9q0Y+gb04CG5/wXs+1hJy/dz0tYy
 iua4nCuSRbxnSHKBS5vvjosWWjWQXsRKd+zzXp6kfRHHpzJkhRwF6ArXi4XnQ+REnoTfM5Fk
 VmVmSQ3yFKKePEzoIriT1b2sXO0g5QXOAvFqB65LZjXG9jGJoVG6ZJrUV1MVK8vamKoVbUEe
 0NlLl/tX96HLowHHoKhxEsbFzGzKiFLh7hyboTpy2whdonkDxpnv/H8wE9M3VW/fPgnL2nPe
 xaBLqyHxy9hA9JrZvxg3IQ61x7rtBWBUQPmEaK0azW+l3ysiNpBhISkZrsW3ZUdknWu87nh6
 eTB7mR7xBcVxnomxWwJI4B0wuMwCPdgbV6YDUKCuSgRMUEiVry10xd9KLypR9Vfyn1AhROrq
 AubRPVeJBf9zR5UW1trJNfwVt3XmbHX50HCcHdEdCKiT9O+FiEcahIaWh9lihvO0ci0TtVGZ
 MCEtaCE80Q3Ma9RdHYB3uVF930jwquplFLNF+IBCn5JRzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmA872oFCRRflLYACgkQG5NDfTtBYpvScw/9GrqBrVLuJoJ52qBBKUBDo4E+5fU1bjt0
 Gv0nh/hNJuecuRY6aemU6HOPNc2t8QHMSvwbSF+Vp9ZkOvrM36yUOufctoqON+wXrliEY0J4
 ksR89ZILRRAold9Mh0YDqEJc1HmuxYLJ7lnbLYH1oui8bLbMBM8S2Uo9RKqV2GROLi44enVt
 vdrDvo+CxKj2K+d4cleCNiz5qbTxPUW/cgkwG0lJc4I4sso7l4XMDKn95c7JtNsuzqKvhEVS
 oic5by3fbUnuI0cemeizF4QdtX2uQxrP7RwHFBd+YUia7zCcz0//rv6FZmAxWZGy5arNl6Vm
 lQqNo7/Poh8WWfRS+xegBxc6hBXahpyUKphAKYkah+m+I0QToCfnGKnPqyYIMDEHCS/RfqA5
 t8F+O56+oyLBAeWX7XcmyM6TGeVfb+OZVMJnZzK0s2VYAuI0Rl87FBFYgULdgqKV7R7WHzwD
 uZwJCLykjad45hsWcOGk3OcaAGQS6NDlfhM6O9aYNwGL6tGt/6BkRikNOs7VDEa4/HlbaSJo
 7FgndGw1kWmkeL6oQh7wBvYll2buKod4qYntmNKEicoHGU+x91Gcan8mCoqhJkbqrL7+nXG2
 5Q/GS5M9RFWS+nYyJh+c3OcfKqVcZQNANItt7+ULzdNJuhvTRRdC3g9hmCEuNSr+CLMdnRBY fv0=
In-Reply-To: <20240422080408.1639247-1-20373622@buaa.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/04/2024 10:04, Yuxuan Hu wrote:
>    ? kthread_blkcg+0xa0/0xa0
>    ret_from_fork_asm+0x11/0x20
>    </TASK>
>   Modules linked in: nfcvirt(O) pn533(O) nfc(O) ki_coverage(O) [last unloaded: pn533(O)]
>   CR2: 0000000000000014
>   ---[ end trace 0000000000000000 ]---
>   RIP: 0010:pn533_recv_frame+0x18a/0x1e0 [pn533]
>   Code: 43 ff ff ff 48 8b bb 80 02 00 00 48 c7 c6 0b 02 46 c0 31 c0 e8 97 64 4f c4 48 83 bb b0 01 00 00 00 74 3f 48 8b 83 b0 01 00 00 <c7> 40 14 fb ff ff ff 48 8b 83 b0 01 00 00 48 85 c0 0f 85 3b ff ff
>   RSP: 0018:ffff88802665fc68 EFLAGS: 00010246
>   RAX: 0000000000000000 RBX: ffff88804a13b800 RCX: ad381de3b3cd5e00
>   RDX: 1ffff11004ccbf38 RSI: 0000000000000008 RDI: ffff88802665f9e0
>   RBP: ffff88804fb25000 R08: ffff88802665f9e7 R09: 1ffff11004ccbf3c
>   R10: dffffc0000000000 R11: ffffed1004ccbf3d R12: 0000000000001950
>   R13: ffff88804ab80000 R14: ffff888021d22640 R15: ffff88802665fcb0
>   FS:  0000000000000000(0000) GS:ffff88806d200000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000000000014 CR3: 0000000004ebc000 CR4: 00000000000006f0
> 
> Signed-off-by: Yuxuan Hu <yuxuanhu@buaa.edu.cn>

Also, please provide here Fixes, Cc:stable and Closes tags.

Best regards,
Krzysztof


