Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7FD76DB4C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 01:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjHBXN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 19:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjHBXNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 19:13:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF47FB
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 16:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691017989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=20Np0whiILikZWPV0Tm+DkfZOvMb6xU6aDilwDNR8Lg=;
        b=DqzhmOWV76IC7G6Vitt+S08ADe8+uy2hWDwuRks6XAhntBg0XSCkYDvbxEGWqIJ5OnIMM9
        qEAL5m9oTt+e4MzIdIrqILUd9HBQ3c2zj/bTrAX2zuPpJ2ICM8ka59nrFcc6XusWTCSy2M
        Fj2/+fAu+nZpwcdzKAINpsdC0YG5UbI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-dnQq1jRHM1qw_P9_3Om1WQ-1; Wed, 02 Aug 2023 19:13:08 -0400
X-MC-Unique: dnQq1jRHM1qw_P9_3Om1WQ-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1bba270c62dso3106795ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 16:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691017987; x=1691622787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20Np0whiILikZWPV0Tm+DkfZOvMb6xU6aDilwDNR8Lg=;
        b=NqyaEEmRKDah5HuD401KI02L1TxR999C4xcELC5XFdESLdyHWIOpR8mt6TWvRlJ6yY
         QyCMpPvQVV3lrSAWmhEwrGKvj3sWgHnFGrEixKb2V8Gs6a8RI7acB1ieBZC1Vv3XnOjo
         /jnjNJcNXomVRo6KEbh3mmri07oYEnFzSwWNjxsVtA5LOnL0SRUsqyCaEtceRztkaL+f
         HKEJE8zObQ5zpgE3eR5kqw6Wp//Wl0VSUA5S+8IFSraE+tg/CoOh8arciPseTBD7nCVw
         yQ4imH7QjiW4yTFZS0i68QutO43Zxyr/OqRbM2bdadQ+cvSi67MVwtIx5i/zVOURhD/J
         B3Qw==
X-Gm-Message-State: ABy/qLYVGXTbxDZtSCXWw6fiLT9oz3nklOxXt7qBUcaitsfUgkyNujlF
        fW+bvlh3gpk6ESfdFuGCGPShf8oZxRDyyHH06SUKvg2qbkICEFIqlpQkkDztH8BWGiFXPRkN5oN
        7iT2YXJBTUXJQpIIsqcPERs2l
X-Received: by 2002:a17:903:234d:b0:1b6:6c32:59a8 with SMTP id c13-20020a170903234d00b001b66c3259a8mr16368694plh.36.1691017987195;
        Wed, 02 Aug 2023 16:13:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGUasP1ILLvLjYv7dds9M1+TNQWo0lRyGqDpoahYttq390Z2rmdy2dwB1sArRMDxIfc57+UQg==
X-Received: by 2002:a17:903:234d:b0:1b6:6c32:59a8 with SMTP id c13-20020a170903234d00b001b66c3259a8mr16368677plh.36.1691017986871;
        Wed, 02 Aug 2023 16:13:06 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id v5-20020a170902b7c500b001b891259eddsm12882039plz.197.2023.08.02.16.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 16:13:06 -0700 (PDT)
Date:   Wed, 2 Aug 2023 16:13:04 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniil Stas <daniil.stas@posteo.net>,
        Mario Limonciello <mario.limonciello@amd.com>,
        James.Bottomley@hansenpartnership.com, Jason@zx2c4.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@leemhuis.info, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
Message-ID: <ejqnhdrhktfrhcb76bxx6y73hydjov34t7m4wrvzjc22gdtzts@p4g7yqxdnijn>
References: <65a1c307-826d-4ca3-0336-07a185684e5d@amd.com>
 <20230727195019.41abb48d@g14>
 <67eefe98-e6df-e152-3169-44329e22478d@amd.com>
 <20230727200527.4080c595@g14>
 <CAHk-=whqT0PxBazwfjWwoHQQFzZt50tV6Jfgq3iYceKMJtyuUg@mail.gmail.com>
 <CUGAV1Y993FB.1O2Q691015Z2C@seitikki>
 <CAHk-=whphk8Jp=NYmnm7Qv+vZ6ScYCz+rV8a2G1nD-AQY3z+mQ@mail.gmail.com>
 <CUHF67ZOFOTN.1UFE7Q1IFRQMX@suppilovahvero>
 <CAHk-=wgK0Z-LrJGExwG=e=oxjD93LJhY3jMmi_2O2_Pkjf8Tsg@mail.gmail.com>
 <CUHG1TB7IELF.PVXOXEXBGEPP@suppilovahvero>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CUHG1TB7IELF.PVXOXEXBGEPP@suppilovahvero>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 10:09:58PM +0300, Jarkko Sakkinen wrote:
> On Tue Aug 1, 2023 at 9:42 PM EEST, Linus Torvalds wrote:
> > On Tue, 1 Aug 2023 at 11:28, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > >
> > > I would disable it inside tpm_crb driver, which is the driver used
> > > for fTPM's: they are identified by MSFT0101 ACPI identifier.
> > >
> > > I think the right scope is still AMD because we don't have such
> > > regressions with Intel fTPM.
> >
> > I'm ok with that.
> >
> > > I.e. I would move the helper I created inside tpm_crb driver, and
> > > a new flag, let's say "TPM_CHIP_FLAG_HWRNG_DISABLED", which tpm_crb
> > > sets before calling tpm_chip_register().
> > >
> > > Finally, tpm_add_hwrng() needs the following invariant:
> > >
> > >         if (chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED)
> > >                 return 0;
> > >
> > > How does this sound? I can refine this quickly from my first trial.
> >
> > Sounds fine.
> 
> Mario, it would be good if you could send a fix candidate but take my
> suggestion for a new TPM chip flag into account, while doing it. Please
> send it as a separate patch, not attachment to this thread.
> 
> I can test and ack it, if it looks reasonable.
> 
> > My only worry comes from my ignorance: do these fTPM devices *always*
> > end up being enumerated through CRB, or do they potentially look
> > "normal enough" that you can actually end up using them even without
> > having that CRB driver loaded?
> 
> I know that QEMU has TPM passthrough but I don't know how it behaves
> exactly.
> 

I just created a passthrough tpm device with a guest which it is using
the tis driver, while the host is using crb (and apparently one of the
amd devices that has an impacted fTPM). It looks like there is a
complete separation between the frontend and backends, with the front
end providing either a tis or crb interface to the guest, and then the
backend sending commands by writing to the passthrough device that was
given, such as /dev/tpm0, or an emulator such as swtpm. Stefan can
probably explain it much better than I.

Regards,
Jerry

> > Put another way: is the CRB driver the _only_ way they are visible, or
> > could some people hit on this through the TPM TIS interface if they
> > have CRB disabled?
> 
> I'm not aware of such implementations.
> 
> > I see, for example, that qemu ends up emulating the TIS layer, and it
> > might end up forwarding the TPM requests to something that is natively
> > CRB?
> >
> > But again: I don't know enough about CRB vs TIS, so the above may be a
> > stupid question.
> >
> >            Linus
> 
> I would focus exactly what is known not to work and disable exactly
> that.
> 
> If someone still wants to enable TPM on such hardware, we can later
> on add a kernel command-line flag to enforce hwrng. This ofc based
> on user feedback, not something I would add right now.
> 
> BR, Jarkko

