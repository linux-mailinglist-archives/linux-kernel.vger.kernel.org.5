Return-Path: <linux-kernel+bounces-153888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F13A8AD481
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97902B223A4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428E4219E0;
	Mon, 22 Apr 2024 19:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vfo4C0Wh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2DC1552E5;
	Mon, 22 Apr 2024 19:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713812432; cv=none; b=t+LiGamu/tfw7Siejj6scGSfMjj2O4NvlsorRprJXNayy73EgEEy6xs6/+USEAtHqtFoxp/CT3WyyL5xzncgqZ7zL3B8qOmltzvgGea6gKYcYbfFtbTn0eIkxJ1EUZKSoAZxLnmJvLv00y5TASWLcg0uI9hz1D46ZUEKx14TdCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713812432; c=relaxed/simple;
	bh=+mgDa3JyuWBIzvRueoyVDThH6E0UIe85snistqOpadk=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=NynhrxoIOdxL8wi1kWvvWdteAhvu1VDtEbsvY8KauA/lK6cCv3DEO59sVyn0QDsPPRNLLm+NHwv8Dc6t8OhCC1u6e9NTYbry3kBGec2qoQF+ZL3FB3lANpH1gVT7paENL0uR7zRnxx5q09lQocC4l9Q1mMQx5evXyGWWettx37A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vfo4C0Wh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C59C113CC;
	Mon, 22 Apr 2024 19:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713812431;
	bh=+mgDa3JyuWBIzvRueoyVDThH6E0UIe85snistqOpadk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Vfo4C0Wh6KNOX/574RJSG5R4xEe+sVwM3NlhWjNosU+2wL9n6LLz4dIdac59SO7E1
	 XjI4HdPg1bCMWUm8b5CRzwhx7uHhP9B1sQDOMZdk3bGvrOFj0KqrpXHATA6lzkFnbo
	 h4e1Ip1US1fL4RsnWYiHC93EY4BpcoN488r4sVlqf1I05HZQb+VtggkWF2z7wNnwwr
	 42UGvzKDR24hpN21aQBncRR4QD5OXe6mkN7+flexFAgId6BwI42bo7xxJJHOf3+Ylb
	 epcYA/ETA7dRtExF0H1Jpyp8i61nLNdLtdWA6YRXwxhxTXgzjXwSP1s0zq5XQpXZ/e
	 IUBjiR4IYM9VQ==
Message-ID: <14430b872eff187b4a4c213f6db31e0a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240422080606.zai2sgr74o3dcasp@bogus>
References: <20240415163649.895268-1-cristian.marussi@arm.com> <6b8e12767fdfaf1ba819896fbd610733.sboyd@kernel.org> <20240422080606.zai2sgr74o3dcasp@bogus>
Subject: Re: [PATCH v3 0/5] Rework SCMI Clock driver clk_ops setup procedure
From: Stephen Boyd <sboyd@kernel.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, james.quinlan@broadcom.com, f.fainelli@gmail.com, vincent.guittot@linaro.org, peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com, quic_nkela@quicinc.com, souvik.chakravarty@arm.com, mturquette@baylibre.com
To: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 22 Apr 2024 12:00:27 -0700
User-Agent: alot/0.10

Quoting Sudeep Holla (2024-04-22 01:06:06)
> On Fri, Apr 19, 2024 at 07:08:54PM -0700, Stephen Boyd wrote:
> > Quoting Cristian Marussi (2024-04-15 09:36:44)
> > > Hi,
> > >=20
> > > a small series to review how the SCMI Clock driver chooses and sets u=
p the
> > > CLK operations to associate to a clock when registering with CLK fram=
ework.
> >=20
> > Did you want me to merge this through clk tree?
>=20
> I am fine either way. You add:
>=20
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>=20
> if you prefer to take it. Or else please provide your ack for me to
> take it via SCMI tree.
>=20

Ok I can take it then.

