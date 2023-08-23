Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C26B785F14
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 20:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237991AbjHWSBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 14:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236766AbjHWSBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 14:01:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7040F10CC;
        Wed, 23 Aug 2023 11:01:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0359D61493;
        Wed, 23 Aug 2023 18:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171C7C433CB;
        Wed, 23 Aug 2023 18:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692813680;
        bh=e6v4G4jDId6hSaMFJ0Kx8OgZafHgAdprexUAH84vTj4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=dFsqugUGl0tq8Gl4euWZzkD93IAHJBfTd6WBCPx6rBdtKFjNK6oU+7ieeF09hHwh6
         NiJtkPHDdoObFrFepffIOZOsHVHGuNgFXnnCFspcKmtCwklnMlJsxtR5/TXdQUnLMk
         cJcbHeXlucaD9eXCQb+aBC38vu5xQcrjDDQ2jpEkwgUGrDIRQSrJkP0Gy5gL6uFZZB
         tYuPa2l/kZzaH9PrL12pHbMbTq70I4qfYguOyB6GGNSAXFAeggM5UgzmOrqiHOqEnS
         YlHQhCn+VHHFOqE6/Sb/S1wYzxefYWtN4ni2vu9cx7KfYxqzyhQzsgecmrkMTWPoiB
         oG4Af56/cKiow==
Message-ID: <a14cdd584283d32a3642658aaed6c98c.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZOXLNliOogkNyJYQ@e120937-lin>
References: <20230811161446.636253-1-cristian.marussi@arm.com> <20230811161446.636253-2-cristian.marussi@arm.com> <17bd83d833b59fd4f64eec433589fa55.sboyd@kernel.org> <ZOXLNliOogkNyJYQ@e120937-lin>
Subject: Re: [PATCH 1/6] firmware: arm_scmi: Simplify enable/disable Clock operations
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        etienne.carriere@linaro.org, peng.fan@oss.nxp.com,
        chuck.cannon@nxp.com, souvik.chakravarty@arm.com,
        nicola.mazzucato@arm.com,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
To:     Cristian Marussi <cristian.marussi@arm.com>
Date:   Wed, 23 Aug 2023 11:01:17 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Cristian Marussi (2023-08-23 02:02:46)
> On Tue, Aug 22, 2023 at 01:17:15PM -0700, Stephen Boyd wrote:
> > Quoting Cristian Marussi (2023-08-11 09:14:41)
> > > Add a param to Clock enable/disable operation to ask for atomic opera=
tion
> > > and remove _atomic version of such operations.
> >=20
>=20
> Hi,

Yo

>=20
> > Why?
> >=20
>=20
> :D, given that the 2 flavours of SCMI enable/disable ops (and the upcoming
> state_get) just differ in their operating mode (atomic or not) and the
> Clock framework in turn wrap such calls into 4 related and explicitly
> named clk_ops (scmi_clock_enable/scmi_clock_atomic_enable etc) that hint
> at what is being done, seemed to me reasonable to reduce the churn and
> remove a bit of code wrappers in favour of a param.

Please add these extra details to the commit text about why we're making
the change.

>=20
> > >=20
> > > No functional change.
> > >=20
> > > CC: Michael Turquette <mturquette@baylibre.com>
> > > CC: Stephen Boyd <sboyd@kernel.org>
> > > CC: linux-clk@vger.kernel.org
> > > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > > ---
> > >  drivers/clk/clk-scmi.c            |  8 ++++----
> > >  drivers/firmware/arm_scmi/clock.c | 24 ++++++------------------
> > >  include/linux/scmi_protocol.h     |  9 ++++-----
> > >  3 files changed, 14 insertions(+), 27 deletions(-)
> > >=20
> > > diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
> > > index 2c7a830ce308..ff003083e592 100644
> > > --- a/drivers/clk/clk-scmi.c
> > > +++ b/drivers/clk/clk-scmi.c
> > > @@ -78,28 +78,28 @@ static int scmi_clk_enable(struct clk_hw *hw)
> > >  {
> > >         struct scmi_clk *clk =3D to_scmi_clk(hw);
> > > =20
> > > -       return scmi_proto_clk_ops->enable(clk->ph, clk->id);
> > > +       return scmi_proto_clk_ops->enable(clk->ph, clk->id, false);
> > >  }
> > > =20
> > >  static void scmi_clk_disable(struct clk_hw *hw)
> > >  {
> > >         struct scmi_clk *clk =3D to_scmi_clk(hw);
> > > =20
> > > -       scmi_proto_clk_ops->disable(clk->ph, clk->id);
> > > +       scmi_proto_clk_ops->disable(clk->ph, clk->id, false);
> >=20
> > I enjoyed how it was before because I don't know what 'false' means
> > without looking at the ops now.
> >=20
>=20
> Yes indeed, I can drop this and rework if you prefer to maintain the old
> API calls, but this would mean that whenever we'll add new atomic
> flavour to some new SCMI clk operations we'll have to add 2 ops instead
> of a parametrized one...this is what would happen also in this series
> with state_get (and what really triggered this refactor)
>=20
> (and please consider that on the SCMI side, for testing purposes, I would
> prefer to expose always both atomic and non-atomic flavours even if NOT
> both actively used by the Clock framework...like state_get() that can only
> be atomic for Clock frmwk...)
>=20

Perhaps we need a local variable to make it more readable.

	static int scmi_clk_enable(struct clk_hw *hw)
	{
	       bool can_sleep =3D false;
	       struct scmi_clk *clk =3D to_scmi_clk(hw);

	       return scmi_proto_clk_ops->enable(clk->ph, clk->id, can_sleep);
	}

This let's the reader quickly understand what the parameter means. I'm
OK with adding the function parameter, but a plain 'true' or 'false'
doesn't help with clarity.
