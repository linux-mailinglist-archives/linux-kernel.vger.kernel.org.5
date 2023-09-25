Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB30F7AD283
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjIYH7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjIYH7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:59:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49464EE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 00:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695628696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L87wzYgBgGwZuiVFHiZUcLCo+dUlchfJ95HVn2+U9YU=;
        b=G+2ZeFxw7lqPxTqt3f+bCJr6yxMUk9KFJeYZCRAGUaLD7xwoFchP/BtRQvF9mIj7+H/0Km
        +XcfTyZrWyS7JuiMsaKtd1Qdt7lZZLJ0KZKz9qrk2p4VKy6F6UCqqR4ffpcDLtPZlkyULe
        FK4km3hAlJiZMTKkQYp8BktcvuqGHJw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-bLBAse31OkuW1NuqB80Heg-1; Mon, 25 Sep 2023 03:58:14 -0400
X-MC-Unique: bLBAse31OkuW1NuqB80Heg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-277576268e9so1446324a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 00:58:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695628693; x=1696233493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L87wzYgBgGwZuiVFHiZUcLCo+dUlchfJ95HVn2+U9YU=;
        b=rI+3dGWPf9enZaTrD+zG4v7MKK6KHYuTGQVsFg+fbzGCf4AUUyOT4kawGHGSph5jTK
         YiCo5tX9/rutqOrk4LsDP6mLOziHa7/0DuZOn1mr4TglQ2AnfFkUhCwmVqULPPJFBifP
         ezYP4am446r+RYRV/L/xTlk8rDZ36rG+Attu6NNsMfCCK4FxYQXCDYBOBYGMPyRHAu63
         Z1b7HJlRnucMB67ETlHvxALeRaz6YabxYJui+0MRzFi2DOu4IJrSFRCuR6Hk6UdX4b15
         zP7bBp1iOJWn6m/+QStzPEu6IYLfg7DPW5ilyaIdmiqMJwWDnyplB3+nmVGn73gnh+i8
         cAkQ==
X-Gm-Message-State: AOJu0YwNN8WE8tfU9noR2IudaD4t/QRVl72PlZyqtVADCvhTjB96CwVN
        ms4h81Kgu5mTTJwDYec5LSZxeVop7mPbDn2ZkF1NTxqzeN6oXgcsBew4vVfkycAL1KFuNT6JGmm
        phsEQNzgviSXGz3XuC2qIpMRubqFvic5agudwCRDh2L31Nsm8f6Ww1w==
X-Received: by 2002:a17:90a:f298:b0:269:6c5:11a7 with SMTP id fs24-20020a17090af29800b0026906c511a7mr3761446pjb.17.1695628693663;
        Mon, 25 Sep 2023 00:58:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUHlCR4v/MWcEU3R+aDOAkhHVQ8j4RqKF2cT2K2UDK1UaBW28SvLxDtzYC6qYK1vvOo4NEDTrotl718upwZN4=
X-Received: by 2002:a17:90a:f298:b0:269:6c5:11a7 with SMTP id
 fs24-20020a17090af29800b0026906c511a7mr3761439pjb.17.1695628693390; Mon, 25
 Sep 2023 00:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230830092902.1236950-1-yukuai1@huaweicloud.com> <CAPhsuW4QNwL3+AXk8_ZNwgSAZj9k6Ce=tPmz9xPHwC+BjT=Dcg@mail.gmail.com>
In-Reply-To: <CAPhsuW4QNwL3+AXk8_ZNwgSAZj9k6Ce=tPmz9xPHwC+BjT=Dcg@mail.gmail.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Mon, 25 Sep 2023 15:58:02 +0800
Message-ID: <CALTww28+gk4upte4wo=VBJxYCJxr2i1hdcwy+OwNHY1PqaCqVg@mail.gmail.com>
Subject: Re: [PATCH -next 0/2] md: fix potential hang for mddev_suspend()
To:     Song Liu <song@kernel.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 5:33=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Wed, Aug 30, 2023 at 2:33=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com>=
 wrote:
> >
> > From: Yu Kuai <yukuai3@huawei.com>
> >
> > Yu Kuai (2):
> >   md: factor out helpers to grab and put 'active_io'
> >   md: fix potential hang for mddev_suspend()
>
> Applied to md-next. Thanks!
>
> Song
>
> >
> >  drivers/md/md.c | 36 ++++++++++++++++++++++++++++++------
> >  1 file changed, 30 insertions(+), 6 deletions(-)
> >
> > --
> > 2.39.2
> >
>

Hi all

For the second patch, active_io_release does this job. So it doesn't
need to do this in md_array_exit again.

Best Regards
Xiao

