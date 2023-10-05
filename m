Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F09B7BABC1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 23:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjJEVD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 17:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjJEVDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 17:03:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969B7E7;
        Thu,  5 Oct 2023 14:03:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CEAC433C9;
        Thu,  5 Oct 2023 21:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696539802;
        bh=d7Ppl8D44fkRETlgz0A2LIGOQ/MHiCD4kZFvw+UJxEI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=M2xhVj2NonefTX0Fr2avsBvsmxS7B89O6UJNdP2pIB5LjkaPbfnjzCJwyEsslERhM
         yNnGxvCUIV+3fpzisohQ6YHTX5bvLmjUhXqJMV4amk3mG3Jaz8VZGo83NFkZLBMiee
         IuiMN5qWJwLh9nGx7TWYB39GiTSQ5aZQzlihI/62ChWupkrVw6j0ZGQNcMrv2mnIlj
         OgrqfQ9VE21tB56LV8zRv9D1pvxca806WCnkYJJwmPgAB3qQ4yNxyWcf1f8TNXAhHx
         KVekNW4njiUejlzV+XvWGy10g7K/2udnYHgYRWR56BMvRcDe4lfNZON3ZamQkksfpp
         /WqUg+XFSqihQ==
Message-ID: <77d94f6a6a4b45f8ad711f52ca6ba86c.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231005203202.08b5d1cf@mitra>
References: <20231005095927.12398-1-b.spranger@linutronix.de> <20231005095927.12398-2-b.spranger@linutronix.de> <qpskbgigcaoyjuhzeguz366cjukv3ij7utlbkra5edhwn6uzh4@bdedm6vs62y5> <20231005203202.08b5d1cf@mitra>
Subject: Re: [PATCH 1/1] clk: socfpga: gate: Fix of by factor 2 for serial console
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>
To:     Benedikt Spranger <b.spranger@linutronix.de>,
        Maxime Ripard <mripard@kernel.org>
Date:   Thu, 05 Oct 2023 14:03:19 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Benedikt Spranger (2023-10-05 11:32:23)
> On Thu, 5 Oct 2023 13:34:01 +0200
> Maxime Ripard <mripard@kernel.org> wrote:
>=20
> > Hi,
> >=20
> > On Thu, Oct 05, 2023 at 11:59:27AM +0200, Benedikt Spranger wrote:
> > > Commit 9607beb917df ("clk: socfpga: gate: Add a determine_rate
> > > hook") introduce a specific determine_rate hook. As a result the
> > > calculated clock for the serial IP is off by factor 2 after that
> > > i.e. if the system configures a baudrate of 115200 it is set
> > > physicaly to 57600. =20
> >=20
> > Where is that factor 2 coming from?
> In drivers/tty/serial/8250/8250_dw.c p->uartclk is set twice as high,
> as it should be:=20
>=20
> dw8250_set_termios() is called and rate is evaluated to 20000000 in the
> bad and 10000000 in the good case. As a result p->uartclk is set to
> 20000000 in the bad case.
>=20
> > > Change the determine_rate hook to the reparent variant
> > > __clk_mux_determine_rate() to fix the issue. =20
> >=20
> > It's also not clear to me why that would fix anything. This patch
> > should only make the old behaviour explicit, could you expand a bit
> > on what happens?
> Booting the kernel with console=3DttyS0,115200 result in a corrupted
> character output. Setting the serial terminal application to 57600
> make the serial console working.
>=20
> I dug deeper and added some debug output (see patch below):

What's your analysis?

Does this patch also fix it?

---8<---
diff --git a/drivers/clk/socfpga/clk-gate.c b/drivers/clk/socfpga/clk-gate.c
index 8dd601bd8538..b3400d2d8128 100644
--- a/drivers/clk/socfpga/clk-gate.c
+++ b/drivers/clk/socfpga/clk-gate.c
@@ -173,6 +173,7 @@ void __init socfpga_gate_init(struct device_node *node)
 	if (init.num_parents < 2) {
 		ops->get_parent =3D NULL;
 		ops->set_parent =3D NULL;
+		ops->determine_rate =3D NULL;
 	}
=20
 	init.parent_names =3D parent_name;
