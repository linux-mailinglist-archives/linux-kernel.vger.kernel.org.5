Return-Path: <linux-kernel+bounces-66917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB0A856391
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7981F25F4A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0F312DD80;
	Thu, 15 Feb 2024 12:45:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7202912BF1E
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001127; cv=none; b=IYxeVMUdV2EgUR2DQUdp+9UicEwtzUxy5otttWVFkPi1KVTISoT6E4P7UMizqk0AGZK78CcJZYU46UAnHGol2u2XXRpm6W6/2eZW4paYvxQR+RIrYEtlscWD3PvvuqiBR1cZK/NQgKtNc96u4d2ItjGfw8XwnBXju1RonpATyDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001127; c=relaxed/simple;
	bh=UzKmg5Hhf+KMfuB37xNJBpKPXOndS3x3f0mxLQwSk9Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CS05Q5oOQJ/GP+75cGp48tVOwMWdNNxW0GWTfpiuM2SALOxeTv5GHZIUXAPuej8m4s6RPJL46fvODLYXjapfmIPR5Yg4mTz1kAnZvV+rgm/ItHbScw2FxEd9M8oQAW6dbgAmzJKFZuGdsKiOjY2a0KR4tf7T1DenrTHa+lsiuJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rab7B-0003jZ-Iz; Thu, 15 Feb 2024 13:45:21 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rab77-000t5u-9s; Thu, 15 Feb 2024 13:45:17 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rab77-0007iB-0k;
	Thu, 15 Feb 2024 13:45:17 +0100
Message-ID: <8981ec7d30444d2127ee97f5c804f8837ae5c6ce.camel@pengutronix.de>
Subject: Re: [PATCH v3 2/4] reset: simple: add support for Sophgo SG2042
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
 chao.wei@sophgo.com,  conor@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 palmer@dabbelt.com,  paul.walmsley@sifive.com, robh+dt@kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org,  haijiao.liu@sophgo.com,
 xiaoguang.xing@sophgo.com, guoren@kernel.org,  jszhang@kernel.org,
 inochiama@outlook.com
Cc: Chen Wang <unicorn_wang@outlook.com>
Date: Thu, 15 Feb 2024 13:45:17 +0100
In-Reply-To: <1cfd7b3ba447942784c4f7aa595e962399e9f617.1706577450.git.unicorn_wang@outlook.com>
References: <cover.1706577450.git.unicorn_wang@outlook.com>
	 <1cfd7b3ba447942784c4f7aa595e962399e9f617.1706577450.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Di, 2024-01-30 at 09:50 +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
>=20
> Reuse reset-simple driver for the Sophgo SG2042 reset generator.
>=20
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp


