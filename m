Return-Path: <linux-kernel+bounces-156441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 662028B02D3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6E05B20FF3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC85F157A6B;
	Wed, 24 Apr 2024 07:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6sjQLiN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F371315442D;
	Wed, 24 Apr 2024 07:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713942215; cv=none; b=WE9IkW5M+wI5BZDrUCJl/7VhH2olLQZfeMvJBY7RS1SwLSQicd5HlZhE7chgVeaG3vKhdod+ZN4hZTnEzduLY8QyrmTOm4NvKZnNPAX1TdZ3q7Jjcw6T6GFOp6Fxo1sQmhM63T156BUjuC1xfqX+HFzLldVNWeSkKw8C9NFnmYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713942215; c=relaxed/simple;
	bh=VdK8Fuzd/eYU2FHWOzvzIXTwl7D2F6yWLkUOsvGwFSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UV7JZHg5ut2mVfvTMjgyoAWjZEdgr+n6d6i+zY/2aZrC+/A3ipVYgsHEN6usM96qXZu4WApUqqSn1deJacWlStCOphkRY22UlqVlXPLBI2Bkhf+aZFq1Wu5Tc2ulJNT60LcFR+ZbGTtOqPXJtL2CmLyU9hEzy/x0QL0OgZzA5Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6sjQLiN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F015C113CE;
	Wed, 24 Apr 2024 07:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713942214;
	bh=VdK8Fuzd/eYU2FHWOzvzIXTwl7D2F6yWLkUOsvGwFSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H6sjQLiNYE34dpjw/kyqceO8MU+Yrdzy9ZYgThdr0DNfKUhAeF4i7SBiEb6LjlFfd
	 AN3AMukrTFLph/AQsL1Dk3xSMHoggcbH32/UZP0lxpj/X6J4morHHyPIEM2MVnH1N0
	 s1HQ0jWJAyeQW3qHeXxaVbMnBZLwvtZ3rrAad+1NWmykk6aIXqudZ9jqTShb/PZX0g
	 U5jPs12w39/la+LQ8uiNcVvFZVrU3B3/4v7rbgUUT85CQ609i1I1tsLO/CI7cF2liL
	 pWPyCmBSARuPchROm2eKsw00kZgDn9DrDJyyC5XljF3xiioQsLbRAJjZDFdgm/+wFP
	 4gUHLLssdHlIg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rzWfE-0000000009x-3KM7;
	Wed, 24 Apr 2024 09:03:32 +0200
Date: Wed, 24 Apr 2024 09:03:32 +0200
From: Johan Hovold <johan@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: HID: i2c-hid: elan: add Elan eKTH5015M
Message-ID: <ZiiuxI3GfJQIjxAG@hovoldconsulting.com>
References: <20240423134611.31979-1-johan+linaro@kernel.org>
 <20240423134611.31979-3-johan+linaro@kernel.org>
 <1dc47644-56c9-4fdc-80cf-756cf4cea54c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dc47644-56c9-4fdc-80cf-756cf4cea54c@linaro.org>

On Tue, Apr 23, 2024 at 06:24:39PM +0200, Krzysztof Kozlowski wrote:
> On 23/04/2024 15:46, Johan Hovold wrote:
 
> >  properties:
> >    compatible:
> > -    items:
> > -      - const: elan,ekth6915
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - elan,ekth5015m
> > +          - const: elan,ekth6915
> > +      - items:
> 
> Don't re-add the items for this entry. Just const.

Sure. But note that the example schema uses 'items' like this (e.g. for
'compatible' and 'clock-names'):

	https://docs.kernel.org/devicetree/bindings/writing-schema.html#annotated-example-schema

Johan

