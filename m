Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4587D9876
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345796AbjJ0Mh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjJ0Mh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:37:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF528C0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 05:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698410229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NZk9KIdsmuso3KQlnqbaPEbP9tjr8ir7g3ODaI70e5E=;
        b=SeohUZcP9FdC6wj2224gd9F5rEbdtLBfCSsZzoVe1rhyZMN+WQag7kC8WRr8PknXn/ookT
        z2VLMwoDHPKvFHYeg+opNSnvUDpeCFloSwC4OdY82nEDAlxCxqiz9d9zWAZ2I8TdQzGhYV
        0qFwi0ftGywPWKh8dnzr/vRAXVEMML0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-5AlSmj5wO5qvI6d8VhdNdA-1; Fri, 27 Oct 2023 08:37:07 -0400
X-MC-Unique: 5AlSmj5wO5qvI6d8VhdNdA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-28001f80712so1367265a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 05:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698410226; x=1699015026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZk9KIdsmuso3KQlnqbaPEbP9tjr8ir7g3ODaI70e5E=;
        b=SmNhoMWX7LxMDrvXj0cqe7YTh7r2A2BW7Qi+18TnFJPqoO3k97kuCHfygXhglYHc3f
         tAt8/9gU9IDrq6eJODu5MQVffGQRxxdNZ+67VL0vq4+yD6MEcOTxVOfYUjxk9kwrazE8
         +PzjvFSCMn+HbDcbno8MoTsjbXBgFmk+pdJaTcPnfcRvgKTqzM2DCoxT/vZct4znFaoU
         HmMYzkYgRFZn/cT5igTEuMFqMXw2Q/Vs0RzXU40pRIZpwJCzr8fpjAb9PSL0XQS0db/i
         w6BAiF79rvJ4bho2T0G1qwUYUHl6xzoiy7kHs2zm/mjCHCtBNX3j/RSXg7VzLhWmlG7F
         tjdw==
X-Gm-Message-State: AOJu0YzCFGXjuDXpvZ/oy0onKhkLb6gVdgAkAdjRaduTT5ZNTZVFFLdE
        UT8/bhyjb9bxoe4Xd8u/Jx1JNAH0hmJINm/pr1WMgDRrJTS1BZ9FexzE3xH++OaBbgccnp1nkjG
        hdK8jJ0tKLB1CroLxMzs/e2k01YWWk8cFU5vinLLx
X-Received: by 2002:a17:90a:db92:b0:27d:4f1f:47f5 with SMTP id h18-20020a17090adb9200b0027d4f1f47f5mr2628319pjv.23.1698410226660;
        Fri, 27 Oct 2023 05:37:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4uArItkfbIE+TacSDkk4EhW5nU+csRC7m600pJIU3M+AKlQ6UE8I5QG2tHKN1rBlwidB48swu5c9dHYmYNWw=
X-Received: by 2002:a17:90a:db92:b0:27d:4f1f:47f5 with SMTP id
 h18-20020a17090adb9200b0027d4f1f47f5mr2628295pjv.23.1698410226402; Fri, 27
 Oct 2023 05:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230904133321.104584-1-git@andred.net> <20231018111508.3913860-1-git@andred.net>
 <717fd97a-6d14-4dc9-808c-d752d718fb80@ddn.com> <4b0b46f29955956916765d8d615f96849c8ce3f7.camel@linaro.org>
 <fa3510f3-d3cc-45d2-b38e-e8717e2a9f83@ddn.com> <1b03f355170333f20ee20e47c5f355dc73d3a91c.camel@linaro.org>
 <9afc3152-5448-42eb-a7f4-4167fc8bc589@ddn.com> <5cd87a64-c506-46f2-9fed-ac8a74658631@ddn.com>
 <8ae8ce4d-6323-4160-848a-5e94895ae60e@leemhuis.info> <CAOssrKdvy9qTGSwwPVqYLAYYEk0jbqhGg4Lz=jEff7U58O4Yqw@mail.gmail.com>
 <2023102731-wobbly-glimpse-97f5@gregkh>
In-Reply-To: <2023102731-wobbly-glimpse-97f5@gregkh>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Fri, 27 Oct 2023 14:36:55 +0200
Message-ID: <CAOssrKfNkMmHB2oHHO8gWbzDX27vS--e9dZoh_Mjv-17mSUTBw@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "fuse: Apply flags2 only when userspace set the FUSE_INIT_EXT"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Daniel Rosenberg <drosen@google.com>,
        Alessio Balsini <balsini@android.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Bernd Schubert <bschubert@ddn.com>,
        =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 12:40=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Oct 25, 2023 at 03:17:09PM +0200, Miklos Szeredi wrote:

> > I don't think the Android use case counts as a regression.
>
> Why not?  In the changelog for this commit, it says:
>
>     There is a risk with this change, though - it might break existing us=
er
>     space libraries, which are already using flags2 without setting
>     FUSE_INIT_EXT.
>
> And that's exactly what Android was doing.  Not all the world uses libfus=
e,
> unfortunatly.

No, this is not about libfuse or not libfuse.   It's about upstream or
downstream.  If upstream maintainers would need to care about
downstream regressions, then it would be hell.

How should Android handle this?  Here's how: they have an internal
patch, which conflicts with the patch they want to revert.  Well, let
them revert that patch in their kernel.  It's not like it's a big
maintenance burden, since it's just a few lines.  This is the sort of
thing that downstream maintainers do all the time.

It's a no-brainer, what are we talking about then?

Thanks,
Miklos

