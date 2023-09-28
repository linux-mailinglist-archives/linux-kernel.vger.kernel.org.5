Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AE87B24B6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 20:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjI1SEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 14:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjI1SEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:04:21 -0400
X-Greylist: delayed 448 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 28 Sep 2023 11:04:17 PDT
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A06DD;
        Thu, 28 Sep 2023 11:04:17 -0700 (PDT)
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id AA16F2849E2;
        Thu, 28 Sep 2023 19:56:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
        s=gen1; t=1695923805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DWp3kDtho7RU/DdQcVMnlTwUzQKLeIBgkhDxP9Wgdl0=;
        b=vQU/YjfnQ2WCDqgnnbT2/EXcIiQ72fNfw5LmI81X9kGcN84JD1mvxp4bUNsVGOhhYcKxtR
        xWhddkYSNNaNgjYPedleSdaSptLcjInqJIMYM0yIogNmMhOhLxbiPNuTgPz8Y0jFCjrUjZ
        b38mG6AmqkXJADH50Ls5hKhAbrrIrKQ=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: karelb)
        by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 8757644AFF0;
        Thu, 28 Sep 2023 19:56:45 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 28 Sep 2023 19:56:45 +0200
Message-Id: <CVUQTCJBG265.1MTSYOLY0FR7Q@gimli.ms.mff.cuni.cz>
Cc:     "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Markuss Broks" <markuss.broks@gmail.com>,
        <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        <~postmarketos/upstreaming@lists.sr.ht>
Subject: Re: [PATCH 2/2] input: Imagis: add support for the IST3032C
 touchscreen
To:     "Jeff LaBundy" <jeff@labundy.com>, "Karel Balej" <balejk@matfyz.cz>
From:   "Karel Balej" <karelb@gimli.ms.mff.cuni.cz>
References: <20230926173531.18715-1-balejk@matfyz.cz>
 <20230926173531.18715-3-balejk@matfyz.cz> <ZROIKSVCiTI3VB2B@nixie71>
In-Reply-To: <ZROIKSVCiTI3VB2B@nixie71>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Jeff,

thank you very much for your feedback.

> > +	if (chip_id =3D=3D IST3032C_WHOAMI) {
> > +		/*
> > +		 * if the regulator voltage is not set like this, the touchscreen
> > +		 * generates random touches without user interaction
> > +		 */
> > +		error =3D regulator_set_voltage(ts->supplies[0].consumer, 3100000, 3=
100000);
> > +		if (error)
> > +			dev_warn(dev, "failed to set regulator voltage\n");
> > +	}
> > +
>
> Opinions may vary, but mine is that this kind of hard-coded board-level p=
olicy
> does not belong in the driver. Surely the supply need not be equal to exa=
ctly
> 3.1 V and this is merely an upper or lower limit? Assuming so, what if th=
e board
> designer opts to share this supply with another consumer that requires a =
specific
> voltage not equal to 3.1 V, but still within the safe range of IST3032C?
>
> To me, this restriction belongs in dts, specifically within the regulator=
 child
> node referenced by the client which bears the new 'ist3032c' compatible s=
tring.
> Maybe a better solution is to simply note this presumed silicon erratum i=
n the
> description of the vdd supply in the binding which, as Conor states, must=
 not be
> clubbed with driver patches.

I agree that the voltage should not be hardcoded. I do not know what the
safe range for the touchscreen is though, because the downstream driver
does exactly this. I will try to test it with several values within the
range allowed by the regulator and see if I can determine some limits on
when the "ghost" touches do not appear.

However I am not sure whether this setting should be moved to the
regulator DT - it is my understanding that the DT for the regulator
should list the min/max range *supported* by the regulator, not conform
to requirements of its consumers, which should instead ask for the
regulator to be set to a range they require themselves, via their driver
- is it not so?

The regulator driver is not mainlined yet (although I managed to get the
downstream code working with mainline), however the downstream DT
contains much wider range of supported voltage (compared to those 3.1 V
used by the touchscreen) - an information which would get lost if I set
the DT for the regulator by the requirements of the touchscreen, which I
believe would have similiar implications as what you said regarding
using this regulator with other consumers.

What would seem a reasonable solution to me would be to move the voltage
range values to the touchscreen DT (which incidentally is what the
downstream driver does also, except it uses one value for both min and
max), so that they would be set by the driver but not hardcoded in the
code - what do you think about this?

Best regards,
K. B.
