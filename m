Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA1A7D97F9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345796AbjJ0M0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjJ0M0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:26:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B36710A;
        Fri, 27 Oct 2023 05:26:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17739C433C8;
        Fri, 27 Oct 2023 12:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698409605;
        bh=0QBZJYhDj4i9wPC5H3bgFCd3c49bNMRjHNHFhr9slBw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tyhY6muhq/Id+QUzwY4YRLltk8slV/xon2beeX5chm+U3dQD4iHJXzKmcPeeFJTVv
         kH83eMrwHYfSF79aKDGR4JK4d6LOm0d53dTC/1lrvrQglF6Tp4SLKth4Ri+D49qlDr
         4Ji7Nsv1bt2wP3v/S0vgs9gQn2BNQCPwfVn6JhqpP4M3E/JqlzEWTfXPHgCPpJdOzQ
         aL69rFG21yU8sf60V5vV1XTJyp7NG6jNryjcwYmVwkYDVS2Xq/EhQx664fuzta1i3z
         fqsOZJmjhBvdZuxNj+RrjjNSclOerx7JUdSYC5XiwwkR48uNRbMMvU/LN/8j/FYUZx
         K26krnTv/9Tvw==
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-457cb7f53afso916978137.3;
        Fri, 27 Oct 2023 05:26:45 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw8tGVISrGGdOjIivJXiOYnoZUAkaKtY13ZrQaLkcNZ/WqLBCzq
        /kv2gsPBrDJpZbmLPMn3V3VTSlPE18moIGNVbhU=
X-Google-Smtp-Source: AGHT+IGj3bRHtOnD0QGoA7J7kdYUFLwbsUZlI0dAtDJ+TnHqWfhmLogridmHSknNjm1dJW1mT1iLntR5AwDor9Ado3w=
X-Received: by 2002:a67:c199:0:b0:452:7f81:1502 with SMTP id
 h25-20020a67c199000000b004527f811502mr2616635vsj.26.1698409604180; Fri, 27
 Oct 2023 05:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231023-imx214-v1-0-b33f1bbd1fcf@apitzsch.eu> <20231023-imx214-v1-3-b33f1bbd1fcf@apitzsch.eu>
In-Reply-To: <20231023-imx214-v1-3-b33f1bbd1fcf@apitzsch.eu>
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
Date:   Fri, 27 Oct 2023 14:26:26 +0200
X-Gmail-Original-Message-ID: <CAPybu_0ggxLOjf+yxvPJisg-6AJ2Cu9_tjZ8=zN58czNEFTGoQ@mail.gmail.com>
Message-ID: <CAPybu_0ggxLOjf+yxvPJisg-6AJ2Cu9_tjZ8=zN58czNEFTGoQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] media: i2c: imx214: Read orientation and rotation
 from system firmware
To:     git@apitzsch.eu
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 11:49=E2=80=AFPM Andr=C3=A9 Apitzsch <git@apitzsch.=
eu> wrote:
>
> Obtain rotation and orientation information from system firmware and
> register the appropriate controls.
>
> Signed-off-by: Andr=C3=A9 Apitzsch <git@apitzsch.eu>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
