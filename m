Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33212788D9F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 19:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243155AbjHYRJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 13:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243439AbjHYRJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 13:09:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248412108
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 10:09:43 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692983381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B3H5zuheq25pTXFcAoUiAM/AmAZ+5MjnbuSdvUn6CEk=;
        b=gva8oHAR5XDnqLAMsSkevg+0Gyr4qZzuCDDO664cGTNNFtqyF9n3AO4E8/VFKE45wfAzKE
        7rf3W1et014kGBYWyY7r2cKdKFKqOLp45+327glx63CGFC04OJVNhlIX5KJ4y795VlYaix
        zdx4PP0eXdNx2G5IsCdZGHyzIcbU7SxY7INahYUuvk2ThQIM5cdtcwV+HFYhDdV3v2gl0k
        nYM5WXvdTLn7gWygvGgR2FJjbho3D0+MstoexJuyD4d1nFXNiEduDewe4BsqBQjY1TUQFd
        xXntdy99QzTMleGD7lXUYk+jXvpZaVOVptjoAZnBeoG3u/464H/+6CC0RAgbIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692983381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B3H5zuheq25pTXFcAoUiAM/AmAZ+5MjnbuSdvUn6CEk=;
        b=z87NC/P17Yb270AfmmP5qOcEim6oteTECA0e6ZfijcLD5RFnQWz5yqLTO4qzXjqHVNa/BS
        QDFCJPqlfBip4VCA==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/tdx: Mark TSC reliable
In-Reply-To: <20230825135226.ikxvskplvppghwtz@box.shutemov.name>
References: <20230808162320.27297-1-kirill.shutemov@linux.intel.com>
 <ecc11d54-6aaa-f755-9436-ae15b94fb627@intel.com>
 <20230808200111.nz74tmschph435ri@box> <87bkewcufi.ffs@tglx>
 <20230825135226.ikxvskplvppghwtz@box.shutemov.name>
Date:   Fri, 25 Aug 2023 19:09:41 +0200
Message-ID: <87pm3baw16.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25 2023 at 16:52, Kirill A. Shutemov wrote:
> On Thu, Aug 24, 2023 at 05:49:05PM +0200, Thomas Gleixner wrote:
>> On Tue, Aug 08 2023 at 23:01, Kirill A. Shutemov wrote:
>> > On Tue, Aug 08, 2023 at 10:13:05AM -0700, Dave Hansen wrote:
>> >> I take it this is carved in stone in the TDX specs somewhere.  A
>> >> reference would be nice.
>> >
>> > TDX Module 1.0 spec:
>> >
>> > 	5.3.5. Time Stamp Counter (TSC)
>> >
>> > 	TDX provides a trusted virtual TSC to the guest TDs. TSC value is
>> > 	monotonously incrementing, starting from 0 on TD initialization by the
>> > 	host VMM. The deviation between virtual TSC values read by each VCPU =
is
>> > 	small.
>>=20
>> Nice weasel wording. What's the definition of "small"?
>
> The newer spec says "Virtual TSC values are consistent among all the TD=
=E2=80=99s
> VCPUs at the level supported by the CPU".

That means what? It's not a guarantee for consistency either. :(
