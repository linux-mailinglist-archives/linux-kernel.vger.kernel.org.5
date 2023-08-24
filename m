Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60E378782E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243061AbjHXSoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243079AbjHXSnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:43:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145E5170F;
        Thu, 24 Aug 2023 11:43:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A40A567041;
        Thu, 24 Aug 2023 18:43:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044DFC433C7;
        Thu, 24 Aug 2023 18:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692902618;
        bh=hyPhg2lvFHq0M/FUCI5u+mGZ2jcsghXBoKYtqtflqY8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=XPE7QR2GgWieE3RFuMbgoUJ5Qd7rMSz4Hw+UwDJ2MlzgtLcCMiWOFN1wdeYCw1I3k
         mz8ED62pC8TeVzCUngqa6HkAxLtoKdCYQs5MhVwKvG50T3ePIRm1AIsFYRaGMd4eCq
         jdGEsBqCNdy7eDs6W+qczR37s02PyODrCPFrA89fJ1FOvFlFFLYGs3P8Ir3yGdC29r
         lWiFQDQkbVodQUX/Oxww1RCpKdKc3LYkKs+DeKtbV0817vJiy1BiosU/L357c0nxh8
         7lI218ctgcTeVIF6hgPCH3U6S8Nx5lrJ5e6VN5Y9WHlnoXngmSWbyg/n/pXUDpWmpY
         IYjJHqitToD8w==
Message-ID: <4870d94375cfdf6c0ba4d4b5cb3b6dc3.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZOdoP00tlAIRr9fN@pluto>
References: <20230811161446.636253-1-cristian.marussi@arm.com> <20230811161446.636253-2-cristian.marussi@arm.com> <17bd83d833b59fd4f64eec433589fa55.sboyd@kernel.org> <ZOXLNliOogkNyJYQ@e120937-lin> <a14cdd584283d32a3642658aaed6c98c.sboyd@kernel.org> <ZOdoP00tlAIRr9fN@pluto>
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
Date:   Thu, 24 Aug 2023 11:43:35 -0700
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

Quoting Cristian Marussi (2023-08-24 07:25:21)
> On Wed, Aug 23, 2023 at 11:01:17AM -0700, Stephen Boyd wrote:
> >=20
> > Perhaps we need a local variable to make it more readable.
> >=20
> >       static int scmi_clk_enable(struct clk_hw *hw)
> >       {
> >              bool can_sleep =3D false;
> >              struct scmi_clk *clk =3D to_scmi_clk(hw);
> >=20
> >              return scmi_proto_clk_ops->enable(clk->ph, clk->id, can_sl=
eep);
> >       }
> >=20
> > This let's the reader quickly understand what the parameter means. I'm
> > OK with adding the function parameter, but a plain 'true' or 'false'
> > doesn't help with clarity.
>=20
> Thanks for the suggestion, it would help definitely making it more
> readable, maybe a local define or enum could make it without even
> putting anything on the stack.
>=20

Surely the compiler can optimize that so there isn't stack local
storage for a local variable used as an argument to a function call?
