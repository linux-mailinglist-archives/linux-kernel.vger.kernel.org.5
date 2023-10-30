Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403617DBB2A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 14:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjJ3N4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 09:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjJ3N42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 09:56:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E59B3;
        Mon, 30 Oct 2023 06:56:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72CE6C43391;
        Mon, 30 Oct 2023 13:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698674186;
        bh=2DZ+XWbpDn0sXl7TDL0KQKYuOPYneWoL1U/98sLZaFE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZWbDK//OJvJjn+DLrR6VkuxvhRBkw6e45sLs6zysQ50nLhkx5qhphr6OTbTrAPlRD
         kPKsXFLvJmuyytSppyQkw/fNbLUT5aJxzrnyGMzmrR68/CwfTmUoeheRwkNN24uM8p
         wFnQhOxBvHibqYNme5TmSBz2WxJZMUCs5aIVJ4gs02GpSh9pDqcHmhxzWi4sw+O790
         he1OYlxAOF1dkVy8SngH2S8TvYblgLCE9qLtKw02ylFancpUKErqwrk3CXEA+VpANY
         dcJcV32XfucNeBFM1FswiGsZBUh3GHDUV74HTKP0EoeuO+qpdW4EjjLvKaAy/MK9Zk
         H1cH4Szm4HPbw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-507d7b73b74so6233130e87.3;
        Mon, 30 Oct 2023 06:56:26 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyoy3YaOrlktHW04iFW6ACLRYK27vbhOZNG+/HQDWJtI8BjKQ+U
        /LW4dHDQeLyhQKIYQoFn70zQAFbF0dn3aluXug==
X-Google-Smtp-Source: AGHT+IGRk5k6TOaRz01lOrfm/xGwXcwa+cTtDPqqZfMNpCg78iWd+jyDG1E9PMKVzvEqI+DNhLNltlXr/Je56dSlG74=
X-Received: by 2002:a19:5206:0:b0:500:d970:6541 with SMTP id
 m6-20020a195206000000b00500d9706541mr6928782lfb.39.1698674184558; Mon, 30 Oct
 2023 06:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231009172923.2457844-7-robh@kernel.org> <20231010-bronzing-protegee-6d30d36fd9d7-mkl@pengutronix.de>
In-Reply-To: <20231010-bronzing-protegee-6d30d36fd9d7-mkl@pengutronix.de>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 30 Oct 2023 08:56:09 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKjS1TgCtcy_L3X5g54JDheF9PEF9tGE=SZR1H=NWP6Mg@mail.gmail.com>
Message-ID: <CAL_JsqKjS1TgCtcy_L3X5g54JDheF9PEF9tGE=SZR1H=NWP6Mg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: can: Use device_get_match_data()
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Michal Simek <michal.simek@amd.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 7:02=E2=80=AFAM Marc Kleine-Budde <mkl@pengutronix.=
de> wrote:
>
> On 09.10.2023 12:29:02, Rob Herring wrote:
> > Use preferred device_get_match_data() instead of of_match_device() to
> > get the driver match data. With this, adjust the includes to explicitly
> > include the correct headers.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> Applied to linux-can-next/testing.

Still not seeing this in linux-next. Did it get lost?

Rob
