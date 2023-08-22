Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A51B784D39
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 01:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjHVXQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 19:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjHVXQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 19:16:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0904CE9;
        Tue, 22 Aug 2023 16:16:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55F5861530;
        Tue, 22 Aug 2023 23:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020D2C433C8;
        Tue, 22 Aug 2023 23:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692746166;
        bh=jvom6YRY9DFH5+a0nubub9bkoGzaeU6lyAMRBFbF8eU=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=B6KzT4i0p19Ms4aXFI1rXalaTg+n7KRzghhFzyPugaK7L59ByhEdMZXTmP426BVNU
         oqPzuv4v5BpMsccm/OlzRj5fatrKlFoi7Qezuwq9d8coYjZ7owstgW6Sg1CgvePLHA
         8Qz6/tWimb/vgDSUXSyY9fcOwWKzTyDziQg+l2TETXMMfmlqwWOU37ufCu1pJKE/2N
         eIlr9iTQ4WHNFTFJNThxQYNYS9aU3Rzx45jFZsdV/FeVWa7yNgqMQRuTqGh8P1lyvT
         MGn2T/V/9ylyBSG44igWuvzNdntUNdZspLG48dhsrkzAMjR4AAw4BYilQvBgkh6nOV
         1U6Cp4dpAGung==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 23 Aug 2023 02:16:02 +0300
Message-Id: <CUZGFNUNLO3W.1669MKELG1XIL@suppilovahvero>
Cc:     <linux-sgx@vger.kernel.org>, <stable@vger.kernel.org>,
        "Todd Brandt" <todd.e.brandt@intel.com>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tpm: Enable hwrng only for Pluton on AMD CPUs
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jerry Snitselaar" <jsnitsel@redhat.com>
X-Mailer: aerc 0.14.0
References: <20230822203912.2256229-1-jarkko@kernel.org>
 <ubwdpgalqja6c3ggp4rjapqhts7m3pxgrdvm7ytwxitaasbjhd@32tbbipd2vfn>
In-Reply-To: <ubwdpgalqja6c3ggp4rjapqhts7m3pxgrdvm7ytwxitaasbjhd@32tbbipd2vfn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Aug 23, 2023 at 12:28 AM EEST, Jerry Snitselaar wrote:
> On Tue, Aug 22, 2023 at 11:39:12PM +0300, Jarkko Sakkinen wrote:
> > The vendor check introduced by commit 554b841d4703 ("tpm: Disable RNG f=
or
> > all AMD fTPMs") doesn't work properly on a number of Intel fTPMs.  On t=
he
> > reported systems the TPM doesn't reply at bootup and returns back the
> > command code. This makes the TPM fail probe.
> >=20
> > Since only Microsoft Pluton is the only known combination of AMD CPU an=
d
> > fTPM from other vendor, disable hwrng otherwise. In order to make sysad=
min
> > aware of this, print also info message to the klog.
> >=20
> > Cc: stable@vger.kernel.org
> > Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
> > Reported-by: Todd Brandt <todd.e.brandt@intel.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217804
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > v2:
> > * CONFIG_X86
>
> Did you mean to wrap the crb_acpi_add chunk with CONFIG_X86?

Yup :-/

$ git diff
diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 28448bfd4062..ea085b14ab7c 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -805,12 +805,14 @@ static int crb_acpi_add(struct acpi_device *device)
        if (rc)
                goto out;

+#ifdef CONFIG_X86
        /* A quirk for https://www.amd.com/en/support/kb/faq/pa-410 */
        if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD &&
            priv->sm !=3D ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON) {
                dev_info(dev, "Disabling hwrng\n");
                chip->flags |=3D TPM_CHIP_FLAG_HWRNG_DISABLED;
        }
+#endif /* CONFIG_X86 */

        rc =3D tpm_chip_register(chip);

[also linux-sgx leaked by mistake to my git-send-email command line]

I sent a new one:
https://lkml.org/lkml/2023/8/22/1288

BR, Jarkko
