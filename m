Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F0F77EAA7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 22:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346119AbjHPU0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 16:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346149AbjHPUZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:25:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF4226A5;
        Wed, 16 Aug 2023 13:25:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0C5E6337F;
        Wed, 16 Aug 2023 20:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A04C433C7;
        Wed, 16 Aug 2023 20:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692217556;
        bh=4Hck3NckYavMevwhzS7rwNDDmjeTuC4S+YTRQAbiwVg=;
        h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
        b=A8v2+j3t2HQhwjby1RKm32OAsnOLt2VvG5yeCOWKH7ZpzYg5JgMnaI2z5bES5IWGE
         GbQbip5Y9ysAZMy7xULtZJvhdLLwuUr2j5sf+Qya85gH01Muae+RfXgg18PqL6c3cg
         hZpM43E+g2Qne22BcPrrCVF0sgGQrgSh0v098IlitieJRQTrhJQxkmX9M31y1QwsVC
         tkoE+lNxEI6Adg5TY9PLbSrXZgajLkxogXX67gmHk8UAZ5/mCyPbTRF+FswF2O1z66
         jXV1kH+X5NjB885Q8ky4EUDOyg3OY8z/QtSgUboPt2uWlJsO5O8x/2MV75ULfXqAvL
         P9eH9gUIIZN3g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 16 Aug 2023 23:25:51 +0300
Message-Id: <CUU9233YQJOT.220UJ3EYHDZZ9@suppilovahvero>
To:     "Randy Dunlap" <rdunlap@infradead.org>,
        <linux-integrity@vger.kernel.org>
Cc:     "Jonathan Corbet" <corbet@lwn.net>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Richard Cochran" <richardcochran@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        "Daniel Sneddon" <daniel.sneddon@linux.intel.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: Re: [PATCH] tpm_tis: Revert "tpm_tis: Disable interrupts on
 ThinkPad T490s"
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.14.0
References: <20230814164054.64280-1-jarkko@kernel.org>
 <155add9d-241c-0e15-cc3b-a2ea22e8cdd0@infradead.org>
In-Reply-To: <155add9d-241c-0e15-cc3b-a2ea22e8cdd0@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Aug 14, 2023 at 11:00 PM EEST, Randy Dunlap wrote:
> Hi Jarkko,
>
> On 8/14/23 09:40, Jarkko Sakkinen wrote:
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index 722b6eca2e93..6354aa779178 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -6340,6 +6340,13 @@
> >  			This will guarantee that all the other pcrs
> >  			are saved.
> > =20
> > +	tpm_tis.interrupts=3D [HW,TPM]
> > +			Enable interrupts for the MMIO based physical layer
> > +			for the FIFO interface. By default it is set to false
> > +			(0). For more information about TPM hardware interfaces
> > +			defined by Trusted Computing Group (TCG) look up to
>
> s/look up to/see/ would be much better IMO.

Agreed, thanks.

BR, Jarkko
