Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9D5784B3D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 22:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjHVURV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 16:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjHVURU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 16:17:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D31CC;
        Tue, 22 Aug 2023 13:17:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6D8B63CE0;
        Tue, 22 Aug 2023 20:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08250C433C7;
        Tue, 22 Aug 2023 20:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692735438;
        bh=QdTTuQ+Mug3wHUDRHlafLoo8YB7CrkNNHVFAfFK1fWs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=A25SwGi5HWqRbBZutRVRGVmfML+PS/yJFx4jXa6520tJU1uwK95Ffppwy2i5WiKiv
         v3J+HSJN0eyaazJRietKvypvI3PzVq/odPmXjF3RQYvxOprHcXai4Ofo9M7b8N9ttz
         akFjpPXlRIjZDECWg82v8UxpboUlyjfasfACpKDllLh/boOznPgTDMRM3QfvLTWvlQ
         /ZPeISUawzQKZpd5jPhd7Gav+bQiPBgz9VF+dClu1LBnpQ0XMQSHcrI/qYAeO5dAl+
         ybYqevHnqZcV7oaCtOjXDg0Um/zQdpzlsPCYT/yJ6kxxdNS6reSEX+bG/pkAgd24Uu
         q9J1h798v9UEw==
Message-ID: <17bd83d833b59fd4f64eec433589fa55.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230811161446.636253-2-cristian.marussi@arm.com>
References: <20230811161446.636253-1-cristian.marussi@arm.com> <20230811161446.636253-2-cristian.marussi@arm.com>
Subject: Re: [PATCH 1/6] firmware: arm_scmi: Simplify enable/disable Clock operations
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        etienne.carriere@linaro.org, peng.fan@oss.nxp.com,
        chuck.cannon@nxp.com, souvik.chakravarty@arm.com,
        nicola.mazzucato@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 22 Aug 2023 13:17:15 -0700
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

Quoting Cristian Marussi (2023-08-11 09:14:41)
> Add a param to Clock enable/disable operation to ask for atomic operation
> and remove _atomic version of such operations.

Why?

>=20
> No functional change.
>=20
> CC: Michael Turquette <mturquette@baylibre.com>
> CC: Stephen Boyd <sboyd@kernel.org>
> CC: linux-clk@vger.kernel.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  drivers/clk/clk-scmi.c            |  8 ++++----
>  drivers/firmware/arm_scmi/clock.c | 24 ++++++------------------
>  include/linux/scmi_protocol.h     |  9 ++++-----
>  3 files changed, 14 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
> index 2c7a830ce308..ff003083e592 100644
> --- a/drivers/clk/clk-scmi.c
> +++ b/drivers/clk/clk-scmi.c
> @@ -78,28 +78,28 @@ static int scmi_clk_enable(struct clk_hw *hw)
>  {
>         struct scmi_clk *clk =3D to_scmi_clk(hw);
> =20
> -       return scmi_proto_clk_ops->enable(clk->ph, clk->id);
> +       return scmi_proto_clk_ops->enable(clk->ph, clk->id, false);
>  }
> =20
>  static void scmi_clk_disable(struct clk_hw *hw)
>  {
>         struct scmi_clk *clk =3D to_scmi_clk(hw);
> =20
> -       scmi_proto_clk_ops->disable(clk->ph, clk->id);
> +       scmi_proto_clk_ops->disable(clk->ph, clk->id, false);

I enjoyed how it was before because I don't know what 'false' means
without looking at the ops now.

>  }
> =20
>  static int scmi_clk_atomic_enable(struct clk_hw *hw)
>  {
>         struct scmi_clk *clk =3D to_scmi_clk(hw);
> =20
> -       return scmi_proto_clk_ops->enable_atomic(clk->ph, clk->id);
> +       return scmi_proto_clk_ops->enable(clk->ph, clk->id, true);
>  }
> =20
>  static void scmi_clk_atomic_disable(struct clk_hw *hw)
>  {
>         struct scmi_clk *clk =3D to_scmi_clk(hw);
> =20
> -       scmi_proto_clk_ops->disable_atomic(clk->ph, clk->id);
> +       scmi_proto_clk_ops->disable(clk->ph, clk->id, true);
>  }
> =20
>  /*
