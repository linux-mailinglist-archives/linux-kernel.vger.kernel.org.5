Return-Path: <linux-kernel+bounces-140297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 187E48A1264
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F202830C7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFB71474AA;
	Thu, 11 Apr 2024 10:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGBKyPZg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BEA146591;
	Thu, 11 Apr 2024 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833173; cv=none; b=fAh5MU37W0kCnw+AiiahGIzkWZT/jdyOqlYe9Y1UuP+X3bnbvKGiucWBUwZmqPuX/a3ZLG3ThWtiKyQa92dDPF1R0n2p8pNrA7mxLjQbDfytlRVKb1AY1odHqBGlqRPekkVvK5VFUTmTCTSxKVuOFv5Wa6RdhgGmSmvPWjLF2RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833173; c=relaxed/simple;
	bh=LkE30NYpF2o7SzMeclAi3/U/CTniH0WkbJ93S02QeA0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MsWlbbVUdRLccQcclHQVdmG3dJ9gTitHLsjGxBIyqh44qK8/qPJnBHuxMVruv1tc9Y9bgy3SR6xsj4XKOpSHmX+H6LuK3q3lDtMgSUcfcfJpkPkD2yPkL8y1+7oihtK/XFVJq7WqTki1cvF64QetfIGI4DlofOPVOPYQM5jYKCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGBKyPZg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4060EC433F1;
	Thu, 11 Apr 2024 10:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712833173;
	bh=LkE30NYpF2o7SzMeclAi3/U/CTniH0WkbJ93S02QeA0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gGBKyPZg2EGppsuNECaD/GTUmKioTdwoKkTNmfQ7J3oVUmZCmjO+iH0LpL3sf+8Mr
	 qP/aFOWv3XVKTResT+dB1cSh4JlbWr3XaKhee1RkuJokwVQAuwGsjE9+tRvjtkNCLy
	 e9XS6aeJS3Y157UZSz5mw+OsRLInbvhILiEK3cO8vzy+814949nkxJ50eB/TrtSGQp
	 1LrcnqKZ2yq0dN4K0G7Pd7bbrGoqQftimQbkxTqV/WxUDqqsLTQRcwfGSzD+8E/45M
	 B4dZaw77nS8JUzNuLOnMPfMA58i/n5EbuPHc4SI5nkcNy2seLg3JhP3qhy130nDARB
	 lZV8PlmZ8NSIA==
From: Lee Jones <lee@kernel.org>
To: andy.shevchenko@gmail.com, pavel@ucw.cz, lee@kernel.org, 
 vadimp@nvidia.com, christophe.leroy@csgroup.eu, hdegoede@redhat.com, 
 mazziesaccount@gmail.com, peterz@infradead.org, mingo@redhat.com, 
 will@kernel.org, longman@redhat.com, boqun.feng@gmail.com, 
 nikitos.tr@gmail.com, kabel@kernel.org, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 George Stark <gnstark@salutedevices.com>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@salutedevices.com
In-Reply-To: <20240314201856.1991899-1-gnstark@salutedevices.com>
References: <20240314201856.1991899-1-gnstark@salutedevices.com>
Subject: Re: [PATCH v7 0/8] devm_led_classdev_register() usage problem
Message-Id: <171283316999.2296003.5529877568304975347.b4-ty@kernel.org>
Date: Thu, 11 Apr 2024 11:59:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Thu, 14 Mar 2024 23:18:48 +0300, George Stark wrote:
> This patch series fixes the problem of devm_led_classdev_register misusing.
> 
> The basic problem is described in [1]. Shortly when devm_led_classdev_register()
> is used then led_classdev_unregister() called after driver's remove() callback.
> led_classdev_unregister() calls driver's brightness_set callback and that callback
> may use resources which were destroyed already in driver's remove().
> 
> [...]

Applied, thanks!

[1/8] locking/mutex: introduce devm_mutex_init()
      commit: c1a17857f8e333aa597ce0099c8728888e0c5037
[2/8] leds: aw2013: use devm API to cleanup module's resources
      commit: aa2fb50d9f17185e799a5969d0d357842d07450b
[3/8] leds: aw200xx: use devm API to cleanup module's resources
      commit: 517d9d3c408369cfa552652ac06294410c570095
[4/8] leds: lp3952: use devm API to cleanup module's resources
      commit: f8cf710c971e021e5ca39832adde32dfa241e081
[5/8] leds: lm3532: use devm API to cleanup module's resources
      commit: d265d86a2725e38c4f13ef79fc4e685b7234e7a3
[6/8] leds: nic78bx: use devm API to cleanup module's resources
      commit: 917676a8961e18e4dd5b17411317e3261473762a
[7/8] leds: mlxreg: use devm_mutex_init() for mutex initialization
      commit: 0548081cb25fbd0eb3a605cb6647dd166368da32
[8/8] leds: an30259a: use devm_mutex_init() for mutex initialization
      commit: c898cf6eb464d4172c79e925ea4d8007e856e10c

--
Lee Jones [李琼斯]


