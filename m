Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D49B798E9E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244959AbjIHTFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240371AbjIHTE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:04:59 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD281186;
        Fri,  8 Sep 2023 12:04:53 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6c07e122a78so1651503a34.2;
        Fri, 08 Sep 2023 12:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694199893; x=1694804693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgzEk2qkub3asCAutUtOqbBvRUsJGSuCfeMNtvAIVwM=;
        b=FJOGCGCB1rWwgLejy1eJSrAKT7oaDlakCb7nrgR8fCQpE8Oj+FidKK8wWtkx8v3ckj
         0Apz6lAqgf850DPPoPgDYz0ZPjV7jaRBeQ7f4tEH0xPG0Z3BMybgsLkL5bj0O4PZnlJw
         goh55l+yx3/+O1fRRYg9SntvS1GF226cRbaJd5n7XauW8SqzakvR/K259dP8PqYV3QmA
         Ya2rJ3dQejPQibZIkX0xRiqlSNVne3AuXsMYrXbenVT5DWM2GAbZX9mOlcqSIdp/UzZI
         rPhULOdas/7Mrja7O5i2X79EUBm5mciX3pzPNEaK3619/J+pAyG5zXabyxy77UgXPjtY
         ipGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694199893; x=1694804693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgzEk2qkub3asCAutUtOqbBvRUsJGSuCfeMNtvAIVwM=;
        b=JwvET/DCgGcANtoGZaUP3F1uDxT47S2ENtDtBLMRlQ6SHMqGqza7hi5kP9S2Qzu3Ta
         1Q4TSToy3FpJxHO9N114cPPUD6Eed+y0bXXiImHvJ/2vQJoAoG2uY7XR5513+8lMHSTP
         XcPaK5UTyVRZA1LEeav+wzMqpq9s+VdBS2yAWYK/gjn84XZ/GN/joO1zb3R4dMS26sZT
         iO2V0VQv7imueCDBkIrsEwMUQiB7C1EVGSHl1ILZj3/rOGVMNCFbyy0wujxdxzfrvzP3
         hi+2K9C5hC1PkEGePQtZwScbnYKdzoX6Rwdz5C7gBzAptjDOBq73okMl3maPDthSN6GH
         Nj2Q==
X-Gm-Message-State: AOJu0YyWo5m9mkbJZVlmzd4Y/i1ObEkmyqCCws6EfMp/CapW3DHfsduH
        ZZDp0VOSfyBRaiPrOZevHE/V/qSt98QIr8eNH4g=
X-Google-Smtp-Source: AGHT+IEdu4UP7K8lWbLtvXhmHQxq55TJqdSAd8r/tdJ+ykZfzJ0WakRKnEo55G5CrGkVndvSpChRcFsGuP/Bjk6j0vk=
X-Received: by 2002:a05:6830:10da:b0:6b9:2989:c261 with SMTP id
 z26-20020a05683010da00b006b92989c261mr3252569oto.21.1694199892969; Fri, 08
 Sep 2023 12:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230818152910.176044-1-cgzones@googlemail.com>
In-Reply-To: <20230818152910.176044-1-cgzones@googlemail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 8 Sep 2023 15:04:42 -0400
Message-ID: <CAEjxPJ650OQ0VirNwhOiFnbNMR+w8kaxLF4wjY2QGLZ=1Ufgdg@mail.gmail.com>
Subject: Re: [PATCH] selinux: reject invalid ebitmaps
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
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

On Fri, Aug 18, 2023 at 11:29=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Reject ebitmaps with a node containing an empty map or with an incorrect
> highbit.  Both checks are already performed by userspace, the former
> since 2008 (patch 13cd4c896068 ("initial import from svn trunk revision
> 2950")), the latter since v2.7 in 2017 (patch 75b14a5de10a ("libsepol:
> ebitmap: reject loading bitmaps with incorrect high bit")).
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
