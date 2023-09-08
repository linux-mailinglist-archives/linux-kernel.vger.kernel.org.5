Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FA8798C4B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240352AbjIHSLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239886AbjIHSLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:11:38 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0232682;
        Fri,  8 Sep 2023 11:10:55 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6bf01bcb1aeso1745573a34.3;
        Fri, 08 Sep 2023 11:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694196241; x=1694801041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0BC5AdZDTmF7z5ChU/rQxu18uHOTMhJPMK4z/qlXRc=;
        b=SsyKjVvpck/vkupkd9DFDQxGhsMK7TT313w1G45DKi/+0RDittkwrhTlvr3qJzZVXO
         e3puttLKt94ZDeawVw4Y4t8l5YIDdG/ncsiVdFi44vs7M9tDjd3zI4GmfNGT25oi9Txa
         dSL8QATwTk1F4rHkQS9IVcJkkRNZ3wNowsntOmbv2I/0nyzt/PFQ9ZSSv7lchm5ZOYQO
         W9h81IHqpJfR5C40tGdMnaCGeqLM62SRI9EDU6V8bRX8Mw8K/XiacEvXL8AxLxn6TJIa
         pds0lHXC+OVbzCpO1Q8L2m/ibDsoQNRCQzrokJyeeYz1gd6IATDxmFH8Zjc3sDOBLWeo
         EwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694196241; x=1694801041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0BC5AdZDTmF7z5ChU/rQxu18uHOTMhJPMK4z/qlXRc=;
        b=qigmIWO7nEFg7kezH+TaPhaNBNmh19IFyApL0IU+QrPTvtgEKvEbefXtqvQZAr6/qC
         wt1/MnBfxjVMYjAcPFr26OWvFXZZqhdddNfLtbEtT6kfaHmWxkMLbIiGl1HcRmaxglwf
         VvdoM3pimflSn1sg7huneAnj4G607EYoG107woi65/LsHLareGlR2StVroT/P4uUcDfD
         ZxGEz1INOE3KZzZhQnPVm+gevvyosDJUogp3Jxb3pQsFvk2ciX8rfe7Jsdc4oPqPJrU0
         Kr0mKGoMLku/I4cPDFcsol3FK/1F9Xxytms3ouE8du0MBBkRGzNfyJgWDL0DMeJ4ipnr
         iVfg==
X-Gm-Message-State: AOJu0YyRTvaB05Y+trxiH8Ora9A/F/MpsqKEmyU1bPmj9jG8oP9XoYWM
        DPoXa+i0PWz4h0TtXKhdjUfiW5S0QyzfSpYNALM=
X-Google-Smtp-Source: AGHT+IFBqDBipIhOiWV6eUP137vR+BsFoE2ZuAvBhhwAwCCT1ePnExRXZHTyxxFeBPe5DByYkpH6lzzFnYCGlnIYE40=
X-Received: by 2002:a9d:6a11:0:b0:6bc:88da:af44 with SMTP id
 g17-20020a9d6a11000000b006bc88daaf44mr3518599otn.6.1694196241406; Fri, 08 Sep
 2023 11:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230818151220.166215-1-cgzones@googlemail.com>
In-Reply-To: <20230818151220.166215-1-cgzones@googlemail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 8 Sep 2023 14:03:50 -0400
Message-ID: <CAEjxPJ4J6UpwyazPV0eouBJ8rOScF2RUh0Hw6qaL9hNeb3j8JA@mail.gmail.com>
Subject: Re: [PATCH 2/6] selinux: dump statistics for more hash tables
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 11:12=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Dump in the SELinux debug configuration the statistics for the
> conditional rules avtab, the role transition, and class and common
> permission hash tables.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Aside from the question I asked, which I have no strong opinion about,
Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
