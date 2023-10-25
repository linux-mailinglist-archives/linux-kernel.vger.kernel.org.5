Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8020C7D6CF5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 15:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344521AbjJYNSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbjJYNSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:18:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08206131
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 06:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698239844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IozGvl6ym7FtpXWIgUQGELou+dXeHqFgoLDxKjZILp0=;
        b=NKCvjXfR4AH8xREssTR8wBq4foj3H4Dm4XJd2qNgAMNcgJps1qfB9S71Zg5DG37Ka+l2qh
        u2UZyh1jhDa5w7l1l4AbiPcHTOmMlcDb8oujqzaYB8gYND+V+JSNgPzVEboT/tFkzmUAEp
        XM+EfFChlikdkK4RYj/6942Ryo89KHQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-ppDzhPDNN2-paG0RBetPZw-1; Wed, 25 Oct 2023 09:17:22 -0400
X-MC-Unique: ppDzhPDNN2-paG0RBetPZw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-27dd8d7d6c3so4291865a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 06:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698239841; x=1698844641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IozGvl6ym7FtpXWIgUQGELou+dXeHqFgoLDxKjZILp0=;
        b=lXGWV6FCBaX8xMhsJPWw09Z6D1QgWgJTkx6eGvr5llBoP9ksj2K+mHl8bo4ZvoqLV1
         qPjkDfHl/7pMdkSL81+TJbEB8XtHwX+zLp2+KC1TaVmuZyUm6If6GIT+71sihGRtpC5w
         /2pqgSXP+XAz05w8TcLfVb+uz6xnDL98g1+Qvu5K+1yLMhXt2kbL2vAF/MLrnRfC5LRL
         +MwvX1XK/5EcofM1DVmEfywuX1B9NWbqA9lKgU1xPsgmAUZ34Izi616AQ/zotlAIRcp4
         iB/PvhwidPVeQZ50QCyEcblCkzsv6ZrG8YVitcHsFal3iIU2Gy0d0wUhQdrtOSdjirhi
         86fQ==
X-Gm-Message-State: AOJu0Yz7xde/+9WbC/KNrQ8VBnjRvfDcXZPfjJi3uAu9XHie+O7YPbBE
        VaWDClES7Xynee7ipUptFrKklZzCScYkEnEXPH93p2uWajhanSyZjsd0kTS/Fb3F1qqbQUJjqc+
        CUEqVE0d7WIE1NZCeLUSuX61t140or9FUxnS4Sbif
X-Received: by 2002:a17:90b:4b8a:b0:27d:4282:e3d2 with SMTP id lr10-20020a17090b4b8a00b0027d4282e3d2mr11790035pjb.30.1698239841313;
        Wed, 25 Oct 2023 06:17:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBXLRdWrDOrQCF5FvsKobYfb7nyIu56I/K8W5F1yWLZe9klbEb/Sixm0+WmmNoJIkM4fZDAptKQq/7701Eamw=
X-Received: by 2002:a17:90b:4b8a:b0:27d:4282:e3d2 with SMTP id
 lr10-20020a17090b4b8a00b0027d4282e3d2mr11790015pjb.30.1698239841018; Wed, 25
 Oct 2023 06:17:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230904133321.104584-1-git@andred.net> <20231018111508.3913860-1-git@andred.net>
 <717fd97a-6d14-4dc9-808c-d752d718fb80@ddn.com> <4b0b46f29955956916765d8d615f96849c8ce3f7.camel@linaro.org>
 <fa3510f3-d3cc-45d2-b38e-e8717e2a9f83@ddn.com> <1b03f355170333f20ee20e47c5f355dc73d3a91c.camel@linaro.org>
 <9afc3152-5448-42eb-a7f4-4167fc8bc589@ddn.com> <5cd87a64-c506-46f2-9fed-ac8a74658631@ddn.com>
 <8ae8ce4d-6323-4160-848a-5e94895ae60e@leemhuis.info>
In-Reply-To: <8ae8ce4d-6323-4160-848a-5e94895ae60e@leemhuis.info>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Wed, 25 Oct 2023 15:17:09 +0200
Message-ID: <CAOssrKdvy9qTGSwwPVqYLAYYEk0jbqhGg4Lz=jEff7U58O4Yqw@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "fuse: Apply flags2 only when userspace set the FUSE_INIT_EXT"
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Daniel Rosenberg <drosen@google.com>,
        Alessio Balsini <balsini@android.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Bernd Schubert <bschubert@ddn.com>,
        =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 1:30=E2=80=AFPM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:

> Miklos, I'm wondering what the status here is. The description in the
> reverts Andr=C3=A9 sent[1] are maybe a bit vague[2], but it sounds a lot =
like
> he ran into a big regression that should be addressed somehow -- maybe
> with a revert. But it seems we haven't got any closer to that in all
> those ~7 weeks since the first revert was posted. But I might be missing
> something, hence a quick evaluation from your side would help me a lot
> here to understand the situation.

I don't think the Android use case counts as a regression.

If they'd use an unmodified upstream kernel, it would be a different case.

But they modify the kernel heavily, and AFAICS this breakage is
related to such a modification (as pointed out by Bernd upthread).

Andr=C3=A9 might want to clarify, but I've not seen any concrete real world
examples of regressions caused by this change outside of Android.

Thanks,
Miklos

