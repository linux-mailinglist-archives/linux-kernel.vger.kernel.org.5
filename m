Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE4E76B452
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbjHAMEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbjHAMEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:04:02 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5751BC1;
        Tue,  1 Aug 2023 05:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1690891434;
        bh=A5Xp0ljkKmdYL3sgYa355A3A62vFCtOc0x8cdx5MtMk=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=KUnqGwrLqqEu+ttUE3pLXZ8wjg3yjQv1a2U1Mo/bwAy8cW1La6gdGKM128/BGdjEt
         dKougbdACNTLJ0kb4pEbYGavpC8IffNivtMyvQArxguPaxAf/VIRB1PvNMJ1ahJjqT
         egOIArUpFMKkCg1q0Pxo9/74jEk9JbzHD9wJ6Cpc=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3A9CE12868C0;
        Tue,  1 Aug 2023 08:03:54 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id SjriggjNz9md; Tue,  1 Aug 2023 08:03:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1690891432;
        bh=A5Xp0ljkKmdYL3sgYa355A3A62vFCtOc0x8cdx5MtMk=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=sYD53L6PgfttXBZ6u2JW31Qs7KWZxIE5fvDAOk+EEZYLU6mg7iS1X40pC/gNQ/oAE
         BlBq+6vJNEmU8Fq0S1ns24PF5pdexpd8CE0ddi8prRcTx8FxPwQ08bJOeg+nMSZue4
         RklReOKKhtg3RAtrK/zB9LHCKFKrpVI171Y8SpsM=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 89C6E1280ECC;
        Tue,  1 Aug 2023 08:03:49 -0400 (EDT)
Message-ID: <55cec220f20c497925f46074fc70eeccccff61c9.camel@HansenPartnership.com>
Subject: Re: [PATCH 0/4] keys: Introduce a keys frontend for attestation
 reports
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Huang, Kai" <kai.huang@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>
Cc:     "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "dionnaglaze@google.com" <dionnaglaze@google.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "x86@kernel.org" <x86@kernel.org>
Date:   Tue, 01 Aug 2023 08:03:47 -0400
In-Reply-To: <6dec442c64faf2fecd21bcc77e4a6350e88948b9.camel@intel.com>
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
         <a507ef3302d3afff58d82528ee17e82df1f21de0.camel@HansenPartnership.com>
         <64c5ed6eb4ca1_a88b2942a@dwillia2-xfh.jf.intel.com.notmuch>
         <c6576d1682b576ba47556478a98f397ed518a177.camel@HansenPartnership.com>
         <6dec442c64faf2fecd21bcc77e4a6350e88948b9.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-08-01 at 11:45 +0000, Huang, Kai wrote:
[...]
> 
> Sorry perhaps a dumb question to ask:
> 
> As it has been adequately put, the remote verifiable report normally
> contains a nonce.  For instance, it can be a per-session or per-
> request nonce from the remote verification service to the
> confidential VM.  
> 
> IIUC, exposing attestation report via /sysfs means many processes (in
> the confidential VM) can potentially see the report and the nonce. 
> My question is whether such nonce should be considered as a secret
> thus should be only visible to the process which is responsible for
> talking to the remote verification service?  Using IOCTL seems can
> avoid such exposure.

OK, so the nonce seems to be a considerably misunderstood piece of this
(and not just by you), so I'll try to go over carefully what it is and
why.  The problem we have in pretty much any signature based
attestation evidence scheme is when I, the attesting party, present the
signed evidence to you, the relying part, how do you know I got it
today from the system in question not five days ago when I happen to
have engineered the correct conditions?  The solution to this currency
problem is to incorporate a challenge supplied by the relying party
(called a nonce) into the signature.  The nonce must be unpredictable
enough that the attesting party can't guess it beforehand and it must
be unique so that the attesting party can't go through its records and
find an attestation signature with the same nonce and supply that
instead.

This property of unpredictability and uniqueness is usually satisfied
simply by sending a random number.  However, as you can also see, since
the nonce is supplied by the relying party to the attesting party, it
eventually gets known to both, so can't be a secret to one or the
other.  Because of the unpredictability requirement, it's generally
frowned on to have nonces based on anything other than random numbers,
because that might lead to predictability.

James

