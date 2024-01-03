Return-Path: <linux-kernel+bounces-15505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40210822CDE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 650221C234E8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D616199CB;
	Wed,  3 Jan 2024 12:20:17 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFBB199BF;
	Wed,  3 Jan 2024 12:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id C707428144;
	Wed,  3 Jan 2024 13:20:09 +0100 (CET)
Date: Wed, 3 Jan 2024 13:20:05 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: pratikmanvar09@gmail.com
Cc: francesco@dolcini.it, festevam@gmail.com, jun.li@nxp.com,
	kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
	pratik.manvar@ifm.com, s.hauer@pengutronix.de, shawnguo@kernel.org,
	thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
	xiaoning.wang@nxp.com
Subject: Re: [PATCH v3] pwm: imx27: workaround of the pwm output bug
Message-ID: <20240103122005.GA3347@francesco-nb>
References: <20240103103421.GA3758@francesco-nb>
 <20240103110200.1018-1-pratikmanvar09@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103110200.1018-1-pratikmanvar09@gmail.com>

Hello Pratik,

On Wed, Jan 03, 2024 at 04:32:00PM +0530, pratikmanvar09@gmail.com wrote:
> From: Clark Wang <xiaoning.wang@nxp.com>
> 
> This fixes the pwm output bug when decrease the duty cycle.
> This is a limited workaround for the PWM IP issue TKT0577206.
> 
> Root cause:
> When the SAR FIFO is empty, the new write value will be directly applied
> to SAR even the current period is not over.
> If the new SAR value is less than the old one, and the counter is
> greater than the new SAR value, the current period will not filp the
> level. This will result in a pulse with a duty cycle of 100%.
> 
> Workaround:
> Add an old value SAR write before updating the new duty cycle to SAR.
> This will keep the new value is always in a not empty fifo, and can be
> wait to update after a period finished.
> 
> Limitation:
> This workaround can only solve this issue when the PWM period is longer
> than 2us(or <500KHz).
> 
> Reviewed-by: Jun Li <jun.li@nxp.com>
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Link: https://github.com/nxp-imx/linux-imx/commit/16181cc4eee61d87cbaba0e5a479990507816317
> Tested-by: Pratik Manvar <pratik.manvar@ifm.com>
> Signed-off-by: Pratik Manvar <pratik.manvar@ifm.com>

A very similar patch was already send in 2021 [1], did it had review
comments not addressed? Please have a look.

In general please refrain from sending a new patch version every other
day, while every Linux kernel subsystem has different rules and a
difference pace of development, in this specific case sending a v3 just
adding your signed-off-by without allowing a little bit of time to wait
for more feedback is just not sane.

[1] https://lore.kernel.org/all/?q=dfn%3Adrivers%2Fpwm%2Fpwm-imx27.c+AND+b%3A%22Clark+Wang%22

Francesco


