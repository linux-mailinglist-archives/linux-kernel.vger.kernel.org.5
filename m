Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2998752E8E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 03:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjGNBbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 21:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbjGNBa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 21:30:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82552D61
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 18:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689298207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hg3g8npLeTm73F7FXPVIMRbHW6X0157DFp2TVsm0Cjc=;
        b=Pmg6iq2345a8lB7iqYYWnGKd+Rcr+eki+wJflIpnwWcAU4YKB+mn+Ecs/UuIKH/ZiXwX1J
        /nUHy39YiaeBA7sX0xGp+GAEAlg/ew4rDFwVmTHAn+14cEl29AO2j8fBcj0gR7aHd89vnF
        m/1moDAMjuDoOKrPCfQ4qzQvBW6L17M=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-nLkAvV_rOpiiN3XCq-jUug-1; Thu, 13 Jul 2023 21:30:06 -0400
X-MC-Unique: nLkAvV_rOpiiN3XCq-jUug-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-55c964d031aso673234a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 18:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689298205; x=1691890205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hg3g8npLeTm73F7FXPVIMRbHW6X0157DFp2TVsm0Cjc=;
        b=iLgXFDsc+T3c2E9uF1ZHfosKr8FoP8MTO5YlwaF3AFZoLs6INYqKXhX8AHvSn297x9
         N76iqDw8PYIRvtjgu3mlpapdeLd6etmoNuYx3eVSUV/72JXg+NWL+kFox7Feng8rqTG0
         iPfC71Z8UIYrD6pCtyIknQCrFnHOFqC6l1mQhlSIm4qEIDVq/SXTHAtleqRg8FUmA4K4
         MMlJdTghMC1GxvlW0AlSKG4fAU1ankK8rdQy6wEl8PSEJgJoENNLtbRoT4T/D4oXguPJ
         +2J4+NT5uK/JHwtbOFgv62S5Xe7X9JRjUf2ZGVdEmvGtJ2X+0XZDgtJatL3RRH0x77BP
         +ZQQ==
X-Gm-Message-State: ABy/qLYDJpm1Z5bs1RmX4lrzjlmchHWknkDcy1zxQobArtIbSJEcM9sS
        rN/BisSbg1Pxu3Tg43sCACy+is1yB+SSkU7pkd18CA7o3m9piQT6LQxwcGB8PSgmSwSdmfoOcCJ
        Oy3o208vNa3hLTHYtsHrQjbUZ
X-Received: by 2002:a05:6a21:7803:b0:118:eeef:2a25 with SMTP id be3-20020a056a21780300b00118eeef2a25mr3486160pzc.34.1689298205010;
        Thu, 13 Jul 2023 18:30:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFq/XnCOuQNRwq2r6T10iPQLdLYwT59jK1mNIui4mQ7panH0+97fCKpRAKLGejuvfUfaDLYKg==
X-Received: by 2002:a05:6a21:7803:b0:118:eeef:2a25 with SMTP id be3-20020a056a21780300b00118eeef2a25mr3486143pzc.34.1689298204665;
        Thu, 13 Jul 2023 18:30:04 -0700 (PDT)
Received: from localhost ([112.80.132.180])
        by smtp.gmail.com with ESMTPSA id a12-20020aa7864c000000b00666e649ca46sm6009531pfo.101.2023.07.13.18.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 18:30:04 -0700 (PDT)
Date:   Fri, 14 Jul 2023 09:29:04 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ima: require signed IMA policy when UEFI secure boot is
 enabled
Message-ID: <kglacif5fwh3byrjkmlzygpnaecdb2zxh6hbglnvdbsfu7hbxm@gc3mjr37mnpb>
References: <20230703115442.129725-1-coxu@redhat.com>
 <b61fedf214cbe72de063a3bf516dd72f80595219.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b61fedf214cbe72de063a3bf516dd72f80595219.camel@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 08:57:10AM -0400, Mimi Zohar wrote:
>On Mon, 2023-07-03 at 19:54 +0800, Coiby Xu wrote:
>> With the introduction of the .machine keyring for UEFI-based systems,
>> users are able to add custom CAs keys via MOK. This allow users to sign
>> their own IMA polices. For the sake of security, mandate signed IMA
>> policy when UEFI secure boot is enabled.
>>
>> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>>  security/integrity/ima/ima_efi.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/security/integrity/ima/ima_efi.c b/security/integrity/ima/ima_efi.c
>> index 9db66fe310d4..bb2881759505 100644
>> --- a/security/integrity/ima/ima_efi.c
>> +++ b/security/integrity/ima/ima_efi.c
>> @@ -58,6 +58,9 @@ static const char * const sb_arch_rules[] = {
>>  #if !IS_ENABLED(CONFIG_MODULE_SIG)
>>  	"appraise func=MODULE_CHECK appraise_type=imasig",
>>  #endif
>> +#if IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING) && IS_ENABLED(CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY)
>> +	"appraise func=POLICY_CHECK appraise_type=imasig",
>> +#endif /* CONFIG_INTEGRITY_MACHINE_KEYRING && IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY */
>>  	"measure func=MODULE_CHECK",
>>  	NULL
>>  };
>
>Thanks, Coiby.

You are welcome!

>
>Using IS_ENABLED() is not wrong, but unnecessary.  IS_BUILTIN()
>suffices.

Thanks for the reminding! When I was going to apply this suggestion, I
noticed ima_efi.c uses IS_ENABLED for all configuration items i.e.
CONFIG_MODULE_SIG and CONFIG_KEXEC_SIG which are all of bool type. Would
you like me to switch all IS_ENABLEs to IS_BUILTIN or still use
IS_ENABLED? While IS_BUILTIN is exclusively for bool type, it's not as
intuitive as IS_ENABLED. So it's not easy for me to make a choice.

>
>-- 
>thanks,
>
>Mimi
>

-- 
Best regards,
Coiby

