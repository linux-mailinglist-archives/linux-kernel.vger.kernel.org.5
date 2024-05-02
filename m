Return-Path: <linux-kernel+bounces-166995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F03F8BA315
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BD981C21A85
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DC257CB5;
	Thu,  2 May 2024 22:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYZzqwa9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88F957CA1;
	Thu,  2 May 2024 22:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714688674; cv=none; b=FBcmFjynVbRCssImzYLg/iIjac9kbGX997JS7MfeQLtm9RVAonF1uCfyD7AUzl4sYxfwPTeZjwUDsFn2PVVKamju4I3z6lmXSDEziI2C/Hqpvw5fKtpmx1Xnt/xrVORFZDzJvcUeNHURmJxqWnEgvv22svBw0Jwp3cCsuz9E0Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714688674; c=relaxed/simple;
	bh=m5C4VvNJit1RDhJf8i/dqNorHaLtupPY9uTZKx4YgMk=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=TFe4A69hjja9/V5ngbC0nXo9itjCSt9TYTXZ9isyr4fTFWl5mAsLVGu7uOkZ9XVIOV7/ybQ94mA4pQmk2lKuYlXP2roQzeBJ+MzHkEpKJDR6G6eZ17ur9rpQ93p8OO+HGxGTw9fMZ9gNJFklp+gwBBiMprrv60UTRbS1Hcza+bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYZzqwa9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695BBC113CC;
	Thu,  2 May 2024 22:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714688673;
	bh=m5C4VvNJit1RDhJf8i/dqNorHaLtupPY9uTZKx4YgMk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=uYZzqwa9Si6ERcU4prohokGVGpCgcznEp7GWeOlppK/Pq6cLNoYar7f5z/7Eji7wC
	 ZuFbIRLT8BpVa1uQFffLCfDeHirKHm3ta7WsrjmCDWK9TEbJIsLCIp2kUkVBsn9241
	 uA+JuA4cAVd2yDpaENSWAxA0mIaetVR/7c9Xm5Cbe49ZfvifLYP/bU3KLeKh+UoANA
	 9kPSz2qAZhlYg6Wp1829y7tJOI2rw46hUbQ4ax7zH8ucADbeI+Y8LzHQ8WRnaekS6N
	 Hb2EnjgiiswInjoZa9HOkGqHXvT/Z+NtlmyNxxdw0bss/ux1XgYfqp6ydZpNryL9Je
	 jwQr8PP5y0qcQ==
Message-ID: <a88f34f36ef5ad8fbcb1343a9ce79823.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <dba8658a-f13f-4fde-b610-57a391b0a1c2@moroto.mountain>
References: <53c31752-c8a2-4098-837e-2f84f03c8748@moroto.mountain> <0d26a80d9b595954aabd8f6c6e18c710.sboyd@kernel.org> <dba8658a-f13f-4fde-b610-57a391b0a1c2@moroto.mountain>
Subject: Re: [PATCH] spmi: pmic-arb: Fix of_irq_get_byname() error checking
From: Stephen Boyd <sboyd@kernel.org>
Cc: Abel Vesa <abel.vesa@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
To: Dan Carpenter <dan.carpenter@linaro.org>
Date: Thu, 02 May 2024 15:24:31 -0700
User-Agent: alot/0.10

Quoting Dan Carpenter (2024-05-02 00:08:29)
> On Wed, May 01, 2024 at 05:55:03PM -0700, Stephen Boyd wrote:
> > Quoting Dan Carpenter (2024-04-24 04:42:46)
> > > There are two bugs in this code:
> > > 1)  The "irq" variable needs to be signed for the error handling to
> > >     work.
> > > 2) The of_irq_get_byname() also returns zero on error so change the
> > >    comparison from < 0 to <=3D 0.
> > >=20
> > > Fixes: 932282f154ac ("spmi: pmic-arb: Register controller for bus ins=
tead of arbiter")
> >=20
> > Sadly this isn't stable because I just send patches over email.
> >=20
>=20
> If you're going to send these as email then you should fold it into the
> original commit or otherwise people will be confused.

I removed the fixes tag. I will fold it in with your SoB, thanks!

