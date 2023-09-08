Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB4F798E63
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240003AbjIHStj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239298AbjIHSti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:49:38 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB39A1BF9;
        Fri,  8 Sep 2023 11:48:59 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6c09d760cb9so1642238a34.2;
        Fri, 08 Sep 2023 11:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694198880; x=1694803680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OhdGfaSAosi+Jeg13gZjnmBKkNLiGPRHNdQ81D0fCU=;
        b=bCj/BXJvKeh/uvJnFNwDA2tdm1fLT04OVeEs7+JE6BKxhY1C5fp6MmWpvL+cndRUac
         pdAOq/OR0lmW1eJjA05O0FHmSirLvtPJwQf4cROnVRuWNa0hXD6wZFMAg9AhGR3RtbZp
         oOQSFZ/d6o7o0bddb+Cc+0ByciLMBbckOctgABvr2Fn0Ks9rCbOOJOv2hXVCfcJvh5Y/
         u0MgFGHqdLI0fur2/X0rQemsxF4/JicUQlX9kCdJJ2iWatHhPNABI4Q8MzCDBoI+Fwt1
         4/ZR1wUokCtz2cXBHLXwgoTrgelf5ICk/7q5U0IkHTfXiXfaEi5J/W9yLSKnQ0S1IKuI
         mG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694198880; x=1694803680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6OhdGfaSAosi+Jeg13gZjnmBKkNLiGPRHNdQ81D0fCU=;
        b=beZgezjP+OAdqwq8Qx95DXYEUzIvyWbxX0zupYyamVcVCsau/XxjHrYzEUap234a/b
         LJPOSCxEe6YKS+Lfw8sdbNMz8OvCCts7wAphZdAEAZPU4thxDEbKMvurwT3OZwBvvrri
         KYokK4D9iWr0jAgoXqRR18oF7O8AAA1Xi+jZwWj5JsUmjiiJbiLjXIfULei4kVXzuQJU
         R98iyA1F3qAJ3hzF5eIgWzAFQ3pXgZbF0WpD6q3YwaV9Juqb5pncOgYoSGNQ3L/SGUbi
         PwV36qoWZEEwABTajCILXJrcuZcmdb55v7z0mZ241J5hWpdSbtz9McLSJiqhbDmdiZRQ
         8yhQ==
X-Gm-Message-State: AOJu0YyOhJaIa6YnRVnUD6McJdprTCPyDm2gnSPNrQs50wcwMuGBr96T
        y0lIaVUquutD4Ia87AyI1HipgfQAs7e9W5OPF3A=
X-Google-Smtp-Source: AGHT+IEg6RV0F3LkR7tYzZNIDqTKUnETmSSAcrJmG1OW0s1Y6p2JOGEwiXkziDx5UjsQoex1JZWFpEVrukeI0eFPXyc=
X-Received: by 2002:a9d:7999:0:b0:6bd:b29:85d3 with SMTP id
 h25-20020a9d7999000000b006bd0b2985d3mr3588136otm.24.1694198880366; Fri, 08
 Sep 2023 11:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230818151220.166215-1-cgzones@googlemail.com> <20230818151220.166215-6-cgzones@googlemail.com>
In-Reply-To: <20230818151220.166215-6-cgzones@googlemail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 8 Sep 2023 14:47:49 -0400
Message-ID: <CAEjxPJ52-gr+7EswzgJW14Q8VkFazE2RJ-9uGTTG4m4CB9Ck4A@mail.gmail.com>
Subject: Re: [PATCH 1/6] selinux: print sum of chain lengths^2 for hash tables
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 11:12=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Print the sum of chain lengths squared as a metric for hash tables to
> provide more insights, similar to avtabs.
>
> While on it add a comma in the avtab message to improve readability of
> the output.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
