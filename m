Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2030976CD34
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbjHBMnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbjHBMnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:43:10 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C442722;
        Wed,  2 Aug 2023 05:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1690980111;
        bh=OVp9/5eXr90ixhPTEpgp22DDNgheas8aSJabvLl6ZBc=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=wYfpWYWZtLtDmi4p2IyLnx+xqeaHzaQudIjkJwIUIxiRaQpjrZ35/sbaEkKvH5Z+e
         3Y5arjwM9mWrkKn95lfLoVubYX8mtVZf9aN+8yGEuEE4I7jg4QXYOvu5DvlvXgtZW8
         02+KFkY9yagBAn+CTxacejwVEfCaAvbvVnvQBWCk=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C4E0A128006A;
        Wed,  2 Aug 2023 08:41:51 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id JV7x_JQ4eBds; Wed,  2 Aug 2023 08:41:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1690980111;
        bh=OVp9/5eXr90ixhPTEpgp22DDNgheas8aSJabvLl6ZBc=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=wYfpWYWZtLtDmi4p2IyLnx+xqeaHzaQudIjkJwIUIxiRaQpjrZ35/sbaEkKvH5Z+e
         3Y5arjwM9mWrkKn95lfLoVubYX8mtVZf9aN+8yGEuEE4I7jg4QXYOvu5DvlvXgtZW8
         02+KFkY9yagBAn+CTxacejwVEfCaAvbvVnvQBWCk=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id EECA01280255;
        Wed,  2 Aug 2023 08:41:49 -0400 (EDT)
Message-ID: <5a76c56a10f6512d0613577a412d2644945dbe77.camel@HansenPartnership.com>
Subject: Re: [PATCH 0/4] keys: Introduce a keys frontend for attestation
 reports
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Huang, Kai" <kai.huang@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>
Cc:     "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "dionnaglaze@google.com" <dionnaglaze@google.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Date:   Wed, 02 Aug 2023 08:41:47 -0400
In-Reply-To: <070e2386c99137b59bea114032d22664dd7272f8.camel@intel.com>
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
         <a507ef3302d3afff58d82528ee17e82df1f21de0.camel@HansenPartnership.com>
         <64c5ed6eb4ca1_a88b2942a@dwillia2-xfh.jf.intel.com.notmuch>
         <c6576d1682b576ba47556478a98f397ed518a177.camel@HansenPartnership.com>
         <6dec442c64faf2fecd21bcc77e4a6350e88948b9.camel@intel.com>
         <55cec220f20c497925f46074fc70eeccccff61c9.camel@HansenPartnership.com>
         <ebedf39723d465923413b0ab2b50fe6c78aab64b.camel@HansenPartnership.com>
         <070e2386c99137b59bea114032d22664dd7272f8.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-08-02 at 00:10 +0000, Huang, Kai wrote:
> On Tue, 2023-08-01 at 08:30 -0400, James Bottomley wrote:
> > On Tue, 2023-08-01 at 08:03 -0400, James Bottomley wrote:
> > > On Tue, 2023-08-01 at 11:45 +0000, Huang, Kai wrote:
> > > [...]
> > > > 
> > > > Sorry perhaps a dumb question to ask:
> > > > 
> > > > As it has been adequately put, the remote verifiable report
> > > > normally contains a nonce.  For instance, it can be a per-
> > > > session or per-request nonce from the remote verification
> > > > service to the confidential VM.  
> > > > 
> > > > IIUC, exposing attestation report via /sysfs means many
> > > > processes (in the confidential VM) can potentially see the
> > > > report and the nonce. My question is whether such nonce should
> > > > be considered as a secret thus should be only visible to the
> > > > process which is responsible for talking to the remote
> > > > verification service? 
> > > > Using IOCTL seems can avoid such exposure.
> > > 
> > > OK, so the nonce seems to be a considerably misunderstood piece
> > > of this (and not just by you), so I'll try to go over carefully
> > > what it is and why.  The problem we have in pretty much any
> > > signature based attestation evidence scheme is when I, the
> > > attesting party, present the signed evidence to you, the relying
> > > part, how do you know I got it today from the system in question
> > > not five days ago when I happen to have engineered the correct
> > > conditions?  The solution to this currency problem is to
> > > incorporate a challenge supplied by the relying party (called a
> > > nonce) into the signature.  The nonce must be unpredictable
> > > enough that the attesting party can't guess it beforehand and it
> > > must be unique so that the attesting party can't go through its
> > > records and find an attestation signature with the same
> > > nonce and supply that instead.
> > > 
> > > This property of unpredictability and uniqueness is usually
> > > satisfied simply by sending a random number.  However, as you can
> > > also see, since the nonce is supplied by the relying party to the
> > > attesting party, it eventually gets known to both, so can't be a
> > > secret to one or the other.  Because of the unpredictability
> > > requirement, it's generally frowned on to have nonces based on
> > > anything other than random numbers, because that might lead to
> > > predictability.
> 
> Thanks for explaining!
> 
> So in other words, in general nonce shouldn't be a secret due to it's
> unpredictability, thus using /sysfs to expose attestation report
> should be OK?

There's no reason I can think of it should be secret (well, except
security through obscurity in case someone is monitoring for a replay).

> > I suppose there is a situation where you use the nonce to bind
> > other details of the attesting party.  For instance, in
> > confidential computing, the parties often exchange secrets after
> > successful attestation.  To do this, the attesting party generates
> > an ephemeral public key.  It then communicates the key binding by
> > constructing a new nonce as
> > 
> > <new nonce> = hash( <relying party nonce> || <public key> )
> > 
> > and using that new nonce in the attestation report signature.
> 
> This looks like taking advantage of the attestation flow to carry
> additional info that can be communicated _after_ attestation is done.

Well, no, the <new nonce> must be part of the attestation report.

>   Not sure the benefit?  For instance, shouldn't we normally use
> symmetric key for exchanging secrets after attestation?

Yes, but how do you get the symmetric key?  A pre-chosen symmetric key
would have to be in the enclave as an existing secret, which can't be
done if you have to provision secrets.  The way around this is to use a
key agreement to generate a symmetric key on the fly.  The problem,
when you are doing things like Diffie Hellman Ephemeral (DHE) to give
you this transport encryption key is that of endpoint verification. 
You can provision a public certificate in the enclave to verify the
remote (so a malicious remote can't inject false secrets), but the
remote needs some assurance that it has established communication with
the correct local (otherwise it would give up its secrets to anyone). 
A binding of the local public DHE key to the attestation report can do
this. 

> > So the relying party can also reconstruct the new nonce (if it
> > knows the key) and verify that it has a current attestation report
> > *and* that the attesting party wants secrets encrypted to <public
> > key>.  This scheme does rely on the fact that the thing generating
> > the attestation signature must only send reports to the owner of
> > the enclave, so that untrusted third parties, like the host owner,
> > can't generate a report with their own nonce and thus fake out the
> > key exchange.
> 
> Sorry I am not sure I am following this.

If you use an attestation report for binding, you have to be sure no
third party could generate the report and give a false binding.

For instance, this isn't true of a TPM2_Quote because anyone who can
get into the tss group can generate one.

James


>   For TDX only the confidential VM can put the nonce to the report
> (because the specific instruction to get the local-verifiable report
> out from firmware can only be made from the confidential VM).
> Not sure other vendors' implementations though.
> 

