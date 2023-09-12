Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1180579CC5E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjILJuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbjILJuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:50:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61ABBE5F;
        Tue, 12 Sep 2023 02:49:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229BCC43395;
        Tue, 12 Sep 2023 09:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694512196;
        bh=iIW7ciGWybIARozzfiRHtOz95Ez3pQ72Bb9zv5s25O4=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=ueMO6ienw+FxLK4joCzSYY6ODFNbmyw2ZVZS4SLV+q0gdsvP13kQPbNMeRxiYaIex
         R1tbQO6X4qyb1TOHjTIu8mC1/LYRzfJSV1/FnKongdVWOUbVgrEVumBuw7jiIHfVm4
         5ajfx+/abCKX3IW0w2UHNVUWFp9+InyfR8w/j5CLy0I0B87ZRTqmBlcIGaq/ZIyMAD
         PyzPRwlIvc1DMQnL4u5vC4j9RnME2dZ7+U1vTsMJYyff3UHoUjKCB7ESPG6T8yPDa4
         5IMFWYvqr9Yvxt5YO5BW5Xoj2OgibYec9P7rt77g3nUUlfiMgAHEHs0rUY5eKiM48Y
         W5WCiv25FzynQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Sep 2023 12:49:52 +0300
Message-Id: <CVGUFUEQVCHS.37OA20PNG9EVB@suppilovahvero>
Cc:     <linux-integrity@vger.kernel.org>,
        "Mimi Zohar" <zohar@linux.ibm.com>,
        "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
        "Paul Moore" <paul@paul-moore.com>,
        "James Morris" <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "joeyli" <jlee@suse.com>,
        "Eric Snowberg" <eric.snowberg@oracle.com>,
        "Nayna Jain" <nayna@linux.ibm.com>,
        "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] integrity: powerpc: Do not select CA_MACHINE_KEYRING
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     =?utf-8?q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        "Nayna" <nayna@linux.vnet.ibm.com>
X-Mailer: aerc 0.14.0
References: <20230907165224.32256-1-msuchanek@suse.de>
 <20230907173232.GD8826@kitsune.suse.cz>
 <92e23f29-1a16-54da-48d1-59186158e923@linux.vnet.ibm.com>
 <20230912074116.GL8826@kitsune.suse.cz>
In-Reply-To: <20230912074116.GL8826@kitsune.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Sep 12, 2023 at 10:41 AM EEST, Michal Such=C3=A1nek wrote:
> On Mon, Sep 11, 2023 at 11:39:38PM -0400, Nayna wrote:
> >=20
> > On 9/7/23 13:32, Michal Such=C3=A1nek wrote:
> > > Adding more CC's from the original patch, looks like get_maintainers =
is
> > > not that great for this file.
> > >=20
> > > On Thu, Sep 07, 2023 at 06:52:19PM +0200, Michal Suchanek wrote:
> > > > No other platform needs CA_MACHINE_KEYRING, either.
> > > >=20
> > > > This is policy that should be decided by the administrator, not Kco=
nfig
> > > > dependencies.
> >=20
> > We certainly agree that flexibility is important. However, in this case=
,
> > this also implies that we are expecting system admins to be security
> > experts. As per our understanding, CA based infrastructure(PKI) is the
> > standard to be followed and not the policy decision. And we can only sp=
eak
> > for Power.
> >=20
> > INTEGRITY_CA_MACHINE_KEYRING ensures that we always have CA signed leaf
> > certs.
>
> And that's the problem.
>
> From a distribution point of view there are two types of leaf certs:
>
>  - leaf certs signed by the distribution CA which need not be imported
>    because the distribution CA cert is enrolled one way or another
>  - user generated ad-hoc certificates that are not signed in any way,
>    and enrolled by the user
>
> The latter are vouched for by the user by enrolling the certificate, and
> confirming that they really want to trust this certificate. Enrolling
> user certificates is vital for usability or secure boot. Adding extra
> step of creating a CA certificate stored on the same system only
> complicates things with no added benefit.

This all comes down to the generic fact that kernel should not
proactively define what it *expects* sysadmins.

CA based infrastructure like anything is a policy decision not
a decision to be enforced by kernel.

BR, Jarkko
