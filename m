Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15377B534B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237101AbjJBMd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237075AbjJBMdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:33:25 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCE3AD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 05:33:22 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50567477b29so5321663e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 05:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1696250001; x=1696854801; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=StpB9mR4+Ji6vD1c80NIElCOF05XnAD93+ZiNtHS3IU=;
        b=RXUPNinKZ6CRQcofZ9YRYGfW/vIegaLqauWSS0ragS5ZbfrMF3rheJ8Lk1M6rGjgS8
         /bgEMxcxQn7bU4/tyXNEEelyw+CkYV2P9D8EPQogXl6CKe5vJLVE57unpScsgQxnn9xr
         s2DIOWUukMRKtWj+ZrkQWMrpocuZ9T79zCPIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696250001; x=1696854801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=StpB9mR4+Ji6vD1c80NIElCOF05XnAD93+ZiNtHS3IU=;
        b=AWoi/uim4XEvsBG9cKpDzNf0RkQP13lReovYoQwEc2YoNGo/f+vaCkQJVpUrHRJUHH
         FXbCObjbzm5SFQSUCymU2PeWERm/187NILdlC0L6KL15e1YaZMXGjMpBEZ4gIOXEKyIV
         VR3qE5mTJos+lotfAMDymU5J7P7XDK723NVfClmbDJj+4bRiL6Key6I1r9ZZJm+a2cT7
         h7jHYk+8wjrNHf8Se4ez/kYc+TnPU+/aSb16tXtJy26v7sz7NkZgjBqbYcirBREGSHOj
         fOmPNgBh6hcdpC1ikuRehtv9pT8yUg9DBxOfFCgQZ1ZX/PcNVeJhGkf5yCEoukTB3/Gl
         okPQ==
X-Gm-Message-State: AOJu0YyK8uzz7/JSvECvmalEyDbGKo90B7wuFyk7dHP9vMDg2SFgIsNE
        UheROguCzdgncS6iijBwAFagIsZMTpvEkUURK+MCow==
X-Google-Smtp-Source: AGHT+IEW/SaIAI2xQ7EUTpmpm2B44VAy3ik0sK5VWBTLyhWB/kPdYvpBRtR91uz3jMYk6rcNrEqzJFVyVj+6ZKEtEAc=
X-Received: by 2002:a05:6512:29b:b0:503:fee:5849 with SMTP id
 j27-20020a056512029b00b005030fee5849mr7964621lfp.53.1696250000601; Mon, 02
 Oct 2023 05:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230926175208.9298-1-james.quinlan@broadcom.com>
 <20230926175208.9298-2-james.quinlan@broadcom.com> <CACRpkdYGPpUUCqmJLT4t+6CNOOmRAh_vYPSPK1SWy+tNycnSqQ@mail.gmail.com>
 <CA+-6iNwkegPBxeksgNntrP1Cr5Edk5Q4o660NCZjKo9s8z3OOQ@mail.gmail.com> <d0d1452f-3746-a357-3255-c164222ba4bf@arm.com>
In-Reply-To: <d0d1452f-3746-a357-3255-c164222ba4bf@arm.com>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Mon, 2 Oct 2023 08:33:08 -0400
Message-ID: <CA+-6iNyj2ZuosbeNb2kB=BXh6XjW=VKS37CVK0uh4YFvLVHBFg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ARM: Select DMA_DIRECT_REMAP to fix restricted DMA
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Christoph Hellwig <hch@lst.de>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Claire Chang <tientzu@chromium.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000c2d0230606bafa2f"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000c2d0230606bafa2f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 11:47=E2=80=AFAM Robin Murphy <robin.murphy@arm.com=
> wrote:
>
> On 28/09/2023 1:07 pm, Jim Quinlan wrote:
> > On Wed, Sep 27, 2023 at 7:10=E2=80=AFPM Linus Walleij <linus.walleij@li=
naro.org> wrote:
> >>
> >> Hi Jim,
> >>
> >> thanks for your patch!
> >>
> >> On Tue, Sep 26, 2023 at 7:52=E2=80=AFPM Jim Quinlan <james.quinlan@bro=
adcom.com> wrote:
> >>
> >>> Without this commit, the use of dma_alloc_coherent() while
> >>> using CONFIG_DMA_RESTRICTED_POOL=3Dy breaks devices from working.
> >>> For example, the common Wifi 7260 chip (iwlwifi) works fine
> >>> on arm64 with restricted memory but not on arm, unless this
> >>> commit is applied.
> >>>
> >>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> >>
> >> (...)
> >>> +       select DMA_DIRECT_REMAP
> >>
> >> Christoph invented that symbol so he can certainly
> >> explain what is missing to use this on ARM.
> >>
> >> This looks weird to me, because:
> >>> git grep atomic_pool_init
> >> arch/arm/mm/dma-mapping.c:static int __init atomic_pool_init(void)
> >> kernel/dma/pool.c:static int __init dma_atomic_pool_init(void)
> >>
> >> Now you have two atomic DMA pools in the kernel,
> >> and a lot more than that is duplicated. I'm amazed that it
> >> compiles at all.
> >>
> >> Clearly if you want to do this, surely the ARM-specific
> >> arch/arm/mm/dma-mapping.c and arch/arm/mm/dma-mapping-nommu.c
> >> needs to be removed at the same time?
> >>
> >> However I don't think it's that simple, because Christoph would surely
> >> had done this a long time ago if it was that simple.
> >
> > Hello Linus,
> >
> > Yes, this is the reason I used "RFC" as the fix looked too easy to be v=
iable :-)
> > I debugged it enough to see that the host driver's
> > writes to the dma_alloc_coherent() region  were not appearing in
> > memory, and that
> > led me to DMA_DIRECT_REMAP.
>
> Oh, another thing - the restricted-dma-pool is really only for streaming
> DMA - IIRC there can be cases where the emergency fallback of trying to
> allocate out of the bounce buffer won't work properly. Are you also
> using an additional shared-dma-pool carveout to satisfy the coherent
> allocations, per the DT binding?

Hello Robin,
Sorry for the delay.  We use "restricted DMA" as a poor person's IOMMU; we =
can
restrict the DMA memory of a device to a narrow region, and our memory
bus HW has
"checkers' to enforce said region for a specific memory client, e.g. PCIe.

We can confirm the assignment of restricted DMA in the bootlog when the dev=
ice
is probed:

        iwlwifi 0001:01:00.0: assigned reserved memory node pcieSR1@4a00000=
0
        iwlwifi 0001:01:00.0: enabling device (0000 -> 0002)

As far as your other question, why don't I  just post our relevant DT [1].

Regards,
Jim Quinlan
Broardcom STB/CM

[1]
memory {
        device_type =3D "memory";
        reg =3D <0x0 0x40000000 0x1 0x0>;
};

reserved-memory {
        #address-cells =3D <0x2>;
        #size-cells =3D <0x2>;
        ranges;
        /* ... */

        pcieSR1@4a000000 {
                linux,phandle =3D <0x2a>;
                phandle =3D <0x2a>;
                compatible =3D "restricted-dma-pool";
                reserved-names =3D "pcieSR1";
                reg =3D <0x0 0x4a000000 0x0 0x2400000>;
        };
};
pcie@8b20000 {
        /* ... */
        pci@0,0 {
                /* ... */
                pci-ep@0,0 {
                        memory-region =3D <0x2a>;
                        reg =3D <0x10000 0x0 0x0 0x0 0x0>;
                };
        };
};




>
> Thanks,
> Robin.

--000000000000c2d0230606bafa2f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOAplh6h3nMZUZxBguxG3g2p3iD4EgibUYneEzqOQafIQB/naf2uetKb8y9jKgWJxq2Y4y8Jqg2u
uVIO1AyOJjWwqdgN+QhuIlat+qZd03P48Gim9ZPEMDUCAwEAAaOCAdswggHXMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJQYDVR0R
BB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYD
VR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFGx/E27aeGBP2eJktrILxlhK
z8f6MA0GCSqGSIb3DQEBCwUAA4IBAQBdQQukiELsPfse49X4QNy/UN43dPUw0I1asiQ8wye3nAuD
b3GFmf3SZKlgxBTdWJoaNmmUFW2H3HWOoQBnTeedLtV9M2Tb9vOKMncQD1f9hvWZR6LnZpjBIlKe
+R+v6CLF07qYmBI6olvOY/Rsv9QpW9W8qZYk+2RkWHz/fR5N5YldKlJHP0NDT4Wjc5fEzV+mZC8A
AlT80qiuCVv+IQP08ovEVSLPhUp8i1pwsHT9atbWOfXQjbq1B/ditFIbPzwmwJPuGUc7n7vpmtxB
75sSFMj27j4JXl5W9vORgHR2YzuPBzfzDJU1ul0DIofSWVF6E1dx4tZohRED1Yl/T/ZGMYICbTCC
AmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMSO43VW7D5NP1X/KD
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDnXxhvcJpfE0IggDCLslBXE1TUjCEg
w6MjqBQE12kuYzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMzEw
MDIxMjMzMjFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAIjtyWdCl/0+crzDWcJJwrwmKZiXHhomqe7h9pQvRq1aFA1P1
F52yovg6bALKLQ6yDBiPxTVnwX3KBnx0RFvyaaWsyeeJIuyDLIbv2Eh9EAHZO41c6ms6aJ34ujuL
tKEhHSgNjScorUzKKZxb7rwUrDpG3NGspG0eOYhmikMlQjvqXZpyimNPLLgAWSkVHEdvYFWq5i13
GMRyqNRE2KTeJ2NpWJSkNML+EuM0bh4Vid2r6ArvkJSNJ3myVa/QMaK9tptitWMyfsKZ2cfC6gDz
03Cq6dlNbUzm/ZvrPslNLmbFqph+R5TYRyVfVpmtGU0Sg0L+YNfN28bTxO074B5QNg==
--000000000000c2d0230606bafa2f--
