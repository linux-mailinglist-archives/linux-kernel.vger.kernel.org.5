Return-Path: <linux-kernel+bounces-91679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 542178714F1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FA10281383
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3852F40C04;
	Tue,  5 Mar 2024 04:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfp68Q5A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F863FB1B;
	Tue,  5 Mar 2024 04:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709613913; cv=none; b=ISI6H+Gpo7o/1MimjD4dcHhTZNaGGtagh+JHdPfpoBKXX0BVOjBSpfYsJzSV1bOLBV/4lrt6fQ8anzcBEWr9+YB1Lb0Wf7h4BydQYCjh8J7S+59hm0iaGHECT28w2bC9UZ6ita5njuV7VzY4wiR2Ju9chI4xqGOlZ4pCaxi7Uqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709613913; c=relaxed/simple;
	bh=o5AhRyVpm0MHjgXv5WZrKN6oDlqFXFlzf715iNFGFMk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ebh+7qG6RGE71e6MZOYQiaZAxy/zRcHP0fkuqutJnmfk5nAd08RnnDUXWULAEXpQXfr17Kt9W7fABZqDYq7E85ZkaXopomF1VmmF0nMKSz3zX+ahNQfTWqL6ofBp0HapOx/DQT9TQK8qMWC1yDKvaJU5POdU/5xKfncy/dVzvfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfp68Q5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90EFCC433C7;
	Tue,  5 Mar 2024 04:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709613913;
	bh=o5AhRyVpm0MHjgXv5WZrKN6oDlqFXFlzf715iNFGFMk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sfp68Q5AsHeQUYjxLzagHtpHSCDQydC4GK3K+i5MH5d3uu4swLsI17BDeEzEFP1EJ
	 w0n0b2aXUQMbemzIOgpVVvBtm4VLRZaJ5ME5Ca/0GYTCWXG7Aur14Qm2Ar8V/k2CNY
	 vULh5lejGfjfYfPDCjAFQYO/uKY9uH6tqAMNsAP+rHUltbPCXIiukCBde+ekDUr8ie
	 4LH7vMPszeRg1xg1DLcK52aIueTfFArk4obMWv07XQCkaA9k6D6iUTa1++l7kVTVh/
	 Wt/50EAaMga9hxOzlyfQVVfcRXrZPJ1CumeHpGZmOKDAVNw9H4BkYoevYlRhHtEYcc
	 kjA8arIT7bUIA==
Date: Mon, 4 Mar 2024 20:45:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Lena Wang (=?UTF-8?B?546L5aic?=)" <Lena.Wang@mediatek.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>, "dsahern@kernel.org"
 <dsahern@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "Shiming Cheng (=?UTF-8?B?5oiQ6K+X5piO?=)"
 <Shiming.Cheng@mediatek.com>
Subject: Re: [PATCH net v4] ipv6: fib6_rules: flush route cache when rule is
 changed
Message-ID: <20240304204511.2026a56b@kernel.org>
In-Reply-To: <09f2ab1b7946339da5092e10aa216e07c579c60b.camel@mediatek.com>
References: <09f2ab1b7946339da5092e10aa216e07c579c60b.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 1 Mar 2024 14:39:46 +0000 Lena Wang (=E7=8E=8B=E5=A8=9C) wrote:
> From: Shiming Cheng <shiming.cheng@mediatek.com>
>=20
> When rule policy is changed, ipv6 socket cache is not refreshed.
> The sock's skb still uses a outdated route cache and was sent to
> a wrong interface.
>=20
> To avoid this error we should update fib node's version when
> rule is changed. Then skb's route will be reroute checked as
> route cache version is already different with fib node version.
> The route cache is refreshed to match the latest rule.

Doesn't apply, please rebase on top of latest net/main.

