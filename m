Return-Path: <linux-kernel+bounces-106381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC4087ED9D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4281C21935
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5D354BFA;
	Mon, 18 Mar 2024 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQJgdcVa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC3954760;
	Mon, 18 Mar 2024 16:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710779685; cv=none; b=hz9yIIfnMPg9x7jEzf8GvW9SKvD6jnZKY4BTYBtWuISizBJBv+7QbM20Cz/9L/R0q93c/g6I3a9JsYMx94ahZiXux7d5iZld0voNL6DDzIoITDfzuCmPoSOn0BUoylljoccxna1xbKhGuzMiVoyySfFh1TGmrcp7/dwvbj0lhFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710779685; c=relaxed/simple;
	bh=jt/sOoOzj0a59OXvgu+Bf8PPmNVWQEkERkh0u3TimXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGqxfxKz9JhK3jG5q7NhpTJblBD6MFBvvH3MvGAmlszp59Rh3Rq5WKYt0e049enJKbNlIGBmnB+JHIXQOm2qS63wRTExRsbk6h2TBp/GIvp7y21hA7JBpmvmhZ9ZQsYv2mK5JJ7kC7aiSHZ7V/ids1+Gb4e4nGFambU3/UYbD7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQJgdcVa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFA9C433C7;
	Mon, 18 Mar 2024 16:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710779684;
	bh=jt/sOoOzj0a59OXvgu+Bf8PPmNVWQEkERkh0u3TimXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mQJgdcVa5Z/a9TsWkbwMrJ6UUhgpVmB6zeYC3joMYxAGhyyNapKgPZ1GtN5Qs15oQ
	 KKJ1TYve31MsC6UDDoqVxSR+/KJTdL7+6zP9vrP7jNCBLgDDKRjaKxktazMCj7s7F9
	 fsWZkzT/HK6jSmCVRgtUfau3KwQcpEHefQJhk9yobVV8Er7XqTVtYYmU2Z5SHJ50NW
	 ghGekwJtua3ofo1dbntAC49ZVmACcAyjfaOCXOfVgOGv3MgcxuiN/QciwCbNRBEx82
	 xteZwwjB8wtfsq51rRzD4eu8flbOxawuL4vtU8s4JLfAbpGWFFDm38pVchhipdA3Iq
	 F/jUzMg4WC+JA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rmFwo-000000003Jy-35AB;
	Mon, 18 Mar 2024 17:34:50 +0100
Date: Mon, 18 Mar 2024 17:34:50 +0100
From: Johan Hovold <johan@kernel.org>
To: Doug Anderson <dianders@google.com>, Rob Herring <robh@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: bluetooth: add new wcn3991
 compatible to fix bd_addr
Message-ID: <ZfhtKpwzt9ukOL6J@hovoldconsulting.com>
References: <20240318110855.31954-1-johan+linaro@kernel.org>
 <20240318110855.31954-2-johan+linaro@kernel.org>
 <CAA8EJprywWbdoyfAbys=0WzEdAkp0UK1fzzCPzxKRjyk9DrC6Q@mail.gmail.com>
 <Zfg--2_NMPSPTxK-@hovoldconsulting.com>
 <20240318144806.GA3963554-robh@kernel.org>
 <ZfhZffrZXwtKgZ13@hovoldconsulting.com>
 <CAD=FV=UpuD7Lq0DxSZAGpL4Mi2uxy9HNt3V3FZq7Y3p--gbMrg@mail.gmail.com>
 <CAD=FV=WCzrh926mkiyBnKRG_+KGuOkGN6v0DgPiXhQCD3PSQ9w@mail.gmail.com>
 <Zfhh-4wEg4O4Xqeu@hovoldconsulting.com>
 <CAD=FV=XpOf8ZcqROgwFX9bs7B1gNGDDVOYezBztLJEy6U3AOnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XpOf8ZcqROgwFX9bs7B1gNGDDVOYezBztLJEy6U3AOnA@mail.gmail.com>

On Mon, Mar 18, 2024 at 08:58:40AM -0700, Doug Anderson wrote:
> On Mon, Mar 18, 2024 at 8:47 AM Johan Hovold <johan@kernel.org> wrote:
> > On Mon, Mar 18, 2024 at 08:31:09AM -0700, Doug Anderson wrote:

> > Thanks for the details. Sounds like we could get away with adding a new
> > property for the broken firmware in this case, which should resolve this
> > nicely without having to deprecate anything.
> >
> > Could you carry such a devicetree patch out-of-tree until the firmware
> > has been fixed?
> 
> IMO we shouldn't try to fix the firmware at all. Given the fact that
> it took me a year to get a firmware uprev completed for one trogdor
> variant for fixes that actually had functional impact, it's possible
> we'll never actually get an uprev completed that includes this fix or
> it will happen years from now when nobody remembers about it. I'm also
> certain this whole issue will also cause a bunch of debugging over the
> years if we try to fix it in firmware like that. There are cases where
> people end up running with old firmware since the developer workflow
> doesn't automatically update it.
> 
> The handling should be added upstream and we should just accept that
> the trogdor firmware gets it backward.

Fair enough.

Rob, are you OK with adding a 'qcom,local-bd-address-broken' or
similarly named property to indicate that the boot firmware passes the
address in the wrong order?

I'd then add that property to sc7180-trogdor.dtsi in mainline.

Johan

