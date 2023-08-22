Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7A07844CB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbjHVO4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbjHVO4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:56:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AE710B;
        Tue, 22 Aug 2023 07:56:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBBE862211;
        Tue, 22 Aug 2023 14:56:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFF0C433C7;
        Tue, 22 Aug 2023 14:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692716167;
        bh=9rBnVtfIE9EEcKxVqKq4SpV+7NlCvzYXOLbTw1vnuVE=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=i3JdsTGodYVHl7yJvR6B/T26F8aauAsMhnbPuDSd5MMEwlF9oNEUWKG7wVpyU7tPF
         49p8V7FN4+viPVex4rfEoG22JaSB8v1lAKVU9mR6A5W/9Bohf4eA/C78Uce8hvUjEb
         sngJHQr/5mpCxMivw+YoejJf4+rzvCmizm+RHZqIf/Ki595WtWGkhuePmTxb4Sl0jl
         suTFG5Fvs5B99LO6zCFD1PdXtHYOxuCK4jLkr0r1UvBUOK0Rhd6l25jjSyIMhCM2Jb
         VeYAJ6hqUm2GUgrCswpQzMMcAgQAZ5FY7Ee+0JS4Y2F4e7ImRqHmm3BB8llYEWdJed
         esHkPJiNzvg6A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 22 Aug 2023 17:56:03 +0300
Message-Id: <CUZ5SUEX8IUC.2LBS3FZP9XUTA@suppilovahvero>
Cc:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, "Todd Brandt" <todd.e.brandt@intel.com>,
        "Patrick Steinhardt" <ps@pks.im>, "Ronan Pigott" <ronan@rjp.ie>,
        "Raymond Jay Golo" <rjgolo@gmail.com>
Subject: Re: [PATCH v2] tpm: Don't make vendor check required for probe
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Mario Limonciello" <mario.limonciello@amd.com>
X-Mailer: aerc 0.14.0
References: <20230821140230.1168-1-mario.limonciello@amd.com>
 <CUZ3T3G99JG2.29X1G67HRO9QT@suppilovahvero>
 <b7d45df7-3d1c-4b31-9da1-5f81d3e5b279@amd.com>
In-Reply-To: <b7d45df7-3d1c-4b31-9da1-5f81d3e5b279@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Aug 22, 2023 at 5:05 PM EEST, Mario Limonciello wrote:
> On 8/22/2023 08:22, Jarkko Sakkinen wrote:
> > On Mon Aug 21, 2023 at 5:02 PM EEST, Mario Limonciello wrote:
> >> The vendor check introduced by commit 554b841d4703 ("tpm: Disable RNG =
for
> >> all AMD fTPMs") doesn't work properly on a number of Intel fTPMs.  On =
the
> >> reported systems the TPM doesn't reply at bootup and returns back the
> >> command code. This makes the TPM fail probe.
> >>
> >> As this isn't crucial for anything but AMD fTPM and AMD fTPM works, ch=
eck
> >> the chip vendor and if it's not AMD don't run the checks.
> >>
> >> Cc: stable@vger.kernel.org
> >> Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
> >> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
> >> Reported-by: Patrick Steinhardt <ps@pks.im>
> >> Reported-by: Ronan Pigott <ronan@rjp.ie>
> >> Reported-by: Raymond Jay Golo <rjgolo@gmail.com>
> >> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217804
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >> v1->v2:
> >>   * Check x86 vendor for AMD
> >> ---
> >>   drivers/char/tpm/tpm_crb.c | 7 ++++++-
> >>   1 file changed, 6 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> >> index 9eb1a18590123..7faf670201ccc 100644
> >> --- a/drivers/char/tpm/tpm_crb.c
> >> +++ b/drivers/char/tpm/tpm_crb.c
> >> @@ -465,8 +465,12 @@ static bool crb_req_canceled(struct tpm_chip *chi=
p, u8 status)
> >>  =20
> >>   static int crb_check_flags(struct tpm_chip *chip)
> >>   {
> >> +	int ret =3D 0;
> >> +#ifdef CONFIG_X86
> >>   	u32 val;
> >> -	int ret;
> >> +
> >> +	if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_AMD)
> >> +		return ret;
> >>  =20
> >>   	ret =3D crb_request_locality(chip, 0);
> >>   	if (ret)
> >> @@ -481,6 +485,7 @@ static int crb_check_flags(struct tpm_chip *chip)
> >>  =20
> >>   release:
> >>   	crb_relinquish_locality(chip, 0);
> >> +#endif
> >=20
> > Looks much better but the main question here is that is this combinatio=
n
> > possible:
> >=20
> > 1. AMD CPU
> > 2. Non-AMD fTPM (i.e. manufacturer property differs)
> >=20
> > BR, Jarkko
>
> Yes that combination is possible.
>
> Pluton TPM uses the tpm_crb driver.

Then I guess we'll go with this for now. Thanks for the effort.

Tested-by: Jarkko Sakkinen <jarkko@kernel.org> # QEMU + swtpm
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

I'm planning to send a pull request right after this with the fix so it
will land to v6.6-rc1 or v6.6-rc2:
https://lore.kernel.org/linux-integrity/20230817201935.31399-1-jarkko@kerne=
l.org/

BR, Jarkko
