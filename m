Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550547CDA90
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjJRLfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjJRLe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:34:56 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1768A198
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:34:49 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9b2f73e3af3so1028606966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697628887; x=1698233687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bLIYllS+O6Xd2qzawS5VK1eQ02CDGNfk+dIUUR4Mb9M=;
        b=cJFZs9KeWhc44wUobqG2sXmnLVs6/rwf2HA/ZuAiQ+cr20H7bdaq/4ioETFwkKW7bz
         PeMxsrPV/wUFDN4gn5KQxI8iRZQFtAJrwkyTL8flXwTqNiTNIqE19tdI8Bmen5DRJAtA
         nfkEICHwRgUUCi8GqPje5jxK+wkGxk+TFd810Uc0UQ3l2Sk0ll4lJUG2852p6/A4rGaW
         mLx2MphEYLX5+vLs1SViTgvaC10vC+08JXj5zU1JG32grA+WBT7lNn1xqG/yjBxrOGOY
         EMLzPudrOXcv2/wdcAfBGjt8dgNFZCuKVquHDSlY+hcdkpm/BPiDHVV2hJDPcfxA+RH5
         IMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697628887; x=1698233687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLIYllS+O6Xd2qzawS5VK1eQ02CDGNfk+dIUUR4Mb9M=;
        b=cN9LNuG0bipPws+YuCA3u8Ing5I5Pv5VyS/IDTMPfsTkPlQ6jmUNT/eVWVuKHHhS2q
         Qj1mvZyZG0qvD1Ti6AsdGPUOnsDjrUNWlF/jSNciSj5yjboXjsIHwO0sd0W0FqfTI78A
         n46v2SGgabdIjRw/eLEO+EiahIBS8AqfqlkBbz6+O4qv0T3pegavTO/VSbSD2oIoNPZ1
         gP1yK10vVinCZ9AD7WwPgDzZU0wn9ZBhMGWp2Aip1+vu/6oN8H58atnD+tsF3pogVW21
         szNb2EIN+K1zmf5Ioh/DIrX87x+USPTNw19HVFKsdaTbNrHpipk4Mbgex2BkuLMJkLV2
         iH9A==
X-Gm-Message-State: AOJu0YxT/NaLlJ6vyXCCC2Loq+XxEjVUrCtPK4JZkgp4ae569gjU62vD
        r3miUUqkzA4KC7xtyAEgg+g=
X-Google-Smtp-Source: AGHT+IEYuZTECiTe/CWO5fzOqWJ8nMXo46EwDgNlRRBWZqPtxnbzqwj6YGcgm9HvKPNlFMhAV6hFaQ==
X-Received: by 2002:a17:906:dac4:b0:9be:dce3:6e07 with SMTP id xi4-20020a170906dac400b009bedce36e07mr4461109ejb.32.1697628886950;
        Wed, 18 Oct 2023 04:34:46 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id mm27-20020a170906cc5b00b0099e12a49c8fsm1521281ejb.173.2023.10.18.04.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 04:34:46 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 18 Oct 2023 13:34:44 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ajay Kaher <akaher@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
Subject: Re: [PATCH v2 3/4] x86/paravirt: switch mixed paravirt/alternative
 calls to alternative_2
Message-ID: <ZS/C1HS/EEXTtVji@gmail.com>
References: <20231016123933.17284-1-jgross@suse.com>
 <20231016123933.17284-4-jgross@suse.com>
 <20231016142930.GE33217@noisy.programming.kicks-ass.net>
 <4f5cc965-36da-43f0-aaaa-082a2235ec1e@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f5cc965-36da-43f0-aaaa-082a2235ec1e@suse.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Juergen Gross <jgross@suse.com> wrote:

> On 16.10.23 16:29, Peter Zijlstra wrote:
> > On Mon, Oct 16, 2023 at 02:39:32PM +0200, Juergen Gross wrote:
> > > Instead of stacking alternative and paravirt patching, use the new
> > > ALT_FLAG_CALL flag to switch those mixed calls to pure alternative
> > > handling.
> > > 
> > > This eliminates the need to be careful regarding the sequence of
> > > alternative and paravirt patching.
> > > 
> > > For call depth tracking callthunks_setup() needs to be adapted to patch
> > > calls at alternative patching sites instead of paravirt calls.
> > > 
> > > Signed-off-by: Juergen Gross <jgross@suse.com>
> > 
> > I cannot help but feel this would've been better as two patches, one
> > introducing ALT_NOT_XEN and then a second with the rest.
> 
> In case I need to respin I'll split it up.

Yeah, would be nice to split this patch into two, as Peter requested.

Thanks,

	Ingo

