Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DF9800FC9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 17:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjLAPl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjLAPl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:41:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA28C1A6
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701445324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wsIEpjlYbbE94w6VuoJGauTiAJ6LkCQfz+kZ/LREei0=;
        b=dwYIc1MP14OEl+OyBgbh+OuToq/Sa/5YubU2hTGM8Gyhp8unEy/5/QePhM9CQCW/UxWJ4U
        ors4chIbvocG7vjOdX5hBR0trEFt+ps6tUsSXMr9XYoEeAfQE3icpTsogwQLhvluc1j51t
        Es9wtg4ocTDrvzOjAoKmNpMKc6wFUTg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-S8kdMrggMoCEHnqSVSr3YQ-1; Fri, 01 Dec 2023 10:42:02 -0500
X-MC-Unique: S8kdMrggMoCEHnqSVSr3YQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a1867751573so308813766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 07:42:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701445321; x=1702050121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsIEpjlYbbE94w6VuoJGauTiAJ6LkCQfz+kZ/LREei0=;
        b=mH5ZoaVd1T7DuXG98dCIIC2NSO+6cbUJUs7mfB3XPFAP0vOmO3SZIbDjpWjmp4GcXU
         MxKwQi6W5+ClpvPup+XPoYRywqm9pVGQqqVVJYRfLOv4Jx/4Hdt6iGp2bhpJXWZ87BXV
         SN8LbQI+Vs0GA8floA6LsO/vZPmFliVcJj1nFZeOOfjAaj+nZTmc5Yv/QJEjpPElajV9
         cEYpnI+mrbzshXuVsEqhUYh4d6Si2hW3qL9lGS+txvNvpcqu3F45etLteNx6Xifl6moT
         9OMEjgUfBhoy0snqDDDx6/ddbj3s/7S3mTe1Z+0fLF2HbxHDtxhW6DXQR7m2pESeJYAh
         a4nQ==
X-Gm-Message-State: AOJu0YwHAQgBH8cdfXIScJVZFLFF+rR6Bb6YZfc7Xuk9ha6u8FliTMK7
        MqjdOQqIRYNMmBGZaGX/rANW2WiMDVCRFMuvRtpYKbrHEABbacGfxV2hpDRiz/5kL5cY1+GWzl3
        NnHrPdtAjmPblH/8sqLYZn3pt1DFBm5Z/8v8Z/a4z
X-Received: by 2002:a17:907:1591:b0:9f2:859f:713e with SMTP id cf17-20020a170907159100b009f2859f713emr1489854ejc.3.1701445321243;
        Fri, 01 Dec 2023 07:42:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIuEu5QiiqKe3sttIDRA1lfIbTqvxkhoWEKiS8eBtm7d8yrE2lIINNREgPDH4mNUBS/lH2J5lUp4pUSMUTsMs=
X-Received: by 2002:a17:907:1591:b0:9f2:859f:713e with SMTP id
 cf17-20020a170907159100b009f2859f713emr1489835ejc.3.1701445320926; Fri, 01
 Dec 2023 07:42:00 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm>
 <7wmtNlKuYResf5cFQ7M2QTalzIUtw0I6ohvPcz69Jo1c8flezyIlnJu1IwAgXhJ-u0NlRL3IV7HnL0Kza6fVBqd7X7jhc-Z6QCi3oqHEvpY=@protonmail.com>
 <CAO-hwJJ+nx72_TPfxcWRPBDZdDaPrO5yMNH4Y_mj6ej651Mesw@mail.gmail.com>
 <nFHw6XePiH5p60JsbQSbssRkiuABiTiR_n5fIYFZjPgkV3ObjjZuwTC84BJ_1vXYVufPbG3UvZ1L7ODSrrGlq9CrI7BTKhsV5QeAQoakV18=@protonmail.com>
 <CAO-hwJ+jwmTE-v7FsPi3f70mB8SqUha7Ek9DtptZ0auiFpGM7w@mail.gmail.com>
 <CAO-hwJJoCp0_kxf_HHN9n9EWy9YDSY4rP8ysYNrNg2xTUYtKEQ@mail.gmail.com>
 <evHI05gyKuWwynY1WdyVvXqKPUaPE8W34cc3tFfp9FWh94TWfA9FWfHun7AAscF9lqfbiYsLKGC7kTSZ9xWNZg88-PTpbGTLcFMc9D3P2HE=@protonmail.com>
 <CAO-hwJLinACPsk=mEHrEz_YJroknmm=9PcX8byHiqEDxqOConQ@mail.gmail.com>
 <CAO-hwJKnH=Brhq7Jv020qQLROarvFiewnRb__0ZF9WVqDuqxLQ@mail.gmail.com> <xG1_-ipfam98DC9VwbLcH9Rnvu8MbVw9-fWMLHN4hKquTDdAL-nFDpLcf5ZsMQDD1WBnT39Uqtopi42ZWjrKfdzv8D-iMJZgRNln_W5VE3M=@protonmail.com>
In-Reply-To: <xG1_-ipfam98DC9VwbLcH9Rnvu8MbVw9-fWMLHN4hKquTDdAL-nFDpLcf5ZsMQDD1WBnT39Uqtopi42ZWjrKfdzv8D-iMJZgRNln_W5VE3M=@protonmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 1 Dec 2023 16:41:48 +0100
Message-ID: <CAO-hwJ+sj8r36eq9hhQLhPKQ48YV4yzsuz0vPgjmQ5u-9DVNdg@mail.gmail.com>
Subject: Re: Requesting your attention and expertise regarding a Tablet/Kernel issue
To:     David Revoy <davidrevoy@protonmail.com>
Cc:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Eric GOUYER <folays@gmail.com>,
        Illia Ostapyshyn <ostapyshyn@sra.uni-hannover.de>,
        jkosina@suse.cz, jason.gerecke@wacom.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Thu, Nov 30, 2023 at 11:25=E2=80=AFPM David Revoy <davidrevoy@protonmail=
.com> wrote:
>
> Hi Benjamin,
>
> > I've updated the HID-BPF filter, and you can find it in the latest pipe=
line[0].
> > I've removed the extra "Stylus" and you should have a better
> > experience with the upper button now.
> > [0] https://gitlab.freedesktop.org/libevdev/udev-hid-bpf/-/jobs/5214827=
4
>
> Thanks for the update!
>
> > I think we are done with the XP-Pen Pro 24. But now I wonder if the
> > Pro 16 (gen2) doesn't also have those glitches.
> > Could you send me the same debug sequence as the last time
> > (transitions from/to touching the surface while holding the upper
> > button) but on the 16 now?
>
> Sure, here is the same action, three time but now on the Pro 16 (Gen2):
> https://www.peppercarrot.com/extras/mailing-list/hid-records/XPPEN-Artist=
-16-Pro-Gen2/2023-11-30_XPPEN-Artist-16-Pro-Gen2_pen_tip-contact-and-press-=
release-upper-stylus-button-while-pressed-x3.txt

Thanks a lot.

And the good news is that we get correct events all the time, so
nothing more to fix here. The current filter is doing a good job
already :)

>
> Have a good end of week,
> David.

Cheers,
Benjamin

>

