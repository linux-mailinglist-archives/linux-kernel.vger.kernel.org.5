Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCFA8011E8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378962AbjLARla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378969AbjLARl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:41:28 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4488AAC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:41:35 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7c4bcb4e890so773908241.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701452494; x=1702057294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49RGKrTR1X9VcxqHT0Bd8fjI/0/7U8Cy9TlOTmIOtUU=;
        b=kXMk/3kNyYll74KAdmWxrZ41y1ieNvhHtp7huGD8LIbDQOhRoAoGteT/zfgTZvyMMH
         wEKIpjTuM/H4onECK/hNThbD3TT8TlL3pMrg2EMOqaV+4Lgx9SiM5/KXZtqwNooLT3Sd
         jDoQiVml+Y3xxrKbKUQT5b32CFpKGo2Ez8EJysb6ldkPYlvhHOoFna1wKLXwT8P1GH12
         0GvoiGze3z0eVV77jxiOtxwicoxgA5ENb4aVxzUsNuOeYFhnzbqrEDTI4fEcpcpplaoh
         YI/iMinxisRxXO15Y4Nx99D+ae/DBbWN/1aRIr/WMNvlO7ZgkzPTGhZ7g7M0OE/D4SKO
         vPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701452494; x=1702057294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49RGKrTR1X9VcxqHT0Bd8fjI/0/7U8Cy9TlOTmIOtUU=;
        b=aAWBKgxJxXgbFai0k/6ah0YXRFB7yJMv7Bl/UmsuMrucEKveohV/5JV0ZMnv8TCWFo
         iyMGi7XFc/OQc/jhhTzvkdLg7JcQgH8r0GTceFB46VODz7tt1rnfPb2lsDd3kW3frOCV
         P2jqmsGiPaiWeOtrlJJC62czjOUAL/SWdxJPKRKb+HUMVoAulQ2Onw9g0syb9xbAMHcu
         RlBXkauQhASCEBElEhbRa9jtdTDdz5Zz77N5Gh9ONjAuvGzyPKef6s0r9BBZaKnpDR4w
         JL9O57HUvAYZXzwF1ELrc3OTfI2rK5NkS5+qtPP2m0iNxZgeuscQgXXlOjHKpSsa64bU
         L1Iw==
X-Gm-Message-State: AOJu0YzlsMnFuMBGaaF6mw1yZ2gG9fKe2GOu17yTlpGBFdX/54zB7hVH
        EbhcnFrDDqWM+yfJ1DMNMrHpSvYXHHxyWdefzC68Jw==
X-Google-Smtp-Source: AGHT+IE+qDQwDeKNwS7sOXvHwRZNfDlXgKTSRXFs8kBpGSBTci0y5i6Rqkenkeo3WIkJMzwpKJdoK/ojvvxBcCdyb/4=
X-Received: by 2002:a67:f4ca:0:b0:464:609d:6636 with SMTP id
 s10-20020a67f4ca000000b00464609d6636mr4703210vsn.14.1701452494153; Fri, 01
 Dec 2023 09:41:34 -0800 (PST)
MIME-Version: 1.0
References: <20231121211958.3158576-1-samuel.holland@sifive.com>
In-Reply-To: <20231121211958.3158576-1-samuel.holland@sifive.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 1 Dec 2023 09:40:55 -0800
Message-ID: <CABCJKufwox6C5BprNF=rDUxfV532OcawqZBsv5hFejJgrfZ+FA@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fix SMP when shadow call stacks are enabled
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>,
        Andy Chiu <andy.chiu@sifive.com>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nam Cao <namcaov@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

On Tue, Nov 21, 2023 at 1:20=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> This fixes two bugs in SCS initialization for secondary CPUs. First,
> the SCS was not initialized at all in the spinwait boot path. Second,
> the code for the SBI HSM path attempted to initialize the SCS before
> enabling the MMU. However, that involves dereferencing the thread
> pointer, which requires the MMU to be enabled.
>
> Fix both issues by setting up the SCS in the common secondary entry
> path, after enabling the MMU.

Thanks for the patch! Looks like my qemu setup doesn't hit this issue,
but nevertheless, the fix looks good to me.

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
