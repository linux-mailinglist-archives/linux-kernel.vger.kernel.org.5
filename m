Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74827C77B6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 22:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442588AbjJLUNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 16:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347383AbjJLUNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 16:13:33 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DABD7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 13:13:31 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-3574f99d236so5177625ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 13:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697141611; x=1697746411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wWha34q0YQUKT0DSdVeRBdS11wQENGBeefusmSYpbX0=;
        b=aNamkpJMNKwOjGNLHXsDgOLRFaNOq4Ng3wc3rklFRJ19J2R7CLU7MJyefdGBY8aVoU
         rhzPYb6t8CWwgrf1eb28fzRpKIy+wBwjUyMSpeGafzCJmwRZ1jkAYb5MfI46SC7htDQo
         Gc6UNvv0Et0d3AGtsY4JlIETM3y3xMnq4vxCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697141611; x=1697746411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWha34q0YQUKT0DSdVeRBdS11wQENGBeefusmSYpbX0=;
        b=bb5KxVOU7aAbO+4VCaI8WpNwIyETe0LIlfTWGVuEtnp/UgQOfkrMTlibYJAuAPds55
         sV7BjHWWTuqyCZcJ5kQ/FPEuUo6XG/1+z0D64jvso9GqeYZWlusU8mGwA4QS/NgcJGyw
         RhPYaFPMsvli92vIziM6d+6QEzTrgOLvccjq0RHFMxCWgRr0YA90pb6xRwzfISf2/uNS
         iELOBoZsYtG/Cc8BDElyHXZ+4bq0g08oOrgOM4d28uGlnUggvzUDL2vn7vxujOOBaFNv
         o09NMBJgxWXkJmGT7Pk0HT8tlz44Cdf3vqfe/CH3s4VTVyjaamnnnet9jbY/H5al0CR5
         gJQg==
X-Gm-Message-State: AOJu0YyxyMANUFwfS2n+IV2V73SnmrBiAClyD8gHtJdQ42LsuBvqaDIG
        WEuHotOHDhQgDlVB8khE+M0JLQ==
X-Google-Smtp-Source: AGHT+IE7mdeTTDRMn1YtqQYctsHkfyHOEBDy/praRDPF4WV4iEIajBBQIJujHaNI03o+tm5FVxDNuQ==
X-Received: by 2002:a05:6e02:cad:b0:34f:b88d:b2cb with SMTP id 13-20020a056e020cad00b0034fb88db2cbmr23706804ilg.21.1697141611059;
        Thu, 12 Oct 2023 13:13:31 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n14-20020a62e50e000000b0069319bfed42sm12089991pff.79.2023.10.12.13.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 13:13:30 -0700 (PDT)
Date:   Thu, 12 Oct 2023 13:13:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Terrell <terrelln@meta.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        syzbot <syzbot+1f2eb3e8cd123ffce499@syzkaller.appspotmail.com>,
        Chris Mason <clm@meta.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [syzbot] [zstd] UBSAN: array-index-out-of-bounds in
 FSE_decompress_wksp_body_bmi2
Message-ID: <202310121311.4B9DD96E51@keescook>
References: <00000000000049964e06041f2cbf@google.com>
 <20231007210556.GA174883@sol.localdomain>
 <202310091025.4939AEBC9@keescook>
 <19E42116-8FE3-4C4B-8D26-E9B47B0B9AC5@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19E42116-8FE3-4C4B-8D26-E9B47B0B9AC5@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 07:55:55PM +0000, Nick Terrell wrote:
> 
> > On Oct 9, 2023, at 1:29 PM, Kees Cook <keescook@chromium.org> wrote:
> > 
> > !-------------------------------------------------------------------|
> >  This Message Is From an External Sender
> > 
> > |-------------------------------------------------------------------!
> > 
> > On Sat, Oct 07, 2023 at 02:05:56PM -0700, Eric Biggers wrote:
> >> Hi Nick,
> >> 
> >> On Wed, Aug 30, 2023 at 12:49:53AM -0700, syzbot wrote:
> >>> UBSAN: array-index-out-of-bounds in lib/zstd/common/fse_decompress.c:345:30
> >>> index 33 is out of range for type 'FSE_DTable[1]' (aka 'unsigned int[1]')
> >> 
> >> Zstandard needs to be converted to use C99 flex-arrays instead of length-1
> >> arrays.  https://github.com/facebook/zstd/pull/3785 would fix this in upstream
> >> Zstandard, though it doesn't work well with the fact that upstream Zstandard
> >> supports C90.  Not sure how you want to handle this.
> > 
> > For the kernel, we just need:
> > 
> > diff --git a/lib/zstd/common/fse_decompress.c b/lib/zstd/common/fse_decompress.c
> > index a0d06095be83..b11e87fff261 100644
> > --- a/lib/zstd/common/fse_decompress.c
> > +++ b/lib/zstd/common/fse_decompress.c
> > @@ -312,7 +312,7 @@ size_t FSE_decompress_wksp(void* dst, size_t dstCapacity, const void* cSrc, size
> > 
> > typedef struct {
> >     short ncount[FSE_MAX_SYMBOL_VALUE + 1];
> > -    FSE_DTable dtable[1]; /* Dynamically sized */
> > +    FSE_DTable dtable[]; /* Dynamically sized */
> > } FSE_DecompressWksp;
> 
> Thanks Eric and Kees for the report and the fix! I am working on putting this
> patch up now, just need to test the fix myself to ensure I can reproduce the
> issue and the fix.
> 
> In your opinion does this worth trying to get this patch into v6.6, or should it
> wait for v6.7?

For all these flex array conversions we're mostly on a "slow and steady"
route, so there's no rush really. I think waiting for v6.7 is fine. If
anyone ends up wanting to backport it, it should be pretty clean
I imagine.

Thanks for getting it all landed! :)

-Kees

-- 
Kees Cook
