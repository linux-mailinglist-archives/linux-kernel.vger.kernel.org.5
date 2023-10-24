Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B697D453F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjJXCAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjJXCAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:00:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA6C10C3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 19:00:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377DCC433C8;
        Tue, 24 Oct 2023 02:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698112822;
        bh=5Sn3H4oSN3dJtZjA+ZBhX1Pu9c0nxls8h7MoaYAi7n0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=QVAPh1uPdXfvl0LfK1KAM8xDPpdsB0lWPL47UpoeDyZqaQFMhkYzl8gzGx0GCHfqf
         gQbGpqiwZfqFXe8rEv/3HJgd9nfgOh1rHoBFIkRAGM6Hq7OWOIhWN/AIztHfJbzkfG
         jIbQtPU4rHmuwN5082Cys8ml8/FL0ypY7GgbSCpiwA52s+N69eeNjSevvwShE8mZt4
         1J0vzY46xCWJFsVlKzXZpOuVra8oSuLZDGjhF/jW2omNlpIzmbtWo6Oj4OqVuUEW6Z
         xwhgWCrAW2f7OjdFsZ5SontrM8/djBmrCuWhvgnj80tD80TPXcLtrMk+6Ham9U1Vwi
         8PRZ/QJ/Z2CSg==
Message-ID: <909e5d44d6cd79924d6e62d1b649646f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230922025216.3604978-1-make_ruc2021@163.com>
References: <20230922025216.3604978-1-make_ruc2021@163.com>
Subject: Re: [PATCH] spmi: hisi-spmi-controller: fix potential memory leak in spmi_controller_probe()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ma Ke <make_ruc2021@163.com>
To:     Ma Ke <make_ruc2021@163.com>, mchehab+huawei@kernel.org
Date:   Mon, 23 Oct 2023 19:00:20 -0700
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

Quoting Ma Ke (2023-09-21 19:52:16)
> spmi_controller_alloc() allocates a memory space for ctrl. When some
> errors occur, ctrl should be handled by spmi_controller_put() and set
> spmi_controller->controller =3D NULL because spmi_controller->controller
> has a dangling pointer to the freed memory. When the failure happens,
> the function returns without calling spmi_controller_put() and setting
> spmi_controller->controller =3D NULL, which will lead to a memory leak.
>=20
> When the failure happens, we can fix it by calling spmi_controller_put()
> and setting spmi_controller->controller =3D NULL in all of the places
> where we call spmi_controller_put().
>=20
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  drivers/spmi/hisi-spmi-controller.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/spmi/hisi-spmi-controller.c b/drivers/spmi/hisi-spmi=
-controller.c
> index 9cbd473487cb..5b3cfa7f5056 100644
> --- a/drivers/spmi/hisi-spmi-controller.c
> +++ b/drivers/spmi/hisi-spmi-controller.c
> @@ -321,6 +321,7 @@ static int spmi_controller_probe(struct platform_devi=
ce *pdev)
> =20
>  err_put_controller:
>         spmi_controller_put(ctrl);
> +       spmi_controller->controller =3D NULL;

The controller will most likely be freed after the put call one line
above so this will oops. No thanks.
