Return-Path: <linux-kernel+bounces-97717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58037876E5F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 02:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37F941C2088E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 01:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B7315B1;
	Sat,  9 Mar 2024 01:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okwEMuhw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD4DA29;
	Sat,  9 Mar 2024 01:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709946438; cv=none; b=ARTQhqcsAVKd7lKX/cdYtsi+AmOYq2e1ouj1h1+WyQsxlYstG6vFA3QEIDloRdd+TXkXVUpHCX6mr3MQzG5ycxkupe8eUuXOnskxflAO8/wlSUN7U5hJ+dTwVBbj+bn7o2Te/07lqmigt0AfOvbTXBezERQTRAPH/pg65FIe1+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709946438; c=relaxed/simple;
	bh=0d4/5dhHEz7FfRUlkbZpqy7jl9lAa4LKfgGn/enTyDY=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=kQIGOB1mzUZRf+7lZEn4f+PY6W8v/VfixEXPjaRvoa0tAQr7xVZuZOaLDWCNot0yscpZKwoITMdohzVTkxa+NVnr22VsidfZSrY9/Jur606rC0ig43oYKpPi+nSL1VfA2gzVuulpe31laK3gbj2QktndM8N9hxKEku3ZwTdaPIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okwEMuhw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70763C433C7;
	Sat,  9 Mar 2024 01:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709946437;
	bh=0d4/5dhHEz7FfRUlkbZpqy7jl9lAa4LKfgGn/enTyDY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=okwEMuhwqWPWKj7Bc/eTONvUO68oDHT6bA9A/EEuJ4W8wiU2iPiJXKiEJ90LBKz+r
	 ESNK6uHoV/xvslVXrTjdnpaaG+YUP9zKn/2h016cu2PcGA9x2uQOjqDyz+SA3Z2szx
	 eahM5W3gv/xPZH+F1q6IxeocqC7FafFIAhZd0EK3PP9IaX1X67WuAptJgSJioVvOMw
	 4pru9/FIBrMIlfgR/FX7OujJTHjgCJVVxtJdhtw1HXbte11WCvHBwvNH98f1M7UaXF
	 WOWqummPJl7rJmbzWhRXCJ0QGrhr98oh3n2Tzqk5BwZONYGmx6uYbD9XDDFXzI+I/2
	 edcLpGE3H5hWw==
Message-ID: <8c56e786b692bf9400c7f66b5d3e17b0.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240303120732.240355-1-andy.shevchenko@gmail.com>
References: <20240303120732.240355-1-andy.shevchenko@gmail.com>
Subject: Re: [PATCH v1 1/1] clk: fractional-divider: Use bit operations consistently
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 08 Mar 2024 17:07:15 -0800
User-Agent: alot/0.10

Quoting Andy Shevchenko (2024-03-03 04:07:32)
> Use BIT() where makes sense. This alings usage of bit operations
> in the same pieces of code. Moreover, strictly speaking by the
> letter of the C standard, left shift of 1 by 31 bits is UB (undefined
> behaviour), switching to BIT() addresses that as well.
>=20
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---

Applied to clk-next

