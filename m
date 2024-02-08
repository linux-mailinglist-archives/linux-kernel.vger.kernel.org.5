Return-Path: <linux-kernel+bounces-58211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4916984E2C7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05BA2287111
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C2B7869D;
	Thu,  8 Feb 2024 14:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7U4hszY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BCB7640A;
	Thu,  8 Feb 2024 14:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707401076; cv=none; b=J7qQKflWvqlrclfFBi4Jy8VLYF+RYTl1Cw+QincI2bVu00pWmHT4ZFTcPJeiieK0tP9dm4zi0Z7j331+v6RRqsO3WtqONxpIv1PjWeObexRxonxZzUtOVAcwOlAVZ35veL/o0/4QtT61QWibE9ufEKnFED362D6HhKBMzfrNK7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707401076; c=relaxed/simple;
	bh=2hms3TPwr8f/X4oq2c4MaDQ1qmoGBSzkbH2R7hmgcsQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n5bLHOPPitnZ3UahOx/vPTIpuHQf+bjnQtQmUQpOueIPaGrZd0bKbg2nhD8ajifPBmRbDA6w6lrK1B50iZ0zXCndOk51fa6YgPqOKxZzGEJmZKDET0miSxfxVjC4K4WMXtu+3aC9WCXJbCpl6uLpP57dLlTjEPhIH+InW6dAhv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7U4hszY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8CEC433F1;
	Thu,  8 Feb 2024 14:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707401076;
	bh=2hms3TPwr8f/X4oq2c4MaDQ1qmoGBSzkbH2R7hmgcsQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=X7U4hszYYIGuPdTJiWEfdww+3wccTo4vUAcwy/kRbUjPmJRy8C0bAttEpTo66YDsI
	 KcJtQufUqI6EGMANuhxHo2Hua1CbyXozK8VwL4Z4/z/aH/LiiEg65OS5TnUze4z4up
	 3ufLPaHOuPFzVceNuQfWkApK2h0SAyKo7N0fuVtUdqHMT33kYXIwqC9EmqczjD0WNN
	 acG19aft04xQdpM9z3b0C4ShtpWPqMQMU//1z4LDORfk75zMDbQefcaXtI9KmBv9dI
	 6uSsvXPIoz8/NE+JbYAUrqyo6DEPAEY8EeXImy1klrWh93iu5AzvK8WY+w6cUUD0tY
	 7Q/xtCg2c8Kwg==
From: Lee Jones <lee@kernel.org>
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Daniel Golle <daniel@makrotopia.org>, Li Zetao <lizetao1@huawei.com>, 
 linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Christian Marangi <ansuelsmth@gmail.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20240203235413.1146-1-ansuelsmth@gmail.com>
References: <20240203235413.1146-1-ansuelsmth@gmail.com>
Subject: Re: (subset) [PATCH] leds: trigger: netdev: Fix kernel panic on
 interface rename trig notify
Message-Id: <170740107363.1051506.1320961736541911295.b4-ty@kernel.org>
Date: Thu, 08 Feb 2024 14:04:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Sun, 04 Feb 2024 00:54:01 +0100, Christian Marangi wrote:
> Commit d5e01266e7f5 ("leds: trigger: netdev: add additional specific link
> speed mode") in the various changes, reworked the way to set the LINKUP
> mode in commit cee4bd16c319 ("leds: trigger: netdev: Recheck
> NETDEV_LED_MODE_LINKUP on dev rename") and moved it to a generic function.
> 
> This changed the logic where, in the previous implementation the dev
> from the trigger event was used to check if the carrier was ok, but in
> the new implementation with the generic function, the dev in
> trigger_data is used instead.
> 
> [...]

Applied, thanks!

[1/1] leds: trigger: netdev: Fix kernel panic on interface rename trig notify
      commit: db36d7d45d191879ec4dd1535fbf04ee4ac28711

--
Lee Jones [李琼斯]


