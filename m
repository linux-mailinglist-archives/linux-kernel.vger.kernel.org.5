Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3618C7D800C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbjJZJxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjJZJxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:53:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A3C193
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 02:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698313969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jUGHXZ5r8VrtHiU2cyOY7n2q1m3B5M1JVdNETd/i4xs=;
        b=EsRxGBT8Tf1vr4ERqUeYWtCRV2Inp/JEYRp2LzR0HusxPig+0K0Mo+AQz3L0dNivyNyDxm
        GAv1wBHqXMhGIdh2dHcKw5SSbozSpV3+v3cJBlibo/CSF9YwlB+VJpb1dsgy85MKDXcsb/
        L2uf2I/iaFbmDMOJaDNezPb9i+bIOBU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-iqzFalcmM0mIa8UKX9xL-A-1; Thu, 26 Oct 2023 05:52:47 -0400
X-MC-Unique: iqzFalcmM0mIa8UKX9xL-A-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-27ff2533572so611457a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 02:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698313966; x=1698918766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUGHXZ5r8VrtHiU2cyOY7n2q1m3B5M1JVdNETd/i4xs=;
        b=rzu/1zbi5gafhiUdop7rPOlMmdEL3H6t02Ikq7g33gcyMKP/LiWAOC1I+cwjEZIdWK
         qqhspsqRpEinsA0tctDes2tqtMII27DC97tG8Eh1RjWwuKAZWzgVWrXeXhRB7pC/6Q6r
         7v9j5V5Rlt2S7HzZsiDuEKPtUUNJAi4NPF2hKZlcnKppJlErnIXUkCrd0H9k6KTDnh30
         /jnnqWUEsLMiTzlIVXWVWdTQ4AumNyoiup02LEZ8d+hCKYiyZ0aRmsphRT1SUAdJ4dgV
         38ogx36mfwConRey/G/E6aiq544jmPsXV5N2LSvnlTa5WiU5Rqm/BctqnV2ALCKyg7kc
         NVcg==
X-Gm-Message-State: AOJu0YzIdWgL4z+g+p5OMicn/wQJzyleyDnS9tGKhtOXdnsFh4zJJwwt
        cKdjQuG2zcbeB8zLuexr9kd9Ej946vwJo/8etZKl3POIvP85MyBLdyC8/+gt/VWH14XNAaeQV+D
        Fu4bvOxf955AgKQfiwapDLK9Nd+5Oj7LDtoOsSX2u
X-Received: by 2002:a17:90b:249:b0:27c:f8f4:fedb with SMTP id fz9-20020a17090b024900b0027cf8f4fedbmr18110615pjb.21.1698313966505;
        Thu, 26 Oct 2023 02:52:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgk4/kJhkFPCMHOgTd7sEScBvvWywAJ1OkK+lKiIO5zFIKTID1rSDbDOBT052LbLAdSfEULw2Ln8eFpenKLFc=
X-Received: by 2002:a17:90b:249:b0:27c:f8f4:fedb with SMTP id
 fz9-20020a17090b024900b0027cf8f4fedbmr18110597pjb.21.1698313966251; Thu, 26
 Oct 2023 02:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231020102901.3354273-1-mszeredi@redhat.com> <20231020102901.3354273-2-mszeredi@redhat.com>
 <3ab474953c734d0bbf0177bf5d208799@AcuMS.aculab.com>
In-Reply-To: <3ab474953c734d0bbf0177bf5d208799@AcuMS.aculab.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Thu, 26 Oct 2023 11:52:34 +0200
Message-ID: <CAOssrKd2tO9a18qEUPnxnoWzD0WSvT2G7_kcJr=uunCd1xKXYA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] add list_for_each_entry_del()
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Takashi Iwai <tiwai@suse.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 12:00=E2=80=AFPM David Laight <David.Laight@aculab.=
com> wrote:

> Adding a list_del_first() function that returns the deleted
> item or NULL to optimise it might make more sense.

Something like this?

- list_for_each_entry_del(entry, head, member))
+ while (list_del_first(entry, head, member))

This allows the compact loop condition, and I always hated having to
pass the type to list_*entry()...  Disadvantage being that the
assignment is now implicit (just as with all the list iterators).

Thanks,
Miklos

