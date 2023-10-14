Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAFD7C94DE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 16:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbjJNOik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 10:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjJNOii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 10:38:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A242BCA;
        Sat, 14 Oct 2023 07:38:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3237CC433C8;
        Sat, 14 Oct 2023 14:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697294317;
        bh=Vv6SV6oN1OVHcZb9IDPODgYh6oBYxcG6c9SVb6aprlY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ET/NkGMSLCvd83SCY3wAv1CnFtmoJDcxGm7NA9Q2T3mHawnqwBe+dir9Xo/rE6LRu
         2kNdtY0dIUUzwGgEbNcq/kCdpNPvH1vvcNuvjMsP/k6V8ebimW3A3zE+9TKZlGey3E
         cZVI8Arn78gLqsP9a2ckLHYNiwtYh4MCfNptRhheqYtCJ9mdmXDAP35G16E/aTnki4
         vepcNq8AXfWvoy904WuPpG1ujUyHV3csju61RmNXthCyyXYDckLqu6j+/7uk2tjbgm
         kdfFWlNk8HSDQnJay7csZJsZKsNU65xGhQkvSJYPfxqKQeDk64SEha7NL4M+MI6qsv
         hwnQ2i78ljSaQ==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-57ddde51033so2135558eaf.1;
        Sat, 14 Oct 2023 07:38:37 -0700 (PDT)
X-Gm-Message-State: AOJu0YyjWe/XAjjg1zDZuZx/gaHc1xmi4fpRmw15Zv+kfWHJorsDSBRV
        A4Rd3e/93VoAuiMFPIaPf/ao0+y+5PVA0jnr5/g=
X-Google-Smtp-Source: AGHT+IEBy4o+v+8BgK883jI/uyZFEQRR4GZNCI3KBg+B0NkqkseUlKPu34U5aJU4hi2BKQdCyl6hjK2RCjxcgd29LkQ=
X-Received: by 2002:a05:6870:8e0c:b0:1e9:668f:46d0 with SMTP id
 lw12-20020a0568708e0c00b001e9668f46d0mr1505657oab.19.1697294316564; Sat, 14
 Oct 2023 07:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231007170448.505487-1-masahiroy@kernel.org> <20231007170448.505487-2-masahiroy@kernel.org>
 <79f74670-768b-46f7-b484-a45ddcd9dc6f@t-8ch.de>
In-Reply-To: <79f74670-768b-46f7-b484-a45ddcd9dc6f@t-8ch.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 14 Oct 2023 23:38:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQDhZ2rJE19b0R5Su5O_N7+4VSa9Fzo90bnh4K7o_BsAw@mail.gmail.com>
Message-ID: <CAK7LNAQDhZ2rJE19b0R5Su5O_N7+4VSa9Fzo90bnh4K7o_BsAw@mail.gmail.com>
Subject: Re: [PATCH 2/5] modpost: fix ishtp MODULE_DEVICE_TABLE built on big
 endian host
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 8, 2023 at 4:51=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisssc=
huh.net> wrote:
>
> On 2023-10-08 02:04:45+0900, Masahiro Yamada wrote:
> > When MODULE_DEVICE_TABLE(ishtp, ) is built on a host with a different
> > endianness from the target architecture, it results in an incorrect
> > MODULE_ALIAS().
> >
> > For example, see a case where drivers/platform/x86/intel/ishtp_eclite.c
> > is built as a module.
>
> Nitpick:
>
> ... [as a module] for x86.
>
> So the statements below can be interpreted correctly.


OK, I fixed up the comment when I applied the patch.
Thanks.


--=20
Best Regards
Masahiro Yamada
