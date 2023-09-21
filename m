Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18FA7AA504
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjIUW1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjIUW1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:27:13 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEB094;
        Thu, 21 Sep 2023 15:25:23 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-4121130e7afso9519171cf.2;
        Thu, 21 Sep 2023 15:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695335122; x=1695939922; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w2WooG+QkTpfUqojwok2CEiVMWZpsqmSjm3ZHCN+V1E=;
        b=CJT4O9x+XcC9h0sn1qHpjKLXnTYL10SrXVHnIbScnMdqgrd/MY1fNwA99qTJVbtkh3
         2jsB/7k0b0CCskbwfyIB6+3I69fsbD9aUIL4wtKcPKHfbfZnp9urVeSztfy3MmcGG9TQ
         vm4ddzBKs/TeqoUQGkp5d+qF4c0G0Av68l+4reWx3y8dEPQaddLXAriaJSsRDgQKFuMX
         FwistacHrieu7Okssq5KBNgSTDTI/VeWvCRsK01UdTimCZn8ZxbOHm8baenOTW0z4jmE
         t/cX5cAldB3fLHrOT3Z14wA6aELGfll9weZ51riZqeK7ampbpV+dRqQUJDD4bt/TF283
         zwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695335122; x=1695939922;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w2WooG+QkTpfUqojwok2CEiVMWZpsqmSjm3ZHCN+V1E=;
        b=dc/o5SjdTUCui/L7FmSjQidQsNG+kg1cVfdwjSMAaZzGgFSdwhHuE2zsT0eTbroHbG
         4ZoQzyNogCoROO3NEqTSND9VaVVIR05u+k3HQSEtUmi9PM65OOmKTI8GECGfMQJDbUIT
         DartBY8VLXUkIglZQqezDj14CFA2Gl/g6/HUzAKtLG96b+32Yg4I9nY7IdB8Wb/EDcmJ
         cDj+UY5FulOuSXPS+9OmSewpLkzN9eSw1+MptGgX+g3RYxTn7S5mcZEStdgZUSo/2iaJ
         ZX7nVwwazpPZTyJ9hKwhp9ZRM9kLO5a7j9Py6hzXiGW8lbBjdn7JmvR60ohaI5KctdHH
         OzBg==
X-Gm-Message-State: AOJu0Yy32VwFmpkcSJoeU710hYfJdFl6cskbFKOyl1AOUguevFG8VZpW
        NCey/G883bDMj82jaUUpaqwYfax78dI=
X-Google-Smtp-Source: AGHT+IFF0Fxu8IrAYMqbYE9O+JZeHJhGWgzy2cxwLDKKEWylEYlzdyNJ+FOguWr32UjLJJaA5m+Wew==
X-Received: by 2002:a0c:e106:0:b0:651:6968:ae40 with SMTP id w6-20020a0ce106000000b006516968ae40mr6418148qvk.20.1695335122511;
        Thu, 21 Sep 2023 15:25:22 -0700 (PDT)
Received: from freeip.amazon.com ([205.251.233.111])
        by smtp.googlemail.com with ESMTPSA id v7-20020a0ce1c7000000b00655d55117f5sm924928qvl.81.2023.09.21.15.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 15:25:21 -0700 (PDT)
Message-ID: <2031eecaa417d4f6021717dcbbba133d784add72.camel@gmail.com>
Subject: Re: [PATCH stable 6.1.y 2/2] KVM: arm64: Prevent unconditional
 donation of unmapped regions from the host
From:   Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     stable@vger.kernel.org, james.morse@arm.com,
        alexandru.elisei@arm.com, suzuki.poulose@arm.com,
        oliver.upton@linux.dev, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>
Date:   Thu, 21 Sep 2023 15:25:19 -0700
In-Reply-To: <877cok3skn.wl-maz@kernel.org>
References: <20230920192729.694309-1-surajjs@amazon.com>
         <20230920192729.694309-2-surajjs@amazon.com> <877cok3skn.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-21 at 08:15 +0100, Marc Zyngier wrote:
> On Wed, 20 Sep 2023 20:27:29 +0100,
> Suraj Jitindar Singh <surajjs@amazon.com> wrote:
> >=20
> > From: Will Deacon <will@kernel.org>
> >=20
> > commit 09cce60bddd6461a93a5bf434265a47827d1bc6f upstream.
> >=20
> > Since host stage-2 mappings are created lazily, we cannot rely
> > solely on
> > the pte in order to recover the target physical address when
> > checking a
> > host-initiated memory transition as this permits donation of
> > unmapped
> > regions corresponding to MMIO or "no-map" memory.
> >=20
> > Instead of inspecting the pte, move the addr_is_allowed_memory()
> > check
> > into the host callback function where it is passed the physical
> > address
> > directly from the walker.
> >=20
> > Cc: Quentin Perret <qperret@google.com>
> > Fixes: e82edcc75c4e ("KVM: arm64: Implement do_share() helper for
> > sharing memory")
> > Signed-off-by: Will Deacon <will@kernel.org>
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > Link:
> > https://lore.kernel.org/r/20230518095844.1178-1-will@kernel.org
> > [ bp: s/ctx->addr/addr in __check_page_state_visitor due to missing
> > commit
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "KVM: arm64: Combine visitor arguments i=
nto a context
> > structure"
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in stable.
> > ]
>=20
> Same question.

Noting what changes were made to the patch from the upstream mainline
version when it was applied to the stable tree.

>=20
> > Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
>=20
> Again, I find this backport pretty pointless. What is the rationale
> for it?

The 2 patches were backported to address CVE-2023-21264.
This one addresses the CVE.

Thanks

>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0M.
>=20

