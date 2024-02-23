Return-Path: <linux-kernel+bounces-78687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D78861758
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9CB51C23AF9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5933D84FA6;
	Fri, 23 Feb 2024 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2uV+eDd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC5A8562E;
	Fri, 23 Feb 2024 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704837; cv=none; b=Mxch4dpj5a7Dl7aQFOqbE6BsaXmyvDZlk5x6599OEH5gugrkjA7Gimwjach4psiQSzkG3q+/gCPM6mF0KTKykzFL0sUcWIqBhBGaAhmtb3e4KgDDONHBDOa8zvrw8GuvPIoby2JYc0JaKy1834NpssLBNjDLh2Fbn348lvUxg0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704837; c=relaxed/simple;
	bh=u7uC2Lv5Wh7Eg5arLbl/WySIY4U6vAGqpGlwxxOfo5c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TTzVUUqXSe+OhU/KvJOvGyXEb5e308rqD+Oac34lSqor6zZ4zx7i08nel3gGnfP5ZIStYwNVrm/msR+LhD/L9Fu9ftDoVosOjUIpHQ3MSH4aFya9NefBpxUOK/eg1+JdlahLyrZqfroH5taKO8rbV1VkkGTeAulHLEe4jhkl2ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2uV+eDd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93387C433F1;
	Fri, 23 Feb 2024 16:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708704836;
	bh=u7uC2Lv5Wh7Eg5arLbl/WySIY4U6vAGqpGlwxxOfo5c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=e2uV+eDdq5qpWNjm5ThB2Bg74MMCU8vge71SGWXCj8ULyKT5H1uNw5+UxOiGNq5kc
	 kF+uMZEIL6t1wU8buwvF2Ttn7Q7zu7PqvepdViZy1pyQSbbbm8gGgda9MoWOohzDOr
	 e+ZGYms985zf47bSO1uOTTzhjfDL/RH/b0QC/EoMWPKFnkmS/fJ21FWvYUJPoGNki/
	 3KPhsca0rTTIiupqpdwu41U6RchezfkaiktPxBj94Rp85yBzWhvZL6GBPcFRJ1YgfR
	 Iod2fF+oefjbS+XAF12MnjwS6ESdEIU//GVPHZbwCWc04fdZRtMhZeOvUEwINrSaGb
	 ngPRdOvDS9T1g==
From: Lee Jones <lee@kernel.org>
To: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ond=C5=99ej_Jirman?= <megi@xff.cz>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Raymond Hackley <raymondhackley@protonmail.com>, 
 Luca Weiss <luca@z3ntu.xyz>, linux-leds@vger.kernel.org
In-Reply-To: <20240217191133.1757553-1-megi@xff.cz>
References: <20240217191133.1757553-1-megi@xff.cz>
Subject: Re: (subset) [PATCH] leds: sgm3140: Add missing timer cleanup and
 flash gpio control
Message-Id: <170870483433.1732693.11627947942452126304.b4-ty@kernel.org>
Date: Fri, 23 Feb 2024 16:13:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Sat, 17 Feb 2024 20:11:30 +0100, Ondřej Jirman wrote:
> Enabling strobe and then setting brightness to 0 causes the driver to enter
> invalid state after strobe end timer fires. We should cancel strobe mode
> resources when changing brightness (aka torch mode).
> 
> 

Applied, thanks!

[1/1] leds: sgm3140: Add missing timer cleanup and flash gpio control
      commit: 3e7b2b9309cd3eb1b82121b8a978d2dd19301924

--
Lee Jones [李琼斯]


