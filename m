Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0770F751C63
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbjGMI6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbjGMI6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:58:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF58A1BB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689238671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Iq7byOxfXSyIllECTYEkmvsKvihAmNm3d0BH2Ps7Itk=;
        b=XcGfXXXILrivUVIcXnVyynQ3DcT+yOUac2YazXd2dVWvxbtjDMucBTUuULgggapAMDFY2U
        14Z21QL9C33kF50Yi1p8u256k70nGU/fXhCVvBgZSStXaYuAEsUK2ybKTZujUuwrrxGjy4
        J42EYpJXawDlCkRcETrCSDX3kcGAjlk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-QZR5DsBJMgu6VpDFuvsw3g-1; Thu, 13 Jul 2023 04:57:50 -0400
X-MC-Unique: QZR5DsBJMgu6VpDFuvsw3g-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-765de3a3404so67970885a.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689238670; x=1691830670;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iq7byOxfXSyIllECTYEkmvsKvihAmNm3d0BH2Ps7Itk=;
        b=F8DCMn5pBKtQXTj9bGoNpFYJD/k+hOGehx976/aEkHdqhqonWoj0cG0FxJ3oH+e1Gj
         egpoCfPHzJjxqp3/BwGYANJMcu8Oot5NGtMGVxDGPVqqnimwRr/1bR4AeBAWDTx1MIXY
         rNmY6YDrSUss3lJ7rLK1V4Vt01pHrBPFvC0lwEhi5OShp0Y4DKyS8FO7+tHDmIa4c0T0
         ob+dhY+UpwGrrO5Vy/kCi2DErFIsS+NJmKgtAPXHaCbxwfW69c1WG75X0zIgA/0f4ZDD
         RkfU+RScyGephUK+sIk6NuUNWvho66sj1AUrnkNgW5MkhoTVEf2ib2cHNHgY0Jh5TCxx
         32GQ==
X-Gm-Message-State: ABy/qLY6wrfUGn5OpgjSkRERLze6yNv0amOZV50ow/5bAqrJPSMuUa80
        QMRM7jZDdOdlY+wYqPxAD6+eLh4TZw/BPOukRAVL4lwclq4+v4vN7LDGS4ZqfeBMx8NvbeKTTdG
        eBiPWRznIXCBhKuJjTTfRZSWNlVXIzIbw497tFQgRVFRacBlYHRaMEKQ8khkJQgE8V0XWqLSh0T
        918vZzEukg
X-Received: by 2002:a05:620a:2889:b0:767:2736:ecd4 with SMTP id j9-20020a05620a288900b007672736ecd4mr1100958qkp.47.1689238670203;
        Thu, 13 Jul 2023 01:57:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGTIhl1XOzQIpU9ZIR+n3ZtYAIDtu+AVSPb6CVTB33ungMPNy5SBG0Ggzb2YmnKmASb1agmbg==
X-Received: by 2002:a05:620a:2889:b0:767:2736:ecd4 with SMTP id j9-20020a05620a288900b007672736ecd4mr1100932qkp.47.1689238669857;
        Thu, 13 Jul 2023 01:57:49 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id pa36-20020a05620a832400b007676658e369sm2749135qkn.26.2023.07.13.01.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 01:57:49 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        bluca@debian.org, lennart@poettering.net,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
In-Reply-To: <2023071237-private-overhang-7f86@gregkh>
References: <20230711154449.1378385-1-eesposit@redhat.com>
 <2023071237-private-overhang-7f86@gregkh>
Date:   Thu, 13 Jul 2023 10:57:45 +0200
Message-ID: <875y6o429i.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> writes:

> On Tue, Jul 11, 2023 at 11:44:49AM -0400, Emanuele Giuseppe Esposito wrote:
>> *Important*: this is just an RFC, as I am not expert in this area and
>> I don't know what's the best way to achieve this.
>> 
>> v2:
>> * add standard "sbat,1,SBAT Version,..." header string
>> 
>> The aim of this patch is to add a .sbat section to the linux binary
>> (https://github.com/rhboot/shim/blob/main/SBAT.md).
>> We mainly need SBAT in UKIs (Unified Kernel Images), as we might want
>> to revoke authorizations to specific signed PEs that were initially
>> considered as trusted. The reason might be for example a security issue
>> related to a specific linux release.
>> 
>> A .sbat is simply a section containing a string with the component name
>> and a version number. This version number is compared with the value in
>> OVMF_VARS, and if it's less than the variable, the binary is not trusted,
>> even if it is correctly signed.
>> 
>> Right now an UKI is built with a .sbat section containing the
>> systemd-stub sbat string (upstream + vendor), we would like to add
>> also a per-component specific string (ie vmlinux has its own sbat,
>> again upstream + vendor, each signed add-on its own and so on).
>> In this way, if a specific kernel version has an issue, we can revoke
>> it without compromising all other UKIs that are using a different
>> kernel with the same stub/initrd/something else.
>> 
>> Issues with this patch:
>> * the string is added in a file but it is never deleted
>> * if the code is not modified but make is issued again, objcopy will
>>   be called again and will fail because .sbat exists already, making
>>   compilation fail
>> * minor display issue: objcopy command is printed in the make logs
>> 
>> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
>> ---
>>  arch/x86/boot/Makefile | 3 +++
>>  1 file changed, 3 insertions(+)
>> 
>> diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
>> index 9e38ffaadb5d..6982a50ba0c0 100644
>> --- a/arch/x86/boot/Makefile
>> +++ b/arch/x86/boot/Makefile
>> @@ -83,6 +83,9 @@ cmd_image = $(obj)/tools/build $(obj)/setup.bin $(obj)/vmlinux.bin \
>>  
>>  $(obj)/bzImage: $(obj)/setup.bin $(obj)/vmlinux.bin $(obj)/tools/build FORCE
>>  	$(call if_changed,image)
>> +	@$(kecho) "sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md" > linux.sbat
>> +	@$(kecho) "linux,1,The Linux Developers,linux,$(KERNELVERSION),https://linux.org" >> linux.sbat;
>
> Who controls "linux.org"?  Why are you thinking they have anything to do
> with kernel development?
>
> This shows a huge lack of understanding of loads of things, please go
> get other experienced Red Hat developers to sign off on the next version
> of your patch before you ask the community to review it.

FWIW,

this was an RFC to answer a fairly straitforward question: is upstream
Linux interested in / is a suitable place for having SBAT revocation
mechanism or not. We can, of course, iron out the details whether it
should be "linux.org"/"linux.com"/"lore.kernel.org/lkml/" or
"linux.onion" and where to put objcopy call, whether to silence its
output or not but these are rather implemntation details. I don't
particularly see why anyone would need to get additional sign-offs to
just ask a question (which I don actually think was asked before!) and
IMO an RFC/patch is usually the best way to do so.

Following the discussion, it seems that at least x86 maintainer[s] are
opposed to the very idea of having SBAT revocation mechanism integrated
upstream because it's hard to meaningfully define what epoch is. This is
OK (which doesn't mean we all agree to that) but as there's real need to
revoke "bad" (in UEFI SecureBoot sense) kernels, distros will likely
come up with their custom, downstream only ways to do it. Without an
upstream reference, however, they may come up with very differently
looking SBAT sections, this may or may not be problematic in the future,
who knows.

-- 
Vitaly

