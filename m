Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41368798B4B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 19:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245393AbjIHRLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 13:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbjIHRLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 13:11:47 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CB81FD5;
        Fri,  8 Sep 2023 10:11:41 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-529fb2c6583so3037262a12.1;
        Fri, 08 Sep 2023 10:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694193099; x=1694797899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRZZtDSDbQ7ziD6U8enIVKCW6fBD3XLhOHURnTZwm+I=;
        b=r27LHMXWq6JFzDriX8S3cF9X1svThjv4/reAkCS3DbEu72buDQ1aYGa1CvFoeZF5aj
         e9yZ0pMOkcupdXxiv6022expw+GebuThz8p16RxTo7WORyDhnmxrUKP0H7+e0HkkQxKn
         RHD8ezIKlE1jYuvHOwKKAUPGp4DYClq8hV+Qeg0vgYL71Wdd2OcKzCVMt7GKODJMhW2t
         BaQyTZACPYm74HCilFHOSnlkAaXT/wZ5torJefR63qsR3Zy0JvV6VX1jGYgBXEwWNkfl
         JWB5Rdnj+dGNmY4tj21esg3v1XdRsqIKCbrxjSC8NMoxYMxJWrpjM3tI0OtHj4CAKac6
         CbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694193099; x=1694797899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZRZZtDSDbQ7ziD6U8enIVKCW6fBD3XLhOHURnTZwm+I=;
        b=Qcxb9JWVnNmdVtposNsiw9UjB0fifaHYlKG4M2zWmaqumXJ1GVAcyNFckFi8y5KKSk
         oKRc6ZN1H8l+Pz86awk7oOBqSA1lqcmTlOYfuACjuAau6C3BriT21JugO19Hm9pbAIXD
         JSmRscEYsUuwC2WXL/Tf51beHJgu92p3Gh/lLOzB6nNO8svoCDfb/1NUFeLDvf4gNnwf
         dWYqcHDMFvqK3jRv2cagb0RMA6hv1Wavg316gZMcq344xCvVKoOZGgvvvPggDJFkCia8
         AICIHGfcoLfjC7IXOrWBQxJY5yczGLLnKLGVbCobx5FE0s+gEOBQJ0df3OLRjxCdun3J
         38Gw==
X-Gm-Message-State: AOJu0Yx2Q0EzD2RrZiTzKc9oL0daeTAGLJuRfvpQtpkfJbnLL3LsGXNX
        mCKwdzEPOh/XUCr6hsdFVaHnmBeROP+4qduMBmg=
X-Google-Smtp-Source: AGHT+IE81vOXgV+267Me6pgBsx7NyiALIoCgSFaF5/bhivgWOBvhVj01wJZJAyOS8B2FCfiqobx9r2YWGa9o39w+McA=
X-Received: by 2002:a05:6402:1219:b0:523:102f:3ce1 with SMTP id
 c25-20020a056402121900b00523102f3ce1mr2572978edw.10.1694193099037; Fri, 08
 Sep 2023 10:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230906182125.48642-1-jandryuk@gmail.com> <24a741a4-b305-c817-e8c3-34b213ad0ee5@intel.com>
In-Reply-To: <24a741a4-b305-c817-e8c3-34b213ad0ee5@intel.com>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Fri, 8 Sep 2023 13:11:27 -0400
Message-ID: <CAKf6xpvOG5kunrfQEoDBvrrY+UVUn3+9ovKmqXZo88nh05tt6Q@mail.gmail.com>
Subject: Re: [PATCH v2] acpi/processor: sanitize _PDC buffer bits when running
 as Xen dom0
To:     "Wilczynski, Michal" <michal.wilczynski@intel.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Roger Pau Monne <roger.pau@citrix.com>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 7, 2023 at 9:20=E2=80=AFAM Wilczynski, Michal
<michal.wilczynski@intel.com> wrote:
>
>
> Hi,
>
> On 9/6/2023 8:21 PM, Jason Andryuk wrote:
> > From: Roger Pau Monne <roger.pau@citrix.com>
> >
> > The Processor _PDC buffer bits notify ACPI of the OS capabilities, and
> > so ACPI can adjust the return of other Processor methods taking the OS
> > capabilities into account.
>
> _PDC method is deprecated for this purpose, since 2018, and is dropped fr=
om
> spec since 6.5
>
> We made the switch in linux since 6.6:
> 95272641338a ("ACPI: processor: Use _OSC to convey OSPM processor support=
 information")

Thanks for the heads up, Michal.  The patch pre-dated 6.6 and I based
this one off of 6.5.

> >
> > When Linux is running as a Xen dom0, it's the hypervisor the entity
> > in charge of processor power management, and hence Xen needs to make
> > sure the capabilities reported in the _PDC buffer match the
> > capabilities of the driver in Xen.
>
> So I guess you would need to sanitize buffer passed to _OSC method instea=
d ?

I think I'll modify the capabilities in arch_acpi_set_proc_cap_bits()
and that will handle both _OSC and the _PDC fallback.

Regards,
Jason
