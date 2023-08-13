Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36D577AA33
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 19:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjHMRFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 13:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjHMRFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 13:05:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF061E63;
        Sun, 13 Aug 2023 10:05:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65F4C61DCC;
        Sun, 13 Aug 2023 17:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0129C433C7;
        Sun, 13 Aug 2023 17:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691946309;
        bh=4vlvVfBgckgn5ntKY0ITHZk2Jw//8hLoO8W6fuI9CjQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bkJNXvSKL+uOgM8U32E784pGt27FuNp6ecJCHmdAGhQxpr7Vz1q2gw1xMa3SfpxWT
         GkviXRYLOR0cokLKP/gxFP3O0g7uD/rwrjlJgEsWpkdw8o9GfzlkBf3TNCJVtxprCB
         sf+v30UGb44S5SUkd2EGmkcGWy/6+rpL3RLDXvcv7WyHS9PrWTl4CkqLOltf7ZA8jg
         O1vQHDVmMQ3P5afxDb4v7wAoIZ8nYusoa78EmqoVT/SCNMJqMABAK/BraeHDhuO00z
         6DJuzNUmGFxYaIRaCais9Z873g5McdPMvpVgVGpk20PWfXIWUeea5VxFpgxrNwe3mB
         c4ZgR6LDvFCfg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4fe0eb0ca75so5275234e87.2;
        Sun, 13 Aug 2023 10:05:09 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywrty10dFP/hWaUH07c3NVb8SoaH2kktcSHUOcO+tO1ZbZl7e5/
        Z32xBg3mmtkxR4hh9JnF753T8GVdg0tGeyoE+lE=
X-Google-Smtp-Source: AGHT+IEkzc38T/uiq+/d/YONasCbYpzFA9SRX0yQlVEvaUbZ01afAJAQ3U2dbCPyPA3csQKMVH75iM8dOrTdbYiE6tE=
X-Received: by 2002:a05:6512:5d4:b0:4fe:193c:de74 with SMTP id
 o20-20020a05651205d400b004fe193cde74mr5066921lfo.18.1691946307763; Sun, 13
 Aug 2023 10:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230803071711.2546560-1-lilingfeng@huaweicloud.com>
In-Reply-To: <20230803071711.2546560-1-lilingfeng@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Sun, 13 Aug 2023 21:04:54 +0400
X-Gmail-Original-Message-ID: <CAPhsuW6W3ia3zYVZjVKLND7oGpVQt0qgO3=7nCXTuDmoT3Mzxg@mail.gmail.com>
Message-ID: <CAPhsuW6W3ia3zYVZjVKLND7oGpVQt0qgO3=7nCXTuDmoT3Mzxg@mail.gmail.com>
Subject: Re: [PATCH -next v3] md: Hold mddev->reconfig_mutex when trying to
 get mddev->sync_thread
To:     Li Lingfeng <lilingfeng@huaweicloud.com>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, linan122@huawei.com, yi.zhang@huawei.com,
        yangerkun@huawei.com, lilingfeng3@huawei.com, pmenzel@molgen.mpg.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 11:20=E2=80=AFAM Li Lingfeng <lilingfeng@huaweicloud=
.com> wrote:
>
> From: Li Lingfeng <lilingfeng3@huawei.com>
>
> Commit ba9d9f1a707f ("Revert "md: unlock mddev before reap sync_thread in
> action_store"") removed the scenario of calling md_unregister_thread()
> without holding mddev->reconfig_mutex, so add a lock holding check before
> acquiring mddev->sync_thread by passing mdev to md_unregister_thread().
>
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> Reviewed-by: Yu Kuai <yukuai3@huawei.com>

Applied to md-next.

Thanks,
Song
