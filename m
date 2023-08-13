Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AAC77AA2E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjHMQ45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjHMQ44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:56:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E4D1B5;
        Sun, 13 Aug 2023 09:56:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DD9B61587;
        Sun, 13 Aug 2023 16:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB0CC433CA;
        Sun, 13 Aug 2023 16:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691945817;
        bh=jPGHBks+9tU5ZVyCU3jAeAHzS27CSIO4RJ/C8+mXZ5s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P3bVp4uddON2p3N8iPP7P0DUiLcOdLma1MQK/gIBVlOou6/5dnwIBduzHF6Lc1eo+
         69yAzvC5pg5vlvFi0peCu7In93D7BDHwRDhJV2GsKroVz3BfEnYvNU7ayL1VwSvxYx
         U6xkX5gSqjNI/lkCjpoMMqMBo/gIu1vqyzLkVa9zgkrh3mGr17SHa84kRapK6UBWW5
         gnRYNwu+ptO+ySpybU/Fzl5eZvYP8vHlMn8lJplzWLra/Mtvy003Nkxndn/3YSz8V5
         Cx189BpwgqLnr2ROQ10Sq/j/VnNl3T3AzVxQPZDybZtFuD6g9at3tyMO2JK3F7ysDy
         bSKgKKWIShNqQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4fe85fd3d27so5850865e87.0;
        Sun, 13 Aug 2023 09:56:57 -0700 (PDT)
X-Gm-Message-State: AOJu0YwiQsGYx8UgVhEhVFmZ/FfCoeVUzGmdoisbh9goim3F5qjkvfIr
        Epw+U6+n1oqp76KyT/PTCZ8AtYz/VRkseHFhNPs=
X-Google-Smtp-Source: AGHT+IFcV8ot7nktcVhIoofXOBNiVFtlqaPUZTG1hsholLeFrBQ4chBp0L7qmHEX8djtY1fZB3kod9HOSkpMmAqHXzc=
X-Received: by 2002:a05:6512:2396:b0:4fc:3756:754e with SMTP id
 c22-20020a056512239600b004fc3756754emr5911701lfv.56.1691945815508; Sun, 13
 Aug 2023 09:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230731022800.1424902-1-yukuai1@huaweicloud.com> <20327acc-e203-9a16-0ff4-f4e49e44c899@molgen.mpg.de>
In-Reply-To: <20327acc-e203-9a16-0ff4-f4e49e44c899@molgen.mpg.de>
From:   Song Liu <song@kernel.org>
Date:   Sun, 13 Aug 2023 20:56:42 +0400
X-Gmail-Original-Message-ID: <CAPhsuW6DBuLV1KvDtLHTAX1uE-YOdR1snnUvAVU6HzX2O6OOLQ@mail.gmail.com>
Message-ID: <CAPhsuW6DBuLV1KvDtLHTAX1uE-YOdR1snnUvAVU6HzX2O6OOLQ@mail.gmail.com>
Subject: Re: [PATCH -next] md/raid10: fix a 'conf->barrier' leakage in raid10_takeover()
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, yukuai3@huawei.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com
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

On Mon, Jul 31, 2023 at 9:50=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
[...]
> >       return conf;
>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>

Applied to md-next after incorporating Paul's recommendations.

Thanks,
Song

>
> Kind regards,
>
> Paul
