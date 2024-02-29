Return-Path: <linux-kernel+bounces-86041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 983B886BEDF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 283BDB24263
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE12036B01;
	Thu, 29 Feb 2024 02:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMlLiRWC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6A43612E;
	Thu, 29 Feb 2024 02:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709173237; cv=none; b=edkEY/PZCC7G3pjDs18rgrjaK0/+Y7f/B4wXxQE++SQNg2qilQs2rRXcaKP/IIUFF1iV5JEtPBcasyDkBcKVDT3m/uyDGp5kxJFatNXECkNp4TI9etVyaIBA5bMgOy2iiHHBTHMqHiLANhLnD5ESZUmo9XGu2THeU1VgV7qwRxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709173237; c=relaxed/simple;
	bh=ndHU4Gl3W3V+sGQ4tm5lbUz87+Cesf9e9pD+O9WP5iE=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=FUcGDf8v4MMThVVttn0jSi2aCsJ37Gr5TU5VSQWR5QHuBv0AoPuh1952oaG7RA04olnni+nyGBHTYVdG3XqPVgS6EpvgVrtDpdFBC5aal6MxrKDWsWB3ZqTktld9M0MfDuXCbYk9uSWR0e0K1rja5U2zfi3uClQay1YN66saixo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMlLiRWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA4CC433F1;
	Thu, 29 Feb 2024 02:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709173236;
	bh=ndHU4Gl3W3V+sGQ4tm5lbUz87+Cesf9e9pD+O9WP5iE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=SMlLiRWCRXf9UeJ6EIl+4DGlqM+J1wHQwlRmSRroWC4rI18MdpO6BkwgVtEfeOvna
	 uDTBbtJNi9BMgFzrHZRKPnPOSko+gCLz8ZJIV4gzqW7uC6+BfbLjj0EyH5RIRx0lgt
	 oPv23BBBaS9QnG/FQgO/walRsP+KSKy8HSjy4RlVwSCy6l2srhc3M4uLYMAp22OWrU
	 pdFmUCDGRiCNV6AdTI8u51/NYVb3bgdD1PK9k/dZF8gq6UflzQNysr6+dDwa8Fn7wt
	 m4VBBZm0js7S/RZhwabX3uFqqdmMse9BS0Ule8yJvbALIgnWVzmJExI1fec7z4Wz5E
	 bq7bmxQUUivVw==
Message-ID: <1d0baf6dbaa1c2ca6594f9a2bcade2c4.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZdcFuV0KQDXTH8L8@pluto>
References: <20240214183006.3403207-1-cristian.marussi@arm.com> <20240214183006.3403207-7-cristian.marussi@arm.com> <500e265eb7c6a03a40e0067c8806e059.sboyd@kernel.org> <ZdcFuV0KQDXTH8L8@pluto>
Subject: Re: [PATCH 6/7] clk: scmi: Allocate CLK operations dynamically
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, sudeep.holla@arm.com, james.quinlan@broadcom.com, f.fainelli@gmail.com, vincent.guittot@linaro.org, peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com, quic_nkela@quicinc.com, souvik.chakravarty@arm.com, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org
To: Cristian Marussi <cristian.marussi@arm.com>
Date: Wed, 28 Feb 2024 18:20:34 -0800
User-Agent: alot/0.10

Quoting Cristian Marussi (2024-02-22 00:28:41)
> On Wed, Feb 21, 2024 at 09:44:14PM -0800, Stephen Boyd wrote:
> >=20
> > It's not great to move these function pointer structs out of RO memory
> > to RW. I'm also not convinced that it's any better to construct them at
> > runtime. Isn't there a constant set of possible clk configurations? Or
> > why can't we simply add some failures to the clk_ops functions instead?
>=20
> Well, the real clock devices managed by the SCMI server can be a of

SCMI is a server!? :)

> varying nature and so the minimum set of possible clk configurations
> to cover will amount to all the possible combinations of supported ops
> regarding the specific clock properties (i.e. .set_parent / .set_rate /
> .enable / .get/set_duty_cycle / atomic_capability ... for now)...we
> simply cannot know in advance what the backend SCMI server is handling.
>=20
> These seemed to me too much in number (and growing) to be pre-allocated
> in all possible combinations. (and mostly wasted since you dont really
> probably use all combinations all the time)
>=20
> Moreover, SCMI latest spec now exposes some clock properties (or not) to
> be able avoid even sending an actual SCMI message that we know will be
> denied all the time; one option is that we return an error,, as you said,
> but what is the point (I thought) to provide at all a clk-callback that
> we know upfront will fail to be executed every time ? (and some consumer
> drivers have been reported by partners not to be happy with these errors)
>=20
> What I think could be optimized here instead, and I will try in the next
> respin, it is that now I am allocating one set of custom ops for each clo=
ck
> at the end, even if exactly the same ops are provided since the clock
> capabilities are the same; I could instead allocate dynamically and fill =
only
> one single set of ops for each distinct set of combinations, so as to avo=
id
> useless duplication and use only the miminum strict amount of RW memory
> needed.
>=20

Yes please don't allocate a clk_op per clk. And, please add these
answers to the commit text so that we know why it's not possible to know
all combinations or fail clk_ops calls.

