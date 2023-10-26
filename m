Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1903E7D860A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbjJZPcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjJZPcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:32:04 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DC8187
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:31:58 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b3f6f330d4so598057b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698334317; x=1698939117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Xy5YlEFiFq1Kwk2QLLV40Y+ZS9JkzljZy78RTLW+DE=;
        b=mzQ+lSTGw9qY9foZURxV5bM6Jbw5XtLKKiy5xhUiM264DJ60ylX/xNphAQZ3HLjLR/
         vduc4KEEHdm3Tt2N6WRCO4l8iZBMtY6Y6qt2PY8YkFEnxwB7RCRMSYPKzUl7l2ZQ7QBt
         2NyzvKR/l8tRt6DNRgUHi7u5CSrfrJy7KOMnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698334317; x=1698939117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Xy5YlEFiFq1Kwk2QLLV40Y+ZS9JkzljZy78RTLW+DE=;
        b=MPYkhlCFzbrt/b5mMdplGU9AiTG9xa31VV/BVBayixvshnCYHY2jRI0NnH30HZ8wy3
         +ypfUAwYhwOekvTRkcVqnOYSVpRR0b6lBHPB67Z9XsyX1sp+SIEVPp126mlARCM6L4pr
         qpXTSYyyNbpdy+TVdfuPveu3HU2BtwLMA3EFaOZ4teuKfb47gzmXGVOtWVZtAtlUCBLD
         dz53wbHkzmTZ3jCI2xMIhONyiAxOCrGJUB2XWfUiGQ3264a15spe8H4fyKS3ZwPdgNvu
         QAM073jpeEytMUmiGdBfhpZaZFL6K/gMjhFuAkKsf8LEGyiQk0tonRRTu2qoMsVPBGoZ
         3blQ==
X-Gm-Message-State: AOJu0YyUYDCh8qpBXYTQcGaYSDMAxk/X2MtD3ICG326iHTHt73jkKv3H
        E9v4dbicoF8Tvm/TDRi9dhcXChzk5N/VuJtJ4jY=
X-Google-Smtp-Source: AGHT+IFOH+aX1Vw6ZoQdbvu1p9OJlEGG4EXTdDg4ELD0u19SlSZFHuJMaL8m5Gy+A6a+Vm+bz2t+kA==
X-Received: by 2002:a05:6808:90:b0:3b2:f54b:8b3a with SMTP id s16-20020a056808009000b003b2f54b8b3amr20166510oic.27.1698334317456;
        Thu, 26 Oct 2023 08:31:57 -0700 (PDT)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com. [209.85.160.52])
        by smtp.gmail.com with ESMTPSA id z18-20020a056808029200b003b2f369a932sm2793896oic.49.2023.10.26.08.31.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 08:31:57 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1ea4a3d0a44so607239fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:31:56 -0700 (PDT)
X-Received: by 2002:a05:6870:c991:b0:1c8:bbd0:2fc9 with SMTP id
 hi17-20020a056870c99100b001c8bbd02fc9mr24965060oab.49.1698334316575; Thu, 26
 Oct 2023 08:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231025143906.133218-1-zohar@linux.ibm.com> <485C9C57-ABF1-4618-81D1-345597A1B9FA@oracle.com>
 <488442598c3703760ed6182426ed891f85fe0a1a.camel@linux.ibm.com>
In-Reply-To: <488442598c3703760ed6182426ed891f85fe0a1a.camel@linux.ibm.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Thu, 26 Oct 2023 09:31:42 -0600
X-Gmail-Original-Message-ID: <CAHQZ30BbtoTGHV803WpiSdCi6Bz9E050FJUy=HEeSAti_zPsqg@mail.gmail.com>
Message-ID: <CAHQZ30BbtoTGHV803WpiSdCi6Bz9E050FJUy=HEeSAti_zPsqg@mail.gmail.com>
Subject: Re: [PATCH v3] ima: detect changes to the backing overlay file
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Eric Snowberg <eric.snowberg@oracle.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 12:01=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> w=
rote:
>
> On Wed, 2023-10-25 at 16:27 +0000, Eric Snowberg wrote:
> >
> > > On Oct 25, 2023, at 8:39 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > >
> > > Commit 18b44bc5a672 ("ovl: Always reevaluate the file signature for
> > > IMA") forced signature re-evaulation on every file access.
> > >
> > > Instead of always re-evaluating the file's integrity, detect a change
> > > to the backing file, by comparing the cached file metadata with the
> > > backing file's metadata.  Verifying just the i_version has not change=
d
> > > is insufficient.  In addition save and compare the i_ino and s_dev
> > > as well.
> > >
> > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> >
> > I ran the file integrity tests that originally uncovered the need for
> > "Commit 18b44bc5a672 ("ovl: Always reevaluate the file signature for
> > IMA=E2=80=9D). When the backing file is changed, file integrity remains=
.  For that
> > part, feel free to add:
> >
> > Tested-by: Eric Snowberg <eric.snowberg@oracle.com>
>
> Thanks!
>
> Mimi
>

I just verified this fixes the speed regression:

```
rrangel920 / # time clang --version >/dev/null

real 0m0.369s
user 0m0.000s
sys 0m0.368s
rrangel920 / #
rrangel920 / # time clang --version >/dev/null

real 0m0.017s
user 0m0.004s
sys 0m0.013s
rrangel920 / # time clang --version >/dev/null

real 0m0.012s
user 0m0.000s
sys 0m0.012s
rrangel920 / # time clang --version >/dev/null

real 0m0.012s
user 0m0.000s
sys 0m0.012s
```

Tested-by: Raul E Rangel <rrangel@chromium.org>

Thanks again for the quick fix!
