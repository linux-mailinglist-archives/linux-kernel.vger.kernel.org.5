Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A6B774A5F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjHHU0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbjHHU0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:26:07 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD1386279;
        Tue,  8 Aug 2023 12:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1691523476;
        bh=iWclFeWz6A/OZCUv6T7u98I9B1XbWJNfa3WMgB4bmP8=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=SXPWdVIe45JNSw71kqC/YZLMVTuHJjsPw+oKv/wEA0hU7MXzoEy2Q4zyDV/6G1GJd
         6/fGwEmXHXJQ223OJLqmn9N7qC/ZQEZaN/MFHYjTNxuzjveCCeo6aZz84iLE+H3oP4
         IaEn50JFxj3NTRZWS8wRDy5EojKopwgy9dyG+UG0=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 995E212868AE;
        Tue,  8 Aug 2023 15:37:56 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 6GipOO7im5oG; Tue,  8 Aug 2023 15:37:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1691523476;
        bh=iWclFeWz6A/OZCUv6T7u98I9B1XbWJNfa3WMgB4bmP8=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=SXPWdVIe45JNSw71kqC/YZLMVTuHJjsPw+oKv/wEA0hU7MXzoEy2Q4zyDV/6G1GJd
         6/fGwEmXHXJQ223OJLqmn9N7qC/ZQEZaN/MFHYjTNxuzjveCCeo6aZz84iLE+H3oP4
         IaEn50JFxj3NTRZWS8wRDy5EojKopwgy9dyG+UG0=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 30A121286887;
        Tue,  8 Aug 2023 15:37:55 -0400 (EDT)
Message-ID: <9c9c62f9243595a1faa3b0745fa8a1f8f018d9b8.camel@HansenPartnership.com>
Subject: Re: [PATCH 0/4] keys: Introduce a keys frontend for attestation
 reports
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Dionna Amalie Glaze <dionnaglaze@google.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Sathyanarayanan Kuppuswamy 
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
Date:   Tue, 08 Aug 2023 15:37:53 -0400
In-Reply-To: <CAAH4kHYJrKPgWXn7+G_sZXoAs8fq2sDEyT-tyECPthdaaoXyDw@mail.gmail.com>
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
         <f95d75c513c081d5bb8b5d1fd3b0a5d5e24ab467.camel@HansenPartnership.com>
         <CAAH4kHYJrKPgWXn7+G_sZXoAs8fq2sDEyT-tyECPthdaaoXyDw@mail.gmail.com>
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

On Tue, 2023-08-08 at 11:48 -0700, Dionna Amalie Glaze wrote:
> > Isn't this more runtime attestation?  In which case you wouldn't
> > use the boot report.  I assume someone somewhere is hacking the
> > TPM-TLS protocol to also do RTMRs, but it strikes me we could just
> > use a vTPM and the existing protocols.
> > 
> > Even if you don't do anything as complex as TPM-TLS (and continuing
> > runtime attestation), you can still make TLS conditioned on a
> > private key released after a successful boot time attestation. 
> > Since the boot evidence never changes, there's not much point doing
> > it on each connection, so relying on a private key conditioned on
> > boot evidence is just as good.
> > 
> > James
> > 
> 
> The TPM quote will need to be bound to the VM instance, so there will
> still be a hardware attestation in there that incorporates the user's
> challenge.

Well, it's all in the protocol: A TLS-TPM system using a physical TPM
has to do an EK/AK makecredential/activatecredential to verify it's
talking to a real TPM.  In the CC vTPM case that step is substituted by
doing a vTPM attestation.  However, the point is in each case the
verification step is only done once before you trust the TPM.  After
that, it's the TPM key you trust because the proof, in either case, was
that the key is TPM generated and the TPM should be tamper proof
(enforced by the casing for a physical TPM and the situation in the
VMPL or other software protection for the vTPM).

> Anything less than that is subject to replay attacks, no? Am I
> missing a clever trick?

Trusting the vTPM is a one time thing.  Once trust in the TPM is
established, you don't need to be worried about replay and you can just
use standard TPM primitives for everything onward, even when doing
point in time runtime attestation.

James

