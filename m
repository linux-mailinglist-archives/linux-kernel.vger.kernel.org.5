Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0CB78F356
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 21:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347086AbjHaT2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 15:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238398AbjHaT2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 15:28:48 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A379CE65
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:28:44 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52c1d861c5eso2935a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693510123; x=1694114923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEy1646/LdTkntYPfRfxD8MrrDBhc7iaLhvOs1aWaHo=;
        b=nR+0NCNnYqk8udjeOH8nLxM4N+Xa7Bkf8ZRQ1vJuPQMpUS7ya2FvN15qhfuMvr1gfR
         xbremoRY+ilpRTG5AVtcH0bIkaM6mfBuVamnIuBJkmDopdF1rLSjLds48pzWZeFtiCEe
         lNvsOL1KtzH4lgqhTyydrAMWReYwlnCfTfiQj2i7V4En99Gr57qHA4wns5KjsAVOUEOg
         tmiDIev5IhWsQn0GR4DzKPBxTd9guA8mUfzidDdOluJZwfNaA6TZ+ePXp9r5E3CSr+vm
         dHL7zj/TP9TlMArmizwcHhbWUSZ1BUxQk96Olo9QApsTBrG+ouCMBG0jviGW6LgAnCx8
         S1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693510123; x=1694114923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEy1646/LdTkntYPfRfxD8MrrDBhc7iaLhvOs1aWaHo=;
        b=VxzkcwjrEHEiWOyEowBVgT3cqJK8D1e7juVwvkTNpgglhb/osmYq50QeYZIGtWRz99
         BIlXzBngAtGdQkg4zYDlRThqet4aD4oPMDmKbhj+eMaAFLCU5CYa7Y5NzbxiF1B3sDRI
         zO9emljH6cIFXZkxOVYRqOCK/gc2Zog3+EsVt1i5LNhmAzm7+ARK0Y6urSfywTGUfvCA
         WKF6IMb68ZxLNSdbEVE2TUgtwqoSsIZsH9EPRQVIFTzT+KDkdjkN2oJvTkJ3B2IieIsO
         KwovNcp3PhPhUSOV9qTiy8/VmOsDMurvEYs/Iaa/rPNWC2DdJhQ79LjcsrswslEYn6id
         DJyA==
X-Gm-Message-State: AOJu0Yz58r2ENXYctHakdKgt8e29G2qXy9iNCwQnfET2co9IKUuXNRCx
        FjvcQgEH0n6yfuf+i9hOo4eMT+joBSaK0Mk+sAG+Ng==
X-Google-Smtp-Source: AGHT+IHxMGoMfSUhR02SlMyOTTU0alOJLi1o6B9HwVbD5gBXd6k9gdMEEtbUNjw+m1j0ipSS6/BfGFsKojNTABPnsoQ=
X-Received: by 2002:a50:f60d:0:b0:506:b280:4993 with SMTP id
 c13-20020a50f60d000000b00506b2804993mr38886edn.2.1693510123063; Thu, 31 Aug
 2023 12:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230831043228.1194256-1-jmattson@google.com> <c71199d1-93b3-ff51-f571-34d60cd36c1c@intel.com>
In-Reply-To: <c71199d1-93b3-ff51-f571-34d60cd36c1c@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 31 Aug 2023 12:28:27 -0700
Message-ID: <CALMp9eRT3+amVEFvX1vzeqDoVP7Fz6a_xUorKYK63+QeyaO4kA@mail.gmail.com>
Subject: Re: [PATCH] x86/fpu/xstate: Fix PKRU covert channel
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Tavis Ormandy <taviso@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Kyle Huey <me@kylehuey.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 12:12=E2=80=AFPM Dave Hansen <dave.hansen@intel.com=
> wrote:
>
> On 8/30/23 21:32, Jim Mattson wrote:
> > When XCR0[9] is set, PKRU can be read and written from userspace with
> > XSAVE and XRSTOR, even when CR4.PKE is clear.
> >
> > Clear XCR0[9] when protection keys are disabled.
> >
> > Reported-by: Tavis Ormandy <taviso@google.com>
> > Signed-off-by: Jim Mattson <jmattson@google.com>
>
> Is there any way to trigger this other than "nopku" on the command-line?

Or by configuration option:

CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=3Dn

> I'm not sure how scary this particular covert channel is, but it does
> make sense to do this even if it's only to avoid wasting XSAVE space on
> a feature that nobody can use (for things other than covert channels).
>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
