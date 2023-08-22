Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0ECA7836FF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 02:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjHVAP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 20:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjHVAPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 20:15:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C35180;
        Mon, 21 Aug 2023 17:15:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A66F64D02;
        Tue, 22 Aug 2023 00:15:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF75C433C8;
        Tue, 22 Aug 2023 00:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692663316;
        bh=W4oSTCBfgCbCR8ZY3PEmgCF2Gxgb1kitL4a1Al3j5Wc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jJnTKwsT30Ic800K9ovfDEsMSfOowL/3sGbGbVlvDpdPJmZSMiAWrfwMjlPRIcOtC
         8ArkC8hqi/T08PwLLTlxvbwmwGlSC69VF8c9YsC4jVuJ1Bb4KYxjsCVb58Fxfvxv71
         5OdS0xBkNztMhFeYb/EIutiJ6wdOmrr5rIio2BxeaX85LllI6pwZwldi8zHSZqbx72
         m8cQUQ3PRNWdqSOkyZd16gHMXBP7rp59rxLcDIS7zCLafI+jOUMnB7LK8Kd7BoV3yM
         xeMoO9aatzUGl/uvsnK6bnQbGpoZEzmF7DOwdhgccwcx0mkzDuGLQwTe5qvGlNstHG
         cMYaXxpnIw5Xw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4ff9b389677so5903735e87.3;
        Mon, 21 Aug 2023 17:15:16 -0700 (PDT)
X-Gm-Message-State: AOJu0YwmePG94wQ82hlZu2rMVOy72VRC+q/ioM+w5aAZJTyREsA8f28Q
        I+i2uIGXd67zBS1d7uFTe2XP2uONUtYPO240xOk=
X-Google-Smtp-Source: AGHT+IEeFxFioF0G2cL3tsfU/Cpp/t4yLBC9M/itJ7p/wfDyYdA2tSFNIxFMPZ0TDLHMVZcUPN5gwMly0UY+PAPm+lY=
X-Received: by 2002:ac2:5a0a:0:b0:4fb:745e:dd01 with SMTP id
 q10-20020ac25a0a000000b004fb745edd01mr5363415lfn.45.1692663314926; Mon, 21
 Aug 2023 17:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230803132930.2742286-1-yukuai1@huaweicloud.com> <20230803132930.2742286-11-yukuai1@huaweicloud.com>
In-Reply-To: <20230803132930.2742286-11-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 21 Aug 2023 17:15:02 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7P0czQSQ88bt-+Dp3kMFErK2GOd_a70GGU5CS7Ks+MZQ@mail.gmail.com>
Message-ID: <CAPhsuW7P0czQSQ88bt-+Dp3kMFErK2GOd_a70GGU5CS7Ks+MZQ@mail.gmail.com>
Subject: Re: [PATCH -next 10/29] md/raid5-cache: use READ_ONCE/WRITE_ONCE for 'conf->log'
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
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

On Thu, Aug 3, 2023 at 6:32=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> wr=
ote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> 'conf->log' is set with 'reconfig_mutex' grabbed, however, readers are
> not procted, hence use READ_ONCE/WRITE_ONCE to prevent reading abnormal
> value.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

It appears to me that this patch doesn't apply to md-next. Please rebase
and resend all 3 sets.

Thanks,
Song
