Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECC77932D8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 02:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239631AbjIFAQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 20:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbjIFAQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 20:16:26 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1B01B7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 17:16:21 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so84803766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 17:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693959380; x=1694564180; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D917AWho7Feua99GqojIXSmDzbaIdD3bTXf4gib3fXk=;
        b=WR1djjrnv6gFGd+ZpSN7Cp4XWCG1347niztXHXHoGLfPfs6GPdI903gBGvQQ3Z95re
         ugK2o+atkDHS/9XbhQlcgkcHu0j1p1xPHmrjto9jVzvhxTVEN4q9HglRjbxNujSQbimw
         i/c8LGZsQWGKoiVXlqGgY/OjtSTlk417M3DM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693959380; x=1694564180;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D917AWho7Feua99GqojIXSmDzbaIdD3bTXf4gib3fXk=;
        b=UdGiI3zqIp+WW5YWGJMqAzUbw9AgOOqZ9y9x+j5hGM7EgNrRNvEmrfUMCvvyvHKPy/
         RfTNY1iDGangJnoBP9neLkQfGL99L/B/+wC5HdfgGStfna+LWpu8ID+S6+3PMDfacVkr
         /XqKxHf7nrGM8N+GEE7nzL6k0icLnTUHe2HvEXt2vBsbWL/ME/KBMWWS4e4oqDRYsGp6
         4c2WfRInA3ernnG6xa+2wGA3VEgzDFEt7AJGqj5uEdV1UtacesKHuLRxP+MdS5F6nz6Y
         9j4Dgwk7K64xFFfFpVbEaYBjQERJM1HkNwEiAsfDopQ4gmI2Plb2F0lEmoE2G2EL36uZ
         oTiQ==
X-Gm-Message-State: AOJu0YxUN4wml1d+usQatvhJyD7GSpm6LOjlNSW0J/2dWscjxQlNjqc9
        gADUGTJ1+3VRdlcmvS6mVkyGuBkTO9iG4OCIEqnUWA==
X-Google-Smtp-Source: AGHT+IHArMcb4EaDd22pM7j7o7Xft0XRe4Xs06JuDyI1ef9pDfmOHD6jZLdMUaC5uJIsaEa/VLm5sg==
X-Received: by 2002:a17:907:97c6:b0:9a5:962c:cb6c with SMTP id js6-20020a17090797c600b009a5962ccb6cmr1361079ejc.31.1693959379997;
        Tue, 05 Sep 2023 17:16:19 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id dk24-20020a170906f0d800b00992d0de8762sm8221480ejb.216.2023.09.05.17.16.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 17:16:19 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-9a2a4a5472dso80612566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 17:16:19 -0700 (PDT)
X-Received: by 2002:a17:907:2d14:b0:9a1:c69c:9388 with SMTP id
 gs20-20020a1709072d1400b009a1c69c9388mr1222628ejc.37.1693959378665; Tue, 05
 Sep 2023 17:16:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230830140315.2666490-1-mjguzik@gmail.com> <CAHk-=wgADyL9i8r1=YkRTehKG8T89TzqAFMXDJV1Ag+_4_25Cw@mail.gmail.com>
 <CAGudoHH95OKVgf0jW5pz_Nt2ab0HTnt3H9hbmU=aSHozOS5B0Q@mail.gmail.com>
 <CAHk-=wh+=W2k1V_0Om=_=QpPAN_VgHzdZ4FLXSfcyTSK7xo0Eg@mail.gmail.com>
 <CAHk-=wg6bzTdQHSsswHPYFUbb1DfszyWTZ97hZv7bYxaNHVkHw@mail.gmail.com>
 <20230903204858.lv7i3kqvw6eamhgz@f> <CAHk-=wjYOZf2wPj_=arATJ==DQQAQwh0ki=Za0RcE542rWBGFw@mail.gmail.com>
 <ZPT/LzkPR/jaiaDb@gmail.com> <CAHk-=wh1hi-HnBQRu9_ALQL-fbhyn_go+2c9FajO26khf2dsTw@mail.gmail.com>
 <CAGudoHG1_r1B0pz6-HUqb6AfbAgWHxBy+TnimvQtwLLqkKtchA@mail.gmail.com>
 <CAHk-=wjM6KwAvC9+sCAm9BgBSspZm60VBLzHcuonGcHrPKJrbw@mail.gmail.com>
 <CAHk-=whnEF7-+DL+71wVgnJG1xjeHAQjzqMAULgQq_uhWfP0ZA@mail.gmail.com>
 <CAGudoHENT1yPBD=+xAUTzWxL+iro8CE3+hHLtYiU6j3cCv7PPA@mail.gmail.com>
 <CAHk-=wgjyGX3OVDtzJW6Oh2ukviXtJYi9+7eJW75DgX+d673iw@mail.gmail.com> <CAGudoHEXyYSZj-7=3Xss=65jGyX4Lq=R-BdbnmGKJwSS8QznSw@mail.gmail.com>
In-Reply-To: <CAGudoHEXyYSZj-7=3Xss=65jGyX4Lq=R-BdbnmGKJwSS8QznSw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 5 Sep 2023 17:16:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh0J7HotWcjP5nL4pZZLZN31SMid5rpf3pvmv-7Yi2W1A@mail.gmail.com>
Message-ID: <CAHk-=wh0J7HotWcjP5nL4pZZLZN31SMid5rpf3pvmv-7Yi2W1A@mail.gmail.com>
Subject: Re: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Sept 2023 at 13:41, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> @@ -312,7 +314,15 @@ int vfs_fstatat(int dfd, const char __user *filename,
>         struct filename *name;
>
>         name = getname_flags(filename,
> getname_statx_lookup_flags(statx_flags), NULL);
> -       ret = vfs_statx(dfd, name, statx_flags, stat, STATX_BASIC_STATS);
> +       /*
> +        * Hack: ugliness below damage controls glibc which reimplemented fstat
> +        * on top of newfstatat(fd, "", buf, AT_EMPTY_PATH). We still pay for
> +        * kmalloc and user access, but elide lockref.
> +        */
> +       if (name->name[0] == '\0' && flags == AT_EMPTY_PATH && dfd >= 0)
> +               ret = vfs_fstat(dfd, stat);
> +       else
> +               ret = vfs_statx(dfd, name, statx_flags, stat,
> STATX_BASIC_STATS);
>         putname(name);

I actually think I might prefer the earlier hacky thing, because it
avoids the whole nasty pathname allocation thing (ie the __getname()
dance in getname_flags(), and the addition of the pathname to the
audit records etc).

I suspect your "there are no real loads that combine AT_EMPTY_PATH
with a path" comment is true.

So if we have this short-circuit of the code, let's go all hog on it,
and avoid not just the RCU lookup (with lockref etc), but the pathname
allocation too.

                  Linus
