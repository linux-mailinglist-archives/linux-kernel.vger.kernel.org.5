Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1F977AA4B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 19:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjHMRUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 13:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjHMRUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 13:20:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B11A10E4;
        Sun, 13 Aug 2023 10:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0B8460EF0;
        Sun, 13 Aug 2023 17:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488DEC433C7;
        Sun, 13 Aug 2023 17:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691947221;
        bh=4XjJ/m1q8Bs92xYp1IMaLNP82sMw8APWOQV52SF+PY8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BAxuFpuXwCCDvy2GqC3juGxG3ZWWR24UXBAQFTvHjtPXP9mpCfEfmiH0CsvINue34
         AKNe6DBNYmljF9cazzkMmgLEZYpvmtuIb4okXMhgZCKGEYa0kAFWCN226dgzv97G5l
         K9bSymGJLp+8FFjwTrohpn1cwt9g1t1+AXUbyu0RXtPY1qlGDg0HyfgNHwtjiRWkDY
         CxWEYd1fKdUIZEMUeE1S1wVraQ/5SanvKsCQ/9ZW7XEgFrZcr0Y2dfycwK8t448BYa
         3GHw762q8tBLaP4TKWUfVYdyD4aROanIBS80JHtCfK3T2gP/oIKCULU2wjbg2OSluw
         hU83GroB2NlrQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4fe8c16c1b4so5436831e87.2;
        Sun, 13 Aug 2023 10:20:21 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz9Y0d74B1Ux11oESEMRTMoTuEzx71mMpwMiMw61mT/+5KWq8gt
        aYU8RPCjgqqKIJYGqzUpv6M1Z7cNjIgIAQKuaEE=
X-Google-Smtp-Source: AGHT+IFiLEp9CF0ecmdJzWRfveOAbYiAjQhrssR/IIlpTn4KLDoA7SQlBMgIFFB33cO5A/k745EPwfJcHOV85lr4nY8=
X-Received: by 2002:a05:6512:33d5:b0:4fe:3364:6c20 with SMTP id
 d21-20020a05651233d500b004fe33646c20mr6003187lfg.16.1691947219316; Sun, 13
 Aug 2023 10:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230804124611.2051048-1-kernel@xen0n.name> <CAAhV-H681+pput57E2vHz_V7A_oNy1Av6aCDN6eP0wBQqo7kAg@mail.gmail.com>
In-Reply-To: <CAAhV-H681+pput57E2vHz_V7A_oNy1Av6aCDN6eP0wBQqo7kAg@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Sun, 13 Aug 2023 21:20:06 +0400
X-Gmail-Original-Message-ID: <CAPhsuW5J_wUGmU+1tvzTqmpJSRrJicXoNmp+-ftDuHuhBcbkqA@mail.gmail.com>
Message-ID: <CAPhsuW5J_wUGmU+1tvzTqmpJSRrJicXoNmp+-ftDuHuhBcbkqA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] raid5, raid6: Accelerate RAID math with LoongArch SIMD
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, linux-raid@vger.kernel.org,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
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

On Fri, Aug 4, 2023 at 7:27=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org> =
wrote:
>
> Hi, Xuerui and Song,
>
> This series looks good to me, if no one has objections, I will queue
> for loongarch-next.

Sorry for the delayed response. This set looks good to me. You can add

Acked-by: Song Liu <song@kernel.org>

Thanks,
Song
