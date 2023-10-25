Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E641B7D6D42
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 15:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344560AbjJYNaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344555AbjJYNac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:30:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC19B4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 06:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698240584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RKM+gb1rWlbrsyGe0ru+asYHoehN8Amt0gEY38pCGlY=;
        b=DSpn5zaqSRytD1Kvth4qXMjcacBWBt8E1TtD23QUQlsGnJop2RhwQDr4uxd/EXb3Cq/z7h
        fL35OjMihOuD/PiiMOE2BhiOWaO43gmUQi2h6CX1Eo+XKVKZLt/5Tnkufk6SqlK1dwoIL7
        tUNpFVD/9sBOzKs4ZvjK5m3D0Om3oxE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-R1DUIScEOIy4KTXQyzyODQ-1; Wed, 25 Oct 2023 09:29:28 -0400
X-MC-Unique: R1DUIScEOIy4KTXQyzyODQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2c5073588cbso43757001fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 06:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698240566; x=1698845366;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKM+gb1rWlbrsyGe0ru+asYHoehN8Amt0gEY38pCGlY=;
        b=fG+PbAyyN65HOA2oTsfxrNDAVQJPmdWqlszQjaPNxf7BeZIF2QZLQ2JUTOr5DYoM39
         Mlfz0iEopjuXFXZA8ed92qZ7+ZtuilCDbN9RYDWfy7u4/asEyakBDlZ1Qt4pr1RKxCpz
         l7u03vHmc1Fw7ycZWhpGFn51yKw1QNq/YVwxwe6y0/tdmFvbay4FbDYxTRqsQLcoiwz7
         Mkqt0xal8nJJwDcozkxvYsf8osb4gxoLhYnIE04aGrs3EA5hncQ+Ui+fXbob5CYfvAXY
         +2koSVY52gshl8YEFW23ysf055GSCvKTVjLqlQuTgzb5/i4cQFLttXnUlR/7b13UDY6S
         ZfdQ==
X-Gm-Message-State: AOJu0YzKEWBwbSCLm7reocpkwGBX/aN/ffMPelLiWYpdoEFMdjB+vwVA
        8MhhGTdNdN2pz7Mb0ZramxA3PBMjISskYGDsqLPoFR3iomU2SH93YZPFuC0ZNhvAgvyzn3qiCUF
        t3vG+ovL72e9Se5rqJG9yQjan
X-Received: by 2002:a2e:a167:0:b0:2c5:2242:ba5f with SMTP id u7-20020a2ea167000000b002c52242ba5fmr10223990ljl.26.1698240566741;
        Wed, 25 Oct 2023 06:29:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/bd1sv994kl11qxaY4JhVZknbw1CMFlecWdVOEe4wLnbmCw3X4wu/FtaHxVQeGg/8wymYQw==
X-Received: by 2002:a2e:a167:0:b0:2c5:2242:ba5f with SMTP id u7-20020a2ea167000000b002c52242ba5fmr10223969ljl.26.1698240566378;
        Wed, 25 Oct 2023 06:29:26 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600c2e4c00b0040648217f4fsm19250273wmf.39.2023.10.25.06.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 06:29:26 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Evan Preston <x.arch@epreston.net>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jaak Ristioja <jaak@ristioja.ee>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: Blank screen on boot of Linux 6.5 and later on Lenovo ThinkPad
 L570
In-Reply-To: <CAAhV-H5DH3Oj3ttSpa_k6jUdZ+0_pMwgoaqUTGGFr46j7DMXRw@mail.gmail.com>
References: <7c50e051-eba2-09fc-da9f-023d592de457@ristioja.ee>
 <31bdf7b1-0ed9-4217-b459-1d857e53120b@leemhuis.info>
 <CAAhV-H7fRpykesVUEyaTpVnFiGwpP+fPbtdrp6JwfgD=bDp06Q@mail.gmail.com>
 <CAAhV-H7XCmbgS=N4-SE8FnASAws8hnDRZsQJgXE+dwyARaqzNw@mail.gmail.com>
 <ZSO9uArAtsPMPeTP@debian.me>
 <CAAhV-H5GbidUx8YanUc7S9oGqBkDd53xeT=2O4aCuX7KpM-+8A@mail.gmail.com>
 <c9b79a69-bdc1-4457-900d-709a15d99568@leemhuis.info>
 <CAAhV-H4qQW_fOdkTxmT1xbvo4LOapzw_tOw7Kma47xmh0PvpPA@mail.gmail.com>
 <ZTWoDSPxGO-ApR4r@P70.localdomain>
 <82f1b533-3bd8-4418-843a-718d9a6b5786@leemhuis.info>
 <CAAhV-H5DH3Oj3ttSpa_k6jUdZ+0_pMwgoaqUTGGFr46j7DMXRw@mail.gmail.com>
Date:   Wed, 25 Oct 2023 15:29:24 +0200
Message-ID: <87v8auhlu3.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huacai Chen <chenhuacai@kernel.org> writes:

Hello,

> On Wed, Oct 25, 2023 at 6:08=E2=80=AFPM Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:

[...]

>>
>> This additional report makes me wonder if we should revert the culprit
>> (60aebc9559492c ("drivers/firmware: Move sysfb_init() from
>> device_initcall to subsys_initcall_sync") [v6.5-rc1]). But I guess that
>> might lead to regressions for some users? But the patch description says
>> that this is not a common configuration, so can we maybe get away with t=
hat?
> From my point of view, this is not a regression, 60aebc9559492c
> doesn't cause a problem, but exposes a problem. So we need to fix the
> real problem (SIMPLEDRM has a blank screen on some conditions). This
> needs Jaak or Evan's help.
>

I agree with this.

> Huacai

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

