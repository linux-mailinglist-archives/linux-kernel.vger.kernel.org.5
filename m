Return-Path: <linux-kernel+bounces-143722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A118A3CA3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 13:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABFE02819E8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 11:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C273F9FB;
	Sat, 13 Apr 2024 11:32:38 +0000 (UTC)
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BAA14265;
	Sat, 13 Apr 2024 11:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713007958; cv=none; b=Kan3Lj4VOHDxpkKMVitNao/S/5RRm9eMYxK+12BXYnD6NoFgBsAHSMJlUGbD+tAMdvsxkee/BWDn1pldgvobeprg9ZI1S8HbjLmDiM4NBD2AxuwsJmfM8IKvqbmZPadp9hq2t7m2F38yCYOmaT12UmT8rjjGjjHpW47c8f7CR2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713007958; c=relaxed/simple;
	bh=Z/ckyqGb+pytaMUSxcubIfiijffJM/OYK5XFNgCxCYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEgXPAxWZX9N5/UGBkNETk8boqK4/RQKha1WjdbPvmJscrLlM+/W0BM2sp9aug/tshkCmTs/AjhiWzE/PFG52Gt1b40/l4N6lcWKYAVypKsO7xsDh9RFyfot5uuCGSKhRpu3xLzncD1cgJKFttv0YXfbNv0lcQfePjMePZ34J3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from localhost.localdomain (unknown [82.64.135.138])
	by smtp2-g21.free.fr (Postfix) with ESMTPS id 8D48B2003C1;
	Sat, 13 Apr 2024 13:32:24 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 35A0D40039; Sat, 13 Apr 2024 13:31:30 +0200 (CEST)
Date: Sat, 13 Apr 2024 13:31:29 +0200
From: Etienne Buira <etienne.buira@free.fr>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: brgl@bgdev.pl, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC][resend after bogus] gpio-syscon: do not report
 bogus error
Message-ID: <ZhptEWb7tD5pummq@Z926fQmE5jqhFMgp6>
Mail-Followup-To: Linus Walleij <linus.walleij@linaro.org>, brgl@bgdev.pl,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZhgDCKhcHdwGoJ4Y@Z926fQmE5jqhFMgp6>
 <CACRpkdbTdGajQLSGDkD0cWRG+79tpojYkdyF3t0jD7_WEDtQLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdbTdGajQLSGDkD0cWRG+79tpojYkdyF3t0jD7_WEDtQLw@mail.gmail.com>

On Fri, Apr 12, 2024 at 12:44:34PM +0200, Linus Walleij wrote:
> Hi Etienne,
> 
> thanks for your patch!
> 
> On Thu, Apr 11, 2024 at 5:35 PM Etienne Buira <etienne.buira@free.fr> wrote:
> 
> > Do not call dev_err when gpio,syscon-dev is not set albeit unneeded.
> > gpio-syscon is used with rk3328 chip, but this iomem region is
> > documented in
> > Documentation/devicetree/bindings/gpio/rockchip,rk3328-grf-gpio.yaml and
> > does not look like to require gpio,syscon-dev setting.
> >
> > Signed-off-by: Etienne Buira <etienne.buira@free.fr>
> > X-Prefers: kind explanations over rotten tomatoes
./..
> So indeed the parent is a sycon, and syscon_node_to_regmap(np->parent) will
> be used to populate priv->syscon on RK3328.
./..
> if (!has_parent_syscon) {
> (...)
> 
> What do you think about this?
./..

Hi Linus,

Thanks for your review.

IIUC, that would prevent calling dev_err() if, for example,
gpio,syscon-dev were forgotten from
arch/arm/boot/dts/ti/keystone/keystone-k2g.dtsi, dspgpio0 node although
it is needed and would result in funny things without notice.

Thinking twice about it, a cleaner way looks to add gpio,syscon-dev node
to rk3328.dtsi. I'll send the one-liner to relevant people (that would
be really easier if there were only one repo, with different
branches...).

Do you agree?

Regards.

Note: I'm not subscribed to list, so please To or CC me.


