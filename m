Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F957B21D0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjI1PyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbjI1PyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:54:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1E6B7;
        Thu, 28 Sep 2023 08:54:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F24FC433CC;
        Thu, 28 Sep 2023 15:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695916456;
        bh=K1EsjSElxnLz3/mbgZwNJDnhfBE8cMQKJ6SMAMDhccs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ooj1xhw/OwOQ7aWdPxgd3vgPc+/FpBHsZNpbtWf2kJRLh/iipN51wERFmAZo5jWpH
         PulxSwr5xL0fHzZD227o6u+2TgyETgMjYHLzl6ouDWCD6O2UYD5326nz5+sk0U1qDp
         A8mhkxwEOJNSzL9Y36/b+Zp6JcFYqmuoZ3mW9UKyssorQRFp4bCk+QSPClmR0s25X/
         SxcmJtEU+fLb9cljFomOggOVYMt7FAQ5QG0TeJ0FQyFn68LZcjxmeUcPe2rF4UT6+n
         pqF3fwGBN2fxriNliIJNKrU4S9nRCzMNMryGckS3ZSypB4Xig896IffMeIqoRdFhOY
         mi8NhmWpoYmGg==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50305abe5f0so20734009e87.2;
        Thu, 28 Sep 2023 08:54:16 -0700 (PDT)
X-Gm-Message-State: AOJu0YyJfbL6V7Ax5qaClu78433wItXLtZift+BpwvNlI1D0t/RHlCQE
        eObfwA5X7Z5GOkZ3smq2c/2fmXtpaHU6XcR+lm0=
X-Google-Smtp-Source: AGHT+IEFVO/hg/PaKGBPZ3PqAJvJdpHC85BEs/x41TCJ51mvcCeENmSCWHHD1AbaeO30TlabyaCKiL8f7JBOcLjICYU=
X-Received: by 2002:a19:8c43:0:b0:4fe:1681:9377 with SMTP id
 i3-20020a198c43000000b004fe16819377mr1438879lfj.44.1695916454807; Thu, 28 Sep
 2023 08:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230928061543.1845742-1-yukuai1@huaweicloud.com> <20230928061543.1845742-2-yukuai1@huaweicloud.com>
In-Reply-To: <20230928061543.1845742-2-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 28 Sep 2023 08:54:02 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7-Kq_bFpXtDUpiWtmBTFajewv=Uv4_GZR4zcoB9m1dBg@mail.gmail.com>
Message-ID: <CAPhsuW7-Kq_bFpXtDUpiWtmBTFajewv=Uv4_GZR4zcoB9m1dBg@mail.gmail.com>
Subject: Re: [PATCH -next v3 01/25] md: use READ_ONCE/WRITE_ONCE for
 'suspend_lo' and 'suspend_hi'
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yukuai3@huawei.com,
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

On Wed, Sep 27, 2023 at 11:22=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Because reading 'suspend_lo' and 'suspend_hi' from md_handle_request()
> is not protected, use READ_ONCE/WRITE_ONCE to prevent reading abnormal
> value.

I rephrase this a bit:

Protect 'suspend_lo' and 'suspend_hi' with READ_ONCE/WRITE_ONCE to prevent
reading abnormal values.

Thanks,
Song
