Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73377D9ACB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346020AbjJ0OG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345943AbjJ0OG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:06:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A666B10A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698415541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qmiVVEtRZXlvZiCEBDmIRly02OLScsCRxyCghuB2vJE=;
        b=HPnzN/TgmnTvk9LO8GBD920+sr6JcceWOwd1hFCBkxIEmnHxHcpZz8ElQq9M0QDxbEYnMs
        L165fwfsHLci1eJAiX1Hmd+kON5CHdioOyU3m3aAzxPOLMGqFEWl+FvQNKFS3ObTGCTK7p
        PTz86KgN0Z/RRtKtQ7PZQqTHt7LCwPY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-Bu9ZWXY-OYKH-guaMsWqaQ-1; Fri, 27 Oct 2023 10:05:39 -0400
X-MC-Unique: Bu9ZWXY-OYKH-guaMsWqaQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-27dd8d7d6c3so1864127a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698415538; x=1699020338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmiVVEtRZXlvZiCEBDmIRly02OLScsCRxyCghuB2vJE=;
        b=R4Nqf9z2yHS/uXkyUzpAXa5IEM4qNyr0yokQej9klT3ShwrGllA9UxQnxbUA6pvcUj
         m9fE9yc57Q5IGWvWBKS1dluSPcfLAXm2vbiBBaBmXXfnW3uclWwf9b2Rn+soXlojhzVs
         3+Xei2H/Fh3WgRKYG/LstriHVZKSUjabuoIPsJPpbNajz2CqqWomsq9uWUn5rTVn0CHA
         rLsl5XAF+Ro93pdGyjfv3KrgQpQGOcExsOpY3jIrRTtkI+ykZ3UBAJ48pnpJnhdiJdLl
         RHJM5+A9pq+6f1iVWtcydIXJPRh6vDqyBdK70WkC0uhAGbzoFOkJwXpNSq9gD2ZyVIIO
         l33Q==
X-Gm-Message-State: AOJu0YxxdFvDuyuXzWpy5B0IzGIVTREitT+DojRBsJn8nrlLC1MZzM7d
        n9ftEUYEdirdupoacIVPHtBoZPhsSqQPMK8uSKnnZCYjQpq9Ye4WAiVUQ97tbpjODNF7/pk7cky
        7dH1kzMIaAW2sLQRuH6+U8UTd5MGGEcQR/rUL5txl
X-Received: by 2002:a17:90a:4f48:b0:27d:166b:40f6 with SMTP id w8-20020a17090a4f4800b0027d166b40f6mr2532534pjl.41.1698415538764;
        Fri, 27 Oct 2023 07:05:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz7lrTl+zAdmgTnAvT/azIXBCe0/XGufVtBRSSehgdm4mTofu5iqEwH7u2CGPh9s/wxC1dldLVGTED5Rv21bY=
X-Received: by 2002:a17:90a:4f48:b0:27d:166b:40f6 with SMTP id
 w8-20020a17090a4f4800b0027d166b40f6mr2532514pjl.41.1698415538507; Fri, 27 Oct
 2023 07:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <717fd97a-6d14-4dc9-808c-d752d718fb80@ddn.com> <4b0b46f29955956916765d8d615f96849c8ce3f7.camel@linaro.org>
 <fa3510f3-d3cc-45d2-b38e-e8717e2a9f83@ddn.com> <1b03f355170333f20ee20e47c5f355dc73d3a91c.camel@linaro.org>
 <9afc3152-5448-42eb-a7f4-4167fc8bc589@ddn.com> <5cd87a64-c506-46f2-9fed-ac8a74658631@ddn.com>
 <8ae8ce4d-6323-4160-848a-5e94895ae60e@leemhuis.info> <CAOssrKdvy9qTGSwwPVqYLAYYEk0jbqhGg4Lz=jEff7U58O4Yqw@mail.gmail.com>
 <2023102731-wobbly-glimpse-97f5@gregkh> <CAOssrKfNkMmHB2oHHO8gWbzDX27vS--e9dZoh_Mjv-17mSUTBw@mail.gmail.com>
 <2023102740-think-hatless-ab87@gregkh> <CAOssrKd-O1JKEPzvnM1VkQ0-oTpDv0RfY6B5oF5p63AtQ4HoqA@mail.gmail.com>
 <689f677b84b484636b673b362b17a6501a056968.camel@linaro.org>
 <CAOssrKfP+t-cy322ujizQofgZkPZsBu1H4+zfbWNEFCmTsXwug@mail.gmail.com> <afe378bf254f6c4ac73bb55be3fa7422f2da3f5f.camel@linaro.org>
In-Reply-To: <afe378bf254f6c4ac73bb55be3fa7422f2da3f5f.camel@linaro.org>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Fri, 27 Oct 2023 16:05:27 +0200
Message-ID: <CAOssrKeJB7BZ7fA6Uqo6rHohybmgovc6rVwDeHbegvweSyZeeA@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "fuse: Apply flags2 only when userspace set the FUSE_INIT_EXT"
To:     =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Daniel Rosenberg <drosen@google.com>,
        Alessio Balsini <balsini@android.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 3:39=E2=80=AFPM Andr=C3=A9 Draszik <andre.draszik@l=
inaro.org> wrote:
>
> On Fri, 2023-10-27 at 15:24 +0200, Miklos Szeredi wrote:
> > On Fri, Oct 27, 2023 at 3:14=E2=80=AFPM Andr=C3=A9 Draszik
> > <andre.draszik@linaro.org> wrote:
> >
> > > The patch in question has broken all users that use the higher
> > > flags
> > > and that don't use your version of libfuse, not just Android.
> > > You're
> > > filtering them out now when you didn't at the time that those
> > > ('official) high flags were added. There are a couple more high
> > > flags
> > > than just the one that Android added.
> >
> > Okay.  Where are all those users?
>
> That's not the point. The point is the kernel<->user API has rendered
> them too non-working.

It is a very important point.  A theoretical bug isn't a regression.
Nor is a broken test case BTW.

Please read section 'What is a "regression" and what is the "no
regressions rule"?' in
Documentation/admin-guide/reporting-regressions.rst.

 Thanks,
Miklos

