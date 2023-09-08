Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394EE798E82
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239471AbjIHS47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238172AbjIHS45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:56:57 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CB91BF5;
        Fri,  8 Sep 2023 11:56:21 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-58cd9d9dbf5so32837587b3.0;
        Fri, 08 Sep 2023 11:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694199322; x=1694804122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExdORgkHFjC/6koOVRzQbhxqfEwiczzROf102Hctdl8=;
        b=XV6VW2Zq3CoaaY5DV7klr1OE4V7HHqVhY+s1Exv0KyFjGUW/A+zhrUsxbWU1x5C6E6
         95bGbunn04I9Tpc28ZC1LqqoAdiYm0xiXK78WURDs6tGDuHGeUCpjtfC2Su6xR+wdmZB
         EjFTAv7YSZUDxMDh2QqVnSXRikW1mHhEfTrMpZxtX9mNYn/k9TJ+szrZS8u8eMeD1onp
         fipyzxf6d8MnAVA0QOEuUSf1C1yrM+6q/HP0q6Zyk1DgAcTNYi8clpPG/IM/WxmHn6Af
         oYe+qF9Ry0SPhQpZVTeUy9AS9+Z+q/3QhFYzaygWUUH71DMwEq1bhAX9DgIIlpZaVg7i
         f3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694199322; x=1694804122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExdORgkHFjC/6koOVRzQbhxqfEwiczzROf102Hctdl8=;
        b=XtPk8NSrX3HHPGPyDl//bk9WWsAaBsiAMkNR5ErQ7LToVhqXB71jo3k8Bh5SkZp8Tf
         D/vp/mpVauZovAU9GFsecdj+/GuRUYiVplW2DmVYKa4SGsEMe6vDwG7OCUP45rz3TQvO
         +2J1p3x5b6gO/pb7/Xyezdvmz53QnidrpyhIOoNlr1MlYH7ooIZQz7AkQgGWjEBoHJFe
         eKcMLsY5RfbEAbSVB9j8QfZucUMzBFm72DWQkfal36QdArReVcWHGyfIF1+3re/uvLX0
         l2y/0v5twd4dZ5oSBH9a3C/tFcvm40cr2UfR95rNH80dt37leAtrGUL5AaXMpftJGAKt
         LqLQ==
X-Gm-Message-State: AOJu0YxQvKSJlYPPPgjAWVATBDqh7xFt8maA1OL0N7+hEmd2i6mr0+S9
        c5vrgLdANI41sgxjpKVdgoMDviBJFM9vTaxnf+RTLhvG8rU=
X-Google-Smtp-Source: AGHT+IHD9RLOX3oAW9xNhsxji32lMjNhSLgQPIi2C6Hwi+DpWteNVoYLvCQY62Ndm8NBtuI93YZu2RPF1hZd4tkyCts=
X-Received: by 2002:a9d:7a8a:0:b0:6ba:864e:c5de with SMTP id
 l10-20020a9d7a8a000000b006ba864ec5demr1432864otn.8.1694198799372; Fri, 08 Sep
 2023 11:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230818151220.166215-1-cgzones@googlemail.com> <20230818151220.166215-4-cgzones@googlemail.com>
In-Reply-To: <20230818151220.166215-4-cgzones@googlemail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 8 Sep 2023 14:46:28 -0400
Message-ID: <CAEjxPJ7Js6TJg3=uadoFc_P73-SVG2=0cQ1d5UpC9qOHdreR-g@mail.gmail.com>
Subject: Re: [PATCH 5/6] selinux: improve role transition hashing
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 11:12=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The number of buckets is calculated by performing a binary AND against
> the mask of the hash table, which is one less than its size (which is a
> power of two).  This leads to all top bits being discarded, e.g. with
> the Reference Policy on Debian there exists 376 entries, leading to a
> size of 512, discarding the top 23 bits.
>
> Use jhash to improve the hash table utilization:
>
>     # current
>     roletr:  376 entries and 124/512 buckets used, longest chain length 8=
, sum of chain length^2 1496
>
>     # patch
>     roletr:  376 entries and 266/512 buckets used, longest chain length 4=
, sum of chain length^2 646
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
