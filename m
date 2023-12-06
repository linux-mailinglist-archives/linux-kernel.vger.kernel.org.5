Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489C3807959
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442900AbjLFUYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 15:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379461AbjLFUYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:24:21 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D034E9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 12:24:27 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40b35199f94so14045e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 12:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701894266; x=1702499066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLC4g0QAR1KTCpF/vWrK4BIctaHe951zqqCOPkqNXTI=;
        b=mlEunK0wb1B0uEObAouYZIN7Fs9JPVhu1xe4uLBmjKROCsVeXeLmC0B0pcXLtI9rwe
         gaTQ1SEtAgc7BBqHsy0YWF70KcVLwu+I7qXjfcNlp0RKZ7tYDVKe97GgRWMkNnRnh6wg
         EIWVLPBrjQPUcP3zggpCexZPtDed2fXcyuLQt8depw6uQfKHSHC8pUyffoBmTnsQ69/K
         X21KZkIy28zjeuymAtv87vkU9AqrhmF7ZlZ29acK7cX8M9+Zx1tGF3hewc/AMUg11A53
         itBpYyQmsynQgj45BOJEp17v6J0Z99tdTpi45FJ8SOmlAHs9Dyox6URjou+QERwCnG/P
         9WNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701894266; x=1702499066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLC4g0QAR1KTCpF/vWrK4BIctaHe951zqqCOPkqNXTI=;
        b=e/rHIwwqkrPjBTLTg0yWzLKaEYvcrLpGTSRgC+lbj6+4YWhRMLsAlmn1Il7SQ6xFL5
         v+uR0kUwOJAYYbe2Hb8Z8sYDjV74x9Stdx1kGeGaZD34gNStwiX3OiKwAn4sra2GcJ6l
         pgPHVIjMb4X+7MhilVMORck17Y0X4KU8n47RWGM4zYlDmlNmVMMd0YkWtHdN5aiAFGgG
         sOqCff8Lp65JshyvzWv4ymdDRaLshJn/gceFpVXDeN404SrMa4BOCEhVfw/i1Ns4KMc3
         JkCrkdPh2w7IaKwe8L1W1n2SCm4CBWJ9TcQndbD6129/z7a2D46YA1yQ5MWC+V193IQC
         WP2w==
X-Gm-Message-State: AOJu0Yz8LMmTpJ8RkWTD4JOZ1s0sHvJxoMxgc/Z0zCJQqB1Z85x1OJV1
        ZfCVXSxL+51rKAMTshGSYfw69DDK2LTz+QPete0WTg==
X-Google-Smtp-Source: AGHT+IGpaSmH2SwseasenHdJbHupg+4hENlP3bAotBM+AhFS4zuurIIXkP6sO/G4INzoYgeHL8Kvm9T2DqCiypI9dcU=
X-Received: by 2002:a05:600c:3baa:b0:40c:329:d498 with SMTP id
 n42-20020a05600c3baa00b0040c0329d498mr104199wms.1.1701894265833; Wed, 06 Dec
 2023 12:24:25 -0800 (PST)
MIME-Version: 1.0
References: <20231206172844.1756871-1-jannh@google.com> <20231206195814.GDZXDSVgtCWspEJx8Q@fat_crate.local>
In-Reply-To: <20231206195814.GDZXDSVgtCWspEJx8Q@fat_crate.local>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 6 Dec 2023 21:23:48 +0100
Message-ID: <CAG48ez3weAU-Uti0QyBSDNRv8xYqCJ5UbgJvssEWAWpvyon0DA@mail.gmail.com>
Subject: Re: [PATCH] x86/microcode: Be more verbose, especially about loading errors
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
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

On Wed, Dec 6, 2023 at 8:58=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrote=
:
> On Wed, Dec 06, 2023 at 06:28:44PM +0100, Jann Horn wrote:
> > The AMD ucode loader contains several checks for corrupted ucode blobs =
that
> > only log with pr_debug(); make them pr_err(), corrupted ucode blobs are
> > bad.
> >
> > Also make both microcode loaders a bit more verbose about whether they
> > found ucode blobs at all and whether they found ucode for the specific =
CPU.
>
> So far, so good.
>
> The only thing I'm missing here is the *why*.
>
> There's merit in not complaining about corrupted microcode blobs because
> they won't be loaded anyway: no harm, no foul.

Well, yes, except that if no microcode blob is loaded, you're not
gonna have the errata fixes and/or security mitigations that you might
expect to have.
