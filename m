Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E347749B5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjHHUBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbjHHUAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:00:52 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809AF1E4EE;
        Tue,  8 Aug 2023 11:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1691518568;
        bh=omhrzCL2M1egS/LGQ2Ddjwn7iTzvxQN3JaA541Bt+h4=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=DtFDUjdg7qy0+JERnJJCZ7OMhocCBZSbmvSYK8fPvu/quZd1hwa+MOygYsgp9DQgl
         NG7FgEBf60FWcYn2c7ticQ/9pF09m0jgTy6oKflqhUn2AaMHFX4sIxgljb8a4Z9IzR
         UMpVGBDOAhHwW8b7xQwu772yH6yNG9Z+7KlGe+CY=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 065421281B19;
        Tue,  8 Aug 2023 14:16:08 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id gGeJ4qvip3P7; Tue,  8 Aug 2023 14:16:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1691518567;
        bh=omhrzCL2M1egS/LGQ2Ddjwn7iTzvxQN3JaA541Bt+h4=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=f0ccHe6cJqUxsmc3E8FIHyLOcxTMP0Ayr1dyYPZ2ABbzsvJPMPxnbZLF0+psOCSS9
         7Xlh5908qpFFLG7filZQ6KbwjuryxtSAuRYx9LVbJWak1Hbe3J812m9CHrz0D15FtK
         Pj/Rtek2qdqrG+34aS34wEiXRYY3dJhLex5QJwbY=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 8A72D12819D2;
        Tue,  8 Aug 2023 14:16:06 -0400 (EDT)
Message-ID: <f95d75c513c081d5bb8b5d1fd3b0a5d5e24ab467.camel@HansenPartnership.com>
Subject: Re: [PATCH 0/4] keys: Introduce a keys frontend for attestation
 reports
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>, dhowells@redhat.com,
        Brijesh Singh <brijesh.singh@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-coco@lists.linux.dev, keyrings@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 08 Aug 2023 14:16:04 -0400
In-Reply-To: <CAAH4kHamob7g_+BRd0JW76cM7_vS=jzXzRjrgCPDxZ29VnzdCQ@mail.gmail.com>
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
         <a507ef3302d3afff58d82528ee17e82df1f21de0.camel@HansenPartnership.com>
         <64c5ed6eb4ca1_a88b2942a@dwillia2-xfh.jf.intel.com.notmuch>
         <c6576d1682b576ba47556478a98f397ed518a177.camel@HansenPartnership.com>
         <64cdb5f25c56_2138e294f1@dwillia2-xfh.jf.intel.com.notmuch>
         <1180481830431165d49c5e64b92b81c396ebc9b1.camel@HansenPartnership.com>
         <64d17f5728fbc_5ea6e2943f@dwillia2-xfh.jf.intel.com.notmuch>
         <c7d6e953a4b36014ea0c7406531b24bb29d6127e.camel@HansenPartnership.com>
         <2425e00b-defb-c12b-03e5-c3d23b30be01@linux.intel.com>
         <64d263e44e401_2138e29486@dwillia2-xfh.jf.intel.com.notmuch>
         <CAAH4kHamob7g_+BRd0JW76cM7_vS=jzXzRjrgCPDxZ29VnzdCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-08-08 at 09:07 -0700, Dionna Amalie Glaze wrote:
> > 
> > At least that was not the level of concurrency I was worried about.
> > The sysfs approach makes it so that concurrency problem of
> > option-writing vs report-reading is pushed to userspace.
> > 
> 
> The reason I would advocate against making attestation report
> collection single-threaded in user space at a machine level is that
> there are new schemes of attested connections that may become the
> basis of server handshakes. I think folks are mainly looking at this
> from the use case of
> 
> 1. workload will do large amounts of work on behalf of the VM owner,
> provided it gets a sealing key released by the VM owner once on boot
> after proving its code identity

Right, that's the case for boot time attestation.

> however I'm thinking of the case of a more user-centric use case that
> enables service users to challenge for proof of workload identity
> 
> 2. workload is a server that accepts incoming connections that
> include a hardware attestation challenge. It generates an attestation
> report that includes the challenge as part of the connection
> handshake

Isn't this more runtime attestation?  In which case you wouldn't use
the boot report.  I assume someone somewhere is hacking the TPM-TLS
protocol to also do RTMRs, but it strikes me we could just use a vTPM
and the existing protocols.

Even if you don't do anything as complex as TPM-TLS (and continuing
runtime attestation), you can still make TLS conditioned on a private
key released after a successful boot time attestation.  Since the boot
evidence never changes, there's not much point doing it on each
connection, so relying on a private key conditioned on boot evidence is
just as good.

James

