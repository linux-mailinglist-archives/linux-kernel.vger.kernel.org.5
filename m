Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0681F7709B0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjHDUab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjHDUa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:30:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FED04C37;
        Fri,  4 Aug 2023 13:30:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E65E62089;
        Fri,  4 Aug 2023 20:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D26C433C8;
        Fri,  4 Aug 2023 20:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691181026;
        bh=IjaWPgMNXFUechvjZ5srGREWj9qrDUXH+cZifdeGjWE=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=H9uu+TH9crdwyUCCqU++7TFkiRSg7YxjkHVJPXCrg1Sn6Vceak33fbcyW9gwLsD/x
         U6z2NlTvzz9fDhdzzeuD6lobjbZTESBLAwirfF7NBA+sDCtmR1ueVz/r8dMyt61fLK
         e9oVclVfKYYgvsUT/IaS5WEcfEW+ErmsXtvbxCi+6jOr9P/2FtW3nCNnH8afX8Sf7c
         GoB9UResM+XUD09goFFYCbdLS9nOpzSUZ01FyRfIlcsqH6JLhw+m5U97gXhleerbgx
         0EzT7DZFASAwt3Te8s2h/Q8V8WdOg2EqxI1HCQdCYXfYDM9zOUt4i8CbSccWVndswe
         vjahVxIlYbnQQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 04 Aug 2023 23:30:23 +0300
Message-Id: <CUK1N0K8Q7EO.3DI29Q5LG9K63@wks-101042-mac.ad.tuni.fi>
Cc:     <linux-kernel@vger.kernel.org>, "Jason Gunthorpe" <jgg@ziepe.ca>
Subject: Re: boot-time vtpm helper (was "Re: <void>")
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Stefan Berger" <stefanb@linux.ibm.com>,
        <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <CUIRLIY5N6CI.3O9UKOY2N5BS7@suppilovahvero>
 <CUISH28XXJGN.EWZ3CWAQ7G1C@suppilovahvero>
 <4150bf8c-7321-0dab-ab54-dca7d54c1f3d@linux.ibm.com>
In-Reply-To: <4150bf8c-7321-0dab-ab54-dca7d54c1f3d@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Aug 3, 2023 at 3:46 PM EEST, Stefan Berger wrote:
>
>
> On 8/3/23 05:06, Jarkko Sakkinen wrote:
> > On Thu Aug 3, 2023 at 11:25 AM EEST, Jarkko Sakkinen wrote:
> >> Hi,
> >>
> >> I have a working PoC for boot-time initialization of vtpm inside
> >> tpm_vtpm_proxy. ATM, it uses the Linux firmware interface to load a EL=
F
> >> binary for the vtpm, and delivers a communication end for the helper
> >> process.
> >>
> >> It is a great feature with the current narrow scope for continuous
> >> integration. Obviously the scope could be later on extended to e.g.
>
> Since VMs with vTPMs exist, which CI/CD environment would one use this in=
?
>
> Where does the binary for the vtpm live when it's loaded with the firmwar=
e interface?

Obviously vtpm is identified by a filename. The rest of the details are
in the Linux firmware documentation.

> >> from unencrypted plain text to a vTPM living inside SGX enclave.
>
> I would run swtpm inside an SGX enclave using Gramine.

Having a zero configuration and also zero dependency mechanism for
trivial kernel testing is an objective benefit.

> Where does the binary for the vtpm live when it's loaded with the firmwar=
e interface?

Either in initrd or with the help of CONFIG_EXTRA_FIRMWARE_* in vmlinux.

> >> from unencrypted plain text to a vTPM living inside SGX enclave.
>
> I would run swtpm inside an SGX enclave using Gramine.

Why would do you want to enforce the use of swtpm?

BR, Jarkko
