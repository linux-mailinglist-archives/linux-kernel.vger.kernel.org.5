Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDE277DD8E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243467AbjHPJng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243389AbjHPJnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:43:03 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9555E74
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:43:01 -0700 (PDT)
Received: from [192.168.2.41] (77-166-152-30.fixed.kpn.net [77.166.152.30])
        by linux.microsoft.com (Postfix) with ESMTPSA id BAC74211F608;
        Wed, 16 Aug 2023 02:42:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BAC74211F608
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692178981;
        bh=Gwx6Xom00MkPioxw+Pi/in06ebPb82sxsdQ1BTchRPQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LnQngDegS3VFFejo2RsFDVkREjej8N7XKG+/xZdAWcLdBjmIOPnd6PXWAU89MXP6+
         8QAitHkCpGhwzq6fkogXgjpcZwz6ufMOCiLyoYouCQWOprRH9l4u5If53OMyahYIep
         NyRy1GklnieroaKo5MSTiPxqJvJMBLZ7k30wDwdQ=
Message-ID: <85f4f047-43a4-4a66-8913-f1a55f8cf0fa@linux.microsoft.com>
Date:   Wed, 16 Aug 2023 11:42:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] tsm: Attestation Report ABI
To:     Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Peter Gonda <pgonda@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
 <57f3a05e-8fcd-4656-beea-56bb8365ae64@linux.microsoft.com>
 <64da606b171cc_2138e29484@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <64da606b171cc_2138e29484@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/2023 7:12 PM, Dan Williams wrote:
> Jeremi Piotrowski wrote:
>> On 8/14/2023 9:43 AM, Dan Williams wrote:
>>> Changes since v1:
>>> - Switch from Keyring to sysfs (James)
>>>
>>> An attestation report is signed evidence of how a Trusted Virtual
>>> Machine (TVM) was launched and its current state. A verifying party uses
>>> the report to make judgements of the confidentiality and integrity of
>>> that execution environment. Upon successful attestation the verifying
>>> party may, for example, proceed to deploy secrets to the TVM to carry
>>> out a workload. Multiple confidential computing platforms share this
>>> similar flow.
>>>
>>> The approach of adding adding new char devs and new ioctls, for what
>>> amounts to the same logical functionality with minor formatting
>>> differences across vendors [1], is untenable. Common concepts and the
>>> community benefit from common infrastructure.
>>>
>>> Use sysfs for this facility for maintainability compared to ioctl(). The
>>> expectation is that this interface is a boot time, configure once, get
>>> report, and done flow. I.e. not something that receives ongoing
>>> transactions at runtime. However, runtime retrieval is not precluded and
>>> a mechanism to detect potential configuration conflicts from
>>> multiple-threads using this interface is included.
>>>
>>
>> I wanted to speak up to say that this does not align with the needs we have
>> in the Confidential Containers project. We want to be able to perform attestation
>> not just once during boot but during the lifecycle of the confidential VM. We
>> may need to fetch a fresh attestation report from a trusted agent but also from
>> arbitrary applications running in containers.
>>
>> The trusted agent might need attestation when launching a new container from an
>> encrypted container image or when a new secret is being added to the VM - both
>> of these events may happen at any time (also when containerized applications
>> are already executing).
>>
>> Container applications have their own uses for attestation, such as when they need
>> to fetch keys required to decrypt payloads. We also have things like performing
>> attestation when establishing a TLS or ssh connection to provide an attested e2e
>> encrypted communication channel.
> 
> ...and you expect that the boot time attestation becomes invalidated
> later at run time such that ongoing round trips to the TSM are needed?

It's not that it would become invalidated - it's that it will have served its purpose.
Attestation is used to establish trust with a relying party, for every other relying
party you'll need to generate a fresh attestation report. So we can't lock ourselves
into a specific protocol in the kernel here that only assumes a single party.

The one shot "decrypt disk image during boot" attestation use case is relevant elsewhere,
but not so much for containers.

> I am looking at "Table 21. ATTESTATION_REPORT Structure" for example and
> not seeing data there that changes from one request to the next.

REPORT_DATA in SNP or REPORTDATA in TDX. You want to have a nonce/challenge or short
lived session keys covered by the report, so you hash some data structure that includes
them and request an attestation report with the hash in "report data".

Here's an example of the verifying side:
https://github.com/confidential-containers/attestation-service/blob/main/attestation-service/src/verifier/tdx/mod.rs#L40-L52


> Runtime validation likely looks more like the vTPM use case with PCRs. That will
> leverage the existing / common TPM ABI.> 

Not at all, these two things are orthogonal. PCRs can be extended at runtime but you'll
struggle to use them as described above. You'd have to designate a PCR for this purpose,
lock against concurrent users (across multiple TPM commands) and reset it before every
use. Highly impractical.

TPM2 has a similar concept to "REPORTDATA" called "qualifying data" which is passed
when requesting a quote. This highlights the need for an interface to regenerate evidence
(attestation report or quote) with user defined data mixed in.

>> I don't think sysfs is suitable for such concurrent transactions. Also if you think
>> about exposing the sysfs interface to an application in a container, this requires
>> bind mounting rw part of the sysfs tree into the mount namespace - not ideal.
> 
> sysfs is not suitable for concurrent transactions. The container would
> need to have an alternate path to request that the singleton owner of
> the interface generate new reports, or use the boot time attestation to
> derive per container communication sessions to the attestation agent.

It would be possible to use a userspace agent to coordinate access to generating reports,
but that takes us further away from standardization - applications would have to be
tailored to a specific environment instead of relying on the same kernel (hardware)
interface everywhere.

I don't follow this part:
"use the boot time attestation to derive per container communication sessions to the attestation agent".
In general we want the application attestation report to be linked directly to a hardware
root of trust, without chaining through some intermediate entity.
