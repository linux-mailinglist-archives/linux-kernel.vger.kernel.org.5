Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC5F7EDB51
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 06:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjKPFvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 00:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjKPFve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 00:51:34 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398BD18B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 21:51:31 -0800 (PST)
Received: from [IPv6:::1] ([172.58.204.72])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 3AG5owIE3896720
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 15 Nov 2023 21:51:00 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 3AG5owIE3896720
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023111101; t=1700113861;
        bh=Zo6SeTAF1Hkz5Nt+v04S4U19Noi+Vl6KiRux2UuD7MU=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=nrw9EdqTVcJW0ErdRH3ZGisI0o7N2tUIqJAJoicndB1w+lzptswHGtxcnULSaAcFn
         SkU+AddcOHpINBiOYuBp76DSYAOq9mmLq96iWbZrY8mGIclJMZZy0q8yx9Aly669tv
         Nm0SDI5G8P6/BHh0s7ysIFH7QgwhjKnwCyxRJiSVHhi3j+6G0jJxFG6HNEvoAFkIVt
         2ACfypAznF+nOZRAKb4C03mXk8o++8/snfH9rXx2QabLgIbrHgv0/Zjcfoh7JBq61s
         DwXr7NRNGWJZEmTA5yb6tcpjLaqURqTli5hNTuoNxf2dv8jCPGRgtzvE2fPSdJ7p5r
         EDY/FqZkFuu3g==
Date:   Thu, 16 Nov 2023 00:50:46 -0500
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Michael Roth <michael.roth@amd.com>,
        Dave Hansen <dave.hansen@intel.com>
CC:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_x86=3A_Ensure_input_to_pfn?= =?US-ASCII?Q?=5Fto=5Fkaddr=28=29_is_treated_as_a_64-bit_type?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20231115224231.xmxfktqcb4sls3fb@amd.com>
References: <20231115201431.820278-1-michael.roth@amd.com> <e42524f9-87ef-47f4-9c79-bc06b4d71a58@intel.com> <20231115224231.xmxfktqcb4sls3fb@amd.com>
Message-ID: <CF5E01C9-3EC6-422C-BAD2-B8732E6FCE77@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On November 15, 2023 5:42:31 PM EST, Michael Roth <michael=2Eroth@amd=2Ecom=
> wrote:
>On Wed, Nov 15, 2023 at 12:48:58PM -0800, Dave Hansen wrote:
>> On 11/15/23 12:14, Michael Roth wrote:
>> > While it might be argued that the issue is on the caller side, other
>> > archs/macros have taken similar approaches to deal with instances lik=
e
>> > this, such as commit e48866647b48 ("ARM: 8396/1: use phys_addr_t in
>> > pfn_to_kaddr()")=2E
>>=20
>> Gah, I really hope nobody is arguing that for real, or is even thinking
>> about this as a valid argument=2E
>
>Not that I'm aware, but I did have my own doubts initially, which is
>why I thought it warranted a note in the commit just in case it came up
>from someone else=2E
>
>>=20
>> The helper should, well, help the caller=2E  It makes zero sense to me
>> that every single call site would need to know if the argument's type
>> was big enough to hold the _return_ value=2E  This nonsense can only ev=
en
>> happen with macros=2E  Type promotion would just do the right thing for
>> any sanely declared actual helper function=2E
>
>My thought was that it is easier to expect developers to know the pitfall=
s
>of bit-field types, since it is universally applicable to all C code,
>whereas expecting developers to anticipate such issues when writing simil=
ar
>macros is potentially harder to enforce/audit and could lead to similar
>issues popping up as things are refactored over time and new macros get
>added that don't take such usages into account=2E
>
>But neither argument seems to hold up in reality=2E Experienced developer=
s
>obviously do fall victim to the subtleties of of bit-field types, and
>kernel devs obviously do tend to address these instances in more robust
>ways based on the various pfn-related macros I looked through=2E
>
>-Mike

Now, if you are doing a cast, you are making the macro unusable for assemb=
ly anyway; any reason not to make it an inline function at that point?
