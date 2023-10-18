Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A917CE2A8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbjJRQX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 12:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjJRQXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 12:23:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB09F120;
        Wed, 18 Oct 2023 09:23:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBF3C433CA;
        Wed, 18 Oct 2023 16:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697646232;
        bh=m0y87GMB+kyGBIQT41CfRnMDWagWXiCi7iX5fiBX4X4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LSNj4lvBTces7lYWDdKe2FP2s2s6eTaH3pm693026j1enFyFRZXZVr8gdLGJXsw1H
         H4ttgqNsDObn9inAwyh6v2V9hGkENQ3U9J5Q0nCyiLANgxt2aNNXl9nLqZ39+GY3Lk
         7Zivb+Fs0wMUPD+9X+JSaCoQOlA8DqUNsojSbZ5Bi8op+LiuU9DanNyFLvFyKv9XO/
         PEqQPd9raeir5J3iZF+N0vGXTXpbhOp+voqiEsoqcLAH9fea+eHjiMSvbWAWqB03BW
         6VpTW417yyxDJjKM3LKuP+nUHV05HGWerSDhDDwV76lyNZIjv6CiK0nEDYFnLtFZHa
         9HP3mxDQCXzYw==
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ca74e77aecso27513125ad.1;
        Wed, 18 Oct 2023 09:23:52 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyod6xxJhIQSLuqfCZZWVZzmpKC7mOxAmezVPVDFmfUI5oWGoce
        s+n/w5KH2AxctRTSAaWWGqgclmefIRPkV3ewDSY=
X-Google-Smtp-Source: AGHT+IFSBGwORvXp+fycwvwU1RBz/9eZYLrEvtRiSDVAxdtCApz4Qx5Qv+Qb2SkpmYE9r1Xh+MD3iU7qQzcez8yWk/Q=
X-Received: by 2002:a17:903:1252:b0:1c7:2e8f:c3b5 with SMTP id
 u18-20020a170903125200b001c72e8fc3b5mr7674721plh.20.1697646231792; Wed, 18
 Oct 2023 09:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231016100240.540474-1-yukuai1@huaweicloud.com>
In-Reply-To: <20231016100240.540474-1-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 18 Oct 2023 09:23:36 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4ZGHiftb-G178-EjZodrcF4RocgJ+sa5iVf5qkgFYfCA@mail.gmail.com>
Message-ID: <CAPhsuW4ZGHiftb-G178-EjZodrcF4RocgJ+sa5iVf5qkgFYfCA@mail.gmail.com>
Subject: Re: [PATCH v2] md: cleanup pers->prepare_suspend()
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
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

On Sun, Oct 15, 2023 at 7:06=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> pers->prepare_suspend() is not used anymore and can be removed.
>
> Reverts following three commit:
>
>  - commit 431e61257d63 ("md: export md_is_rdwr() and is_md_suspended()")
>  - commit 3e00777d5157 ("md: add a new api prepare_suspend() in
> md_personality")
>  - commit 868bba54a3bc ("md/raid5: fix a deadlock in the case that reshap=
e
> is interrupted")
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Applied to md-next.

Thanks,
Song
