Return-Path: <linux-kernel+bounces-1126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7911814ADD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7625B1F23907
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507E4358A8;
	Fri, 15 Dec 2023 14:42:49 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359F4347D1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b687c3.dsl.pool.telekom.hu [::ffff:81.182.135.195])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000718F7.00000000657C65E3.0012E612; Fri, 15 Dec 2023 15:42:43 +0100
Message-ID: <f135963cb14d9bef6cddbe0bd1ce0aaa6d4ac7d9.camel@irl.hu>
Subject: Re: [PATCH 03/16] ASoC: tas2781: disable regmap regcache
From: Gergo Koteles <soyer@irl.hu>
To: Mark Brown <broonie@kernel.org>
Cc: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
  linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Date: Fri, 15 Dec 2023 15:42:43 +0100
In-Reply-To: <5b2eb7eb-761e-406d-8d55-b7ea8cddefa8@sirena.org.uk>
References: <cover.1701906455.git.soyer@irl.hu>
	 <21a183b5a08cb23b193af78d4b1114cc59419272.1701906455.git.soyer@irl.hu>
	 <0b836c10-b21b-4275-8dd0-254dd5467497@sirena.org.uk>
	 <47097f19398808b64f4cc87c2a3c7cc462fb2416.camel@irl.hu>
	 <5f3f0306-799f-4f3b-9e05-fbd300c59d5d@sirena.org.uk>
	 <b0ab21657f2e4f0825579de97ca012e294d1e743.camel@irl.hu>
	 <bf24488f-e4e1-4d3e-a67e-fe74c05acda4@sirena.org.uk>
	 <9a2b85a8a19e002093e2471a97850d26e335900f.camel@irl.hu>
	 <5b2eb7eb-761e-406d-8d55-b7ea8cddefa8@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-15 at 12:55 +0000, Mark Brown wrote:
> On Fri, Dec 15, 2023 at 02:17:01AM +0100, Gergo Koteles wrote:
> > On Thu, 2023-12-07 at 22:39 +0000, Mark Brown wrote:
> > > On Thu, Dec 07, 2023 at 10:12:13PM +0100, Gergo Koteles wrote:
> > > > On Thu, 2023-12-07 at 20:36 +0000, Mark Brown wrote:
>=20
> > > > > The code creates the impression that writing to one tas2781 write=
s to
> > > > > all of them, is that not the case?
>=20
> > > > Yes, the tasdevice_* functions, but the regcache_sync doesn't know
> > > > this.
>=20
> > > So this syncing is done in software not hardware?  My understanding w=
as
> > > that this was a hardware thing.
>=20
> > If you mean that the amplifier does not know that there are several
> > programs or configurations or profiles, but only runs the current one,
> > yes.
>=20
> No, I mean that the amplifiers don't talk to each other at a hardware
> level and the grouping is all in software.

No, they don't talk to each other. But they have a global i2c address
to speed up configuration, but the module doesn't use it yet.


