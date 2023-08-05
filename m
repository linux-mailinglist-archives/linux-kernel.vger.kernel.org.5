Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91235770F68
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 13:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjHELFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 07:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjHELFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 07:05:32 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC42A4215;
        Sat,  5 Aug 2023 04:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1691233529;
        bh=Kp0V8XoBe7ftnnqF+Zb6Xx7gGt4oeSLO48BmsQvQNRs=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=dattdD7Q5Ya4ttLlIDRS/BH6AZTqW2rycXm2dneWDDiaOu5g3QRxb4S7iaAvJwjuR
         kNZ7BGvX1b+bsz1sit2Bp/THSHZPNVb0g+/j3tW31IHbCoIwYk7V0zdUEzh5GcI+tV
         PzbvV7HFjW1+ANgwQWrftApsoIDUPPhrFupl9Rf0=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6BFD11286B03;
        Sat,  5 Aug 2023 07:05:29 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id HtRUkobKztqP; Sat,  5 Aug 2023 07:05:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1691233529;
        bh=Kp0V8XoBe7ftnnqF+Zb6Xx7gGt4oeSLO48BmsQvQNRs=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=dattdD7Q5Ya4ttLlIDRS/BH6AZTqW2rycXm2dneWDDiaOu5g3QRxb4S7iaAvJwjuR
         kNZ7BGvX1b+bsz1sit2Bp/THSHZPNVb0g+/j3tW31IHbCoIwYk7V0zdUEzh5GcI+tV
         PzbvV7HFjW1+ANgwQWrftApsoIDUPPhrFupl9Rf0=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D1D221286B02;
        Sat,  5 Aug 2023 07:05:27 -0400 (EDT)
Message-ID: <a8e491304c28f74d9c8a61de4790e0584c40a19e.camel@HansenPartnership.com>
Subject: Re: [PATCH 0/4] keys: Introduce a keys frontend for attestation
 reports
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>,
        "Huang, Kai" <kai.huang@intel.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "sameo@rivosinc.com" <sameo@rivosinc.com>,
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
Date:   Sat, 05 Aug 2023 07:05:25 -0400
In-Reply-To: <ZM0lEvYJ+5IgybLT@redhat.com>
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
         <a507ef3302d3afff58d82528ee17e82df1f21de0.camel@HansenPartnership.com>
         <64c5ed6eb4ca1_a88b2942a@dwillia2-xfh.jf.intel.com.notmuch>
         <c6576d1682b576ba47556478a98f397ed518a177.camel@HansenPartnership.com>
         <6dec442c64faf2fecd21bcc77e4a6350e88948b9.camel@intel.com>
         <ZM0lEvYJ+5IgybLT@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-08-04 at 17:19 +0100, Daniel P. Berrangé wrote:
> On Tue, Aug 01, 2023 at 11:45:12AM +0000, Huang, Kai wrote:
> > The IOCTL vs /sysfs isn't discussed.
> > 
> > For instance, after rough thinking, why is the IOCTL better than
> > below approach
> > using /sysfs?
> > 
> > echo <REPORTDATA> > /sys/kernel/coco/tdx/attest/reportdata
> > cat /sys/kernel/coco/tdx/attest/tdreport
> > 
> > Each "echo <REPORTDATA>" to '/sys/.../reportdata' triggers the
> > driver to call
> > TDCALL to get the TDREPORT, which is available at
> > '/sys/.../tdreport'.
> 
> What would you suggest as behaviour with multiple processes writing
> into 'reportdata' and trying to read from 'tdreport' in parallel ?
> Splitting input and output across separate files removes any
> transactional relationship between input and output. This approach
> feels like it could easily result in buggy behaviour from concurrent
> application usage, which would not be an issue with ioctl()

What's the use case where there are multiple outstanding reports?  The
only use case I've currently seen is single external relying party
requesting a report with a challenge.

> Also note, there needs to be scope for more than 1 input and 1 output
> data items. For SNP guests, the VMPL is a input, and if fetching a
> VMPL 0 report from under SVSM [1], an optional service GUID is
> needed. With SVSM, there are three distinct output data blobs -
> attestation report, services manifest and certificate data.

That's quite simple isn't it?  All the possible additional input
parameters appear as files.  If you don't echo anything into them, they
take the default values.  There's usually a single parameter that
causes the transaction to start (usually the nonce) and the transaction
takes the current values from all the files.

I'm not saying sysfs can substitute for all the transactionality of
ioctl, but in this case where everything is low volume and single
threaded it seems a reasonable choice.  For a more volume based
transactional approach, something more configfs like would work better,
so is there a use case for that?

James

