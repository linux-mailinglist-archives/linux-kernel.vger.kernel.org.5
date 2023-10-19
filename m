Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1977CF391
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbjJSJIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235305AbjJSJIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:08:14 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E19138
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 02:08:08 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so7257a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 02:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697706487; x=1698311287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ut1u++pUnprqXDu+7d3k9MbS7GT1qangQpeLiBStwV0=;
        b=CnTHOWNbYRDvqqmiXsrNlG7n9ob5nZNYPUu9mapAFOo+slCpEbSvNUuL4xMohEU8vT
         DrSDAonN7742PfmmlBvJoQHUWkLINCVWKjOJvz7739fcFRPgS11SUa80a+WZCubq35l9
         6b30v0zYw13lSh8qTv6eKOBBLn+H2VIjminyg4fBoxb+tFuFCfLD0y+9PqwWJ2bg8Xng
         zEtd6NrBT+gIpv+L1Y2RAN3FeFi7WR2RPvYGLwlvSvcEVKCtOnX9Hog4iNX0D3l2sg4G
         mJ6TtHzDZ25I2dPHHdb/EknjhxeSv+xCVbyC4rF3SBMjkYgaWLh0V9kJ41dNyG7rueVO
         s6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697706487; x=1698311287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ut1u++pUnprqXDu+7d3k9MbS7GT1qangQpeLiBStwV0=;
        b=DJljA1yrFUag16J3tVD7qHquu/9GwBE2voO/M5NFFjX0KmSnbeOKqHmUJNUt0S0ggO
         XyoD1UfUtnGhSCcz242OMLsh9YtjtDRDDdsjxVH0sCC83YLd7HkE3BqdQKNW8qu424NZ
         4TJCjedqT6F4sDJzVdG7OmarTEAhrkv4Eyxx3nWh5c/KK8XqH7xKGexrZy4tbooi2sIK
         VGa3PLZKvyWuXeXo1juo6tNzWRoeQUBOoAmFd4mYcXYcVBT+2VtE/T1ypA6JXEgfhDqJ
         NddvmAMmVXb9+Oa4WuQfc5V7cHTjPnTruE45QCKGK90uPnGBlkccbyK1MAWRp0/ErSSM
         z7Rw==
X-Gm-Message-State: AOJu0YyX+kE64CP0SFhUcpw8DRzX1F25kF37S+/Ywx9RfS2EjK8y5l94
        932hvx4bbzAnVqSjc+OJ5SSOm1/t+sH9DwBj8Xo7Cg==
X-Google-Smtp-Source: AGHT+IG4JcoaLNwjNx17ut2GEUh9WtVu3+ZvbgjZVKAPsxDcj/V4LWL8PB/GK1yuubG0rKt6q+IWuxTYvq11jCh0CAg=
X-Received: by 2002:a50:f613:0:b0:53f:2694:c3d5 with SMTP id
 c19-20020a50f613000000b0053f2694c3d5mr112645edn.6.1697706486772; Thu, 19 Oct
 2023 02:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000003b14000606e7f15b@google.com> <f5d66783-b8ca-4f81-9d24-faaf00961dc7@kernel.dk>
In-Reply-To: <f5d66783-b8ca-4f81-9d24-faaf00961dc7@kernel.dk>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Thu, 19 Oct 2023 11:07:50 +0200
Message-ID: <CANp29Y5VzndnC2dka2tHxFdD8wq6cs+KC7iy7gK4dKrbbtX6Xw@mail.gmail.com>
Subject: Re: [syzbot] [block?] WARNING in __floppy_read_block_0 (3)
To:     efremov@linux.com
Cc:     Jens Axboe <axboe@kernel.dk>,
        syzbot <syzbot+06ecd359d1a53c832788@syzkaller.appspotmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've updated configs[1] so that syzbot won't send any floppy driver
reports to LKML (they'll only be displayed on the web dashboard with a
special tag).

If the driver gets rewritten or there's again interest in floppy
reports, please let us know.

[1] https://github.com/google/syzkaller/pull/4273

On Wed, Oct 4, 2023 at 8:52=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> I'll keep saying this:
>
> https://lore.kernel.org/all/7df3e30a-aa31-495c-9d59-cb6080364f61@kernel.d=
k/
>
> but apparently nobody is listening.
>
> --
> Jens Axboe
>
>
