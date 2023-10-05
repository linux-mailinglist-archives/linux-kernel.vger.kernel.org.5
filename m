Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60F67B9E12
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjJEN73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 09:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbjJEN51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 09:57:27 -0400
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [IPv6:2001:1600:4:17::8faa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203FF20E6E;
        Thu,  5 Oct 2023 03:32:16 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4S1SY801f8zMqBgm;
        Thu,  5 Oct 2023 10:32:12 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4S1SY20tYRzMppL1;
        Thu,  5 Oct 2023 12:32:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1696501931;
        bh=suUb32LsvZvJXQo1E+kH10Y5wi38d7ejPfrg9DrJRXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IKLPqywSv6RJ+AkeGeyrA3f87kAtUIuegt7QuHA4S1cLJZYqM0X7HfQFlaUOeIGov
         qwIlaTXPuyPlH/IQ2Mgh3QEyANognYDO2f2u1uK2PTH6bq67jgNYQGlXp7NotzoR6h
         jLyluakXyRrHOlVJ2zt7Dd122Je3xioFtCx+HD+4=
Date:   Thu, 5 Oct 2023 12:32:08 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Subject: RFC: New LSM to control usage of x509 certificates
Message-ID: <20231005.dajohf2peiBu@digikod.net>
References: <CEA476C1-4CE5-4FFC-91D7-6061C8605B18@oracle.com>
 <ba2f5560800608541e81fbdd28efa9875b35e491.camel@linux.ibm.com>
 <932231F5-8050-4436-84B8-D7708DC43845@oracle.com>
 <7335a4587233626a39ce9bc8a969957d7f43a34c.camel@linux.ibm.com>
 <FD6FB139-F901-4E55-9705-E7B0023BDBA8@oracle.com>
 <1149b6dbfdaabef3e48dc2852cc76aa11a6dd6b0.camel@linux.ibm.com>
 <4A0505D0-2933-43BD-BEEA-94350BB22AE7@oracle.com>
 <20230913.Ceifae7ievei@digikod.net>
 <D0F16BFD-72EB-4BE2-BA3D-BAE1BCCDCB6F@oracle.com>
 <20230914.shah5al9Kaib@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230914.shah5al9Kaib@digikod.net>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial subject was "Re: [PATCH] certs: Restrict blacklist updates
to the secondary trusted keyring":
https://lore.kernel.org/all/20230908213428.731513-1-eric.snowberg@oracle.com/

On Thu, Sep 14, 2023 at 10:34:44AM +0200, Mickaël Salaün wrote:
> CCing the LSM mailing list for this potential new LSM proposal:
> 
> On Wed, Sep 13, 2023 at 10:29:58PM +0000, Eric Snowberg wrote:
> > 
> > 
> > > On Sep 13, 2023, at 4:21 AM, Mickaël Salaün <mic@digikod.net> wrote:
> > > 
> > > On Wed, Sep 13, 2023 at 02:40:17AM +0000, Eric Snowberg wrote:
> > >> 
> > >> 
> > >>> On Sep 12, 2023, at 4:47 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > >>> 
> > >>> On Tue, 2023-09-12 at 17:11 +0000, Eric Snowberg wrote:
> > >>>> 
> > >>>>> On Sep 12, 2023, at 5:54 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > >>>>> 
> > >>>>> On Tue, 2023-09-12 at 02:00 +0000, Eric Snowberg wrote:
> > >>>>>> 
> > >>>>>>> On Sep 11, 2023, at 5:08 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > >>>>>>> 
> > >>>>>>> On Mon, 2023-09-11 at 22:17 +0000, Eric Snowberg wrote:
> > >>>>>>>> 
> > >>>>>>>>> On Sep 11, 2023, at 10:51 AM, Mickaël Salaün <mic@digikod.net> wrote:
> > >>>>>>>>> 
> > >>>>>>>>> On Mon, Sep 11, 2023 at 09:29:07AM -0400, Mimi Zohar wrote:
> > >>>>>>>>>> Hi Eric,
> > >>>>>>>>>> 
> > >>>>>>>>>> On Fri, 2023-09-08 at 17:34 -0400, Eric Snowberg wrote:
> > >>>>>>>>>>> Currently root can dynamically update the blacklist keyring if the hash
> > >>>>>>>>>>> being added is signed and vouched for by the builtin trusted keyring.
> > >>>>>>>>>>> Currently keys in the secondary trusted keyring can not be used.
> > >>>>>>>>>>> 
> > >>>>>>>>>>> Keys within the secondary trusted keyring carry the same capabilities as
> > >>>>>>>>>>> the builtin trusted keyring.  Relax the current restriction for updating
> > >>>>>>>>>>> the .blacklist keyring and allow the secondary to also be referenced as
> > >>>>>>>>>>> a trust source.  Since the machine keyring is linked to the secondary
> > >>>>>>>>>>> trusted keyring, any key within it may also be used.
> > >>>>>>>>>>> 
> > >>>>>>>>>>> An example use case for this is IMA appraisal.  Now that IMA both
> > >>>>>>>>>>> references the blacklist keyring and allows the machine owner to add
> > >>>>>>>>>>> custom IMA CA certs via the machine keyring, this adds the additional
> > >>>>>>>>>>> capability for the machine owner to also do revocations on a running
> > >>>>>>>>>>> system.
> > >>>>>>>>>>> 
> > >>>>>>>>>>> IMA appraisal usage example to add a revocation for /usr/foo:
> > >>>>>>>>>>> 
> > >>>>>>>>>>> sha256sum /bin/foo | awk '{printf "bin:" $1}' > hash.txt
> > >>>>>>>>>>> 
> > >>>>>>>>>>> openssl smime -sign -in hash.txt -inkey machine-private-key.pem \
> > >>>>>>>>>>>   -signer machine-certificate.pem -noattr -binary -outform DER \
> > >>>>>>>>>>>   -out hash.p7s
> > >>>>>>>>>>> 
> > >>>>>>>>>>> keyctl padd blacklist "$(< hash.txt)" %:.blacklist < hash.p7s
> > >>>>>>>>>>> 
> > >>>>>>>>>>> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> > >>>>>>>>>> 
> > >>>>>>>>>> The secondary keyring may include both CA and code signing keys.  With
> > >>>>>>>>>> this change any key loaded onto the secondary keyring may blacklist a
> > >>>>>>>>>> hash.  Wouldn't it make more sense to limit blacklisting
> > >>>>>>>>>> certificates/hashes to at least CA keys? 
> > >>>>>>>>> 
> > >>>>>>>>> Some operational constraints may limit what a CA can sign.
> > >>>>>>>> 
> > >>>>>>>> Agreed.  
> > >>>>>>>> 
> > >>>>>>>> Is there precedents for requiring this S/MIME to be signed by a CA? 
> > >>>>>>>> 
> > >>>>>>>>> This change is critical and should be tied to a dedicated kernel config
> > >>>>>>>>> (disabled by default), otherwise existing systems using this feature
> > >>>>>>>>> will have their threat model automatically changed without notice.
> > >>>>>>>> 
> > >>>>>>>> Today we have INTEGRITY_CA_MACHINE_KEYRING_MAX.  This can 
> > >>>>>>>> be enabled to enforce CA restrictions on the machine keyring.  Mimi, would 
> > >>>>>>>> this be a suitable solution for what you are after?
> > >>>>>>> 
> > >>>>>>> There needs to be some correlation between the file hashes being added
> > >>>>>>> to the blacklist and the certificate that signed them.  Without that
> > >>>>>>> correlation, any key on the secondary trusted keyring could add any
> > >>>>>>> file hashes it wants to the blacklist.
> > >>>>>> 
> > >>>>>> Today any key in the secondary trusted keyring can be used to validate a 
> > >>>>>> signed kernel module.  At a later time, if a new hash is added to the blacklist 
> > >>>>>> keyring to revoke loading a signed kernel module,  the ability to do the 
> > >>>>>> revocation with this additional change would be more restrictive than loading 
> > >>>>>> the original module.
> > >>>>> 
> > >>>>> A public key on the secondary keyring is used to verify code that it
> > >>>>> signed, but does not impact any other code. Allowing any public key on
> > >>>>> the secondary keyring to blacklist any file hash is giving it more
> > >>>>> privileges than it originally had.
> > >>>>> 
> > >>>>> This requirement isn't different than how Certificate Revocation List
> > >>>>> (CRL) work.  Not any CA can revoke a certificate.
> > >>>> 
> > >>>> In UEFI Secure Boot we have the Forbidden Signature Database (DBX).  
> > >>>> Root can update the DBX on a host.  The requirement placed on updating 
> > >>>> it is the new DBX entry must be signed by any key contained within the 
> > >>>> KEK.  Following a reboot, all DBX entries load into the .blacklist keyring.  
> > >>>> There is not a requirement similar to how CRL’s work here, any KEK key 
> > >>>> can be used.
> > >>>> 
> > >>>> With architectures booted through a shim there is the MOKX.  Similar to 
> > >>>> DBX, MOKX have the same capabilities, however they do not need to be 
> > >>>> signed by any key, the machine owner must show they have physical 
> > >>>> presence (and potentially a MOK password) for inclusion.  Again there 
> > >>>> is not a requirement similar to how CRL’s work here either.  The machine 
> > >>>> owner can decide what is included.
> > >>>> 
> > >>>> Today when a kernel is built, any number of keys may be included within 
> > >>>> the builtin trusted keyring.  The keys included in the kernel may not have 
> > >>>> a single usage field set or the CA bit set.  There are no requirements on 
> > >>>> how these keys get used later on.  Any key in the builtin trusted keyring 
> > >>>> can be used to sign a revocation that can be added to the blacklist keyring.  
> > >>>> Additionally, any key in the MOK can be used to sign this kernel and it will 
> > >>>> boot.  Before booting the kernel, MOK keys have more privileges than 
> > >>>> after the kernel is booted in some instances.
> > >>>> 
> > >>>> Today MOK keys can be loaded into the machine keyring.  These keys get 
> > >>>> linked to the secondary trusted keyring.  Currently key usage enforcement
> > >>>> is being applied to these keys behind some Kconfig options.  By default 
> > >>>> anything in the secondary has the same capabilities as the builtin trusted 
> > >>>> keyring.  What is challenging here with this request is the inconsistency 
> > >>>> between how everything else currently works. 
> > >>>> 
> > >>>> Root can not arbitrarily add things to the secondary trusted keyring.  These 
> > >>>> keys must be signed by something in either the machine or the builtin.  In 
> > >>>> this thread [1], Jarkko is saying CA based infrastructure should be a policy 
> > >>>> decision not to be enforced by the kernel. Wouldn’t this apply here as well?
> > >>>> 
> > >>>> 1. https://lore.kernel.org/lkml/CVGUFUEQVCHS.37OA20PNG9EVB@suppilovahvero/
> > >>> 
> > >>> Mickaël said, "This change is critical and should be tied to a
> > >>> dedicated kernel config
> > >>> (disabled by default), otherwise existing systems using this feature
> > >>> will have their threat model automatically changed without notice."
> > >> 
> > >> I was thinking he meant it is critical not to change the current behavior
> > >> by limiting blacklisting to only CA keys.  Not that it was critical to add
> > >> CA enforcement.  Maybe Mickaël can comment?
> > > 
> > > I meant that applying this patch as-is may change the threat model used
> > > by some users. Currently, only signed hashes vouched by the builtin
> > > trusted keyring are valid. If we extend this mechanism to the secondary
> > > trusted keyring without notice, this means that more certificates could
> > > vouch blacklisted hashes, which may include some certificates with an
> > > initial different usage.
> > > 
> > > See commit 4da8f8c8a1e0 ("dm verity: Add support for signature
> > > verification with 2nd keyring") that adds
> > > CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG_SECONDARY_KEYRING:
> > > https://lore.kernel.org/all/20201023170512.201124-1-mic@digikod.net/
> > 
> > Thanks for clarifying.  I’ll add something similar in v2.
> > 
> > >> 
> > >>> As a possible alternative I suggested limiting which file hashes the
> > >>> certs on the secondary (or machine) keyring could blacklist.
> > >> 
> > >> I’m not sure I completely understand your suggestion here.
> > >> Do you mean, verify the CA bit is set for secondary keys, but
> > >> ignore the bit for builtin?  And then only use those keys to add
> > >> hashes to the blacklist keyring?  If I have that right, what would 
> > >> be the justification for the change based on how things currently
> > >> get included in the blacklist keyring?  Thanks.
> > > 
> > > I'd like to be able to specify which kind of certificate can vouch for
> > > blacklisting hashes, and for other usages, but AFAIK this is not the
> > > path Linux has followed (e.g. unlike Windows). We only have the keyring
> > > to identify an usage, which is unfortunate. On the other side, this
> > > approach lets users manage their certificates without constraint, which
> > > is quite (too?) flexible.
> > 
> > Yes, it is very flexible. What I believe Mimi is after is having a way to 
> > track what cert actually vouched for each specific binary hash.  But this
> > information is not tracked, plus entries within it can come from various 
> > sources that are not signed (dbx, mokx, compiled in).  Also key usage is 
> > being ignored.
> > 
> > > A complementary approach would be to create an
> > > LSM (or a dedicated interface) to tie certificate properties to a set of
> > > kernel usages, while still letting users configure these constraints.
> > 
> > That is an interesting idea.  Would the other security maintainers be in 
> > support of such an approach?  Would a LSM be the correct interface?  
> > Some of the recent work I have done with introducing key usage and CA 
> > enforcement is difficult for a distro to pick up, since these changes can be 
> > viewed as a regression.  Each end-user has different signing procedures 
> > and policies, so making something work for everyone is difficult.  Letting the 
> > user configure these constraints would solve this problem.
> > 
