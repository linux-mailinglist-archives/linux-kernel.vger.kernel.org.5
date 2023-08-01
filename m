Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0205B76BCB2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjHASnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjHASmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:42:50 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889F226A3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 11:42:32 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52227884855so9109981a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 11:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690915350; x=1691520150;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VhUDsrggxWE6/cGjEOALfjpnRWj6WRZJe/kOVyWiR0I=;
        b=EqSe7pFOurEseFRF56MMkhsqVIuFka3xZBIiptwb/MRsMrmvfb+uNNuu2FQOMlQS/A
         LsgMhlJNlHWAO28Q1CE+vP9Q2VaEBvzuc7EN72nzNikBsDwN3ds+b4MIqP5bMuouYhIa
         nPkRRtLtXCA++yz7k5mOUzQpoVS9pPkBEo+BE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690915350; x=1691520150;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VhUDsrggxWE6/cGjEOALfjpnRWj6WRZJe/kOVyWiR0I=;
        b=GLW3vx9t/n2RsiOBuG3kuUfC8OFaH+IP5esANd9QXvHNp7K68JesgVOS5IB1qpyYtE
         KE1Hytegeb6gS9a3fUmpjOKdeLgVNomHmkJb2wieAE9G4c8ASjcEZi/3/JpztiRI8jFJ
         muMe5/MtGPJkbyoJa4jOV4X1YbqAHFp1c7AHXG3CYtAR5AhgHCXiQlXADwebpldgc1NE
         lSwEIzXFzwdUOn6OUJCCDKLri3cP1WfVSyh2MpYSKR68I6o+ctaEdVoWryBOn/YcKJx8
         4ETl1E3n6Nb/CGifbcmQvUqyw94c2Z/0Qqz8LUoV/DnUtZWHhsiBycbbM2pQPs9aQWuU
         0ILw==
X-Gm-Message-State: ABy/qLa+al8aVontP1h1RzkxIuePTtiqAnuZNVghNanph6SBiL+NydDB
        LeS78GdsItJ669ZCsaMaoulE+3r7FDUlH0GTPPHBv0l4
X-Google-Smtp-Source: APBJJlGkNxn7GhTiZ9MVW9R+B6Yru0nNfgwVrAVrQfGSHD7vkeVkRyVjbQ0KIvf+5V6nWS45kYcL9Q==
X-Received: by 2002:a17:906:3144:b0:99b:c985:cf7e with SMTP id e4-20020a170906314400b0099bc985cf7emr2923293eje.54.1690915349805;
        Tue, 01 Aug 2023 11:42:29 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id z7-20020a170906074700b0099293cdbc98sm8109902ejb.145.2023.08.01.11.42.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 11:42:29 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-522bc9556f5so4533541a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 11:42:28 -0700 (PDT)
X-Received: by 2002:aa7:c6d2:0:b0:522:21a1:4245 with SMTP id
 b18-20020aa7c6d2000000b0052221a14245mr2802747eds.27.1690915348590; Tue, 01
 Aug 2023 11:42:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230727183805.69c36d6e@g14> <b1dd27df-744b-3977-0a86-f5dde8e24288@amd.com>
 <20230727193949.55c18805@g14> <65a1c307-826d-4ca3-0336-07a185684e5d@amd.com>
 <20230727195019.41abb48d@g14> <67eefe98-e6df-e152-3169-44329e22478d@amd.com>
 <20230727200527.4080c595@g14> <CAHk-=whqT0PxBazwfjWwoHQQFzZt50tV6Jfgq3iYceKMJtyuUg@mail.gmail.com>
 <CUGAV1Y993FB.1O2Q691015Z2C@seitikki> <CAHk-=whphk8Jp=NYmnm7Qv+vZ6ScYCz+rV8a2G1nD-AQY3z+mQ@mail.gmail.com>
 <CUHF67ZOFOTN.1UFE7Q1IFRQMX@suppilovahvero>
In-Reply-To: <CUHF67ZOFOTN.1UFE7Q1IFRQMX@suppilovahvero>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 1 Aug 2023 11:42:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgK0Z-LrJGExwG=e=oxjD93LJhY3jMmi_2O2_Pkjf8Tsg@mail.gmail.com>
Message-ID: <CAHk-=wgK0Z-LrJGExwG=e=oxjD93LJhY3jMmi_2O2_Pkjf8Tsg@mail.gmail.com>
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Daniil Stas <daniil.stas@posteo.net>,
        Mario Limonciello <mario.limonciello@amd.com>,
        James.Bottomley@hansenpartnership.com, Jason@zx2c4.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@leemhuis.info, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2023 at 11:28, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> I would disable it inside tpm_crb driver, which is the driver used
> for fTPM's: they are identified by MSFT0101 ACPI identifier.
>
> I think the right scope is still AMD because we don't have such
> regressions with Intel fTPM.

I'm ok with that.

> I.e. I would move the helper I created inside tpm_crb driver, and
> a new flag, let's say "TPM_CHIP_FLAG_HWRNG_DISABLED", which tpm_crb
> sets before calling tpm_chip_register().
>
> Finally, tpm_add_hwrng() needs the following invariant:
>
>         if (chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED)
>                 return 0;
>
> How does this sound? I can refine this quickly from my first trial.

Sounds fine.

My only worry comes from my ignorance: do these fTPM devices *always*
end up being enumerated through CRB, or do they potentially look
"normal enough" that you can actually end up using them even without
having that CRB driver loaded?

Put another way: is the CRB driver the _only_ way they are visible, or
could some people hit on this through the TPM TIS interface if they
have CRB disabled?

I see, for example, that qemu ends up emulating the TIS layer, and it
might end up forwarding the TPM requests to something that is natively
CRB?

But again: I don't know enough about CRB vs TIS, so the above may be a
stupid question.

           Linus
