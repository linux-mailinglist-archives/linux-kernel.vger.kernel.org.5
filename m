Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D637C01F4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbjJJQtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjJJQtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:49:50 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA2F93
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 09:49:49 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-537f07dfe8eso115a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 09:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696956587; x=1697561387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzghsbCDjRJsjSD3ib2zlQsnADkOVOzAmS7OkMaiGB8=;
        b=UxMSbLyadYpu1xVhyOPHfBldq2CeBXwJ7TAzARd9OyjGr7UCZwOY+glXPriRO6wAyY
         mz+so/Ia2cnvqBcJMMozyLkZBjJ5RpX9rVmlrx0L0RAI2P7BE3c2P/9ikEnEyG5HCo6+
         IGdf5PynLkX3jALT+hKcAM+sRm6neSDPL9CyYQNu1HTjIjGIyExaEskAvZvJOKPXBWAN
         JuVHC2uvyuzSI3lEtdvsiyIacwb1B58dMtWx5ufsG5nVTm4x0Sl7+c83I/bO4Xzvlbqw
         IK1Q7wlzUi52Si8lSjCfR5o/XaKaCVwPu/vnuL9yj6A7xqLZCAOqdASYlu1UChVuqqtC
         EmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696956587; x=1697561387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzghsbCDjRJsjSD3ib2zlQsnADkOVOzAmS7OkMaiGB8=;
        b=lmMS/+pZ0BN39Xu1fLqq0+D7ksjPuPFWm5LrU5vx211vKDDWD0NJlXS9/YLCZVb5iq
         JSQiDLxjwEEHoDjdSoLnu3CfiX6PDn6PgyVBmssDIw96vBC5I5u3I6/Hp6xvZLJpvzvT
         tuQnJeF+8OU0p5TSQeI9lTLKWvMR3Wk7VPFc4fpxjhGMq29D0YpGnkFQtDDuq+az0RhW
         f6FwRMTqoSnnD7x50sjHkpXrZEj4rQYHsKneTcc+QEkgS6RL4l7OaCdCVlrFO+tURN0E
         IyDeNypPH+7YNhQDyXDg5XWSQCCIMyAYxQcghUQNb/vl0lrBLnUWwEfe3OW+7zTv7vaX
         4+UA==
X-Gm-Message-State: AOJu0YxrHwrSYRZjhn5EhI1ykimYzF7GAxXHZR5OVmur6tVCcx8qYYU9
        zMgrioDVCEiOowqITt1Cg3wc02hbUZSPoI3r/+w/pw==
X-Google-Smtp-Source: AGHT+IHCGN9JNYAYRJrPJuZIMwYUV0QgxRaw9dM4fLl3AFJYUBdk+FWKGZlP839JVyblIgW4mGse8vBPdDX6ad6Gjas=
X-Received: by 2002:a50:aada:0:b0:538:50e4:5446 with SMTP id
 r26-20020a50aada000000b0053850e45446mr1171edc.5.1696956587422; Tue, 10 Oct
 2023 09:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231010100441.30950-1-jose.pekkarinen@foxhound.fi>
In-Reply-To: <20231010100441.30950-1-jose.pekkarinen@foxhound.fi>
From:   Peter Gonda <pgonda@google.com>
Date:   Tue, 10 Oct 2023 10:49:36 -0600
Message-ID: <CAMkAt6o7urak_kAjxEU4wtXv-mGOnyOYdcyhCRMfAG3MAOip0g@mail.gmail.com>
Subject: Re: [PATCH] kvm/sev: make SEV/SEV-ES asids configurable
To:     =?UTF-8?Q?Jos=C3=A9_Pekkarinen?= <jose.pekkarinen@foxhound.fi>
Cc:     seanjc@google.com, pbonzini@redhat.com, skhan@linuxfoundation.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 5:22=E2=80=AFAM Jos=C3=A9 Pekkarinen
<jose.pekkarinen@foxhound.fi> wrote:
>
> There are bioses that doesn't allow to configure the
> number of asids allocated for SEV/SEV-ES, for those
> cases, the default behaviour allocates all the asids
> for SEV, leaving no room for SEV-ES to have some fun.
> If the user request SEV-ES to be enabled, it will
> find the kernel just run out of resources and ignored
> user request. This following patch will address this
> issue by making the number of asids for SEV/SEV-ES
> configurable over kernel module parameters.
>

All this patch does is introduce an error case right? Because if the
BIOS hasn't actually configured those SEV-ES asids and KVM tries to
use an SEV as an SEV-ES asid commands to the ASP will fail, right?

What happens when you try to create an SEV-ES VM with this patch, when
the BIOS hasn't allocated any SEV-ES asids?
