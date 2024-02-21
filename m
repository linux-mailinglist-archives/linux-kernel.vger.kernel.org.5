Return-Path: <linux-kernel+bounces-74820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E5585DBD9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8BF3B273BC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A8E7BB14;
	Wed, 21 Feb 2024 13:45:44 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6707BB02
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523143; cv=none; b=gi1d7qmt3ANfxAN8YzXZcO81LOR949nMLCAqwERx2EJhshPB9d7CGFCWsIcQMsd2hgEbmbZVfEzLZodoaPpsz9y26pysB4mUIQbHgQQWgvbHLmMnID1e3/kr/mIX9soacZvrPSHM+Sk0GZzOS+5iNbD57eVrwuQJdd61i8j0/9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523143; c=relaxed/simple;
	bh=juEouuUJ136A2uRyt4uiuxJPTi66X9k73J4uyYTWJ0A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PEHTynHKbq3VA3FCptG/r73VQpDyNyRUQFqYILbQOPY5TbXEfm+s8NVKPBSavwTXsIVDZpWghQ8k/MEpzFk9oYlO6jGlAvvYvbm/lYP0CsRe+g/O+7bA2zbyeE4PtPJMtuxB8sHm2s9SyzM9uedMYepnH+1bGSWtlJsjUViUOTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rcmud-0006fc-1G; Wed, 21 Feb 2024 14:45:27 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rcmub-0023Ct-Qm; Wed, 21 Feb 2024 14:45:25 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rcmub-0009z1-2Q;
	Wed, 21 Feb 2024 14:45:25 +0100
Message-ID: <8598dea60afa80effd7fad2650dc045bc36d0f0e.camel@pengutronix.de>
Subject: Re: [PATCH v2 20/20] media: venus: pm_helpers: Use reset_bulk API
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Stanimir Varbanov
 <stanimir.k.varbanov@gmail.com>, Vikash Garodia
 <quic_vgarodia@quicinc.com>,  Bryan O'Donoghue
 <bryan.odonoghue@linaro.org>, Andy Gross <agross@kernel.org>, Bjorn
 Andersson <andersson@kernel.org>,  Mauro Carvalho Chehab
 <mchehab@kernel.org>, Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, Stanimir Varbanov
	 <stanimir.varbanov@linaro.org>, Mauro Carvalho Chehab
	 <mchehab+huawei@kernel.org>, linux-media@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 21 Feb 2024 14:45:25 +0100
In-Reply-To: <466efa71-bd42-46b7-b81f-2a70d80e3f03@linaro.org>
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
	 <20230911-topic-mars-v2-20-3dac84b88c4b@linaro.org>
	 <a25224f5d28aa65e8bfd14fe0a8f599b9f9e3f40.camel@pengutronix.de>
	 <ad20b872-0b50-4a16-b342-582d2f33eeca@linaro.org>
	 <1cf19cf23ffd88d9ffb673e8f382f3b1d24545bb.camel@pengutronix.de>
	 <466efa71-bd42-46b7-b81f-2a70d80e3f03@linaro.org>
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

On Mi, 2024-02-21 at 14:37 +0100, Konrad Dybcio wrote:
> On 21.02.2024 14:34, Philipp Zabel wrote:
> > On Mi, 2024-02-14 at 22:20 +0100, Konrad Dybcio wrote:
> > > On 14.02.2024 14:31, Philipp Zabel wrote:
> > > > Hi Konrad,
> > > >=20
> > > > On Fr, 2024-02-09 at 22:10 +0100, Konrad Dybcio wrote:
> > > > > All of the resets are toggled together. Use the bulk api to save =
on some
> > > > > code complexity.
> > > > >=20
> > > > > The delay between resets is now correctly determined by the reset
> > > > > framework.
> > > >=20
> > > > If this is a recent change, could you reference the commit?
> > >=20
> > > It's a series that recently landed in -next [1]
> >=20
> > Missing link?
>=20
> Yes, sorry!
>=20
> Konrad
>=20
> [1] https://lore.kernel.org/linux-arm-msm/20240105-topic-venus_reset-v2-0=
-c37eba13b5ce@linaro.org/

Thank you. With that,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

