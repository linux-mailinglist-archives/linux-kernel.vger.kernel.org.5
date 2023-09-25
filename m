Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE1E7ADB44
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjIYPWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjIYPWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:22:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838BB9C;
        Mon, 25 Sep 2023 08:22:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F12DC433C8;
        Mon, 25 Sep 2023 15:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695655351;
        bh=OGt2FOw6lDFFBJRltNV7eb25Y3RCJfPYVc/8wsDj+lM=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=Kp0VVt1IVmvLWEfHcZ2kGDvXU/kqTSlU+zkPCXYtz6OOHZKhyu9V5NSp0G4CcW036
         DQ9LCiRXD6Q490pl7u8169h7tTEUAz8V7ziRXZiOnxF5dDnpKDrQj68Gjg0adng4T5
         EC3+inaGcrSbVlkKIJs09PWUwziCRokB4AboyUs2UgQ2pt7Zy2tOwb59ADnu4WpGap
         yRdxENwoFnqspD1+SNBWaf1kvwgaAh2yycGM8qQMtVXclYdN2nIeGugErrwJvR4YEl
         H9OHYREey3oOXKbuXZV2mFLTFooU8OLOf/hOR2Asgxbi05opItQVsGdjANQ69Zqjb3
         L4QCoe2YqHFVQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 25 Sep 2023 18:22:22 +0300
Message-Id: <CVS3NIJ8OO6Y.2C6GJ9OBR6COC@suppilovahvero>
Cc:     "Shawn Guo" <shawnguo@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "Fabio Estevam" <festevam@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        "Ahmad Fatoum" <a.fatoum@pengutronix.de>,
        "sigma star Kernel Team" <upstream+dcp@sigma-star.at>,
        "David Howells" <dhowells@redhat.com>,
        "Li Yang" <leoyang.li@nxp.com>, "Paul Moore" <paul@paul-moore.com>,
        "James Morris" <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Tejun Heo" <tj@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        <linux-security-module@vger.kernel.org>,
        "Richard Weinberger" <richard@nod.at>,
        "David Oberhollenzer" <david.oberhollenzer@sigma-star.at>
Subject: Re: [PATCH v3 1/3] crypto: mxs-dcp: Add support for hardware
 provided keys
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "David Gstir" <david@sigma-star.at>,
        "Mimi Zohar" <zohar@linux.ibm.com>,
        "James Bottomley" <jejb@linux.ibm.com>,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
X-Mailer: aerc 0.14.0
References: <20230918141826.8139-1-david@sigma-star.at>
 <20230918141826.8139-2-david@sigma-star.at>
In-Reply-To: <20230918141826.8139-2-david@sigma-star.at>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Sep 18, 2023 at 5:18 PM EEST, David Gstir wrote:
> DCP is capable to performing AES with hardware-bound keys.
> These keys are not stored in main memory and are therefore not directly
> accessible by the operating system.
>
> So instead of feeding the key into DCP, we need to place a
> reference to such a key before initiating the crypto operation.
> Keys are referenced by a one byte identifiers.

Not sure what the action of feeding key into DCP even means if such
action does not exists.

What you probably would want to describe here is how keys get created
and how they are referenced by the kernel.

For the "use" part please try to avoid academic paper style long
expression starting with "we" pronomine.

So the above paragraph would normalize into "The keys inside DCP
are referenced by one byte identifier". Here of course would be
for the context nice to know what is this set of DCP keys. E.g.
are total 256 keys or some subset?

When using too much prose there can be surprsingly little digestable
information, thus this nitpicking.

> DCP supports 6 different keys: 4 slots in the secure memory area,
> a one time programmable key which can be burnt via on-chip fuses
> and an unique device key.
>
> Using these keys is restricted to in-kernel users that use them as buildi=
ng
> block for other crypto tools such as trusted keys. Allowing userspace
> (e.g. via AF_ALG) to use these keys to crypt or decrypt data is a securit=
y
> risk, because there is no access control mechanism.

Unless this patch has anything else than trusted keys this should not
be an open-ended sentence. You want to say roughly that DCP hardware
keys are implemented for the sake to implement trusted keys support,
and exactly and only that.

This description also lacks actions taken by the code changes below,
which is really the beef of any commit description.

BR, Jarkko
